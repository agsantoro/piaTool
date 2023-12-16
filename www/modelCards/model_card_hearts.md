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

# 2. Model Card: HEARTS


---


## Introducción

A pesar de los avances considerables en las últimas décadas, las enfermedades cardiovasculares (ECV) todavía representan el mayor desafío de salud en la Región de las Américas. Estas enfermedades son responsables de un tercio de todas las muertes y causan un impacto económico y social notable. En 2017, se reportaron 14 millones de nuevos casos de ECV y se estimó que 80 millones de personas sufrían de alguna forma de estas enfermedades, contribuyendo a 2 millones de defunciones en esta región. Aunque hubo una disminución en las muertes prematuras por ECV de 2007 a 2013, este progreso se detuvo entre 2013 y 2017, con un estancamiento en casi todos los países de las Américas.<sup><a href="https://paperpile.com/c/8S3UO1/V0mp">1</a></sup>

La grave crisis de las ECV en la Región está estrechamente relacionada con la alta prevalencia de sus factores de riesgo entre la población. Más del 60% de las personas en esta región padecen sobrepeso u obesidad, un 20% sufre de hipertensión, un 8% presenta hiperglucemia y un 15% consume tabaco. Además, el consumo promedio de sal es de 9 gramos al día.<sup><a href="https://paperpile.com/c/8S3UO1/rq3v">2</a></sup> Paralelamente, se evidencia una clara deficiencia en la capacidad de proporcionar atención adecuada a las personas con hipertensión, que es el principal factor de riesgo de las ECV. Aunque se han logrado avances, el control de la hipertensión sigue siendo inaceptablemente deficiente. Los determinantes de las ECV son variados, pero destacan principalmente la incapacidad del sistema de salud para identificar a personas en riesgo, garantizar el acceso a medicamentos de calidad y cumplir con los estándares aceptados de atención médica.<sup><a href="https://paperpile.com/c/8S3UO1/H4bF">3</a></sup>

Para abordar los desafíos relacionados con las ECV, la Organización Mundial de la Salud (OMS) lanzó la iniciativa Global HEARTS, adaptada en la Región de las Américas como HEARTS en las Américas. Esta iniciativa, liderada por los ministerios de salud locales y respaldada por la Organización Panamericana de la Salud (OPS), los Centros para el Control y la Prevención de Enfermedades (CDC, su sigla del ingles _Communicable Disease Center_) de Estados Unidos y la iniciativa de salud pública global Resolve to Save Lives, se enfoca en la prevención y control de las ECV. Actualmente, HEARTS en las Américas opera en 21 países y en 1045 centros de atención primaria de salud en América Latina y el Caribe. Su estrategia se basa en un enfoque de salud pública y de sistemas de salud, implementando intervenciones simplificadas en la atención primaria que priorizan la hipertensión como principal punto de atención clínica. Para el año 2025, HEARTS en las Américas se proyecta como el modelo a seguir para la gestión del riesgo de ECV en la atención primaria de salud en la Región.<sup><a href="https://paperpile.com/c/8S3UO1/yRi7">4</a></sup>


## Nombre de Modelo

Hipertensión: EstimaHerramienta para Enfermedades Cardiovasculares (HTN: CVD EstimaTool, su sigla del inglés _Hypertension: cardiovascular disease EstimaTool_).<sup><a href="https://paperpile.com/c/8S3UO1/V0mp">1</a></sup>


## Descripción del Modelo y Asunciones 

La herramienta en línea HTN: CVD EstimaTool, respaldada por la OPS, es una plataforma interactiva diseñada para estimar el número de muertes que podrían prevenirse controlando mejor la hipertensión. Esta herramienta se centra específicamente en las ECV más prevalentes: la enfermedad cardíaca isquémica (ECI) y los accidentes cerebrovasculares (ACV).<sup><a href="https://paperpile.com/c/8S3UO1/hbU39+qmDmB">5,6</a></sup> Su objetivo principal es brindar apoyo a los profesionales encargados de los programas de prevención y control de enfermedades cardiovasculares, permitiéndoles evaluar el impacto que tendría una mejora en el control de la hipertensión en la reducción de la mortalidad relacionada con estas enfermedades en la población. Asimismo, habiendo adicionado al modelo indicadores de evaluación del impacto económico permite obtener información valiosa que puede ser utilizada para informar a las autoridades de salud, a los responsables de la toma de decisiones y a los formuladores de políticas públicas en el ámbito de la salud.<sup><a href="https://paperpile.com/c/8S3UO1/hbU39+qmDmB">5,6</a></sup>

