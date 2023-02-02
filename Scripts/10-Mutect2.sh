#!/bin/bash
#Variable para el genoma de referencia
GENREF='/.../References/hg38_v0_Homo_sapiens_assembly38.fasta'
#Asignar variable al archivo

#Variable de bases de datos

PON='/.../References/1000g_pon.hg38.vcf.gz'
GNOMAD='/.../References/af-only-gnomad.hg38.vcf.gz'
CNV='/.../References/CNV_and_centromere_blacklist.hg38liftover.list'

#Asignar ruta del programa
GATK='java -jar /.../Programs/gatk-4.1.8.1/gatk-package-4.1.8.1-local.jar'

#Ruta a archivos de salida 
TABLE='/../Results/VCFs/VCF_table/'
TAR='/../Results/VCFs/VCF_tar/'
VCFunfiltered='/../Results/VCFs/VCF_unfiltered/'
VCFfiltered='/../Results/VCFs/VCF_filtered/'

#Asignar variable al archivo de entrada
ABQSR2=$1
#Asignar variable a archivos de salida
F1R2=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_f1r2\.tar\.gz/')
UNFILTERED=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_unfiltered\.vcf/')
echo 'Estoy ejecutando Mutec2 de' ${ABQSR2}
  
${GATK} Mutect2 -R ${GENREF} -L ${CNV} \
-I ${ABQSR2} \
-germline-resource ${GNOMAD} -pon ${PON} --f1r2-tar-gz ${TAR}${F1R2} \
-O ${VCFunfiltered}${UNFILTERED}

#Asignar variables a archivos de salida
ORIENTATION=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_read-orientation-model\.tar\.gz/')
echo 'Aprendiendo orientacion'

${GATK} LearnReadOrientationModel -I ${TAR}${F1R2} -O ${TAR}${ORIENTATION}
#Asignar variables a archivos de salida
PILEUP=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_getpileupsummaries\.table/')

echo 'Obtener el resumen por GetPileupSummaries'
${GATK} GetPileupSummaries -I ${ABQSR2} -V ${GNOMAD} -L ${CNV} -O ${TABLE}${PILEUP}
#Asignar variables a archivos de salida
SEGMENTS=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_segments\.table/')
CONTAMINATION=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_calculatecontamination\.table/')

echo 'Realizar el calculo de la contaminacion'
${GATK} CalculateContamination -I ${TABLE}${PILEUP} -tumor-segmentation ${TABLE}${SEGMENTS} -O ${TABLE}${CONTAMINATION}
#Asignar variables a archivo VCF filtrado
FILTERED=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_filtered\.vcf/')
echo 'Agregar la orientacion aprendida a las variantes llamadas'
${GATK} FilterMutectCalls -V ${VCFunfiltered}${UNFILTERED} \
	-R ${GENREF} \
	--tumor-segmentation ${TABLE}${SEGMENTS} \
        --contamination-table ${TABLE}${CONTAMINATION} \
        --orientation-bias-artifact-priors ${TAR}${ORIENTATION} \
        -O ${VCFfiltered}${FILTERED}

