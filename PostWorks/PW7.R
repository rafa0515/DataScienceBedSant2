#Utilizando el manejador de BDD Mongodb Compass (previamente instalado), deberás de realizar las siguientes acciones:

#install.packages('mongolite')
library(mongolite) 

URL <- sprintf("mongodb+srv://%s:%s@%s/", 'BeduUser', '*******', 'cluster1ds.sfgzw.mongodb.net')

col.match = mongo("match", db = "match_games", url=URL)

# Alojar el fichero data.csv en una base de datos llamada match_games, nombrando al collection como match
data <- read.csv('data.csv')
col.match$insert(data)

# Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base
col.match$count() 

# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles que metió el Real
# Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?
col.match$find(
  query = '{"Date" : "2015-12-20", "HomeTeam" : "Real Madrid"}', 
  fields = '{"Date" : true, "AwayTeam" : true, "FTHG" : true, "FTAG":true}')  

#No se encontraron registros.
rm(col.match)
