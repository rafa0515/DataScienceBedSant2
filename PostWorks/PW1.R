library(dplyr) 

#Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R
data = read.csv(file = "https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

# Extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y 
# los goles anotados por los equipos que jugaron como visitante (FTAG)
dataFil = select(data, c("FTHG", "FTAG"))

# Tablas de frecuencias relativas
freqR = table(dataFil)

# Probabilidad marginal de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
round(apply(freqR, 1, sum)/sum(freqR),3)

# Probabilidad marginal de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
round(apply(freqR, 2, sum)/sum(freqR),3)

# Probabilidad conjunta de que el equipo que juega en casa anote 'x' goles y el equipo que juega como visitante
# anote 'y' goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
round(freqR/sum(freqR),3)
