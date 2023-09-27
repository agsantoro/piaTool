### Proyecto Modelos OPS


## Documentación - EstimaTool


---



## 1. Definiciones/Glosario marco general

La herramienta “Hypertension: cardiovascular disease EstimaTool (HTN: CVD EstimaTool)”, patrocinada por la Organización Panamericana de Salud (OPS), es una herramienta en línea interactiva que ha sido diseñada con el propósito de calcular las muertes prevenibles causadas por enfermedades cardíacas isquémicas (ECI) y accidentes cerebrovasculares (ACV), mediante el mejor control de la hipertensión.<sup><a href="https://paperpile.com/c/D9RgK6/3Psi6+yvmEB">1,2</a></sup> Su objetivo principal es brindar apoyo a los profesionales encargados de los programas de prevención y control de enfermedades cardiovasculares, permitiéndoles evaluar el impacto que tendría una mejora en el control de la hipertensión en la reducción de la mortalidad relacionada con estas enfermedades en la población. Asimismo, esta herramienta proporciona información valiosa que puede ser utilizada para informar a las autoridades de salud, a los responsables de la toma de decisiones y a los formuladores de políticas públicas en el ámbito de la salud.<sup><a href="https://paperpile.com/c/D9RgK6/yvmEB">2</a></sup> 

Es destacable que esta herramienta se basa en modelos predictivos desarrollados y publicados en el estudio titulado "Association between population hypertension control and ischemic heart disease and stroke mortality in 36 countries of the Americas, 1990-2019: an ecological study".<sup><a href="https://paperpile.com/c/D9RgK6/3Psi6">1</a></sup> Se desarrollaron y ajustaron modelos específicos según el sexo y la causa de las enfermedades no trasmisibles (ECI y ACV) mediante análisis de regresión. Se utilizaron estimaciones del control poblacional de la hipertensión como variable independiente y estimaciones de mortalidad por ECI y ACV como variables dependientes. Los modelos de regresión regional con mejor ajuste se emplearon para predecir el nivel esperado de mortalidad por ECI y ACV, considerando un determinado nivel de control poblacional de la hipertensión.<sup><a href="https://paperpile.com/c/D9RgK6/3Psi6">1</a></sup>

El modelo de regresión se basó en dos fuentes de datos distintas: 1) estimaciones de tasas de mortalidad estandarizadas por edad por 100 000 habitantes, causadas por ECI, ACV y sus subtipos (como ACV isquémico, hemorragia intracerebral y hemorragia subaracnoidea), desglosadas por sexo, para la Región de las Américas y los 36 países y territorios durante el período de 1990 a 2019. Estas estimaciones se obtuvieron del Estudio de Carga Global de Enfermedades, Lesiones y Factores de Riesgo 2019 (GBD 2019)<sup><a href="https://paperpile.com/c/D9RgK6/rEA1E">3</a></sup> y 2) estimaciones de la prevalencia estandarizada por edad del control de la hipertensión poblacional, desglosadas por sexo, para la Región de las Américas y los 36 países. Estas estimaciones fueron extraídas del Observatorio Mundial de la Salud de la OMS y fueron producidas por la Colaboración de Factores de Riesgo de Enfermedades No Transmisibles (NCD RisC).<sup><a href="https://paperpile.com/c/D9RgK6/inT1k+3Psi6">1,4</a></sup>

El HTN:CVD EstimaTool ofrece una interfaz que consta de dos columnas: a la izquierda se encuentran los parámetros que permiten al usuario definir su escenario de análisis, mientras que a la derecha se presentan los resultados de dicho escenario de manera visual. Los usuarios tienen la posibilidad de ajustar los valores predefinidos de los parámetros en la columna izquierda de la herramienta mediante la introducción directa de los valores deseados o la selección de opciones específicas. Esto les permite personalizar su escenario de análisis. Por ejemplo, pueden ingresar el nombre y tamaño de la ubicación, establecer la prevalencia inicial y la meta de hipertensos diagnosticados, la prevalencia de pacientes tratados entre los diagnosticados, la prevalencia de control de la hipertensión entre los tratados, la prevalencia de control de la hipertensión en la población y el período de tiempo para alcanzar la meta. Estos cambios permiten visualizar el impacto en la mortalidad por enfermedades no trasmisibles, como la ECI y ACV, en una población específica.

