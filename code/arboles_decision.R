## Demostración de Árboles de Decisión
## Bastián González-Bustamante
## Universidad Diego Portales
## Octubre 2024

## Clean Environment
rm(list = ls())

## PASO 1: Cargar paquetes

## Packages
library(WDI)
library(rpart)
library(rpart.plot)
library(dplyr)
library(caret)

## PASO 2: Obtener datos

## Descargar datos del World Bank (WDI package)
indicadores <- c("NY.GDP.MKTP.CD",  ## PIB (USD)
                 "SP.POP.TOTL",     ## Población total
                 "SP.DYN.IMRT.IN")  ## Tasa de mortalidad infantil (por 1,000 nacidos vivos)

## Descargar datos para el periodo 2010-2020
datos_wb <- WDI(indicator = indicadores, start = 2010, end = 2020, extra = TRUE)

## Filtrar para algunos países específicos
paises <- c("USA", "ARG", "BRA", "CHL", "MEX", "FRA", "CHN", "IND")
datos_wb <- datos_wb %>% filter(iso3c %in% paises)

## Renombrar columnas
names(datos_wb)[7] = "pib"
names(datos_wb)[8] = "poblacion"
names(datos_wb)[9] = "mortalidad_infantil"

## Inspección
head(datos_wb)

## PASO 3: Preparar datos para el modelo

## Eliminar filas con valores NA
datos_limpios <- na.omit(datos_wb)

## Seleccionar solo algunas variables para el análisis
datos_modelo <- datos_limpios %>% select(pib, poblacion, mortalidad_infantil)

## Inspeccionar
head(datos_modelo)

## PASO 4: Crear árbol de decisión

## Árbol de decisión
modelo_arbol <- rpart(mortalidad_infantil ~ log(pib) + log(poblacion), data = datos_modelo, method = "anova")

## Resumen del modelo
summary(modelo_arbol)

## PASO 5: Visualizar árbol

## Visualizar el árbol de decisión
rpart.plot(modelo_arbol, type = 3, fallen.leaves = TRUE, digits = 3)

## PASO 6: Predecir con el modelo

## Predecir para un conjunto de datos
nuevos_datos <- data.frame(pib = c(log(1e12), log(5e11)), poblacion = c(log(300000000), log(150000000)))
predicciones <- predict(modelo_arbol, nuevos_datos)

## Predicciones
predicciones

## PASO 6: Aplicar diferentes criterios de división

## Árbol con el criterio Gini
modelo_gini <- rpart(mortalidad_infantil ~ log(pib) + log(poblacion), data = datos_modelo, method = "class", parms = list(split = "gini"))

## Árbol con el criterio de entropía (deviance)
modelo_entropy <- rpart(mortalidad_infantil ~ log(pib) + log(poblacion), data = datos_modelo, method = "class", parms = list(split = "information"))

## PASO 7: Poder el árbol de decisión

## Tabla de complejidad (cp) para identificar el mejor cp
printcp(modelo_arbol)

## Elegir el valor de cp mínimo que da el error más bajo
cp_optimo <- modelo_arbol$cptable[which.min(modelo_arbol$cptable[,"xerror"]), "CP"]

## Crear el árbol podado usando el valor óptimo de cp
modelo_podado <- prune(modelo_arbol, cp = cp_optimo)

## Visualizar el árbol podado
rpart.plot(modelo_podado, type = 3, fallen.leaves = TRUE, digits = 3)

## PASO 8: Validación cruzada para obtener métricas de rendimiento

## Definir control de la validación cruzada
control <- trainControl(method = "cv", number = 10)

## Ajustar el modelo de árbol con validación cruzada
modelo_cv <- train(mortalidad_infantil ~ log(pib) + log(poblacion), data = datos_modelo,
                   method = "rpart", trControl = control)

### Ver las métricas de rendimiento
print(modelo_cv)

## Extraer las predicciones y el valor real para calcular métricas adicionales si es necesario
datos_modelo$mortalidad_infantil <- as.factor(datos_modelo$mortalidad_infantil)
predicciones_cv <- predict(modelo_cv, datos_modelo)
predicciones_cv <- as.factor(predicciones_cv)
levels(predicciones_cv) <- levels(datos_modelo$mortalidad_infantil)

## Para modelos de clasificación, puedes usar métricas como exactitud, sensibilidad y especificidad:
confusionMatrix(predicciones_cv, datos_modelo$mortalidad_infantil)
