#En esta carpeta se encuentran los archivos de salida de Trimmomatic
#Resultantes del Script 03
#Con base en las observaciones pertinentes en el primer FastQC 
#se realiza una limpieza de las lecturas. 
#Trimmomatic puede ser ejecutado bajo la siguiente sintaxis:

java -jar /.../Programas/Trimmomatic-0.39/trimmomatic-0.39.jar PE Input1_1.fq Input1_2.fq
 Output1_1_paired.fq Output1_1_unpaired.fq Output1_2_paired.fq Output1_2_unpaired.fq <PARAMETROS>

#Con java -jar se ejecuta el programa indicando la carpeta donde fue instalado
#PE es para indicar el modo Pairend.
#Este modo requiere dos archivos de entrada (input forward y reverse)
#la asignación de 4 archivos de salida (forward pareado, forward no pareado, 
#reverse pareado y reverse no pareado)
#y la asignación de los parámetros deseados
#más información en: http://www.usadellab.org/cms/?page=trimmomatic

#Para asignar los archivos de salida se utilizó el comando
basename
#que permite extraer el nombre de un archivo en una ruta dada. 
#En este caso si asigno a la variable
F= /.../Intermediate-Files/Filtered-FASTQs/Sample1_1.fq.gz
#el comando extrae solo “Sample1_1.fq.gz”
#El símbolo | (pipe o tubería) permite encadenar la ejecución de programas, 
#el output del comando basename pasa como el input del comando sed. 
#Este último busca un patrón marcado entre / / y lo sustituye por un nuevo patrón dado.
#De tal manera, se tiene:
sed 's/.fq.gz/_paired.fq.gz/')
#Busca el patron “.fq.gz” y los sustituye por “_paired.fq.gz” 
#logrando que el resultado final de 
FP=$(basename ${F}|sed 's/.fq/_paired.fq.gz/') 
#para el archivo /.../Intermediate-Files/Filtered-FASTQs/Sample1_1.fq
#Sea
Sample1_1_paired.fq.gz
