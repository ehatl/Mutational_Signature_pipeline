#Instalación de paquetería genoma 39
BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")
#Instalar paquetería faltante
BiocManager::install(c("GenomeInfoDb","GenomicRanges","Biostrings","XVector","rtracklayer"))

#Instalar versión Git  
install.packages("remotes")
remotes::install_github("raerose01/deconstructSigs")
library(remotes)
#Cargar libreria 
library(deconstructSigs)

# Asignar variable de entrada
head(sample.mut.ref)
mut.ref.relatives <- as.data.frame(read.csv("D:/MutationalSignatures_Pipeline/Results/TSV/TSV_relatives/All_relatives_pass.tsv",
                    header = TRUE,sep="\t"))
head(sample.mut.ref)

library(BSgenome.Hsapiens.UCSC.hg38)

# Convertir a entrada de deconstructSigs
sigs.input.relatives <- mut.to.sigs.input(mut.ref = mut.ref.relatives, 
                                sample.id = "Sample", 
                                chr = "chr", 
                                pos = "pos", 
                                ref = "ref", 
                                alt = "alt",
                                bsg = BSgenome.Hsapiens.UCSC.hg38)

#Crear referencias con firmas actualizadas
signatures.DBS2020 <- as.data.frame(read.csv("D:/MutationalSignatures_Pipeline/Ref_signatures/COSMIC_v3.2_DBS_GRCh38.txt",
                                            header = TRUE,sep="\t"))
#Exportado de excel pasar a dataframe
ref.SBS2020 <- as.data.frame(ref_SBS2020,header = TRUE,sep="\t")

#Referencia que contiene columna como nombre de las filas
cosmic.SBS2020 <- as.data.frame(tibble::column_to_rownames(ref.SBS2020),header = TRUE,sep="\t")

# Determinar que firmas contribuyen a muestras normalizadas de linea celular
sample_line1 = whichSignatures(tumor.ref = sigs.input.line, 
                       signatures.ref = COSMIC.SBS2020, 
                       sample.id = 1,
                       contexts.needed = TRUE)

sample_line2 = whichSignatures(tumor.ref = sigs.input.line, 
                               signatures.ref = COSMIC.SBS2020, 
                               sample.id = 2,
                               contexts.needed = TRUE)

sample_line3 = whichSignatures(tumor.ref = sigs.input.line, 
                               signatures.ref = cosmic.SBS2020, 
                               sample.id = 3,
                               contexts.needed = TRUE)

sample_line4 = whichSignatures(tumor.ref = sigs.input.line, 
                               signatures.ref = cosmic.SBS2020, 
                               sample.id = 4,
                               contexts.needed = TRUE)

#Obtener plots de las lineas celulares

plotSignatures(sample_line1, sub = 'Linea celular PD20 RV corregida')

plotSignatures(sample_line2, sub = 'Linea celular PD20 RV coregida')

plotSignatures(sample_line3, sub = 'Linea celular PD20')

plotSignatures(sample_line4, sub = 'Linea celular PD20')

#Obtener gráfica pie

makePie(sample_line1, sub = 'Linea celular PD20 RV corregida',add.color = "pink")

makePie(sample_line2, sub = 'Linea celular PD20 RV coregida',add.color = "pink")

makePie(sample_line3, sub = 'Linea celular PD20',add.color = "pink")

makePie(sample_line4, sub = 'Linea celular PD20', add.color = "pink")

# Determinar que firmas contribuyen a muestras normalizadas de casos índice

sample_proband1 = whichSignatures(tumor.ref = sigs.input.probands, 
                                  signatures.ref = cosmic.SBS2020, 
                                  sample.id = 1,
                                  contexts.needed = TRUE)

sample_proband2 = whichSignatures(tumor.ref = sigs.input.probands, 
                                  signatures.ref = cosmic.SBS2020, 
                                  sample.id = 2,
                                  contexts.needed = TRUE)

sample_proband3 = whichSignatures(tumor.ref = sigs.input.probands, 
                                  signatures.ref = cosmic.SBS2020, 
                                  sample.id = 3,
                                  contexts.needed = TRUE)

sample_proband4 = whichSignatures(tumor.ref = sigs.input.probands, 
                                  signatures.ref = cosmic.SBS2020, 
                                  sample.id = 4,
                                  contexts.needed = TRUE)

sample_proband5 = whichSignatures(tumor.ref = sigs.input.probands, 
                                  signatures.ref = cosmic.SBS2020, 
                                  sample.id = 5,
                                  contexts.needed = TRUE)
#Obtener Plots de casos índice

plotSignatures(sample_proband1, sub = 'Wang1')

plotSignatures(sample_proband2, sub = 'Song1')

plotSignatures(sample_proband3, sub = 'Wang2')

