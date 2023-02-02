for MUESTRA in $(ls /../Intermediate-Files/Filtered-FASTQs/*|cut -d '_' -f 1-6|uniq)
do ./05-BWA.sh $MUESTRA'_1_paired.fq.gz' $MUESTRA'_2_paired.fq.gz' $MUESTRA'_1_unpaired.fq.gz' $MUESTRA'_2_unpaired.fq.gz'
done
