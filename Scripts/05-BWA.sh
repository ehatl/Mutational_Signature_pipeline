#!/bin/bash

#Desarrollar las instrucciones para bwa

#Designar variables para los 4 archivos de salida de trimmomatic

FP=$1
RP=$2
FU=$3
RU=$4

#Asignar la variable del genoma de referencia
GENREF='/.../References/hg38_v0_Homo_sapiens_assembly38.fasta'
#Asignar la ruta de BWA
BWA='/.../Programs/bwa-0.7.17/bwa mem -t 8'
#Asignar ruta de salida
BAMs='/../Intermediate-Files/BAMs/'
#Asignar la variable para el archivo de salida de bwa
SAMP=$(basename ${FP}|sed 's/_1_paired.fq.gz/_paired.sam/')
SAMF=$(basename ${FP}|sed 's/_paired.fq.gz/_single.sam/')
SAMR=$(basename ${RP}|sed 's/_paired.fq.gz/_single.sam/')

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

#Asignar variable de la ruta SAMtools
SAM="/.../Programs/samtools-1.10/samtools"

#Cambio de formato de SAM a BAM 
${SAM} view -bS --threads 8 ${BAMs}${SAMP} -o ${BAMs}${BAMP}
${SAM} view -bS --threads 8 ${BAMs}${SAMF} -o ${BAMs}${BAMF}
${SAM} view -bS --threads 8 ${BAMs}${SAMR} -o ${BAMs}${BAMR}

###Realizar ordenamiento de las lecturas

#Asignar ruta para Picard
Picard="java -jar /.../Programs/picard/build/libs/picard.jar"
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


