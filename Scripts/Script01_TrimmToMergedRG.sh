
#!/bin/bash

source config-file.sh

#Entrada de archivos fastq forward y reverse 
F=$1
R=$2

#Renombrar archivos de salida para Trimmomatic
FP=$(basename ${F}|sed 's/.fq/_paired.fq/')
FU=$(basename ${F}|sed 's/.fq/_unpaired.fq/')
RP=$(basename ${R}|sed 's/.fq/_paired.fq/')
RU=$(basename ${R}|sed 's/.fq/_unpaired.fq/')

#Ejecutar trimmomatic con sus parametros
echo Estoy usando Trimmomatic para limpiar mis muestras
${trimmomatic} ${F} ${R} ${FILTERFQ}${FP} ${FILTERFQ}${FU} ${FILTERFQ}${RP} ${FILTERFQ}${RU} SLIDINGWINDOW:4:25 MINLEN:70
echo Ya termine de usar Trimmomatic

####Alineamiento de archivos####

#Desarrollar las instrucciones para bwa

#Asignar la variable para el archivo de salida de bwa
SAMP=$(basename ${FP}|sed 's/_1_paired.fq/_paired.sam/')
SAMF=$(basename ${FP}|sed 's/_paired.fq/_single.sam/')
SAMR=$(basename ${RP}|sed 's/_paired.fq/_single.sam/')

#Realizar anotación

echo Voy a realizar la anotacion de FP y RP
${BWA} ${GENREF} ${FP} ${RP} -o ${BAMs}${SAMP}
echo Voy a realizar la anotacion del FU
${BWA} ${GENREF} ${FU} -o ${BAMs}${SAMF}
echo Voy a realizar la anotacion del RU
${BWA} ${GENREF} ${RU} -o ${BAMs}${SAMR}
echo Ya termine la anotacion

####Pasar archivos de SAM a BAM
#Asignar variables para el cambio de extension en SAMtools
BAMP=$(echo ${SAMP} |sed 's/\.sam/\.bam/')
BAMF=$(echo ${SAMF} |sed 's/\.sam/\.bam/')
BAMR=$(echo ${SAMR} |sed 's/\.sam/\.bam/')

#Cambio de formato de SAM a BAM
${SAM} view -bS --threads 8 ${BAMs}${SAMP} -o ${BAMs}${BAMP}
${SAM} view -bS --threads 8 ${BAMs}${SAMF} -o ${BAMs}${BAMF}
${SAM} view -bS --threads 8 ${BAMs}${SAMR} -o ${BAMs}${BAMR}

###Realizar ordenamiento de las lecturas

#Cambio de nombre para generar archivos BAM sorted
BAMsortP=$(echo ${BAMP} |sed 's/\.bam/_sorted\.bam/')
BAMsortF=$(echo ${BAMF} |sed 's/\.bam/_sorted\.bam/')
BAMsortR=$(echo ${BAMR} |sed 's/\.bam/_sorted\.bam/')

#Realizar ordenamiento con Picard
${Picard} SortSam I=${BAMs}${BAMP} O=${BAMs}${BAMsortP} SO=coordinate
${Picard} SortSam I=${BAMs}${BAMF} O=${BAMs}${BAMsortF} SO=coordinate
${Picard} SortSam I=${BAMs}${BAMR} O=${BAMs}${BAMsortR} SO=coordinate

#Cambio de nombre para el archivo BAM merged
BAMmerged=$(echo ${BAMsortP} | sed 's/_paired_sorted\.bam/_merged\.bam/')
#Realizar merged con Picard
${Picard} MergeSamFiles INPUT=${BAMs}${BAMsortP} INPUT=${BAMs}${BAMsortR} INPUT=${BAMs}${BAMsortF} OUTPUT=${BAMs}${BAMmerged} 

###### Agregar readgroups al archivo BAM merge ######

#Cambio de nombre para archivo BAM con los ReadGroups
BAMmergedRG=$(echo $BAMoutm | sed 's/_merged\.bam/_merged-RG\.bam/')

#Generacion de ReadGroups (es necesario cambiar -LB por fecha o quien lo realizo, 
#En -PL se anota la plataforma que se hizo el experimento, siempre se crea el indice no mover.
RGID=$(basename $F | cut -d '_' -f 1,3)
RGPU=$(basename $F | cut -d '_' -f 3)
RGSM=$(basename $F | cut -d '_' -f 1)

#Ejecutar Picard para agregar readgroups
#El readgroup RGBL debe de ser remplazado para cada experimento
$Picard AddOrReplaceReadGroups -I ${BAMs}${BAMmerged} -O ${BAMs}${BAMmergedRG} -ID ${RGID} -PU ${RGPU} -LB 2021 -SM $RGSM  -PL ILLUMINA --CREATE_INDEX true


#Eliminando archivos ya no necesarios
#rm -r ${FILTERFQ}/${Tres} ${FILTERFQ}/${Cuatro} ${FILTERFQ}/${Cinco} ${FILTERFQ}/${Seis}
rm -r ${BAMs}${SAMP} ${BAMs}${SAMR} ${BAMs}${SAMF} ${BAMs}${BAMP}
rm -r ${BAMs}${BAMR} ${BAMs}${BAMF} ${BAMs}${BAMsortP} ${BAMs}${BAMsortF}
rm -r ${BAMs}${BAMsortR} ${BAMs}${BAMmerged}