Este modelo se basa en la propuesta metodológica  desarrollada y publicada en el estudio titulado "Association between population hypertension control and ischemic heart disease and stroke mortality in 36 countries of the Americas, 1990-2019: an ecological study".<sup><a href="https://paperpile.com/c/8S3UO1/hbU39+qmDmB">5,6</a></sup> En este trabajo se desarrollaron y ajustaron modelos específicos según el sexo y la causa de las enfermedades no trasmisibles (ECI y ACV) mediante análisis de regresión. Se utilizaron estimaciones del control poblacional de la hipertensión como variable independiente y estimaciones de mortalidad por ECI y ACV como variables dependientes. Los modelos de regresión regional con mejor ajuste se emplearon para predecir el nivel esperado de mortalidad por ECI y ACV, considerando un determinado nivel de control poblacional de la hipertensión.<sup><a href="https://paperpile.com/c/8S3UO1/hbU39+qmDmB">5,6</a></sup>

El modelo de regresión se basó en dos fuentes de datos distintas: 1) estimaciones de tasas de mortalidad estandarizadas por edad por 100 000 habitantes, causadas por ECI, ACV y sus subtipos (como ACV isquémico, hemorragia intracerebral y hemorragia subaracnoidea), desglosadas por sexo, para la Región de las Américas y los 36 países y territorios durante el período de 1990 a 2019. Estas estimaciones se obtuvieron del Estudio de Carga Global de Enfermedades (GBD, su sigla del ingles _Global Burden of Disease Study_)<sup><a href="https://paperpile.com/c/8S3UO1/A5Qe5">7</a></sup> y estimaciones de la prevalencia estandarizada por edad del control de la hipertensión poblacional, desglosadas por sexo, para la Región de las Américas y los 36 países. Estas estimaciones fueron extraídas del Observatorio Mundial de la Salud de la OMS y fueron producidas por la Colaboración de Factores de Riesgo de Enfermedades No Transmisibles (NCD RisC, su sigla del ingles _NCD Risk Factor Collaboration_).<sup><a href="https://paperpile.com/c/8S3UO1/LBUiI+hbU39">5,8</a></sup>

El HTN:CVD EstimaTool ofrece una interfaz que consta de dos columnas: a la izquierda se encuentran los parámetros que permiten al usuario definir su escenario de análisis, mientras que a la derecha se presentan los resultados de dicho escenario de manera visual. Los usuarios tienen la posibilidad de ajustar los valores predefinidos de los parámetros en la columna izquierda de la herramienta mediante la introducción directa de los valores deseados o la selección de opciones específicas. Esto les permite personalizar su escenario de análisis. Por ejemplo, pueden ingresar el nombre y tamaño de la ubicación, establecer la prevalencia inicial y la meta de hipertensos diagnosticados, la prevalencia de pacientes tratados entre los diagnosticados, la prevalencia de control de la hipertensión entre los tratados, la prevalencia de control de la hipertensión en la población y el período de tiempo para alcanzar la meta. Estos cambios permiten visualizar el impacto en la mortalidad por enfermedades no transmisibles, como la ECI y ACV, en una población específica.

Los usuarios tienen la capacidad de modificar cualquier valor en los parámetros, ya sea en la línea de base o en la meta, simplemente ingresando los mismos directamente. Los cambios realizados en los valores de diagnóstico, tratamiento y control de la hipertensión entre los pacientes tratados, se utilizan para calcular la prevalencia de control de la hipertensión en la población hipertensa, ya sea en la línea de base o en la meta. Adicionalmente, los usuarios pueden especificar el número de años en los que se planifica alcanzar la meta establecida.<sup><a href="https://paperpile.com/c/8S3UO1/qmDmB">6</a></sup>

Utilizando como input la estimación de la mortalidad asociada a un aumento del grado de control de la Hipertensión Arterial es que posteriormente se realizó mediante una metodología propia una estimación de los años de vida perdidos así como los años de vida perdidos ajustados por discapacidad para los distintos países incluidos. Esta estimación distribuye las muertes cardiovasculares acorde a las pirámides poblacionales de los distintos países para de esta forma poder estimar carga de enfermedad evitada por edad y sexo para cada uno de los países. A su vez se realizó una estimación del número de eventos cardiovasculares que dan cuenta de estas muertes mediante una estimación reversa a través de la Tasa de Letalidad de los eventos cardiovasculares. Estos eventos estimados fueron utilizados para la estimación del impacto económico de la intervención.