plotSignatures(sample_proband1, sub = 'Kong1')

plotSignatures(sample_proband1, sub = 'Chen1')

#Obtener gráficas Pie de casos índice

makePie(sample_proband1, sub = 'Wang1', add.color = "cyan")

makePie(sample_proband2, sub = 'Song1', add.color = "cyan")

makePie(sample_proband3, sub = 'Wang2', add.color = "cyan")

makePie(sample_proband4, sub = 'Kong1', add.color = "cyan")

makePie(sample_proband5, sub = 'Cheng1', add.color = "cyan")

# Determinar que firmas contribuyen a muestras normalizadas de familiares
sample_relative1 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 1,
                                    contexts.needed = TRUE)

sample_relative2 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 2,
                                    contexts.needed = TRUE)

sample_relative3 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 3,
                                    contexts.needed = TRUE)

sample_relative4 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 4,
                                    contexts.needed = TRUE)

sample_relative5 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 5,
                                    contexts.needed = TRUE)

sample_relative6 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 6,
                                    contexts.needed = TRUE)

sample_relative7 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 7,
                                    contexts.needed = TRUE)

sample_relative8 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 8,
                                    contexts.needed = TRUE)

sample_relative9 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                    signatures.ref = cosmic.SBS2020, 
                                    sample.id = 9,
                                    contexts.needed = TRUE)

sample_relative10 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                   signatures.ref = cosmic.SBS2020, 
                                   sample.id = 10,
                                   contexts.needed = TRUE)

sample_relative11 = whichSignatures(tumor.ref = sigs.input.relatives, 
                                   signatures.ref = cosmic.SBS2020, 
                                   sample.id = 11,
                                   contexts.needed = TRUE)

# Obtener Plot de los familiares

plotSignatures(sample_relative1, sub = 'Father_Of_Wang1')

plotSignatures(sample_relative2, sub = 'Mother_Of_Wang11')

plotSignatures(sample_relative3, sub = 'Father_Of_Song1')

plotSignatures(sample_relative4, sub = 'Mother_Of_Song1')

plotSignatures(sample_relative5, sub = 'Father_Of_Wang2')

plotSignatures(sample_relative6, sub = 'Mother_Of_Wang2')

plotSignatures(sample_relative7, sub = 'Father_Of_Kong1')

plotSignatures(sample_relative8, sub = 'Mother_Of_Kong1')

plotSignatures(sample_relative9, sub = 'Brother_Of_Kong1')

plotSignatures(sample_relative10, sub = 'Father_Of_Cheng1')

plotSignatures(sample_relative11, sub = 'Mother_Of_Cheng1')

# Obtener gráfica Pie de los familiares

makePie(sample_relative1, sub = 'Father_Of_Wang1', add.color = "violet")

makePie(sample_relative2, sub = 'Mother_Of_Wang1', add.color = "violet")

makePie(sample_relative3, sub = 'Father_Of_Song1', add.color = "violet")

makePie(sample_relative4, sub = 'Mother_Of_Song1', add.color = "violet")

makePie(sample_relative5, sub = 'Father_Of_Wang2', add.color = "violet")

makePie(sample_relative6, sub = 'Mother_Of_Wang2', add.color = "violet")

makePie(sample_relative7, sub = 'Father_Of_Kong1', add.color = "violet")

makePie(sample_relative8, sub = 'Mother_Of_Kong1', add.color = "violet")

makePie(sample_relative9, sub = 'Brother_Of_Kong1', add.color = "violet")

makePie(sample_relative10, sub = 'Father_Of_Cheng1', add.color = "violet")

makePie(sample_relative11, sub = 'Mother_Of_Cheng1', add.color = "violet")

#Correr deconstructsigs por grupos
Wang2<- sigs.input.relatives[3,]
Mother_Of_Wang2 <- sigs.input.relatives[6,]
FANCB<-rbind(Wang2,Mother_Of_Wang2)

sample_FANCB1 = whichSignatures(tumor.ref = FANCB, 
                                  signatures.ref = signatures.exome.cosmic.v3.may2019, 
                                  sample.id = 3,
                                  contexts.needed = TRUE)

sample_FANCB2 = whichSignatures(tumor.ref = FANCB, 
                               signatures.ref = signatures.exome.cosmic.v3.may2019, 
                               sample.id = 6,
                               contexts.needed = TRUE)

plotSignatures(sample_FANCB2, sub = 'Mother_Of_Wang2')

makePie(sample_FANCB2, sub = 'Mother_Of_Wang2', add.color = "violet")

plotSignatures(sample_FANCB1, sub = 'Wang2')

makePie(sample_FANCB1, sub = 'Wang2', add.color = "cyan")

save.image("Results/analisis1311.RData")