Los usuarios tienen la capacidad de modificar cualquier valor en los parámetros, ya sea en la línea de base o en la meta, simplemente ingresando los mismos directamente. Los cambios realizados en los valores de diagnóstico, tratamiento y control de la hipertensión entre los pacientes tratados, se utilizan para calcular la prevalencia de control de la hipertensión en la población hipertensa, ya sea en la línea de base o en la meta. Adicionalmente, los usuarios pueden especificar el número de años en los que se planifica alcanzar la meta establecida.<sup><a href="https://paperpile.com/c/D9RgK6/yvmEB">2</a></sup>

En relación a la evaluación del impacto económico del aumento de cobertura de esta intervención, se utilizó como guía la herramienta "Global HEARTS Costing Tool Version 5.4" desarrollada por Training Programs in Epidemiology and Public Health Interventions Network (TEPHINET) un programa de The Task Force for Global Health.<sup><a href="https://paperpile.com/c/D9RgK6/aiP7t">5</a></sup> Se identificó y respetó el listado de recursos sanitarios, así como las tasas de uso respectivas, la frecuencia de visitas médicas y las dosis de los medicamentos utilizados en el tratamiento farmacológico, propuestos por esta herramienta (ver en más detalle en apartado de costos). 


### Impacto de la intervención

Nuestro análisis se enfoca en el control del tratamiento farmacológico de la presión arterial en el marco de la iniciativa HEARTS. Por lo tanto, el impacto de la intervención se ve reflejado en un aumento de la cobertura del tratamiento de hipertensos ya diagnosticados, para cada país. Para establecer la meta de aumento en la cobertura, consideramos alcanzar al menos el 50% de la diferencia (gap) entre la cobertura actual de cada país y un valor ideal del 90% de cobertura de tratamiento para los hipertensos diagnosticados. Por ejemplo, si un país tiene una cobertura actual de tratamiento de hipertensión del 70%, esto significa que existe una brecha absoluta del 20% en comparación con el valor ideal del 90% de cobertura. El 50% de esta brecha absoluta corresponde a un aumento del 10% en términos absolutos. En otras palabras, la meta establecida para ese país sería alcanzar una cobertura del 80%, dado su nivel actual de cobertura del 70%. Este aumento, a su vez, resulta en un incremento en el porcentaje de hipertensos controlados. Para los países cuya cobertura de tratamiento actual es igual o superior al 90%, consideramos un valor ideal de cobertura del 95%.


### Estimación de muertes evitadas

Las muertes evitadas, tanto por ECI y ACV, fueron estimadas a partir de las ecuaciones de regresión utilizadas por defecto en la calculadora EstimaTool y utilizando los parámetros mencionados y detallados en este informe. Como fuera mencionado anteriormente, dichas ecuaciones de regresión, utilizadas por la calculadora EstimaTool, se detallan en el artículo científico correspondiente.<sup><a href="https://paperpile.com/c/D9RgK6/3Psi6">1</a></sup> 


### Estimación de eventos/casos evitados

Una vez obtenidos los resultados de las muertes evitadas por ECI y ACV utilizando esta calculadora, se aplicaron parámetros de letalidad correspondientes a estas enfermedades para estimar también el número de casos evitados. Se tomó como referencia de valores de letalidad los más recientemente reportados por los sistemas de información oficiales de cada país, los cuales incluían datos de hospitalización y letalidad hospitalaria. En aquellos países donde no fue posible obtener esta información, asumimos la misma letalidad a la reportada por el Sistema de Informações Hospitalares/Ministério da Saúde - 2022,<sup><a href="https://paperpile.com/c/D9RgK6/IGDJW">6</a></sup> para el caso de Brasil.


### Distribución de muerte y eventos según grupos de edad y sexo

Habiendo sido estimados los valores de muerte y eventos evitados para el total del país, se procedió a estimar la distribución de los mismos por género y grupo de edad para cada país. Para esto, se asumió que las muertes y eventos evitados, se distribuirán por género y grupos de edad respetando siempre la distribución actual de las muertes por ECI y ACV de cada país según los datos de mortalidad reportados por Global Burden of Disease.<sup><a href="https://paperpile.com/c/D9RgK6/rEA1E">3</a></sup>


### Estimación de años de vida perdidos por muerte prematura y por discapacidad

