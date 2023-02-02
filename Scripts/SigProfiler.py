###Instalar genoma de referencia

from SigProfilerMatrixGenerator import install as genInstall

genInstall.install('GRCh38')

###Asignar función

from SigProfilerExtractor import sigpro as sig

def main_function():

###Sintaxis general de SigProfiler

sig.sigProfilerExtractor(input_type="vcf", output="/.../Results/sigProfiler/", input_data="/.../Results/VCFs/VCF_pass/", reference_genome='GRCh38',
exome=False, minimum_signatures=1, maximum_signatures=10,
nmf_replicates=100, cpu=4, make_decomposition_plots=True)
