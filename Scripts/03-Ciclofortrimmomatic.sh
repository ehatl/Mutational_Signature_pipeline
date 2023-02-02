for archivo in $(ls /../Input-Files/FASTQs/*|cut -d '_' -f 1-6|uniq)
do ./02-Trimmomatic.sh ${archivo}'_1.fq.gz' ${archivo}'_2.fq.gz'
done
