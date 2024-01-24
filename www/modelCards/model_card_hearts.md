<style>
table {
    font-family: 'Istok Web';
}
body {
        font-family: 'Istok Web', sans-serif;
    }

</style>


<head>
    <!-- Otros elementos del head aquí -->

    <!-- Enlace a la fuente Istok Web -->
    <link href="https://fonts.googleapis.com/css2?family=Istok+Web" rel="stylesheet">
    
</head>

# Model Card: HEARTS


---


## Introducción

A pesar de los avances considerables en las últimas décadas, las enfermedades cardiovasculares (ECV) todavía representan el mayor desafío de salud en la Región de las Américas. Estas enfermedades son responsables de un tercio de todas las muertes y causan un impacto económico y social notable. En 2017, se reportaron 14 millones de nuevos casos de ECV y se estimó que 80 millones de personas sufrían de alguna forma de estas enfermedades, contribuyendo a 2 millones de defunciones en esta región. Aunque hubo una disminución en las muertes prematuras por ECV de 2007 a 2013, este progreso se detuvo entre 2013 y 2017, con un estancamiento en casi todos los países de las Américas.<sup><a href="https://paperpile.com/c/R7cCn1/EfGzw">1</a></sup>

La grave crisis de las ECV en la Región está estrechamente relacionada con la alta prevalencia de sus factores de riesgo entre la población. Más del 60% de las personas en esta región padecen sobrepeso u obesidad, un 20% sufre de hipertensión, un 8% presenta hiperglucemia y un 15% consume tabaco. Además, el consumo promedio de sal es de 9 gramos al día.<sup><a href="https://paperpile.com/c/R7cCn1/HJ4Rt">2</a></sup> Paralelamente, se evidencia una clara deficiencia en la capacidad de proporcionar atención adecuada a las personas con hipertensión, que es el principal factor de riesgo de las ECV. Aunque se han logrado avances, el control de la hipertensión sigue siendo inaceptablemente deficiente. Los determinantes de las ECV son variados, pero destacan principalmente la incapacidad del sistema de salud para identificar a personas en riesgo, garantizar el acceso a medicamentos de calidad y cumplir con los estándares aceptados de atención médica.<sup><a href="https://paperpile.com/c/R7cCn1/Pr6Fd">3</a></sup>

Para abordar los desafíos relacionados con las ECV, la Organización Mundial de la Salud (OMS) lanzó la iniciativa Global HEARTS, adaptada en la Región de las Américas como HEARTS en las Américas. Esta iniciativa, liderada por los ministerios de salud locales y respaldada por la Organización Panamericana de la Salud (OPS), los Centros para el Control y la Prevención de Enfermedades (CDC, su sigla del ingles _Communicable Disease Center_) de Estados Unidos y la iniciativa de salud pública global Resolve to Save Lives, se enfoca en la prevención y control de las ECV. Actualmente, HEARTS en las Américas opera en 21 países y en 1045 centros de atención primaria de salud en América Latina y el Caribe. Su estrategia se basa en un enfoque de salud pública y de sistemas de salud, implementando intervenciones simplificadas en la atención primaria que priorizan la hipertensión como principal punto de atención clínica. Para el año 2025, HEARTS en las Américas se proyecta como el modelo a seguir para la gestión del riesgo de ECV en la atención primaria de salud en la Región.<sup><a href="https://paperpile.com/c/R7cCn1/rY9tb">4</a></sup>


## Nombre de Modelo

Hipertensión: EstimaHerramienta para Enfermedades Cardiovasculares (HTN: CVD EstimaTool, su sigla del inglés _Hypertension: cardiovascular disease EstimaTool_).<sup><a href="https://paperpile.com/c/R7cCn1/EfGzw">1</a></sup>


## Descripción del Modelo y Asunciones 

La herramienta en línea HTN: CVD EstimaTool, respaldada por la OPS, es una plataforma interactiva diseñada para estimar el número de muertes que podrían prevenirse controlando mejor la hipertensión. Esta herramienta se centra específicamente en las ECV más prevalentes: la enfermedad cardíaca isquémica (ECI) y los accidentes cerebrovasculares (ACV).<sup><a href="https://paperpile.com/c/R7cCn1/iDDLz+J8gC3">5,6</a></sup> Su objetivo principal es brindar apoyo a los profesionales encargados de los programas de prevención y control de enfermedades cardiovasculares, permitiéndoles evaluar el impacto que tendría una mejora en el control de la hipertensión en la reducción de la mortalidad relacionada con estas enfermedades en la población. Asimismo, habiendo adicionado al modelo indicadores de evaluación del impacto económico permite obtener información valiosa que puede ser utilizada para informar a las autoridades de salud, a los responsables de la toma de decisiones y a los formuladores de políticas públicas en el ámbito de la salud.<sup><a href="https://paperpile.com/c/R7cCn1/iDDLz+J8gC3">5,6</a></sup>

