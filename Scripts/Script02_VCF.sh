#!/bin/bash

source config-file.sh

#Asignar variable al archivo final BAM que contiene los ReadGroups

BAMmergedRG=$1 

###Primera recalibración de calidades PHRED con GATK###

#Asignar cambio de nombre para archivo de salida de BaseRecalibrator

BRC=$(echo ${BAMmergedRG} | sed 's/_merged-RG\.bam/_recal_data\.table/')

#Ejecutar BaseRecalibrator

echo "Estoy ejecutando BaseRecalibrator de" ${BAMmergedRG}

${GATK} BaseRecalibrator -R ${GENREF} -I ${BAMmergedRG} --known-sites ${MILGENOMAS} --known-sites ${MILLS} -O ${BRC}

#Asignar archivo de salida para ApplyBQSR 

ABQSR=$(echo ${BAMmergedRG} | sed 's/_merged-RG\.bam/_recal_data\.bam/')

#Ajuste con ApplyBQSR 

${GATK} ApplyBQSR -R ${GENREF} -I ${BAMmergedRG} --bqsr-recal-file ${BRC} -O ${ABQSR}

#Asignar cambio de nombre para archivo de salida del segundo BaseRecalibrator

BRC2=$(echo ${BAMmergedRG} | sed 's/_merged-RG\.bam/_recal_data2\.table/')

#Ejecutar BaseRecalibrator por segunda vez

echo "Estoy ejecutando BaseRecalibrator por segunda vez"

${GATK} BaseRecalibrator -R ${GENREF} -I ${ABQSR} --known-sites ${MILGENOMAS} --known-sites ${MILLS} -O ${BRC2}

#Asignar archivo de salida para ApplyBQSR
ABQSR2=$(echo ${BAMmergedRG} | sed 's/_merged-RG\.bam/_recal_data2\.bam/')

#Ajuste con ApplyBQSR
${GATK} ApplyBQSR -R ${GENREF} -I ${ABQSR} --bqsr-recal-file ${BRC2} -O ${ABQSR2}

###Hacer llamado de variantes con Mutect2###

#Asignar variable a archivos de salida
F1R2=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_f1r2\.tar\.gz/')
UNFILTERED=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_unfiltered\.vcf/')
echo "Estoy ejecutando Mutec2 de" ${ABQSR2}

${GATK} Mutect2 -R ${GENREF} -L ${CNV} \
-I ${ABQSR2} \
-germline-resource ${GNOMAD} -pon ${PON} --f1r2-tar-gz ${TAR}${F1R2} \
-O ${VCFunfiltered}${UNFILTERED}

#Asignar variables a archivos de salida
ORIENTATION=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_read-orientation-model\.tar\.gz/')

echo "Aprendiendo orientacion"

${GATK} LearnReadOrientationModel -I ${TAR}${F1R2} -O ${TAR}${ORIENTATION}

#Asignar variables a archivos de salida
PILEUP=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_getpileupsummaries\.table/')

echo "Obtener el resumen por GetPileupSummaries"
${GATK} GetPileupSummaries -I ${ABQSR2} -V ${GNOMAD} -L ${CNV} -O ${TABLE}${PILEUP}

#Asignar variables a archivos de salida
SEGMENTS=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_segments\.table/')
CONTAMINATION=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_calculatecontamination\.table/')

echo "Realizar el calculo de la contaminacion"
${GATK} CalculateContamination -I ${TABLE}${PILEUP} -tumor-segmentation ${TABLE}${SEGMENTS} -O ${TABLE}${CONTAMINATION}

#Asignar variables a archivo VCF filtrado
FILTERED=$(basename ${ABQSR2}|sed 's/_recal_data2\.bam/_filtered\.vcf/')

echo "Agregar la orientacion aprendida a las variantes llamadas"
${GATK} FilterMutectCalls -V ${VCFunfiltered}${UNFILTERED} \
        -R ${GENREF} \
        --tumor-segmentation ${TABLE}${SEGMENTS} \
        --contamination-table ${TABLE}${CONTAMINATION} \
        --orientation-bias-artifact-priors ${TAR}${ORIENTATION} \
        -O ${VCFfiltered}${FILTERED}

###Obtener solo archivos PASS###

PASS=$(basename ${FILTERED}|sed 's/_filtered\.vcf/_pass\.vcf/')

grep "#CHROM" ${FILTERED} > /../Results/VCFs/VCF_pass/${PASS}
grep -v "##" ${FILTERED}|grep "PASS" >> /../Results/VCFs/VCF_pass/${PASS}
