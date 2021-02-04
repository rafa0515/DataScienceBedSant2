library(dplyr)

# Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R.
urls = c("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

data = lapply(urls,read.csv)
#Obten una mejor idea de las características de los data frames al usar las funciones: str, head, View y summary
str(data[1]); head(data[1])

View(data[1])
str(data[2]); head(data[2]); 

View(data[2])
str(data[3]); head(data[3]); 

View(data[3])

summary(data[1]); summary(data[2]); summary(data[3])

# Selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; 
# esto para cada uno de los data frames. (Hint: también puedes usar lapply).
dataFil = lapply(data, select, "Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG" ,"FTR")

# Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo 
# Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas.
dataFil = do.call(rbind, dataFil)
str(dataFil)
dataFil = mutate(dataFil, Date = as.Date(Date, "%d/%m/%y"))
str(dataFil)