Para estimar años de vida perdidos por muerte prematura se tomó como referencia la expectativa de vida por sexo y grupos de edad reportados por la OMS.<sup><a href="https://paperpile.com/c/D9RgK6/KJvTd">7</a></sup> Se multiplicó la expectativa de vida de cada género y grupo de edad por el número total de muertes evitadas para cada género y grupo de edad, tanto para ECI y ACV.

Para el cálculo de años de vida perdidos por discapacidad se utilizaron los valores de “Disability weights” (DW) reportados por Global Burden of Disease para el año 2019.<sup><a href="https://paperpile.com/c/D9RgK6/o5bRi">8</a></sup> Sólo se aplicaron DW para el año de incidencia de los eventos. 

Para el caso de eventos de enfermedad cardíaca isquémica, se consideró que el 45% de los mismos serían atribuibles a infarto agudo de miocardio mientras que el 55% restante a evento de angina coronaria distinto a infarto agudo de miocardio.  

Para el caso de infarto agudo de miocardio se consideraron los DW propios de esta patología: un DW específico para los primeros dos días luego del evento (0.432), y un DW específico para subsiguientes días hasta completar los primeros 30 días luego del evento (0.074). Para el período luego de los primeros 30 días del evento, y acorde a la literatura, se asumió un DW de insuficiencia cardíaca moderada (0.072) sólo para al 13% de los eventos de infarto agudo de miocardio, y un DW específico de angina de pecho leve-moderada (0.08) para el total de los eventos para el primer año.

Para el caso de angina coronaria distinta a infarto agudo de miocardio, se realizó un promedio ponderado según los DW reportados por cada grado de severidad de la patología. Según lo reportado por la literatura se consideró una distribución de los casos en un 65% en casos leves (DW de 0.033), y un 35% en casos moderados-severos (DW de 0.08 y 0.167, respectivamente).<sup><a href="https://paperpile.com/c/D9RgK6/QCfHt">9</a></sup>

Para el caso de ACV, se consideraron los disability weights reportados por GBD según nivel de severidad. Se asumió la siguiente distribución de casos de ACV según nivel de severidad: 60.3% casos leves (nivel 1 de severidad), 23.7% casos moderados (nivel 2 de severidad) y 16% casos severos (nivel 3, 4 y 5 de severidad) según lo reportado en la literatura.<sup><a href="https://paperpile.com/c/D9RgK6/ClDrG">10</a></sup>





## 2. Descripción general de los inputs (tablas)
<br />

#### Tabla 1. Parámetros epidemiológicos



<table>
  <tr>
   <td>
    <strong>Parámetro</strong>
   </td>
   <td>
<strong>Descripción</strong>
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
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/D9RgK6/rEA1E">3</a></sup> 
   </td>
  </tr>
  <tr>
   <td>Número de muertes totales por ACV entre 30 y 79 años
   </td>
   <td>Número total de muertes por ACV, desglosado por sexo y grupo de edad (30 a 79 años), en cada pais (última actualización año 2019).
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/D9RgK6/rEA1E">3</a></sup> 
   </td>
  </tr>
  <tr>
   <td>Prevalencia de hipertensión (sean casos diagnosticados o no diagnosticados) entre 30 y 79 años.
   </td>
   <td>Proporción de personas que presentan hipertensión en el rango de edades de 30 a 79 años, ya sea diagnosticada o no, en cada país.
   </td>
   <td>Observatorio Mundial de la Salud de la OMS. Colaboración de Factores de Riesgo de Enfermedades No Transmisibles (NCD RisC)<sup><a href="https://paperpile.com/c/D9RgK6/inT1k+3Psi6">1,4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Prevalencia de hipertensos controlados del total de hipertensos entre 30 y 79 años.
   </td>
   <td>Proporción de personas con hipertensión controlada con respecto al total de personas con hipertensión en el rango de edades de 30 a 79 años en cada país
   </td>
   <td>Observatorio Mundial de la Salud de la OMS. Colaboración de Factores de Riesgo de Enfermedades No Transmisibles (NCD RisC).<sup><a href="https://paperpile.com/c/D9RgK6/inT1k+3Psi6">1,4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Letalidad (case fatality rate) ponderada por edad y sexo para enfermedad cardíaca isquémica (grupo entre 30-79 años)
   </td>
   <td>Índice de letalidad (tasa de letalidad ponderada por sexo y edad) para enfermedad cardíaca isquémica en el grupo de edad de 30 a 79 años
   </td>
   <td>Caso Brasil. Internações: Sistema de Informações Hospitalares/Ministério da Saúde - 2022
   </td>
  </tr>
  <tr>
   <td>Letalidad (case fatality rate) ponderada por edad y sexo para accidente cerebrovascular (grupo entre 30-79 años)
   </td>
   <td>Índice de letalidad (tasa de letalidad ponderada por sexo y edad) para accidente cerebrovascular en el grupo de edad de 30 a 79 años
   </td>
   <td>Caso Brasil. Internações: Sistema de Informações Hospitalares/Ministério da Saúde - 2022
   </td>
  </tr>