En relación a la evaluación del impacto económico este modelo, se utilizó como guía la herramienta "Global HEARTS Costing Tool Version 5.4" desarrollada por Programas de Capacitación en Epidemiología y Red de Intervenciones en Salud Pública (TEPHINET, su sigla del ingles _Training Programs in Epidemiology and Public Health Interventions Network_) un programa de The Task Force for Global Health.<sup><a href="https://paperpile.com/c/8S3UO1/pdei9">9</a></sup> Se identificó y respetó el listado de recursos sanitarios, así como las tasas de uso respectivas, la frecuencia de visitas médicas y las dosis de los medicamentos utilizados en el tratamiento farmacológico, propuestos por esta herramienta (ver en más detalle en apartado de costos). 


## Limitaciones y Consideraciones

Este modelo aunque valioso, presenta ciertas limitaciones. Aporta datos observacionales ecológicos, siendo principal enfoque la relación entre el control de la hipertensión a nivel poblacional y la mortalidad cardiovascular. Esta asociación, aunque sólida y plausible, tiene sus desafíos. A pesar de ello, se alinea con los hallazgos de otros estudios en nuestra Región, incluyendo aquellos con metodologías más robustas. Datos de grandes cohortes en Cuba, México y América del Sur respaldan la importancia de la hipertensión como causa principal de eventos y mortalidad relacionados con las ECV.

Las principales fuentes de datos para este análisis son el estudio de la GBD y el estudio NCD-RisC. El GBD es una metodología consolidada que se actualiza continuamente, pero tiene limitaciones en cuanto a la incertidumbre de sus estimaciones. Por otro lado, el NCD-RisC, a pesar de ser una importante fuente de información sobre factores de riesgo de ECV, enfrenta cuestionamientos sobre la fiabilidad de su enfoque de vigilancia, especialmente por la falta de datos empíricos en muchos países incluidos en su análisis.

Una limitación adicional es la calidad de los datos de ciertos países, especialmente aquellos con sistemas de salud frágiles y bajos índices de desarrollo social, que pueden tener dificultades para implementar programas efectivos de manejo de la hipertensión. Esto se refleja en la discrepancia entre las tendencias de mortalidad por ECV observadas y el supuesto buen desempeño en el control de la hipertensión.<sup><a href="https://paperpile.com/c/8S3UO1/hbU39">5</a></sup>

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
<h2>Porcentaje de tratamiento entre diagnosticados (línea base).</h2>


   </td>
   <td>
<h2>Porcentaje de personas que están recibiendo tratamiento en relación con el total de individuos que han sido diagnosticados con una hipertensión en un punto inicial o línea de base.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/8S3UO1/LBUiI+hbU39">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Porcentaje de tratamiento entre diagnosticados (objetivo).</h2>


   </td>
   <td>
<h2>Refleja el objetivo fijado para la Porcentaje de pacientes diagnosticados con hipertensión que deben ser sometidos a tratamiento.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/8S3UO1/LBUiI+hbU39">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Prevalencia de hipertensión entre adultos de 30 y 79 años, estandarizada por edad  (línea de base).</h2>


   </td>
   <td>
<h2>Porcentaje de individuos con hipertensión, diagnosticada o no, en el grupo etario de 30 a 79 años en cada país, proporcionando un punto de referencia inicial.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/8S3UO1/LBUiI+hbU39">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad (línea de base).
   </td>
   <td>
<h2>Porcentaje de individuos entre 30 y 79 años previamente diagnosticados con hipertensión, proporcionando un punto de referencia inicial.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/8S3UO1/LBUiI+hbU39">5,8</a></sup></h2>


   </td>
  </tr>
  <tr>
   <td>
<h2>Porcentaje de control de la hipertensión entre los tratados (línea base)</h2>


   </td>
   <td>
<h2>Porcentaje de personas de 30 a 79 años, ya diagnosticadas con hipertensión y en tratamiento, que han conseguido controlar su presión arterial, proporcionando un punto de referencia inicial.</h2>


   </td>
   <td>
<h2>Observatorio Mundial de la Salud de la OMS. </h2>


