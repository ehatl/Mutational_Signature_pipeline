#En esta carpeta se guardaran los archivos resultantes del Script 01.
#A lo largo del pipeline se realizan diferentes "ciclo for"
#La sintaxis general de un ciclo for es

for <VALOR> in <LISTA DE VALORES> do #instrucciones 
done

#En este caso, mi lista de valores se trata del contenido la carpeta FASTQs
# y las instrucciones solicitadas son: 
#decir con que archivo está trabajando
#realizar en análisis en FastQC
#guardar los archivos de salida en la carpeta denominada Before_T
# y, finalmente indicar cuando finalice el procedimiento con el archivo determinado.
#Una vez realizado el análisis en FastQC, se revisaron los archivos de salida 
#en donde se pueden visualizar los 10 módulos de análisis relatados en 
#https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
