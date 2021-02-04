library(ggplot2)
library(dplyr)

# Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R.
urls = c("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

data = lapply(urls,read.csv)
dataFil = lapply(data, select, "Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG" ,"FTR")
dataFil = do.call(rbind, dataFil)
dataFil = mutate(dataFil, Date = as.Date(Date, "%d/%m/%y"))

# Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las 
# siguientes probabilidades:

# La probabilidad marginal de que el equipo que juega en casa anote 'x' goles (x=0,1,2,)
freqR = select(dataFil, c("FTHG","FTAG")) %>% table()

# La probabilidad marginal de que el equipo que juega como visitante anote 'y' goles (y=0,1,2,)
visita = data.frame(Goles_anotados = 0:(dim(freqR)[2]-1),
                             Probabilidad_marginal = apply(freqR, 2, sum)/sum(freqR)) 

# La probabilidad conjunta de que el equipo que juega en casa anote 'x' goles y el equipo que juega como visitante anote 'y' 
# goles (x=0,1,2,, y=0,1,2,)
casa = data.frame(Goles_anotados = 0:(dim(freqR)[1]-1),
                        Probabilidad_marginal = apply(freqR, 1, sum)/sum(freqR)) 

#Realiza lo siguiente:
#Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa

ggplot(casa, aes(x = Goles_anotados, y = Probabilidad_marginal))+
  geom_bar(stat = "identity") + ggtitle("Probabilidades para el equipo de casa")+
  theme_classic() + xlab("Goles anotados")+ ylab("Probabilidad marginal")

#Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
ggplot(visita, aes(x = Goles_anotados, y = Probabilidad_marginal))+
  geom_bar(stat = "identity") + ggtitle("Probabilidades para el equipo visitante")+
  theme_classic()+ xlab("Goles anotados")+ ylab("Probabilidad marginal")

#Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo 
#visitante en un partido.
heatmap(freqR/sum(freqR), Rowv = NA, Colv = NA, 
        freqRe = "none", main = "Probabilidades conjuntas de anotar goles",
        xlab = "Equipo visitante", ylab = "Equipo de casa")