Este modelo se basa en la propuesta metodológica  desarrollada y publicada en el estudio titulado "Association between population hypertension control and ischemic heart disease and stroke mortality in 36 countries of the Americas, 1990-2019: an ecological study".<sup><a href="https://paperpile.com/c/R7cCn1/iDDLz+J8gC3">5,6</a></sup> En este trabajo se desarrollaron y ajustaron modelos específicos según el sexo y la causa de las enfermedades no trasmisibles (ECI y ACV) mediante análisis de regresión. Se utilizaron estimaciones del control poblacional de la hipertensión como variable independiente y estimaciones de mortalidad por ECI y ACV como variables dependientes. Los modelos de regresión regional con mejor ajuste se emplearon para predecir el nivel esperado de mortalidad por ECI y ACV, considerando un determinado nivel de control poblacional de la hipertensión.<sup><a href="https://paperpile.com/c/R7cCn1/iDDLz+J8gC3">5,6</a></sup>

El modelo de regresión se basó en dos fuentes de datos distintas: 1) estimaciones de tasas de mortalidad estandarizadas por edad por 100 000 habitantes, causadas por ECI, ACV y sus subtipos (como ACV isquémico, hemorragia intracerebral y hemorragia subaracnoidea), desglosadas por sexo, para la Región de las Américas y los 36 países y territorios durante el período de 1990 a 2019. Estas estimaciones se obtuvieron del Estudio de Carga Global de Enfermedades (GBD, su sigla del ingles _Global Burden of Disease Study_)<sup><a href="https://paperpile.com/c/R7cCn1/VhPsw">7</a></sup> y estimaciones de la prevalencia estandarizada por edad del control de la hipertensión poblacional, desglosadas por sexo, para la Región de las Américas y los 36 países. Estas estimaciones fueron extraídas del Observatorio Mundial de la Salud de la OMS y fueron producidas por la Colaboración de Factores de Riesgo de Enfermedades No Transmisibles (NCD RisC, su sigla del ingles _NCD Risk Factor Collaboration_).<sup><a href="https://paperpile.com/c/R7cCn1/8WDiH+iDDLz">5,8</a></sup>

El HTN:CVD EstimaTool ofrece una interfaz que consta de dos columnas: a la izquierda se encuentran los parámetros que permiten al usuario definir su escenario de análisis, mientras que a la derecha se presentan los resultados de dicho escenario de manera visual. Los usuarios tienen la posibilidad de ajustar los valores predefinidos de los parámetros en la columna izquierda de la herramienta mediante la introducción directa de los valores deseados o la selección de opciones específicas. Esto les permite personalizar su escenario de análisis. Por ejemplo, pueden ingresar el nombre y tamaño de la ubicación, establecer la prevalencia inicial y la meta de hipertensos diagnosticados, la prevalencia de pacientes tratados entre los diagnosticados, la prevalencia de control de la hipertensión entre los tratados, la prevalencia de control de la hipertensión en la población y el período de tiempo para alcanzar la meta. Estos cambios permiten visualizar el impacto en la mortalidad por enfermedades no transmisibles, como la ECI y ACV, en una población específica.

Los usuarios tienen la capacidad de modificar cualquier valor en los parámetros, ya sea en la línea de base o en la meta, simplemente ingresando los mismos directamente. Los cambios realizados en los valores de diagnóstico, tratamiento y control de la hipertensión entre los pacientes tratados, se utilizan para calcular la prevalencia de control de la hipertensión en la población hipertensa, ya sea en la línea de base o en la meta. Adicionalmente, los usuarios pueden especificar el número de años en los que se planifica alcanzar la meta establecida.<sup><a href="https://paperpile.com/c/R7cCn1/J8gC3">6</a></sup>

Utilizando como input la estimación de la mortalidad asociada a un aumento del grado de control de la hipertensión arterial es que posteriormente se realizó mediante una metodología propia una estimación de los años de vida perdidos así como los años de vida perdidos ajustados por discapacidad para los distintos países incluidos. Esta estimación distribuye las muertes cardiovasculares acorde a las pirámides poblacionales de los distintos países para de esta forma poder estimar carga de enfermedad evitada por edad y sexo para cada uno de los países. A su vez se realizó una estimación del número de eventos cardiovasculares que dan cuenta de estas muertes mediante una estimación reversa a través de la Tasa de Letalidad de los eventos cardiovasculares. Estos eventos estimados fueron utilizados para la estimación del impacto económico de la intervención.

En relación a la evaluación del impacto económico este modelo, se utilizó como guía la herramienta "Global HEARTS Costing Tool Version 5.4" desarrollada por Programas de Capacitación en Epidemiología y Red de Intervenciones en Salud Pública (TEPHINET, su sigla del inglés _Training Programs in Epidemiology and Public Health Interventions Network_) un programa de The Task Force for Global Health.<sup><a href="https://paperpile.com/c/R7cCn1/Usey5">9</a></sup> Se identificó y respetó el listado de recursos sanitarios, así como las tasas de uso respectivas, la frecuencia de visitas médicas y las dosis de los medicamentos utilizados en el tratamiento farmacológico, propuestos por esta herramienta (ver en más detalle en apartado de costos). 


## Limitaciones y Consideraciones