</table>


<br />

#### Tabla 2. Parámetros de costos.

<table>
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
   <td>Nomencladores de cada país, actualizados por inflación en dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/xqNx+kHgQ+0iG8+vNWP+QitM+XpIa+jcJJ+hQnE+P1II+dZZO+npjC+i5zf+xLsX+fWTX">11–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo anual de consulta médica en paciente promedio
   </td>
   <td>Tiene en cuenta el número de visitas médicas anuales necesarias por paciente según nivel de riesgo cardiovascular calculado y la proporción de pacientes con ese nivel de riesgo, por país para abril de 2023.
   </td>
   <td>Nomencladores de cada país, actualizados por inflación en dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/xqNx+kHgQ+0iG8+vNWP+QitM+XpIa+jcJJ+hQnE+P1II+dZZO+npjC+i5zf+xLsX+fWTX">11–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 2
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/D9RgK6/6WB6">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/D9RgK6/bAZn">26</a></sup> COL,<sup><a href="https://paperpile.com/c/D9RgK6/gNVs">27</a></sup> ECU<sup><a href="https://paperpile.com/c/D9RgK6/lpUH">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/D9RgK6/39hG">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/D9RgK6/lCm3">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/D9RgK6/RVd1">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 3
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días y 20 mg de enalapril una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/D9RgK6/6WB6">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/D9RgK6/bAZn">26</a></sup> COL,<sup><a href="https://paperpile.com/c/D9RgK6/gNVs">27</a></sup> ECU<sup><a href="https://paperpile.com/c/D9RgK6/lpUH">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/D9RgK6/39hG">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/D9RgK6/lCm3">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/D9RgK6/RVd1">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 4
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días y 20 mg de enalapril dos veces al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/D9RgK6/6WB6">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/D9RgK6/bAZn">26</a></sup> COL,<sup><a href="https://paperpile.com/c/D9RgK6/gNVs">27</a></sup> ECU<sup><a href="https://paperpile.com/c/D9RgK6/lpUH">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/D9RgK6/39hG">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/D9RgK6/lCm3">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/D9RgK6/RVd1">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 5
   </td>
   <td>Incluye 12.5mg de Clortalidona una vez al día durante 365 días, 20 mg de enalapril dos veces al día durante 365 días y 5mg amlodipina una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/D9RgK6/6WB6">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/D9RgK6/bAZn">26</a></sup> COL,<sup><a href="https://paperpile.com/c/D9RgK6/gNVs">27</a></sup> ECU<sup><a href="https://paperpile.com/c/D9RgK6/lpUH">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/D9RgK6/39hG">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/D9RgK6/lCm3">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/D9RgK6/RVd1">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente en Step 6
   </td>
   <td>12.5mg de Clortalidona una vez al día durante 365 días, 20 mg de enalapril dos veces al día durante 365 días y 10mg amlodipina una vez al día durante 365 días.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/D9RgK6/6WB6">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/D9RgK6/bAZn">26</a></sup> COL,<sup><a href="https://paperpile.com/c/D9RgK6/gNVs">27</a></sup> ECU<sup><a href="https://paperpile.com/c/D9RgK6/lpUH">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/D9RgK6/39hG">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/D9RgK6/lCm3">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/D9RgK6/RVd1">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo farmacológico anual por paciente promedio
   </td>
   <td>Incluye la proporción de pacientes que están en cada paso por país para abril de 2023.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/D9RgK6/6WB6">25</a></sup> BRA,<sup><a href="https://paperpile.com/c/D9RgK6/bAZn">26</a></sup> COL,<sup><a href="https://paperpile.com/c/D9RgK6/gNVs">27</a></sup> ECU<sup><a href="https://paperpile.com/c/D9RgK6/lpUH">28</a></sup> y PER.<sup><a href="https://paperpile.com/c/D9RgK6/39hG">29</a></sup> 
