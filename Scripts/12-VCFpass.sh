#! /bin/bash
FILTERED=$1

PASS=$(basename ${FILTERED}|sed 's/_filtered\.vcf/_pass\.vcf/')

grep '#CHROM' ${FILTERED} > /../Results/VCFs/VCF_pass/${PASS}
grep -v '##' ${FILTERED}|grep 'PASS' >> /../Results/VCFs/VCF_pass/${PASS}


