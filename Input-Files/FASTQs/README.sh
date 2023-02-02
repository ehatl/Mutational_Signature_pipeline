#En esta carpeta se encuentran todos los archivos .fastq
#En caso de que las secuencias se encuentren en formato SRA 
#Descargar archivos en SRA toolkit
#1.Comando para descargar los archivos SRA
prefetch -v RUN
#2.Comando para dividir archivos fastq en en forward y reverse
fastq-dump --outdir . --split-files /ruta/donde/descargué/sra/SRREJEMPLO.sra
