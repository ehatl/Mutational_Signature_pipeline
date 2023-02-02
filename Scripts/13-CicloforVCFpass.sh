#!/bin/bash

for MUESTRA in $(ls /.../Results/VCFs/VCF_filtered/*|cut -d '_' -f 1-7|uniq)
do ./12-VCFpass.sh ${MUESTRA}'_filtered.vcf'
done

