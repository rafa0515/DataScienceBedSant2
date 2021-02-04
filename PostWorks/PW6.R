# Importe el conjunto de datos match.data.csv a `R`:	
library(dplyr)
library(ggplot2)

data = read.csv("match.data.csv") 

# 1. Agregue una nueva columna `sumagoles` que contenga la suma de goles por partido	
# 2. Obtenga el promedio por mes de la suma de goles	
serie = data %>%
  mutate(sumagoles = home.score + away.score) %>% 
  group_by(Mes = lubridate::floor_date(as.Date(date), unit = "month")) %>% 
  summarise(GolesPromedio = mean(sumagoles))

# 3. Creé la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019	
# 4. Grafique la serie de tiempo	
serie %>%
  ggplot(aes(Mes, GolesPromedio)) +
  geom_line() +
  geom_point() +
  scale_x_date(date_labels = "%b. %Y")