<p>
Actualizado por inflación<sup><a href="https://paperpile.com/c/D9RgK6/lCm3">30</a></sup>: CHL.<sup><a href="https://paperpile.com/c/D9RgK6/RVd1">31</a></sup>
<p>
Estimación indirecta*: CRC, MEX.
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Evento de infarto agudo de miocardio
   </td>
   <td>Costos de tratar un evento de infarto agudo de miocardio por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/D9RgK6/FZiI">32</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/D9RgK6/xqNx+kHgQ+hQnE+0iG8+vNWP+QitM+XpIa+jcJJ">11–18</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Evento coronario no infarto
   </td>
   <td>Costos de tratar un evento de angina coronaria no infarto por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/D9RgK6/FZiI">32</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/D9RgK6/xqNx+kHgQ+hQnE+0iG8+vNWP+QitM+XpIa+jcJJ">11–18</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
  <tr>
   <td>Evento de ACV
   </td>
   <td>Costos de tratar un accidente cerebrovascular por país para abril de 2023.
   </td>
   <td>Pichon-Riviere y cols.,<sup><a href="https://paperpile.com/c/D9RgK6/FZiI">32</a></sup> actualizados por inflación.<sup><a href="https://paperpile.com/c/D9RgK6/xqNx+kHgQ+hQnE+0iG8+vNWP+QitM+XpIa+jcJJ">11–18</a></sup>
<p>
En dólares estadounidenses.<sup><a href="https://paperpile.com/c/D9RgK6/P1II+kHgQ+dZZO+npjC+i5zf+xLsX+fWTX">12,19–24</a></sup>
   </td>
  </tr>
</table>


(*) Debido a que no se contó con información específica del país, los costos fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.

<br />

## 3. Lista de indicadores, para cada indicador
a. **Eventos evitados por ECI: **número de eventos por ECI evitados tras la implementación de la intervención.

    Ej: **Eventos evitados por ECI n=200. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 200 eventos por ECI en la población en estudio. 

b. **Eventos evitados por ACV: **número de eventos por ACV evitados tras la implementación de la intervención

    Ej: **Eventos evitados por ACV n=200. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 200 eventos por ACV en la población en estudio. 

c. **Muertes evitadas por ECI: **número de muertes por ECI evitadas tras la implementación de la intervención

    Ej: **Muertes evitadas por ECI n=200. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 200 muertes por ECI en la población en estudio. 

d. **Muertes evitadas por ACV: **número de muertes por ACV evitadas tras la implementación de la intervención

    Ej: **Muertes evitadas por ACV n=200. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 200 muertes por ACV en la población en estudio. 

e. **Años de vida perdidos por ECI**
    - **Años de vida perdidos por ECI por discapacidad:** cuantifica la cantidad de años de vida que se perderían como resultado de la carga de discapacidad causada por ECI en la población.

        Ej: **Años de vida perdidos por ECI por discapacidad** **n=1500**. Esto sugiere que la intervención propuesta podría potencialmente evitar la pérdida de 1500 años de vida saludable debido a la discapacidad causada por ECI en la población en estudio."

    - **Años de vida perdidos por ECI por muerte prematura:** cuantifica la cantidad de años de vida que se perderían como resultado de la carga de muerte prematura causada por ECI en la población.

        Ej: **Años de vida perdidos por ECI por muerte prematura** **n=1500**. Esto sugiere que la intervención propuesta podría potencialmente evitar la pérdida de 1500 años de vida saludable debido a ECI por muerte prematura en la población en estudio.

f. **Años de vida perdidos por ACV**
    - **Años de vida perdidos por ACV por discapacidad: **cuantifica la cantidad de años que se perderían debido a la carga de discapacidad producida por ACV en la población en estudio.

        Ej: **Años de vida perdidos por ACV por discapacidad** **n=1500**. Esto sugiere que la intervención propuesta podría potencialmente evitar la pérdida de 1500 años de vida saludable debido a ACV por discapacidad en la población en estudio. 

    - **Años de vida perdidos por ACV por muerte prematura:** cuantifica la cantidad de años que se perderían debido a la carga de muerte prematura producida por ACV en la población en estudio."

        Ej: **Años de vida perdidos por ACV por muerte prematura** **n=1500**. Esto sugiere que la intervención propuesta podría potencialmente evitar la pérdida de 1500 años de vida saludable debido a ACV por muerte prematura en la población en estudio.

