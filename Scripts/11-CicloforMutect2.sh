for MUESTRA in $(ls /.../Intermediate-Files/BAMs/*|cut -d '_' -f 1-6|uniq)
do ./10-Mutect2.sh $MUESTRA'_recal_data2.bam'
done
