###Agregar readgroups al archivo BAMmerged
#A los archivos de salida merged.bam se les añade los readgroups, 
#en caso de ser los mismos para todas las muestras se puede integrar al Script 08 
#pero si estos son distintos se sugiere añadirlos por separado.


#Asignar variable al archivo de entrada

BAMmerged=$1

#Asignar ruta de salida
BAMs="/../Intermediate-Files/BAMs/"

#Asignar ruta de Picard
Picard="java -jar /.../Programs/picard/build/libs/picard.jar"
#Asignar nombre al archivo de salida
BAMmergedRG=$(echo ${BAMmerged}|sed 's/_merged\.bam/_merged_RG\.bam/')

${Picard} AddOrReplaceReadGroups -I ${BAMs}${BAMmerged} -O ${BAMs}${BAMmergedRG} -LB library -PL ILLUMINA -PU 1 -SM sample_name --CREATE_INDEX true