Este modelo aunque valioso, presenta ciertas limitaciones. Aporta datos observacionales ecológicos, siendo principal enfoque la relación entre el control de la hipertensión a nivel poblacional y la mortalidad cardiovascular. Esta asociación, aunque sólida y plausible, tiene sus desafíos. A pesar de ello, se alinea con los hallazgos de otros estudios en nuestra Región, incluyendo aquellos con metodologías más robustas. Datos de grandes cohortes en Cuba, México y América del Sur respaldan la importancia de la hipertensión como causa principal de eventos y mortalidad relacionados con las ECV.

Las principales fuentes de datos para este análisis son el estudio de la GBD y el estudio NCD-RisC. El GBD es una metodología consolidada que se actualiza continuamente, pero tiene limitaciones en cuanto a la incertidumbre de sus estimaciones. Por otro lado, el NCD-RisC, a pesar de ser una importante fuente de información sobre factores de riesgo de ECV, enfrenta cuestionamientos sobre la fiabilidad de su enfoque de vigilancia, especialmente por la falta de datos empíricos en muchos países incluidos en su análisis.

Una limitación adicional es la calidad de los datos de ciertos países, especialmente aquellos con sistemas de salud frágiles y bajos índices de desarrollo social, que pueden tener dificultades para implementar programas efectivos de manejo de la hipertensión. Esto se refleja en la discrepancia entre las tendencias de mortalidad por ECV observadas y el supuesto buen desempeño en el control de la hipertensión.<sup><a href="https://paperpile.com/c/R7cCn1/iDDLz">5</a></sup>

Respecto a las limitaciones relacionadas con los costos, es importante señalar que, debido a la ausencia de datos completos para todos los países, se efectúan estimaciones indirectas, las cuales se ajustan según el producto interno bruto (PIB) de cada nación. Además, todos los datos de costos son susceptibles de mejora y pueden ser personalizados para adaptarse a las particularidades de cada uno de los países considerados en el análisis."


## Descripción General de los Parámetros


<table>
  <tr>
   <td colspan="3" >
<h2>
    <strong>Parámetros epidemiológicos</strong></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>
    <strong>Parámetro</strong></h2>


   </td>
   <td>
<h2><strong>Descripción</strong></h2>


   </td>
   <td>
<h2><strong>Fuente</strong></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Porcentaje de personas diagnosticadas que se encuentran en  tratamiento (objetivo).</h2>


   </td>
   <td>
<h2>Refleja el objetivo fijado para el porcentaje de personas diagnosticadas con hipertensión que deben tener tratamiento.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/R7cCn1/8WDiH+iDDLz">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Población total del país</h2>


   </td>
   <td>
<h2>Población total (proyectada para el año 2023) de cada país.</h2>


   </td>
   <td>
<h2>Instituto de estadística de cada uno de los 8 países</h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Prevalencia de adultos con hipertensión, estandarizada por edad.</h2>


   </td>
   <td>
<h2>Prevalencia de individuos con hipertensión, diagnosticada o no, en el grupo etario de 30 a 79 años en cada país, proporcionando un punto de referencia inicial.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/R7cCn1/8WDiH+iDDLz">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Porcentaje de adultos con hipertensión diagnosticados </h2>


   </td>
   <td>
<h2>Porcentaje de individuos entre 30 y 79 años previamente diagnosticados con hipertensión, proporcionando un punto de referencia inicial.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/R7cCn1/8WDiH+iDDLz">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Porcentaje de personas diagnosticadas que se encuentran en  tratamiento (basal).</h2>


   </td>
   <td>
<h2>Porcentaje de personas que están recibiendo tratamiento en relación con el total de individuos que han sido diagnosticados con hipertensión en un punto inicial o línea de base.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/R7cCn1/8WDiH+iDDLz">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Porcentaje de adultos con hipertensión controla entre los tratados </h2>


   </td>
   <td>
<h2>Porcentaje de personas de 30 a 79 años, ya diagnosticadas con hipertensión y en tratamiento, que han conseguido controlar su presión arterial, proporcionando un punto de referencia inicial.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/R7cCn1/8WDiH+iDDLz">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Letalidad ponderada por edad y sexo para accidente cerebrovascular (grupo entre 30-79 años)</h2>


   </td>
   <td>
<h2>Índice de letalidad (tasa de letalidad ponderada por sexo y edad) para accidente cerebrovascular en el grupo de edad de 30 a 79 años.</h2>


   </td>
   <td>
<h2>Internações: Sistema de Informações Hospitalares/Ministério da Saúde - 2022<sup><a href="https://paperpile.com/c/R7cCn1/0kSTw">10</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Letalidad ponderada por edad y sexo para enfermedad cardíaca isquémica (grupo entre 30-79 años)</h2>


   </td>
   <td>
<h2>Índice de letalidad (tasa de letalidad ponderada por sexo y edad) para enfermedad cardíaca isquémica en el grupo de edad de 30 a 79 años.</h2>


   </td>
   <td>