<h2>NCD RisC<sup><a href="https://paperpile.com/c/8S3UO1/LBUiI+hbU39">5,8</a></sup></h2>


   </td>
  </tr>
</table>



## Lista de indicadores

**Resultados epidemiológicos**



1. **Total de nuevos ECI evitados (n): **número de eventos por ECI evitados tras la implementación de la intervención.

    Ej: **Eventos evitados por ECI en Argentina n= 67.531,3. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 67.531,3 eventos por ECI en la población argentina. 

2. **Tasa de nuevos ECI evitados cada 100.000 habitantes (n/100.000 hab):** número de ECI incidentes evitados por cada 100,000 habitantes.

    Ej: **Tasa de nuevos ECI evitados cada 100.000 habitantes en Argentina =  148,8. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 148,8 ECI por cada 100.000 habitantes en Argentina.

3. **Total de nuevos ACV evitados (n): **número de eventos por ACV evitados tras la implementación de la intervención.

    Ej: **Eventos evitados por ACV en Argentina n = 9.411,0. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 9.411,0 eventos por ACV en la población argentina 

4. **Tasa de nuevos ACV evitados cada 100.000 habitantes (n/100.000 hab): **número de ACV incidentes evitados por cada 100.000 habitantes que podrían ser evitados tras la implementación de la intervención en Argentina.

    Ej: **Tasa de nuevos ACV evitados cada 100.000 habitantes en Argentina = 20,9. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 20,9 ACV por cada 100.000 habitantes en Argentina.

5. **Muertes evitadas por ECI (n): **número de muertes por ECI evitadas tras la implementación de la intervención

    Ej: **Muertes evitadas por ECI en Argentina n = 4.221. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 4.221 muertes por ECI en la población argentina. 

6. **Muertes por ECI por cada 100.000 habitantes que podrían evitarse (n/100.000 hab): **número de muertes por ECI por cada 100.000 habitantes que podrían ser evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas por ECI por cada 100.000 habitantes que podrían evitarse en Argentina = 9,3. **En este caso el modelo indica que la intervención propuesta tienen el potencial de evitar 9,3 muertes por ECI por cada 100.000 habitantes en Argentina. 

7. **Muertes evitadas por ACV (n): **número de muertes por ACV evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas por ACV en Argentina n= 1400. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 1400 muertes por ACV en la población argentina. 

8. **Muertes por ACV por cada 100.000 habitantes que podrían evitarse (n/100.000): **número de muertes por ACV por cada 100.000 habitantes que podrían ser evitadas tras la implementación de la intervención.

    Ej: **Muertes evitadas por ACV por cada 100.000 habitantes que podrían evitarse en Argentina  = 3,2. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 3,2 muertes por ACV por cada 100.000 habitantes en Argentina.

9. **Población nueva de adultos entre 30 y 79 años con hipertensión que inició tratamiento (n): **número total de adultos en ese rango de edad que han sido diagnosticados recientemente con hipertensión y han comenzado un tratamiento para la misma.

    Ej: **Población nueva de adultos entre 30 y 79 años con hipertensión que inició tratamiento en Argentina (n): 5.418.194,4. **En este caso el modelo indica que la intervención propuesta tiene el potencial hacer que 5.418.194,4 adultos entre 30 y 79 años con hipertensión inicien tratamiento en Argentina.

10. **Población con hipertensión controlada entre adultos de 30 y 79 años: **número total de adultos dentro de ese rango de edad que han logrado mantener su presión arterial dentro de los límites saludables, indicando un control efectivo de su hipertensión.

    Ej: **Población con hipertensión controlada entre adultos de 30 y 79 años en Argentina (n)= 1.955.968,2. **En este caso el modelo indica que, en Argentina, la intervención propuesta tiene el potencial de hacer que 1.955.968,2 adultos entre 30 y 79 años con hipertensión, logren tenerla controlada. **	**

11. **Nueva población tratada / Controlados actualmente previamente no controlados (n): **número de personas que recientemente comenzaron tratamiento para hipertensión y que han logrado controlarla, a pesar de no haberla controlado anteriormente.

    Ej: **Nueva población tratada / Controlados actualmente previamente no controlados (n)= 1.200. **En este caso el modelo indica que la intervención propuesta tiene el potencial hacer que 1.200 adultos entre 30 y 79 años que recientemente comenzaron tratamiento para hipertensión y que han logrado controlarla, a pesar de no haberla controlado anteriormente.