g. **Años de vida perdidos totales:  **sumatoria de los años de vida perdidos por eventos ECI y ACV en la población.

    Ej: **Años de vida perdidos por ACV por muerte prematura** **n=3000**. Esto sugiere que la intervención propuesta tiene el potencial de evitar la pérdida de 3000 años de vida totales en la población en estudio.

h. **Costo de la intervención: **el costo total de la intervención se determina considerando el costo asociado al aumento de la cobertura del tratamiento farmacológico para control de la hipertensión arterial para las personas que ya han sido diagnosticadas. Esto implica multiplicar el número de personas con hipertensión tratadas por el costo farmacológico en cobertura aumentada.
i. **Costo evitado por eventos cardiovasculares:** los costos evitados por eventos cardiovasculares incluyen los costos específicos de tratar un evento de infarto agudo de miocardio, un evento de angina coronaria no infarto y un accidente cerebrovascular para cada uno de los países. Y se calculan teniendo en cuenta en número de eventos evitados gracias al tratamiento.
j. **Diferencia de costos:** la diferencia de costos surge de restarle a los costos de la intervención los costos evitados por eventos cardiovasculares.
k. **Costo incremental por año de vida salvado: **diferencia de costos dividido por el número de años salvados gracias a la intervención
l. **Costo incremental por AVAD prevenido: **diferencia de costos dividido por el número de AVAD prevenidos gracias a la intervención
m. **Retorno de la inversión: **se define como los ingresos menos la inversión, divido la inversión.