<h2>Internações: Sistema de Informações Hospitalares/Ministério da Saúde - 2022<sup><a href="https://paperpile.com/c/R7cCn1/0kSTw">10</a></sup></h2>


   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros de costos </strong>
   </td>
  </tr>
  <tr>
   <td>
    <strong>Parámetro</strong>
   </td>
   <td><strong>Descripción</strong>
   </td>
   <td><strong>Fuente</strong>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual promedio por paciente (USD)
   </td>
   <td>Costo del tratamiento farmacológico promedio por paciente, ponderado por la proporción de pacientes que están en cada STEP de hipertensión para el país específico.  
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/R7cCn1/Ju9ba">11</a></sup> BRA,<sup><a href="https://paperpile.com/c/R7cCn1/bvVBm">12</a></sup> COL,<sup><a href="https://paperpile.com/c/R7cCn1/5iqft">13</a></sup> ECU<sup><a href="https://paperpile.com/c/R7cCn1/Qw0jm">14</a></sup> y PER.<sup><a href="https://paperpile.com/c/R7cCn1/ElIxm">15</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/R7cCn1/K9Ite">16</a></sup>: CHL.<sup><a href="https://paperpile.com/c/R7cCn1/XPn8Y">17</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para abril de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de seguimiento anual promedio por paciente (USD)
   </td>
   <td>Costos de seguimiento (farmacológico, consultas médicas, etc) anual por paciente. 
   </td>
   <td>Nomencladores específicos para ARG<sup><a href="https://paperpile.com/c/R7cCn1/XYsx">33</a></sup>, BRA <sup><a href="https://paperpile.com/c/R7cCn1/Z01f">34</a></sup>, CHL <sup><a href="https://paperpile.com/c/R7cCn1/PlyG+xXkJ">35,36</a></sup> y COL <sup><a href="https://paperpile.com/c/R7cCn1/w6pC+3Zmo">37,38</a></sup>. 
<p>
Estimación indirecta* para CRC, ECU, MEX y PER.
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para abril de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de evento de enfermedad coronaria isquémica (USD)
   </td>
   <td>Costos de tratar un evento de enfermedad coronaria isquémica. 
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/R7cCn1/yZZbn">25</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/R7cCn1/wx2G5+MRUip+QiELC+m4sVN+mpZTx+sEYWn+Tsaq4+aDl2w">19,26–32</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para abril de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de evento de accidente cerebrovascular (USD)
   </td>
   <td>Costos de tratar un evento de accidente cerebrovascular. 
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/R7cCn1/yZZbn">25</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/R7cCn1/wx2G5+MRUip+QiELC+m4sVN+mpZTx+sEYWn+Tsaq4+aDl2w">19,26–32</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para abril de 2023.
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento (%)
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros. 
   </td>
   <td>Manual metodológico para elaboración de Evaluaciones Económicas <sup><a href="https://paperpile.com/c/R7cCn1/Tkvz">39</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo programático anual (USD)
   </td>
   <td>Costo de implementar y sostener la intervención en un año. (USD oficial a tasa de cambio nominal de cada país).
   </td>
   <td>Se deja la posibilidad al usuario de completar este dato si cuenta con él
   </td>
  </tr>
</table>


*Debido a que no se contó con información específica del país, los costos fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.


## Lista de indicadores

**Resultados epidemiológicos**



1. **Población de adultos entre 30 y 79 años con hipertensión que inició tratamiento (n): **número total de adultos en ese rango de edad que han sido diagnosticados recientemente con hipertensión y han comenzado un tratamiento para la misma.

    Ej: **Población de adultos entre 30 y 79 años con hipertensión que inició tratamiento n = 5.418.194,4. **En este caso el modelo indica que la intervención propuesta tiene el potencial hacer que 5.418.194,4 adultos entre 30 y 79 años con hipertensión inicien tratamiento.**	**

2. **Eventos Coronarios (EC) evitados (n): **número de EC evitados tras la implementación de la intervención.

    Ej: **EC** **evitados n = 67.531,3. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 67.531,3 EC en la población. 

3. **Tasa de EC evitados cada 100.000 habitantes (n/100.000 hab):** número de EC incidentes evitados por cada 100.000 habitantes tras la implementación de la intervención.

    Ej: **Tasa de EC evitados cada 100.000 habitantes =  148,8. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 148,8 EC por cada 100.000 habitantes.

4. **Accidente Cerebrovascular (ACV) evitados (n): **número de eventos por ACV evitados tras la implementación de la intervención.

    Ej: **ACV evitados n = 9.411,0. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 9.411,0 eventos por ACV en la población. 

5. **Tasa de ACV evitados cada 100.000 habitantes (n/100.000 hab): **número de ACV incidentes evitados por cada 100.000 habitantes tras la implementación de la intervención.

    Ej: **Tasa de nuevos ACV evitados cada 100.000 habitantes = 20,9. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 20,9 ACV por cada 100.000 habitantes.

6. **Muertes evitadas por EC (n): **número de muertes por EC evitadas tras la implementación de la intervención

    Ej: **Muertes evitadas por EC n = 4.221. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 4.221 muertes por EC en la población. 

