#!/bin/bash

#Ciclo for para procesar archivos fastq en el programa  FastQC despues del trimmomatic

for VARIABLE in $(ls /../Intermediate-Files/Filtered-FASTQs/*)
do
echo Estoy trabajando con ${VARIABLE} y se va a realizar un Fastqc
fastqc --threads 8 ${VARIABLE} -o /../Intermediate-Files/FASTQC/After_T/
echo Ya termine con el archivo ${VARIABLE}
done


