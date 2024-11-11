# GDP PPP Prediction Challenge

## Data Mining - Doctorado UDP 2024

**Bastián González-Bustamante**

![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://raw.githubusercontent.com/Doctorado-UDP/data-mining-2024/refs/heads/main/prediction_challenge/badges/active.svg) ![License](https://raw.githubusercontent.com/Doctorado-UDP/data-mining-2024/refs/heads/main/prediction_challenge/badges/mit.svg)

## Instrucciones

En la carperta [prediction_challenge/data](https://github.com/Doctorado-UDP/data-mining-2024/tree/main/prediction_challenge/data) se encuentran **cinco conjuntos de datos** que corresponden a particiones de una base de datos con indicadores del Banco Mundial. La base total contiene 8216 observaciones y 67 variables, sin embargo, se eliminaron los casos donde la variable objetivo para las prediciones (**NY.GDP.MKTP.PP.KD**, *GDP, PPP constant 2021 international*) no se registra. La base cubre todos los países con datos disponibles desde 1990 a 2021. La eliminación de observaciones con casos perdidos en **NY.GDP.MKTP.PP.KD** redujo el conjunto a 7455 observaciones, las cuales fueron aleatoriamente divididas en una proporción 70/15/15 para crear un **training set**, **validation set** y **test set**. 

Cada uno de estos conjuntos fue dividido en dos para contener de forma separada predictores y variable dependiente. El **conjunto reservado**, no disponible en GitHub, que se utilizará para calcular las métricas para el leaderboard contiene los valores reales (*ground-truth*) de la variable dependiente del **test set**.

**Los participantes deberán:**

1. Utilizar [X_train.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_train.csv) e [y_train.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/y_train.csv) para entrenar sus modelos y [X_val.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_val.csv) e [y_val.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/y_val.csv) para validarlos.
2. Obtener las etiquetas predichas utilizando [X_test.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_test.csv) y subirlas a la carpeta [prediction_challenge/submissions](https://github.com/Doctorado-UDP/data-mining-2024/tree/main/prediction_challenge/submissions)
3. Pueden utilizar como script base el [código de ejemplo](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/baseline_model.ipynb) y preparar modelos afinados.
4. El siguiente [código](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/submissions_eval.ipynb) será utilizado, por el profesor, para calcular el [**leaderboard**](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/leaderboard.csv).
5. El leaderboard se calculará diariamente, excepto los días sábados, hasta que cierre el challenge.

**Formato de envío (también disponible en el código de ejemplo):**

Es importante que los participantes completen la metadata en el código para el envío y verifiquen el formato del archivo con predicciones (**submission_Nombre_Modelo_N-envío.csv**).

* participant = "Baseline" - Nombre del participante, solo primer nombre.
* model_name = "RF100" - Nombre del modelo: Naive Bayes (NB), Support Vector Machine (SVM), Random Forest (RFX) donde X es el número de árboles, XGBoost.
* submission_number = "1" - El número de envío, mantener las comillas por favor.

> **Durante el challenge NO se subirán los códigos de cada envío, sin embargo, luego se revisarán los scripts de los mejores modelos.**

**Cuestiones logísticas:**

1. Se puede realizar máximo **un envío por día**.
2. Cada modelo tiene un límite de **cinco predictores**.
3. Los participantes pueden crear índices, recodificar y transformar predictores utilizando los datos de entrenamiento y probar distintos hiperparámetros y modelos. 
4. Los participantes tienen **prohibido** crear nuevas variables con información que no exista en el conjunto de datos de entrenamiento.
5. El challenge termina el **viernes 22 de noviembre de 2024 a las 23.59 horas** de Santiago de Chile.

## Leaderboard actualizado

Participant | Date | Submission | Model | Accuracy | Precision | Recall | F1-Score
--- | --- | --- | --- | --- | --- | --- | --- 
Fabian | 08/11/2024 | 1 | RF1000 | 0.897 | 0.898 | 0.897 | 0.897 
Nando | 08/11/2024 | 1 | RF500 | 0.893 | 0.896 | 0.893 | 0.892 
Laura | 08/11/2024 | 1 | RF100 | 0.807 | 0.811 | 0.807 | 0.809
Nando | 10/11/2024 | 2 | XGBoost | 0.695 | 0.747 | 0.695 | 0.679
Baseline | 08/11/2024 | 1 | RF100 | 0.530 | 0.539 | 0.530 | 0.533

## Fórmula para la calificación

$$y = \alpha + (X - 0.001) \times 6.258$$ 

Donde $y$ es la nota de 1.0 a 7.0; $\alpha$ = 1.0; $X$ es el mejor F1-Score obtenido durante el challenge.

De esta forma F1-Score = 0.800 $\sim$ 6.0; 0.900 \$\sim$ 6.6; y la nota máxima se alcanzaría con 0.960.

## Consistencia en el preprocesamiento y evitar data leakage

Los participantes deberían aplicar los pasos de recodificación y transformaciones no solo a [X_train.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_train.csv), también a [X_val.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_val.csv) y [X_test.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_test.csv). Esto asegura la consistencia para la validación y los cálculos finales de las métricas.

Aunque ciertas transformaciones (e.g, scaling, encoding) deben ser aplicadas a todos los conjuntos, es importante que **los parámetros (e.g., media o SD) sean obtenidas solamente de [X_train.csv](https://github.com/Doctorado-UDP/data-mining-2024/blob/main/prediction_challenge/data/X_train.csv)**. Esto evita **data leakage** a través de la influencia de los patrones de **validation test** and **test set** en el conjunto de datos de entrenamiento, garantizando una mejor generalización del modelo y evitando métricas infladas.

No es necesario imputar la variable objetivo ya que, como se ha indicado, todos los valores perdidos ya han sido descartados. Es posible imputar los predictores.

A continuación, hay algunos **ejemplos** de **transformaciones consistentes**, **imputaciones** y **pipeline** para preprocesamiento.

```python
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import LabelEncoder

## Scaling numerical features (FIT ON X_train ONLY, BUT APPLY TO ALL)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)  
X_val_scaled = scaler.transform(X_val)
X_test_scaled = scaler.transform(X_test)

## Encoding categorical features consistently
label_encoder = LabelEncoder()
X_train['CategoryFeature'] = label_encoder.fit_transform(X_train['CategoryFeature'])
X_val['CategoryFeature'] = label_encoder.transform(X_val['CategoryFeature'])
X_test['CategoryFeature'] = label_encoder.transform(X_test['CategoryFeature'])

```

``` python
from sklearn.impute import SimpleImputer

## Impute numerical columns with median based on X_train only
imputer = SimpleImputer(strategy='median')
X_train_imputed = imputer.fit_transform(X_train)
X_val_imputed = imputer.transform(X_val)
X_test_imputed = imputer.transform(X_test)

## If there are categorical columns that need imputation with the most frequent value
categorical_imputer = SimpleImputer(strategy='most_frequent')
X_train_cat_imputed = categorical_imputer.fit_transform(X_train[['CategoryFeature']])
X_val_cat_imputed = categorical_imputer.transform(X_val[['CategoryFeature']])
X_test_cat_imputed = categorical_imputer.transform(X_test[['CategoryFeature']])
```

```python
from sklearn.pipeline import Pipeline

## Pipeline for numerical features
numeric_transformer = Pipeline(steps=[
    ('imputer', SimpleImputer(strategy='median')),
    ('scaler', StandardScaler())
])

## Apply the pipeline to X_train, X_val, and X_test
X_train_num_transformed = numeric_transformer.fit_transform(X_train[numeric_columns])
X_val_num_transformed = numeric_transformer.transform(X_val[numeric_columns])
X_test_num_transformed = numeric_transformer.transform(X_test[numeric_columns])

```

## Codebook

* **NY.GDP.MKTP.PP.KD**. GDP, PPP (constant 2021 international $).
* **SP.POP.GROW**. Population growth (annual %).
* **SP.POP.TOTL**. Population, total.
* **SP.POP.TOTL.FE.IN**. Population, female.
* **SP.POP.TOTL.FE.ZS**. Population, female (% of total population).
* **SP.POP.TOTL.MA.IN**. Population, male.
* **SP.POP.TOTL.MA.ZS**. Population, male (% of total population).
* **SP.URB.GROW**. Urban population growth (annual %).
* **SP.URB.TOTL**. Urban population.
* **SP.URB.TOTL.IN.ZS**. Urban population (% of total population).
* **SP.RUR.TOTL**. Rural population.
* **SP.RUR.TOTL.ZG**. Rural population growth (annual %).
* **SP.RUR.TOTL.ZS**. Rural population (% of total population).
* **SL.TLF.TOTL.IN**. Labor force, total.
* **SL.TLF.TOTL.FE.ZS**. Labor force, female (% of total labor force).
* **SL.UEM.TOTL.FE.NE.ZS**. Unemployment, female (% of female labor force) (national estimate).
* **SL.UEM.TOTL.FE.ZS**. Unemployment, female (% of female labor force) (modeled ILO estimate).
* **SL.UEM.TOTL.MA.NE.ZS**. Unemployment, male (% of male labor force) (national estimate).
* **SL.UEM.TOTL.MA.ZS**. Unemployment, male (% of male labor force) (modeled ILO estimate).
* **SL.UEM.TOTL.NE.ZS**. Unemployment, total (% of total labor force) (national estimate).
* **SL.UEM.TOTL.ZS**. Unemployment, total (% of total labor force) (modeled ILO estimate).
* **FP.CPI.TOTL.ZG**. Inflation, consumer prices (annual %).
* **GC.TAX.EXPT.CN**. Taxes on exports (current LCU).
* **GC.TAX.EXPT.ZS**. Taxes on exports (% of tax revenue).
* **NE.EXP.GNFS.KD.ZG**. Exports of goods and services (annual % growth).
* **NE.EXP.GNFS.KN**. Exports of goods and services (constant LCU).
* **NE.EXP.GNFS.ZS**. Exports of goods and services (% of GDP).
* **NV.AGR.TOTL.CD**. Agriculture, forestry, and fishing, value added (current US$).
* **NV.AGR.TOTL.CN**. Agriculture, forestry, and fishing, value added (current LCU).
* **NV.IND.MANF.CD**. Manufacturing, value added (current US$).
* **NV.IND.MANF.CN**. Manufacturing, value added (current LCU).
* **NV.IND.TOTL.CD**. Industry (including construction), value added (current US$).
* **NV.IND.TOTL.CN**. Industry (including construction), value added (current LCU).
* **NV.SRV.TOTL.CD**. Services, value added (current US$).
* **NV.SRV.TOTL.CN**. Services, value added (current LCU).
* **GE.EST**. Government Effectiveness: Estimate.
* **NE.CON.GOVT.KN.** General government final consumption expenditure (constant LCU).
* **NE.CON.GOVT.ZS**. General government final consumption expenditure (% of GDP).
* **NE.CON.PRVT.CD**. Households and NPISHs Final consumption expenditure (current US$).
* **NE.CON.PRVT.CN**. Households and NPISHs Final consumption expenditure (current LCU).
* **GC.DOD.TOTL.CN**. Central government debt, total (current LCU).
* **GC.DOD.TOTL.GD.ZS**. Central government debt, total (% of GDP).
* **BM.KLT.DINV.CD.WD**. Foreign direct investment, net outflows (BoP, current US$).
* **BX.KLT.DINV.WD.GD.ZS**. Foreign direct investment, net inflows (% of GDP).
* **EG.ELC.LOSS.ZS**. Electric power transmission and distribution losses (% of output).
* **EG.USE.ELEC.KH.PC**. Electric power consumption (kWh per capita).
* **EN.GHG.CO2.IP.MT.CE.AR5**. Carbon dioxide (CO2) emissions from Industrial Processes (Mt CO2e).
* **SE.PRM.NENR**. School enrollment, primary (% net).
* **SE.PRM.NENR.FE**. School enrollment, primary, female (% net).
* **SE.PRM.NENR.MA**. School enrollment, primary, male (% net).
* **SE.SEC.ENRR**. School enrollment, secondary (% gross).
* **SE.SEC.ENRR.FE**. School enrollment, secondary, female (% gross).
* **SE.SEC.ENRR.MA**. School enrollment, secondary, male (% gross).
* **SE.TER.ENRR**. School enrollment, tertiary (% gross).
* **SE.TER.ENRR.FE**. School enrollment, tertiary, female (% gross).
* **SE.TER.ENRR.MA**. School enrollment, tertiary, male (% gross).
* **SP.DYN.LE00.IN**. Life expectancy at birth, total (years).
* **SP.DYN.LE00.FE.IN**. Life expectancy at birth, female (years).
* **SP.DYN.LE00.MA.IN**. Life expectancy at birth, male (years).
* **EG.CFT.ACCS.ZS**. Access to clean fuels and technologies for cooking (% of population).
* **EG.CFT.ACCS.RU.ZS**. Access to clean fuels and technologies for cooking, rural (% of rural population).
* **EG.CFT.ACCS.UR.ZS**. Access to clean fuels and technologies for cooking, urban (% of urban population).
* **IT.NET.USER.FE.ZS**. Individuals using the Internet, female (% of female population).
* **IT.NET.USER.MA.ZS**. Individuals using the Internet, male (% of male population).
* **IT.NET.USER.ZS**. Individuals using the Internet (% of population).