7. **Muertes por EC por cada 100.000 habitantes que podrían evitarse (n/100.000 hab): **número de muertes por EC por cada 100.000 habitantes que podrían ser evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas por EC por cada 100.000 habitantes que podrían evitarse = 9,3. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 9,3 muertes por EC por cada 100.000 habitantes. 

8. **Muertes evitadas por ACV (n): **número de muertes por ACV evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas por ACV n= 1400. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 1400 muertes por ACV en la población. 

9. **Muertes por ACV por cada 100.000 habitantes que podrían evitarse (n/100.000): **número de muertes por ACV por cada 100.000 habitantes que podrían ser evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas por ACV por cada 100.000 habitantes que podrían evitarse = 3,2. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 3,2 muertes por ACV por cada 100.000 habitantes.

10. **Muertes evitadas (n): **número de muertes por EC y ACV evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas n = 5600 **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 5600 muertes por EC y ACV en la población. 

11. **Muertes totales por cada 100.000 habitantes que podrían evitarse (n/100.000): **número de muertes por EC y ACV por cada 100.000 habitantes que podrían ser evitadas tras la implementación de la intervención.

    Ej: **Muertes totales por cada 100.000 habitantes que podrían evitarse = 12. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 12 muertes por EC y ACV por cada 100.000 habitantes.

12. **Años de vida salvados:** cantidad de años que se preservarán al evitar muertes prematuras causadas por EC y ACV en la población.

    Ej: **Años de vida salvados n=86000. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de **86000 **años debido a muertes prematuras en la población. 

13. **Años de vida ajustados por discapacidad evitados (n):  **especifica la cantidad de años que se salvaron de la carga de discapacidad causada por eventos de EC y ACV en la población.

    Ej: **Años de vida ajustados por discapacidad evitados n = 92.000. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de **92.000 **años de vida ajustados por discapacidad en la población.


**Resultados económicos**



14. **Costo total de la intervención (USD):** el costo total anual de la intervención en relación con la población objetivo que se alcanza con el tratamiento. 

    Ej: **Costo total de la intervención USD = $201.416.348,6 USD: **el costo total anual de la intervención en relación con la población objetivo que se alcanza con el tratamiento es de $201.416.348,6 USD. ** ** 

15. **Costos evitados atribuibles a la intervención (USD):** los costos evitados incluyen los costos específicos de tratar un evento de infarto agudo de miocardio, un evento de angina coronaria no infarto y un accidente cerebrovascular para cada uno de los países. Se calculan teniendo en cuenta el número de eventos evitados gracias al tratamiento.

    Ej: **Costos evitados atribuibles a la intervención = $258.024.719,4 USD: **los costos médicos directos evitados por eventos cardiovasculares gracias a la intervención son de $258.024.719,4 USD.  

16. **Diferencia de costos respecto al escenario basal (USD):** la diferencia de costos surge de restarle a los costos de la intervención los costos evitados por eventos coronarios y accidentes cerebrovasculares.

    Ej: **Diferencia de costos respecto al escenario basal USD = -$56.608.370,8 USD: **la diferencia de costos de la intervención debido a los costos evitados por eventos coronarios y accidentes cerebrovasculares es de -$56.608.370,8 USD.** ** 

17. **Razón de costo-efectividad incremental (RCEI) por vida salvada (VS) (USD): **costo adicional por cada vida que se salva como resultado de la implementación de la vacunación. 

    Ej: **RCEI por VS = $300 USD: **en promedio, cada vida salvada por la implementación de la vacunación cuesta un adicional de $**300 **USD. ** **

18. **Razón de costo-efectividad incremental (RCEI) por año de vida salvado (AVS) (USD): **diferencia de costos dividido por el número de años salvados gracias a la intervención.

    Ej: **RCEI por AVS = $9.564 USD: **cada año adicional de vida salvado con la intervención cuesta $9.564 USD. 

19. **Razón de costo-efectividad incremental (RCEI) por  Año de Vida Ajustado por Discapacidad evitado (USD): **diferencia de costos dividido por el número de años de vida ajustados por discapacidad evitados gracias a la intervención. 

    Ej: **RCEI por año de vida ajustado por discapacidad evitado = -$615 USD: **evitar un año de vida ajustado por discapacidad con la intervención cuesta $615 USD

20. **Retorno de Inversión (ROI) (%): **relación entre los beneficios económicos obtenidos y el costo de la intervención. Un ROI positivo indica que la intervención no sólo cubre su costo, sino que también genera un beneficio económico adicional (en intervenciones costo-ahorrativas). Se define como los ingresos menos la inversión, dividido por la inversión. En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la intervención no alcanzan para recuperar la inversión inicial. 

    Ej: **Retorno de la inversión (ROI) = 28%: **por cada 1 USD invertido en la intervención, se ganan 0.28 céntimos de USD además de recuperar el capital inicial.