12. **Años de vida perdidos por discapacidad totales (AVAD):  **sumatoria de los años de vida perdidos por eventos ECI y ACV en la población.

**Resultados económicos**



13. **Costo anual de la intervención por paciente promedio hipertenso tratado (USD): **el costo total de la intervención se determina considerando el costo asociado al aumento de la cobertura del tratamiento farmacológico para control de la hipertensión arterial para las personas que ya han sido diagnosticadas. Esto implica multiplicar el número de personas con hipertensión tratadas por el costo farmacológico en cobertura aumentada.

    Ej: **Costo anual de la intervención por paciente promedio con hipertensión tratado en Argentina $307,7 USD: **el costo anual del total de la intervención por paciente con hipertensión en Argentina es de $307,7 USD.

14. **Costos totales anuales de la intervención ponderado por la población objetivo alcanzada (USD):** el costo total anual de la intervención en relación con la población objetivo que se alcanza con el tratamiento. 

    Ej: **Costos totales anuales de la intervención ponderado por la población objetivo alcanzada en Argentina USD = 201.416.348,6: **el costo total anual de la intervención en relación con la población objetivo que se alcanza con el tratamiento en Argentina es de $201.416.348,6 USD. ** ** 

15. **Costos médicos directos evitados por evento cardiovascular (ECI y ACV) (USD):** los costos evitados por eventos cardiovasculares incluyen los costos específicos de tratar un evento de infarto agudo de miocardio, un evento de angina coronaria no infarto y un accidente cerebrovascular para cada uno de los países. Y se calculan teniendo en cuenta el número de eventos evitados gracias al tratamiento.

    Ej: **Costos médicos directos evitados por eventos cardiovasculares (ECI y ACV) en Argentina $258.024.719,4 USD: **los costos médicos directos evitados por eventos cardiovasculares debido a la intervención son de $258.024.719,4 USD en Argentina   

16. **Diferencia de costos (USD):** la diferencia de costos surge de restarle a los costos de la intervención los costos evitados por eventos cardiovasculares.

    Ej: **Diferencia de costos en Argentina USD = -56.608.370,8: **la diferencia de costos de la intervención debido a los costos evitados por eventos cardiovasculares es de $-56.608.370,8 USD.** ** 

17. **Razón de Costo-Efectividad incremental por año de vida salvado (USD): **diferencia de costos dividido por el número de años salvados gracias a la intervención.

    Ej: **Razón de Costo-Efectividad incremental por año de vida salvado: **por cada año adicional de vida salvado, la intervención cuesta $ xx USD más que la alternativa actual. 

18. **Razón de Costo-Efectividad incremental por año de vida ajustado por discapacidad evitado (USD): **diferencia de costos dividido por el número de AVAD prevenidos gracias a la intervención. 

    Ej: **Razón de Costo-Efectividad incremental por año de vida ajustado por discapacidad evitado en Argentina -$615 USD: **la intervención cuesta $615 USD menos por cada año de vida de calidad o sin discapacidad que se salva en comparación con la alternativa actual. 

19. **Retorno de Inversión (ROI) (USD):** relación entre los beneficios económicos obtenidos y el costo de la intervención. Un ROI positivo indica que la intervención no solo cubre su costo, sino que también genera un beneficio económico adicional. Se define como los ingresos menos la inversión, dividido por la inversión.

    . 


    Ej: **Retorno de la inversión (ROI) en Argentina = 28%: **en Argentina, para un ROI del 28% por cada 1 USD invertido en la intervención, se obtiene un retorno de 0.28 USD.





