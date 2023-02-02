#!/bin/bash

#Ciclo for para FastQC de los datos crudos

for FASTQ in $(ls ../Input-Files/FASTQs/sample*)
do
echo Estoy trabajando con ${FASTQ} y se va a realizar un FastqQC
fastqc ${FASTQ} -o ../Intermediate-Files/FASTQC/Before_T
echo Ya termine con el archivo ${FASTQ}
done

