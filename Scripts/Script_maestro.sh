#! /bin/bash

source config-file.sh


### Enumeracion de los Scripts a usar ###
Script_P1="//Scripts/Script01_TrimmToBAM.sh" #Trimmomatic a bam merged
Script_P2="//Scripts/Script02_VCF.sh" #Llamado de variantes y obtención de PASS

##### Running Trimmomatic, BWA, converting SAM to BAM, sort and merge BAMs, addReadgroups ####
#for archivo in $(ls ${InputFolder}*|cut -d "_" -f 1-2|uniq)
#	do
#		 echo "Actualmente estoy en ${PWD} con las muestas para Trimmomatic"
#               ${Script_P1} ${archivo}"_1.fq" ${archivo}"_2.fq"
#	done
#done

####### Recalibracion de calidades y Mutect2 para generar archivos VCF y obtener las variantes PASS #######
#find ${BAMs} -name "*_merged-RG.bam" \
#	| xargs -I BAM -P ${NT} ${Script_P2} BAM


