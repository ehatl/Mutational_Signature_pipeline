#!/bin/bash

#Variable para el genoma de referencia 
GENREF="/.../References/hg38_v0_Homo_sapiens_assembly38.fasta"
#Asignar variable al archivo BAM final
BAM=$1 
#Variable de known-sites

MILGENOMAS="/.../References/1000G_phase1.snps.high_confidence.hg38.vcf.gz"
MILLS="/.../References/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz"

###Recalibración de calidades PHRED con GATK##

#Asignar cambio de nombre para archivo de salida de BaseRecalibrator

BRC=$(echo ${BAM} | sed 's/_merged_RG\.bam/_recal_data\.table/')

#Asignar ruta del programa
GATK='java -jar /.../Programs/gatk-4.1.8.1/gatk-package-4.1.8.1-local.jar'

#Ejecutar BaseRecalibrator

echo 'Estoy ejecutando BaseRecalibrator de' ${BAM}

${GATK} BaseRecalibrator -R ${GENREF} -I ${BAM} --known-sites ${MILGENOMAS} --known-sites ${MILLS} -O ${BRC}

#Asignar archivo de salida para ApplyBQSR 
ABQSR=$(echo ${BAM} | sed 's/_merged_RG\.bam/_recal_data\.bam/')
#Ajuste con ApplyBQSR 
${GATK} ApplyBQSR -R ${GENREF} -I ${BAM} --bqsr-recal-file ${BRC} -O ${ABQSR}

BRC2=$(echo ${BAM} | sed 's/_merged_RG\.bam/_recal_data2\.table/')

#Ejecutar BaseRecalibrator por segunda vez

echo 'Estoy ejecutando BaseRecalibrator por segunda vez'

${GATK} BaseRecalibrator -R ${GENREF} -I ${ABQSR} --known-sites ${MILGENOMAS} --known-sites ${MILLS} -O ${BRC2}

#Asignar archivo de salida para ApplyBQSR
ABQSR2=$(echo ${BAM} | sed 's/_merged_RG\.bam/_recal_data2\.bam/')

#Ajuste con ApplyBQSR
${GATK} ApplyBQSR -R ${GENREF} -I ${ABQSR} --bqsr-recal-file ${BRC2} -O ${ABQSR2}
