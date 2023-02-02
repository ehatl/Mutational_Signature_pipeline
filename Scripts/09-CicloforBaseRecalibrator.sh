for MUESTRA in $(ls /../Intermediate-Files/BAMs/*|cut -d '_' -f 1-6|uniq)
do ./08-BaseRecalibrator.sh $MUESTRA'_merged_RG.bam'
done
