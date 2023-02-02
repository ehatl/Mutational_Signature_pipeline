#En este Script se pueden detallar todas las variables que sean rutas a
#diferentes archivos en nuestro repositorio local

#Ruta del genoma de referencia, por ejemplo GRCh38
GENREF="/.../References/bundle_gatk/GRCh38/hg38_v0_Homo_sapiens_assembly38.fasta"

#Ruta para variantes de buena calidad para GATK
MILGENOMAS="/.../References/bundle_gatk/hg38_All_files/1000G_phase1.snps.high_confidence.hg38.vcf.gz"
MILLS="/.../References/bundle_gatk/hg38_All_files/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz"
PON="/.../Referencias/1000g_pon.hg38.vcf.gz"
GNOMAD="/.../References/Gnomad.V3.1.2/gnomad.genomes.r3.0.sites.vcf.bgz"
CNV="/.../Referencias/CNV_and_centromere_blacklist.hg38liftover.list"

#Ruta del programa Trimmomatic
trimmomatic="java -jar /.../Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 -phred33"

#Ruta para programa bwa con parametro para generar archivos SAM
BWA="/.../Programs/bwa-0.7.17/bwa mem -t 8"

#Ruta de programa Samtools para el cambio de archivos SAM a BAM
SAM="/.../Programs/samtools-1.10/samtools"

#Ruta para el programa picard
Picard="java -jar /.../Programs/picard/build/libs/picard.jar"

#Ruta de GATK
GATK="java -jar /.../Programs/gatk-4.1.8.1/gatk-package-4.1.8.1-local.jar"

#Ruta de GATK SPARK
GATKS="/.../Programs/gatk-4.1.8.1/gatk"

##Folder con los archivos FASTQ de entrada
InputFolder="/../Input-Files/FASTQs/"

##Ruta para archivos analizados en FASTQC antes del filtrado
FASTQC="/../Intermediate-Files/FASTQC/Before_T"
##Ruta para archivos FASTQ filtrados
FILTERFQ="/../Intermediate-Files/Filtered-FASTQs/"
##Ruta para archivos analizados en FASTQC despues del filtrado
FASTQCAFT="/../Intermediate-Files/FASTQC/After_T/"
##Ruta para los archivos BAM
BAMs="/../Intermediate-Files/BAMs/"
##Ruta para los archivos table de Mutect2
TABLE="/../Results/VCF_table/Dos-GNOMAD/"
##Ruta para los archivos tar de Mutect2
TAR="/../Results/VCF_tar/Dos-GNOMAD/"
##Ruta para los archivos VCF no filtrados
VCFunfiltered="/../Results/VCF_unfiltered/Dos-GNOMAD/"
##Ruta para los archivos VCF filtrados
VCFfiltered="/../Results/VCF_filtered/Dos-GNOMAD/"

### TSV folder, ahí se resume el resultado de todas las muestras ###
TSV="/../Results/TSV/"