Referencias


    1.	[Martinez R, Soliz P, Mujica OJ, Reveiz L, Campbell NRC, Ordunez P. The slowdown in the reduction rate of premature mortality from cardiovascular diseases puts the Americas at risk of achieving SDG 3.4: A population trend analysis of 37 countries from 1990 to 2017. J Clin Hypertens . 2020;22(8):1296-1309.](http://paperpile.com/b/R7cCn1/EfGzw)


    2.	[Las ENT de un vistazo: Mortalidad de las enfermedades no transmisibles y prevalencia de sus factores de riesgo en la Región de las Américas. Published online 2019. Accessed December 13, 2023. https://iris.paho.org/handle/10665.2/51752](http://paperpile.com/b/R7cCn1/HJ4Rt)


    3.	[NCD Risk Factor Collaboration (NCD-RisC). Worldwide trends in hypertension prevalence and progress in treatment and control from 1990 to 2019: a pooled analysis of 1201 population-representative studies with 104 million participants. Lancet. 2021;398(10304):957-980.](http://paperpile.com/b/R7cCn1/Pr6Fd)


    4.	[Campbell NRC, Ordunez P, Giraldo G, et al. WHO HEARTS: A Global Program to Reduce Cardiovascular Disease Burden: Experience Implementing in the Americas and Opportunities in Canada. Can J Cardiol. 2021;37(5):744-755.](http://paperpile.com/b/R7cCn1/rY9tb)


    5.	[Martinez R, Soliz P, Campbell NRC, Lackland DT, Whelton PK, Ordunez P. Association between population hypertension control and ischemic heart disease and stroke mortality in 36 countries of the Americas, 1990-2019: an ecological study. Rev Panam Salud Publica. 2022;46:e143.](http://paperpile.com/b/R7cCn1/iDDLz)


    6.	[HTN:CVD EstimaTool: acerca de. Accessed June 15, 2023. https://www.paho.org/es/enlace/htncvd-estimatool-acerca](http://paperpile.com/b/R7cCn1/J8gC3)


    7.	[Global Burden of Disease (GBD). Institute for Health Metrics and Evaluation. Published March 29, 2014. Accessed June 15, 2023. https://www.healthdata.org/gbd](http://paperpile.com/b/R7cCn1/VhPsw)


    8.	[NCD Risk Factor Collaboration (NCD-RisC). Accessed June 15, 2023. https://epinut.umh.es/ncd-risk-factor-collaboration-ncd-risc/](http://paperpile.com/b/R7cCn1/8WDiH)


    9.	[HEARTS Costing Tool. Accessed April 5, 2023. https://www.tephinet.org/tephinet-learning-center/tephinet-library/hearts-costing-tool](http://paperpile.com/b/R7cCn1/Usey5)


    10.	[Sistema de Internações Hospitalares. Accessed December 13, 2023. http://sihd.datasus.gov.br/principal/index.php](http://paperpile.com/b/R7cCn1/0kSTw)


    11.	[SRV PRECIO. Accessed September 18, 2023. https://www.alfabeta.net/precio/srv](http://paperpile.com/b/R7cCn1/Ju9ba)


    12.	[Kairos preço de remedios. Kairos Web. Published September 28, 2019. Accessed September 21, 2023. https://br.kairosweb.com/](http://paperpile.com/b/R7cCn1/bvVBm)


    13.	[Termómetro de precios de medicamentos. Colombia Potencia de la Vida. Accessed September 17, 2023. https://www.minsalud.gov.co/salud/MT/Paginas/termometro-de-precios.aspx](http://paperpile.com/b/R7cCn1/5iqft)


    14.	[Farmaprecios. Accessed September 25, 2023. https://www.farmaprecios.com.ec/](http://paperpile.com/b/R7cCn1/Qw0jm)


    15.	[Observatorio Peruano de Productos Farmacéuticos. SISTEMA NACIONAL DE INFORMACIÓN DE PRECIOS DE PRODUCTOS FARMACÉUTICOS - SNIPPF. Accessed September 17, 2023. https://opm-digemid.minsa.gob.pe/#/consulta-producto](http://paperpile.com/b/R7cCn1/ElIxm)


    16.	[Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/R7cCn1/K9Ite)


    17.	[Kairos Web Chile - Buscador de precios de Medicamentos y Drogas. Accessed September 18, 2023. https://cl.kairosweb.com/](http://paperpile.com/b/R7cCn1/XPn8Y)


    18.	[Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/R7cCn1/LLXZW)


    19.	[Banco Central do Brasil. Accessed September 25, 2023. https://www3.bcb.gov.br/sgspub/consultarvalores/telaCvsSelecionarSeries.paint](http://paperpile.com/b/R7cCn1/MRUip)


    20.	[de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/R7cCn1/HF0BY)


    21.	[Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/R7cCn1/h7YZG)


    22.	[Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/R7cCn1/EZdD7)


    23.	[Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/R7cCn1/lzRAB)


    24.	[Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/R7cCn1/MUwL1)


    25.	[Pichon-Riviere A, Bardach A, Rodríguez Cairoli F, et al. Health, economic and social burden of tobacco in Latin America and the expected gains of fully implementing taxes, plain packaging, advertising bans and smoke-free environments control measures: a modelling study. Tob Control. Published online May 4, 2023. doi:10.1136/tc-2022-057618](http://paperpile.com/b/R7cCn1/yZZbn)


    26.	[INDEC, Instituto Nacional de Estadistica y Censos de la REPUBLICA ARGENTINA. INDEC: Instituto Nacional de Estadística y Censos de la República Argentina. Accessed September 25, 2023. https://www.indec.gob.ar/indec/web/Nivel4-Tema-3-5-31](http://paperpile.com/b/R7cCn1/wx2G5)


    27.	[Base de Datos Estadísticos (BDE). Accessed September 25, 2023. https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_PRECIOS/MN_CAP_PRECIOS/PEM_VAR_IPC_NEW/637775848569931668](http://paperpile.com/b/R7cCn1/QiELC)


    28.	[DANE - IPC información técnica. Accessed September 25, 2023. https://www.dane.gov.co/index.php/estadisticas-por-tema/precios-y-costos/indice-de-precios-al-consumidor-ipc/ipc-informacion-tecnica](http://paperpile.com/b/R7cCn1/m4sVN)


    29.	[Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/R7cCn1/mpZTx)


    30.	[Banco Central del Ecuador - Información Económica. Accessed September 25, 2023. https://www.bce.fin.ec/informacioneconomica](http://paperpile.com/b/R7cCn1/sEYWn)


    31.	[Estructura de información (SIE, Banco de México). Accessed September 25, 2023. https://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=8&accion=consultarCuadro&idCuadro=CP151&locale=es](http://paperpile.com/b/R7cCn1/Tsaq4)


    32.	[BCRP - Series mensuales. Accessed September 25, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/indice-de-precios-indice-dic-2021-100](http://paperpile.com/b/R7cCn1/aDl2w)


    33.	[Valores de Cartilla y Nomenclador. Accessed December 26, 2023. https://sistemas.amepla.org.ar/cartillaweb/iniciocartilla.aspx](http://paperpile.com/b/R7cCn1/XYsx)


    34.	[SIGTAP - Sistema de Gerenciamento da Tabela de Procedimentos, Medicamentos e OPM do SUS. Accessed December 26, 2023. http://sigtap.datasus.gov.br/tabela-unificada/app/sec/inicio.jsp](http://paperpile.com/b/R7cCn1/Z01f)


    35.	[Fonasa. Modalidad de libre elección. https://www.fonasa.cl/sites/fonasa/prestadores/modalidad-libre-eleccion](http://paperpile.com/b/R7cCn1/PlyG)


    36.	[Precios de Garantías Explícitas en Salud en Isapres - Precios de Garantías Explícitas en Salud en Isapres. Orientación en Salud. Superintendencia de Salud, Gobierno de Chile. Accessed December 26, 2023. http://www.supersalud.gob.cl/difusion/665/w3-article-17297.html](http://paperpile.com/b/R7cCn1/xXkJ)


    37.	[Tarifas ISS2001. Accessed December 26, 2023. https://lexsaludcolombia.files.wordpress.com/2010/10/tarifas-iss-2001.pdf](http://paperpile.com/b/R7cCn1/w6pC)


    38.	[Muñoz CF. Manual Tarifario de Salud SOAT 2023 - versión PDF. CONSULTORSALUD. Published January 2, 2023. Accessed December 26, 2023. https://consultorsalud.com/manual-tarifario-de-salud-soat-2023-version-pdf/](http://paperpile.com/b/R7cCn1/3Zmo)


    39.	[Moreno M, Aurelio M, Castro H. Manual metodológico para la elaboración de Evaluaciones Económicas. IETS. Accessed December 26, 2023. https://www.iets.org.co/Archivos/64/Manual_evaluacion_economica.pdf](http://paperpile.com/b/R7cCn1/Tkvz)


## 
    Anexos


## Descripción parámetros internos del modelo


<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros epidemiológicos</strong>
   </td>
  </tr>
  <tr>
   <td>
    <strong>Parámetro</strong>
   </td>
   <td><strong>Descripción</strong>
   </td>
   <td><strong>Fuente</strong>
   </td>
  </tr>
  <tr>
   <td>Número de muertes totales por ECI entre 30 y 79 años
   </td>
   <td>Número total de muertes por ECI, desglosado por sexo y grupo de edad (30 a 79 años), en cada pais (última actualización año 2019).
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/R7cCn1/VhPsw">7</a></sup> 
   </td>
  </tr>
  <tr>
   <td>Número de muertes totales por ACV entre 30 y 79 años
   </td>
   <td>Número total de muertes por ACV, desglosado por sexo y grupo de edad (30 a 79 años), en cada pais (última actualización año 2019).
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/R7cCn1/VhPsw">7</a></sup> 
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros de costos </strong>
   </td>
  </tr>
  <tr>
   <td>
    <strong>Parámetro</strong>
   </td>
   <td><strong>Descripción</strong>
   </td>
   <td><strong>Fuente</strong>
   </td>
  </tr>
  <tr>
   <td>Consulta médica
   </td>
   <td>Costo de una consulta médica en el país para abril de 2023.
   </td>
   <td>Nomencladores de cada país, actualizados por inflación en dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/wx2G5+MRUip+m4sVN+mpZTx+sEYWn+Tsaq4+aDl2w+QiELC+LLXZW+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24,26–32</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo anual de consulta médica en paciente promedio
   </td>
   <td>Tiene en cuenta el número de visitas médicas anuales necesarias por paciente según nivel de riesgo cardiovascular calculado y la proporción de pacientes con ese nivel de riesgo, por país para abril de 2023.
   </td>
   <td>Nomencladores de cada país, actualizados por inflación en dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/wx2G5+MRUip+m4sVN+mpZTx+sEYWn+Tsaq4+aDl2w+QiELC+LLXZW+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24,26–32</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 2
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/R7cCn1/Ju9ba">11</a></sup> BRA,<sup><a href="https://paperpile.com/c/R7cCn1/bvVBm">12</a></sup> COL,<sup><a href="https://paperpile.com/c/R7cCn1/5iqft">13</a></sup> ECU<sup><a href="https://paperpile.com/c/R7cCn1/Qw0jm">14</a></sup> y PER.<sup><a href="https://paperpile.com/c/R7cCn1/ElIxm">15</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/R7cCn1/K9Ite">16</a></sup>: CHL.<sup><a href="https://paperpile.com/c/R7cCn1/XPn8Y">17</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 3
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días y 20 mg de enalapril una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/R7cCn1/Ju9ba">11</a></sup> BRA,<sup><a href="https://paperpile.com/c/R7cCn1/bvVBm">12</a></sup> COL,<sup><a href="https://paperpile.com/c/R7cCn1/5iqft">13</a></sup> ECU<sup><a href="https://paperpile.com/c/R7cCn1/Qw0jm">14</a></sup> y PER.<sup><a href="https://paperpile.com/c/R7cCn1/ElIxm">15</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/R7cCn1/K9Ite">16</a></sup>: CHL.<sup><a href="https://paperpile.com/c/R7cCn1/XPn8Y">17</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 4
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días y 20 mg de enalapril dos veces al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/R7cCn1/Ju9ba">11</a></sup> BRA,<sup><a href="https://paperpile.com/c/R7cCn1/bvVBm">12</a></sup> COL,<sup><a href="https://paperpile.com/c/R7cCn1/5iqft">13</a></sup> ECU<sup><a href="https://paperpile.com/c/R7cCn1/Qw0jm">14</a></sup> y PER.<sup><a href="https://paperpile.com/c/R7cCn1/ElIxm">15</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/R7cCn1/K9Ite">16</a></sup>: CHL.<sup><a href="https://paperpile.com/c/R7cCn1/XPn8Y">17</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 5
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días, 20 mg de enalapril dos veces al día durante 365 días y 5mg amlodipina una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/R7cCn1/Ju9ba">11</a></sup> BRA,<sup><a href="https://paperpile.com/c/R7cCn1/bvVBm">12</a></sup> COL,<sup><a href="https://paperpile.com/c/R7cCn1/5iqft">13</a></sup> ECU<sup><a href="https://paperpile.com/c/R7cCn1/Qw0jm">14</a></sup> y PER.<sup><a href="https://paperpile.com/c/R7cCn1/ElIxm">15</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/R7cCn1/K9Ite">16</a></sup>: CHL.<sup><a href="https://paperpile.com/c/R7cCn1/XPn8Y">17</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 6
   </td>
   <td>12.5mg de Clortalidona una vez al día durante 365 días, 20 mg de enalapril dos veces al día durante 365 días y 10mg amlodipina una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/R7cCn1/Ju9ba">11</a></sup> BRA,<sup><a href="https://paperpile.com/c/R7cCn1/bvVBm">12</a></sup> COL,<sup><a href="https://paperpile.com/c/R7cCn1/5iqft">13</a></sup> ECU<sup><a href="https://paperpile.com/c/R7cCn1/Qw0jm">14</a></sup> y PER.<sup><a href="https://paperpile.com/c/R7cCn1/ElIxm">15</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/R7cCn1/K9Ite">16</a></sup>: CHL.<sup><a href="https://paperpile.com/c/R7cCn1/XPn8Y">17</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de evento coronario no infarto
   </td>
   <td>Costos de tratar un evento de angina coronaria no infarto por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/R7cCn1/yZZbn">25</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/R7cCn1/wx2G5+MRUip+QiELC+m4sVN+mpZTx+sEYWn+Tsaq4+aDl2w">19,26–32</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de evento de ACV
   </td>
   <td>Costos de tratar un accidente cerebrovascular por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/R7cCn1/yZZbn">25</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/R7cCn1/wx2G5+MRUip+QiELC+m4sVN+mpZTx+sEYWn+Tsaq4+aDl2w">19,26–32</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/R7cCn1/LLXZW+MRUip+HF0BY+h7YZG+EZdD7+lzRAB+MUwL1">18–24</a></sup>
   </td>
  </tr>
</table>


*Debido a que no se contó con información específica del país, los costos fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.

