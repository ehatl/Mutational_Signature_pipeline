#En los archivos VCF_pass de familiares de pacientes con anemia de Fanconi 
#añadir número en una columna inicial
#y remover columnas no necesarias para obtener los archivos .tsv usados en deconstructSigs

sed "s/^/1\t/g" SRR1EJEMPLO_pass.vcf|cut -f 1-3,5-6 > ../../TSV/TSV_relatives/SRR768374_pass.tsv

#El número "1" varia según el número de muestra/orden de las muestras
#Editar cada una en nano
#copiar primer archivo
cp SRR1EJEMPLO_pass.tsx All_relative_pass.tsv

#Unir muestras a un solo archivo .tsv
cat SRR1EJEMPLO_pass.tsv >> All_relative_pass.tsv

#Repetir con todos los archivos en el orden deseado (seguir los consecutivos 1,2...)
