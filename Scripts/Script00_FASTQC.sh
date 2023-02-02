#!/bin/bash

#Ciclo for para FastQC de los datos crudos

for FASTQ in $(ls ../Input-Files/FASTQs/sample*)
do
echo Estoy trabajando con ${FASTQ} y se va a realizar un FastqQC
fastqc --threads 8 ${FASTQ} -o ${FASTQC}
echo Ya termine con el archivo ${FASTQ}
done


#Ciclo for para procesar archivos fastq en el programa  FastQC despues del trimmomatic

for VARIABLE in $(ls /../Intermediate-Files/Filtered-FASTQs/*)
do
echo Estoy trabajando con ${VARIABLE} y se va a realizar un Fastqc
fastqc --threads 8 ${VARIABLE} -o ${FASTQCAFT}
echo Ya termine con el archivo ${VARIABLE}
done

##Ruta para archivos analizados en FASTQC antes del filtrado
FASTQC="/../Intermediate-Files/FASTQC/Before_T"

##Ruta para archivos analizados en FASTQC despues del filtrado
FASTQCAFT="/../Intermediate-Files/FASTQC/After_T/"

####Realiza el agregado de todos los archivos fastQC que se hicieron

multiqc -o ${FASTQC} ${FASTQCAFT}