## Referencias


    1.	[Martinez R, Soliz P, Mujica OJ, Reveiz L, Campbell NRC, Ordunez P. The slowdown in the reduction rate of premature mortality from cardiovascular diseases puts the Americas at risk of achieving SDG 3.4: A population trend analysis of 37 countries from 1990 to 2017. J Clin Hypertens . 2020;22(8):1296-1309. doi:10.1111/jch.13922](http://paperpile.com/b/8S3UO1/V0mp)


    2.	[Las ENT de un vistazo: Mortalidad de las enfermedades no transmisibles y prevalencia de sus factores de riesgo en la Región de las Américas. Published online 2019. Accessed December 13, 2023. https://iris.paho.org/handle/10665.2/51752](http://paperpile.com/b/8S3UO1/rq3v)


    3.	[NCD Risk Factor Collaboration (NCD-RisC). Worldwide trends in hypertension prevalence and progress in treatment and control from 1990 to 2019: a pooled analysis of 1201 population-representative studies with 104 million participants. Lancet. 2021;398(10304):957-980. doi:10.1016/S0140-6736(21)01330-1](http://paperpile.com/b/8S3UO1/H4bF)


    4.	[Campbell NRC, Ordunez P, Giraldo G, et al. WHO HEARTS: A Global Program to Reduce Cardiovascular Disease Burden: Experience Implementing in the Americas and Opportunities in Canada. Can J Cardiol. 2021;37(5):744-755. doi:10.1016/j.cjca.2020.12.004](http://paperpile.com/b/8S3UO1/yRi7)


    5.	[Martinez R, Soliz P, Campbell NRC, Lackland DT, Whelton PK, Ordunez P. Association between population hypertension control and ischemic heart disease and stroke mortality in 36 countries of the Americas, 1990-2019: an ecological study. Rev Panam Salud Publica. 2022;46:e143. doi:10.26633/RPSP.2022.143](http://paperpile.com/b/8S3UO1/hbU39)


    6.	[HTN:CVD EstimaTool: acerca de. Accessed June 15, 2023. https://www.paho.org/es/enlace/htncvd-estimatool-acerca](http://paperpile.com/b/8S3UO1/qmDmB)


    7.	[Global Burden of Disease (GBD). Institute for Health Metrics and Evaluation. Published March 29, 2014. Accessed June 15, 2023. https://www.healthdata.org/gbd](http://paperpile.com/b/8S3UO1/A5Qe5)


    8.	[NCD Risk Factor Collaboration (NCD-RisC). Accessed June 15, 2023. https://epinut.umh.es/ncd-risk-factor-collaboration-ncd-risc/](http://paperpile.com/b/8S3UO1/LBUiI)


    9.	[HEARTS Costing Tool. Accessed April 5, 2023. https://www.tephinet.org/tephinet-learning-center/tephinet-library/hearts-costing-tool](http://paperpile.com/b/8S3UO1/pdei9)


    10.	[Sistema de Internações Hospitalares. Accessed December 13, 2023. http://sihd.datasus.gov.br/principal/index.php](http://paperpile.com/b/8S3UO1/ydsZ)


    11.	[INDEC, Instituto Nacional de Estadistica y Censos de la REPUBLICA ARGENTINA. INDEC: Instituto Nacional de Estadística y Censos de la República Argentina. Accessed September 25, 2023. https://www.indec.gob.ar/indec/web/Nivel4-Tema-3-5-31](http://paperpile.com/b/8S3UO1/Xub5K)


    12.	[Banco Central do Brasil. Accessed September 25, 2023. https://www3.bcb.gov.br/sgspub/consultarvalores/telaCvsSelecionarSeries.paint](http://paperpile.com/b/8S3UO1/Y3GTv)


    13.	[DANE - IPC información técnica. Accessed September 25, 2023. https://www.dane.gov.co/index.php/estadisticas-por-tema/precios-y-costos/indice-de-precios-al-consumidor-ipc/ipc-informacion-tecnica](http://paperpile.com/b/8S3UO1/V5gNL)


    14.	[Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/8S3UO1/hQmQu)


    15.	[Banco Central del Ecuador - Información Económica. Accessed September 25, 2023. https://www.bce.fin.ec/informacioneconomica](http://paperpile.com/b/8S3UO1/g8YCD)


    16.	[Estructura de información (SIE, Banco de México). Accessed September 25, 2023. https://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=8&accion=consultarCuadro&idCuadro=CP151&locale=es](http://paperpile.com/b/8S3UO1/p3MPG)


    17.	[BCRP - Series mensuales. Accessed September 25, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/indice-de-precios-indice-dic-2021-100](http://paperpile.com/b/8S3UO1/vkrce)


    18.	[Base de Datos Estadísticos (BDE). Accessed September 25, 2023. https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_PRECIOS/MN_CAP_PRECIOS/PEM_VAR_IPC_NEW/637775848569931668](http://paperpile.com/b/8S3UO1/8qnhM)


    19.	[Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/8S3UO1/fPZRJ)


    20.	[de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/8S3UO1/EhT1l)


    21.	[Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/8S3UO1/oGf2e)


    22.	[Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/8S3UO1/LnI06)


    23.	[Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/8S3UO1/B88zZ)


    24.	[Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/8S3UO1/kqp4n)


    25.	[SRV PRECIO. Accessed September 18, 2023. https://www.alfabeta.net/precio/srv](http://paperpile.com/b/8S3UO1/5lNGt)


    26.	[Kairos preço de remedios. Kairos Web. Published September 28, 2019. Accessed September 21, 2023. https://br.kairosweb.com/](http://paperpile.com/b/8S3UO1/L4e4F)


    27.	[Termómetro de precios de medicamentos. Colombia Potencia de la Vida. Accessed September 17, 2023. https://www.minsalud.gov.co/salud/MT/Paginas/termometro-de-precios.aspx](http://paperpile.com/b/8S3UO1/6vFcE)


    28.	[Farmaprecios. Accessed September 25, 2023. https://www.farmaprecios.com.ec/](http://paperpile.com/b/8S3UO1/EKRYM)


    29.	[Observatorio Peruano de Productos Farmacéuticos. SISTEMA NACIONAL DE INFORMACIÓN DE PRECIOS DE PRODUCTOS FARMACÉUTICOS - SNIPPF. Accessed September 17, 2023. https://opm-digemid.minsa.gob.pe/#/consulta-producto](http://paperpile.com/b/8S3UO1/pSaxq)


    30.	[Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/8S3UO1/sAFDO)


    31.	[Kairos Web Chile - Buscador de precios de Medicamentos y Drogas. Accessed September 18, 2023. https://cl.kairosweb.com/](http://paperpile.com/b/8S3UO1/fbkjD)


    32.	[Pichon-Riviere A, Bardach A, Rodríguez Cairoli F, et al. Health, economic and social burden of tobacco in Latin America and the expected gains of fully implementing taxes, plain packaging, advertising bans and smoke-free environments control measures: a modelling study. Tob Control. Published online May 4, 2023. doi:10.1136/tc-2022-057618](http://paperpile.com/b/8S3UO1/J5pNQ)


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
   <td>Población total del país
   </td>
   <td>Población total (proyectada para el año 2023) de cada país.
   </td>
   <td>Instituto de estadística de cada uno de los 8 países
   </td>
  </tr>
  <tr>
   <td>Número de muertes totales por ECI entre 30 y 79 años
   </td>
   <td>Número total de muertes por ECI, desglosado por sexo y grupo de edad (30 a 79 años), en cada pais (última actualización año 2019).
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/8S3UO1/A5Qe5">7</a></sup> 
   </td>
  </tr>
  <tr>
   <td>Número de muertes totales por ACV entre 30 y 79 años
   </td>
   <td>Número total de muertes por ACV, desglosado por sexo y grupo de edad (30 a 79 años), en cada pais (última actualización año 2019).
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/8S3UO1/A5Qe5">7</a></sup> 
   </td>
  </tr>
  <tr>
   <td>Letalidad ponderada por edad y sexo para enfermedad cardíaca isquémica (grupo entre 30-79 años)
   </td>
   <td>Índice de letalidad (tasa de letalidad ponderada por sexo y edad) para enfermedad cardíaca isquémica en el grupo de edad de 30 a 79 años
   </td>
   <td>Internações: Sistema de Informações Hospitalares/Ministério da Saúde - 2022<sup><a href="https://paperpile.com/c/8S3UO1/ydsZ">10</a></sup>
   </td>
  </tr>
  <tr>
   <td>Letalidad ponderada por edad y sexo para accidente cerebrovascular (grupo entre 30-79 años)
   </td>
   <td>Índice de letalidad (tasa de letalidad ponderada por sexo y edad) para accidente cerebrovascular en el grupo de edad de 30 a 79 años
   </td>
   <td>Internações: Sistema de Informações Hospitalares/Ministério da Saúde - 2022<sup><a href="https://paperpile.com/c/8S3UO1/ydsZ">10</a></sup>
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
   <td>Nomencladores de cada país, actualizados por inflación en dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/Xub5K+Y3GTv+V5gNL+hQmQu+g8YCD+p3MPG+vkrce+8qnhM+fPZRJ+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">11–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo anual de consulta médica en paciente promedio
   </td>
   <td>Tiene en cuenta el número de visitas médicas anuales necesarias por paciente según nivel de riesgo cardiovascular calculado y la proporción de pacientes con ese nivel de riesgo, por país para abril de 2023.
   </td>
   <td>Nomencladores de cada país, actualizados por inflación en dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/Xub5K+Y3GTv+V5gNL+hQmQu+g8YCD+p3MPG+vkrce+8qnhM+fPZRJ+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">11–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 2
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8S3UO1/5lNGt">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/8S3UO1/L4e4F">26</a></sup> COL,<sup><a href="https://paperpile.com/c/8S3UO1/6vFcE">27</a></sup> ECU<sup><a href="https://paperpile.com/c/8S3UO1/EKRYM">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/8S3UO1/pSaxq">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/8S3UO1/sAFDO">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/8S3UO1/fbkjD">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 3
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días y 20 mg de enalapril una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8S3UO1/5lNGt">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/8S3UO1/L4e4F">26</a></sup> COL,<sup><a href="https://paperpile.com/c/8S3UO1/6vFcE">27</a></sup> ECU<sup><a href="https://paperpile.com/c/8S3UO1/EKRYM">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/8S3UO1/pSaxq">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/8S3UO1/sAFDO">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/8S3UO1/fbkjD">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 4
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días y 20 mg de enalapril dos veces al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8S3UO1/5lNGt">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/8S3UO1/L4e4F">26</a></sup> COL,<sup><a href="https://paperpile.com/c/8S3UO1/6vFcE">27</a></sup> ECU<sup><a href="https://paperpile.com/c/8S3UO1/EKRYM">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/8S3UO1/pSaxq">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/8S3UO1/sAFDO">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/8S3UO1/fbkjD">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 5
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días, 20 mg de enalapril dos veces al día durante 365 días y 5mg amlodipina una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8S3UO1/5lNGt">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/8S3UO1/L4e4F">26</a></sup> COL,<sup><a href="https://paperpile.com/c/8S3UO1/6vFcE">27</a></sup> ECU<sup><a href="https://paperpile.com/c/8S3UO1/EKRYM">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/8S3UO1/pSaxq">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/8S3UO1/sAFDO">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/8S3UO1/fbkjD">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 6
   </td>
   <td>12.5mg de Clortalidona una vez al día durante 365 días, 20 mg de enalapril dos veces al día durante 365 días y 10mg amlodipina una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8S3UO1/5lNGt">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/8S3UO1/L4e4F">26</a></sup> COL,<sup><a href="https://paperpile.com/c/8S3UO1/6vFcE">27</a></sup> ECU<sup><a href="https://paperpile.com/c/8S3UO1/EKRYM">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/8S3UO1/pSaxq">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/8S3UO1/sAFDO">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/8S3UO1/fbkjD">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente promedio
   </td>
   <td>Incluye la proporción de pacientes que están en cada paso por país para abril de 2023.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8S3UO1/5lNGt">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/8S3UO1/L4e4F">26</a></sup> COL,<sup><a href="https://paperpile.com/c/8S3UO1/6vFcE">27</a></sup> ECU<sup><a href="https://paperpile.com/c/8S3UO1/EKRYM">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/8S3UO1/pSaxq">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/8S3UO1/sAFDO">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/8S3UO1/fbkjD">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de evento de infarto agudo de miocardio
   </td>
   <td>Costos de tratar un evento de infarto agudo de miocardio por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/8S3UO1/J5pNQ">32</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/8S3UO1/Xub5K+Y3GTv+8qnhM+V5gNL+hQmQu+g8YCD+p3MPG+vkrce">11–18</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de evento coronario no infarto
   </td>
   <td>Costos de tratar un evento de angina coronaria no infarto por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/8S3UO1/J5pNQ">32</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/8S3UO1/Xub5K+Y3GTv+8qnhM+V5gNL+hQmQu+g8YCD+p3MPG+vkrce">11–18</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de evento de ACV
   </td>
   <td>Costos de tratar un accidente cerebrovascular por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/8S3UO1/J5pNQ">32</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/8S3UO1/Xub5K+Y3GTv+8qnhM+V5gNL+hQmQu+g8YCD+p3MPG+vkrce">11–18</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/8S3UO1/fPZRJ+Y3GTv+EhT1l+oGf2e+LnI06+B88zZ+kqp4n">12,19–24</a></sup>
   </td>
  </tr>
</table>


*Debido a que no se contó con información específica del país, los costos fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.
