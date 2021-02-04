#Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R,
# los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php
urls = c("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
         "https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
data = lapply(urls,read.csv)

# A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, 
# crea el data frame SmallData, que contenga las columnas date, home.team, home.score, away.team y away.score; esto 
# lo puede hacer con ayuda de la función select del paquete dplyr.
SmallData = lapply(data, select, Date, HomeTeam, FTHG, AwayTeam, FTAG)
SmallData[[1]]= mutate(SmallData[[1]], Date = as.Date(Date,"%d/%m/%y"))
SmallData[[2]]= mutate(SmallData[[2]], Date = as.Date(Date,"%d/%m/%y"))
SmallData[[3]]= mutate(SmallData[[3]], Date = as.Date(Date,"%d/%m/%y"))
SmallData = do.call(rbind,SmallData)
colnames(SmallData) = c("date", "home.team", "home.score", "away.team", "away.score")
# Guarda el data frame como un archivo csv con nombre soccer.csv; row.names = FALSE en write.csv.
write.csv(SmallData, file = "soccer.csv", row.names = F)

# Con la función create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al mismo tiempo asignelo a 
# una variable llamada listasoccer. Se creará una lista con los elementos scores y teams que son data frames listos para la 
# función rank.teams. Asigna estos data frames a variables llamadas anotaciones y equipos.
# install.packages("fbRanks")
library(fbRanks)
listasoccer = create.fbRanks.dataframes(scores.file = "soccer.csv")

# Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y que correspondan a las fechas en las que se
# jugaron partidos. Crea una variable llamada n que contenga el número de fechas diferentes. Posteriormente, con la función 
# rank.teams y usando como argumentos los data frames anotaciones y equipos, crea un ranking de equipos usando unicamente datos
# desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar en
#  max.date y min.date. Guarda los resultados con el nombre ranking.
fecha = unique(listasoccer$scores$date)
n = length(fecha)
ranking = rank.teams(scores = listasoccer$scores, teams = listasoccer$teams, min.date = fecha[1], max.date = fecha[n-1])

# Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un 
# empate para los partidos que se jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer con ayuda de la
# función predict y usando como argumentos ranking y fecha[n] que deberá especificar en date.

prediccion <- predict(ranking, date = fecha[n])