## Referencias


    1.	[Martinez R, Soliz P, Campbell NRC, Lackland DT, Whelton PK, Ordunez P. Association between population hypertension control and ischemic heart disease and stroke mortality in 36 countries of the Americas, 1990-2019: an ecological study. Rev Panam Salud Publica. 2022;46:e143. doi:10.26633/RPSP.2022.143](http://paperpile.com/b/D9RgK6/3Psi6)


    2.	[HTN:CVD EstimaTool: acerca de. Accessed June 15, 2023. https://www.paho.org/es/enlace/htncvd-estimatool-acerca](http://paperpile.com/b/D9RgK6/yvmEB)


    3.	[Global Burden of Disease (GBD). Institute for Health Metrics and Evaluation. Published March 29, 2014. Accessed June 15, 2023. https://www.healthdata.org/gbd](http://paperpile.com/b/D9RgK6/rEA1E)


    4.	[NCD Risk Factor Collaboration (NCD-RisC). Accessed June 15, 2023. https://epinut.umh.es/ncd-risk-factor-collaboration-ncd-risc/](http://paperpile.com/b/D9RgK6/inT1k)


    5.	[HEARTS Costing Tool. Accessed April 5, 2023. https://www.tephinet.org/tephinet-learning-center/tephinet-library/hearts-costing-tool](http://paperpile.com/b/D9RgK6/aiP7t)


    6.	[Sistema de Informa��es Hospitalares. Accessed June 26, 2023. http://sihd.datasus.gov.br/principal/index.php](http://paperpile.com/b/D9RgK6/IGDJW)


    7.	[GHE: Life expectancy and healthy life expectancy. Accessed June 26, 2023. https://www.who.int/data/gho/data/themes/mortality-and-global-health-estimates/ghe-life-expectancy-and-healthy-life-expectancy#:~:text=Globally%2C%20life%20expectancy%20has%20increased,reduced%20years%20lived%20with%20disability.](http://paperpile.com/b/D9RgK6/KJvTd)


    8.	[Global Burden of Disease Study 2019 (GBD 2019) Disability Weights. Accessed June 26, 2023. https://ghdx.healthdata.org/record/ihme-data/gbd-2019-disability-weights](http://paperpile.com/b/D9RgK6/o5bRi)


    9.	[Malta DC, Pinheiro PC, Vasconcelos NM de, Stopa SR, Vieira MLFP, Lotufo PA. Prevalence of Angina Pectoris and Associated Factors in the Adult Population of Brazil: National Survey of Health, 2019. Rev Bras Epidemiol. 2021;24(suppl 2):e210012. doi:10.1590/1980-549720210012.supl.2](http://paperpile.com/b/D9RgK6/QCfHt)


    10.	[Sung SF, Hsieh CY, Lin HJ, et al. Validity of a stroke severity index for administrative claims data research: a retrospective cohort study. BMC Health Serv Res. 2016;16(1):509. doi:10.1186/s12913-016-1769-8](http://paperpile.com/b/D9RgK6/ClDrG)


    11.	[INDEC, Instituto Nacional de Estadistica y Censos de la REPUBLICA ARGENTINA. INDEC: Instituto Nacional de Estadística y Censos de la República Argentina. Accessed September 25, 2023. https://www.indec.gob.ar/indec/web/Nivel4-Tema-3-5-31](http://paperpile.com/b/D9RgK6/xqNx)


    12.	[Banco Central do Brasil. Accessed September 25, 2023. https://www3.bcb.gov.br/sgspub/consultarvalores/telaCvsSelecionarSeries.paint](http://paperpile.com/b/D9RgK6/kHgQ)


    13.	[DANE - IPC información técnica. Accessed September 25, 2023. https://www.dane.gov.co/index.php/estadisticas-por-tema/precios-y-costos/indice-de-precios-al-consumidor-ipc/ipc-informacion-tecnica](http://paperpile.com/b/D9RgK6/0iG8)


    14.	[Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/D9RgK6/vNWP)


    15.	[Banco Central del Ecuador - Información Económica. Accessed September 25, 2023. https://www.bce.fin.ec/informacioneconomica](http://paperpile.com/b/D9RgK6/QitM)


    16.	[Estructura de información (SIE, Banco de México). Accessed September 25, 2023. https://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=8&accion=consultarCuadro&idCuadro=CP151&locale=es](http://paperpile.com/b/D9RgK6/XpIa)


    17.	[BCRP - Series mensuales. Accessed September 25, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/indice-de-precios-indice-dic-2021-100](http://paperpile.com/b/D9RgK6/jcJJ)


    18.	[Base de Datos Estadísticos (BDE). Accessed September 25, 2023. https://si3.bcentral.cl/Siete/ES/Siete/Cuadro/CAP_PRECIOS/MN_CAP_PRECIOS/PEM_VAR_IPC_NEW/637775848569931668](http://paperpile.com/b/D9RgK6/hQnE)


    19.	[Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/D9RgK6/P1II)


    20.	[de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/D9RgK6/dZZO)


    21.	[Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/D9RgK6/npjC)


    22.	[Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/D9RgK6/i5zf)


    23.	[Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/D9RgK6/xLsX)


    24.	[Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/D9RgK6/fWTX)


    25.	[SRV PRECIO. Accessed September 18, 2023. https://www.alfabeta.net/precio/srv](http://paperpile.com/b/D9RgK6/6WB6)


    26.	[Kairos preço de remedios. Kairos Web. Published September 28, 2019. Accessed September 21, 2023. https://br.kairosweb.com/](http://paperpile.com/b/D9RgK6/bAZn)


    27.	[Termómetro de precios de medicamentos. Colombia Potencia de la Vida. Accessed September 17, 2023. https://www.minsalud.gov.co/salud/MT/Paginas/termometro-de-precios.aspx](http://paperpile.com/b/D9RgK6/gNVs)


    28.	[Farmaprecios. Accessed September 25, 2023. https://www.farmaprecios.com.ec/](http://paperpile.com/b/D9RgK6/lpUH)


    29.	[Observatorio Peruano de Productos Farmacéuticos. SISTEMA NACIONAL DE INFORMACIÓN DE PRECIOS DE PRODUCTOS FARMACÉUTICOS - SNIPPF. Accessed September 17, 2023. https://opm-digemid.minsa.gob.pe/#/consulta-producto](http://paperpile.com/b/D9RgK6/39hG)


    30.	[Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/D9RgK6/lCm3)


    31.	[Kairos Web Chile - Buscador de precios de Medicamentos y Drogas. Accessed September 18, 2023. https://cl.kairosweb.com/](http://paperpile.com/b/D9RgK6/RVd1)


    32.	[Pichon-Riviere A, Bardach A, Rodríguez Cairoli F, et al. Health, economic and social burden of tobacco in Latin America and the expected gains of fully implementing taxes, plain packaging, advertising bans and smoke-free environments control measures: a modelling study. Tob Control. Published online May 4, 2023. doi:10.1136/tc-2022-057618](http://paperpile.com/b/D9RgK6/FZiI)
