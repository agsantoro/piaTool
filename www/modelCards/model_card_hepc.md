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

# Model Card: Tratamiento de Hepatitis C


---


## Introducción

La hepatitis C, una enfermedad infecciosa del hígado causada por el virus de la hepatitis C (VHC), se transmite mayormente a través del contacto con sangre infectada. Las vías comunes de transmisión son el uso de agujas compartidas, tatuajes con equipo no esterilizado, relaciones sexuales sin protección y transmisión de madre a hijo durante el embarazo o el parto. A nivel mundial, la prevalencia exacta del VHC es difícil de determinar debido al subdiagnóstico, falta de notificación y escasa vigilancia. En 2022, la Organización Mundial de la Salud (OMS) reportó cerca de 58 millones de personas con infección crónica por VHC y alrededor de 1,5 millones de nuevos casos anuales. Específicamente en las Américas, se estimaron 5,7 millones de casos.<sup><a href="https://paperpile.com/c/TwRd3v/hRIeR">1</a></sup>

El VHC puede causar hepatitis aguda, que suele ser autolimitada y raramente lleva a insuficiencia hepática, o crónica, que a menudo es asintomática y puede tardar hasta 30 años en mostrar síntomas graves como fibrosis, cirrosis y cáncer de hígado. Dado que la infección por VHC a menudo no presenta síntomas, se recomienda que todos los adultos mayores de 18 años se hagan un examen de detección al menos una vez. Detectarla temprano es clave, ya que la enfermedad es curable con tratamientos antivirales efectivos. El objetivo del tratamiento es erradicar la infección, evaluado por una respuesta virológica sostenida (ausencia de VHC en sangre) 12 semanas tras finalizar el tratamiento. Para el tratamiento inicial de la infección crónica por VHC en personas sin cirrosis, se utiliza frecuentemente un régimen de 12 semanas con Sofosbuvir-velpatasvir, con una efectividad superior al 95% en todos los genotipos de VHC.<sup><a href="https://paperpile.com/c/TwRd3v/JTbGm+N1mbt">2,3</a></sup>


## Nombre del Modelo

Análisis basado en Markov de Tratamientos para la Hepatitis C Crónica (MATCH, su sigla del inglés _Markov-based Analyses of Treatments for Chronic Hepatitis C_).


## Descripción del Modelo y Asunciones

Se ha desarrollado un modelo mixto que combina un árbol de decisiones para simular la etapa de tratamiento y un modelo de transición de estados que representa la progresión de la enfermedad (MATCH: Análisis basado en Markov de Tratamientos para la Hepatitis C Crónica). Este modelo se basa en el enfoque utilizado por Aggarwal y cols. y ha servido como base para una aplicación web similar que hemos tomado como referencia, conocida como Hep C Treatment Calculator.

La herramienta busca plantear un modelo de evaluación del impacto epidemiológico y de costo-efectividad del tratamiento de la Hepatitis C crónica, centrado en la reducción de la morbimortalidad por Hepatitis C a nivel nacional. De ese modo, visibiliza el impacto de aumentar la cobertura de tratamiento en personas diagnosticadas con diferentes estadíos de fibrosis hepática que aún no han recibido tratamiento. 

En un escenario de toma de decisiones, plasma distintos escenarios del curso de la enfermedad en un conjunto de individuos con hepatitis C y simula los resultados de la decisión de realizar o no el tratamiento en una cohorte de pacientes con infección crónica por hepatitis C en diferentes etapas de fibrosis hepática (F0-F4), y sin tratamiento previo. 

La fase de transición entre estados involucra la clasificación inicial de fibrosis hepática (F0, F1, F2, F3 y F4 - cirrosis compensada -) y sus equivalentes para aquellos que han logrado la RVS (F0RVS, F1RVS, F2RVS, F3RVS, F4RVS). Los individuos pueden avanzar gradualmente desde F0 hasta llegar a F4, y aquellos en el estado F4 tienen la posibilidad de desarrollar cirrosis descompensada (CD) o carcinoma hepatocelular (CHC). A su vez, desde el estadio de CD también pueden progresar a CHC. Los pacientes con CD o CHC enfrentan un riesgo de mortalidad debido a su enfermedad hepática y pueden llegar al estado de mortalidad por hepatopatía. El estadio de cirrosis descompensada se divide en dos subestadios, uno para el primer año y otro para los años siguientes (CD1), con tasas de cáncer y mortalidad diferenciadas. Finalmente, en todos los estadios existe un riesgo de mortalidad por causas generales.

Los pacientes que logran la RVS en el tratamiento, cuando están en las etapas de fibrosis desde F0 hasta F3 (es decir, aquellos en los estadios F0RVS a F3RVS), se consideran curados y no continúan progresando en la enfermedad, teniendo la posibilidad de morir según las tasas de mortalidad de la población general. En cambio, aquellos que ya se encontraban en el estadio de cirrosis (F4RVS) al recibir el tratamiento tienen una posibilidad, aunque reducida, de desarrollar CHC o CD.

Para aquellos casos en los que se desestime el tratamiento, el modelo reproduce la evolución natural de la enfermedad. Entre quienes reciben tratamiento, se realiza una subdivisión entre aquellos que completan el tratamiento y los que lo abandonan. Cabe aclarar que, quienes completan el tratamiento, pueden alcanzar o no una Respuesta Viral Sostenida (RVS). En el caso de quienes abandonan el tratamiento o no logran la RVS, se asume que experimentarán la progresión natural de la hepatitis C. 


## Limitaciones y Consideraciones

Este modelo se centra exclusivamente en el tratamiento con Sofosbuvir-Velpatasvir, excluyendo otros tratamientos disponibles actualmente. Considera dos grupos de pacientes: aquellos que completan el tratamiento y los que lo abandonan, sin abordar diferencias individuales en la adherencia o respuesta al tratamiento. Además, la simplificación de la fibrosis hepática en etapas discretas puede no captar toda la complejidad y variabilidad de la progresión de la enfermedad en situaciones reales.

Desde una perspectiva económica, la estimación de costos para Costa Rica, Ecuador, México y Perú se llevó a cabo a través de un método de estimación indirecta, basado en el PIB de cada país, debido a la falta de información específica de costos disponible para estos países.


## Descripción General de los Parámetros


<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros epidemiológicos.</strong>
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
   <td>Duración del tratamiento (meses)
   </td>
   <td>Duración del tratamiento con Sofosbuvir (400 mg) y Velpatasvir (100 mg) en meses
   </td>
   <td>Asociación Argentina para el Estudio de la Enfermedades del higado<sup><a href="https://paperpile.com/c/TwRd3v/0nwgT">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>Eficacia de Sofosbuvir/ Velpatasvir
<p>
(Epclusa®)
   </td>
   <td>Porcentaje de pacientes que logran la eliminación viral con el  tratamiento antiviral específico que combina los medicamentos Sofosbuvir y Velpatasvir.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de pacientes que abandonan el tratamiento
   </td>
   <td>Porcentaje de pacientes que abandonan el tratamiento.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Tamaño de la cohorte<sup>a</sup>
   </td>
   <td>Número de personas mayores de 18 años con infección por VHC que ingresan al modelo.
   </td>
   <td>Asunción
   </td>
  </tr>
  <tr>
   <td>Porcentaje de personas en estadío de fibrosis F0 al diagnóstico
   </td>
   <td>Porcentaje de personas en estadío de fibrosis F0 al diagnóstico. 
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de personas en estadío de fibrosis F1 al diagnóstico.
   </td>
   <td>Porcentaje de personas en estadío de fibrosis F1 al diagnóstico.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de personas en estadío de fibrosis F2 al diagnóstico.
   </td>
   <td>Porcentaje de personas en estadío de fibrosis F2 al diagnóstico.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de personas en estadío de fibrosis F3 al diagnóstico.
   </td>
   <td>Porcentaje de personas en estadío de fibrosis F3 al diagnóstico.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de personas en estadío de fibrosis F4 al diagnóstico.
   </td>
   <td>Porcentaje de personas en estadío de fibrosis F4 al diagnóstico.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/TwRd3v/EglvT">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Carga de discapacidad asociada a la cirrosis descompensada 
   </td>
   <td>Carga de discapacidad (Disability Weight) asociada a la CD en términos de la pérdida de calidad de vida que esta enfermedad puede causar en una persona.
   </td>
   <td>OMS<sup>31</sup>
   </td>
  </tr>
  <tr>
   <td>Carga de discapacidad asociada al carcinoma hepatocelular 
   </td>
   <td>Carga de discapacidad (Disability Weight) asociada al CHC en términos de la pérdida de calidad de vida que esta enfermedad puede causar en una persona.
   </td>
   <td>OMS<sup>31</sup>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros de costos.</strong>
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
   <td>Costo de tratamiento mensual de Sofosbuvir/ Velpatasvir
<p>
(Epclusa®) (USD)
   </td>
   <td>Costo de tratamiento mensual de Sofosbuvir/ Velpatasvir
<p>
(Epclusa®). Régimen de AAD (antivirales de acción directa) de 4 semanas. 
   </td>
   <td>Organización Panamericana de la Salud<sup><a href="https://paperpile.com/c/TwRd3v/EYkPv">25</a></sup>.
<p>
Valor expresado en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
  <tr>
   <td>Costo anual de estadío de fibrosis F0 a F2 (USD)
   </td>
   <td>Costo anual del seguimiento, tratamiento y complicaciones de estadíos de fibrosis F0 a F2 en el país.
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/TwRd3v/86PCj+I2J7C+MsYJs+6VvmC+75xmu+pRDm5+GPXER">7–13</a></sup> en dólares<sup><a href="https://paperpile.com/c/TwRd3v/brY1b+p1lA9+JsL0p+ckmkF+QmtTq+CfxjP+oBQcY">14–20</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup>, BRA,<sup><a href="https://paperpile.com/c/TwRd3v/FHNZi">22</a></sup> COL,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup> y CHL.<sup><a href="https://paperpile.com/c/TwRd3v/yjxdS">23</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
<p>
Valor expresado en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
  <tr>
   <td>Costo anual de estadío de  fibrosis F3 (USD) 
   </td>
   <td>Costo anual del seguimiento, tratamiento y complicaciones de estadio de fibrosis F3 en el país específico de análisis. 
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/TwRd3v/86PCj+I2J7C+MsYJs+6VvmC+75xmu+pRDm5+GPXER">7–13</a></sup> en dólares<sup><a href="https://paperpile.com/c/TwRd3v/brY1b+p1lA9+JsL0p+ckmkF+QmtTq+CfxjP+oBQcY">14–20</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup> BRA,<sup><a href="https://paperpile.com/c/TwRd3v/FHNZi">22</a></sup> COL,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup> y CHL.<sup><a href="https://paperpile.com/c/TwRd3v/yjxdS">23</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
<p>
Valor expresado en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
  <tr>
   <td>Costo anual de estadío de fibrosis F4 (USD)
   </td>
   <td>Costo anual del seguimiento, tratamiento y complicaciones de estadio de fibrosis F4 (cirrosis) en el país específico de análisis. 
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/TwRd3v/86PCj+I2J7C+MsYJs+6VvmC+75xmu+pRDm5+GPXER">7–13</a></sup> en dólares<sup><a href="https://paperpile.com/c/TwRd3v/brY1b+p1lA9+JsL0p+ckmkF+QmtTq+CfxjP+oBQcY">14–20</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup> BRA,<sup><a href="https://paperpile.com/c/TwRd3v/FHNZi">22</a></sup> COL,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup> y CHL.<sup><a href="https://paperpile.com/c/TwRd3v/yjxdS">23</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
<p>
Valor expresado en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
  <tr>
   <td>Costo anual de cirrosis descompensada (USD)
   </td>
   <td>Costo anual del seguimiento, tratamiento y complicaciones de la cirrosis descompensada en el país específico de análisis.
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/TwRd3v/86PCj+I2J7C+MsYJs+6VvmC+75xmu+pRDm5+GPXER">7–13</a></sup> en dólares<sup><a href="https://paperpile.com/c/TwRd3v/brY1b+p1lA9+JsL0p+ckmkF+QmtTq+CfxjP+oBQcY">14–20</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup>, BRA,<sup><a href="https://paperpile.com/c/TwRd3v/FHNZi">22</a></sup> COL,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup>CHL<sup><a href="https://paperpile.com/c/TwRd3v/yjxdS">23</a></sup> y MEX.<sup><a href="https://paperpile.com/c/TwRd3v/yvFyk">24</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
<p>
Valor expresado en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
  <tr>
   <td>Costo anual de carcinoma hepatocelular (USD) 
   </td>
   <td>Costo anual del seguimiento, tratamiento y complicaciones del cáncer de hígado en el país específico de análisis.
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/TwRd3v/86PCj+I2J7C+MsYJs+6VvmC+75xmu+pRDm5+GPXER">7–13</a></sup> en dólares<sup><a href="https://paperpile.com/c/TwRd3v/brY1b+p1lA9+JsL0p+ckmkF+QmtTq+CfxjP+oBQcY">14–20</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup>, BRA,<sup><a href="https://paperpile.com/c/TwRd3v/FHNZi">22</a></sup> COL,<sup><a href="https://paperpile.com/c/TwRd3v/Egs1t">21</a></sup>CHL<sup><a href="https://paperpile.com/c/TwRd3v/yjxdS">23</a></sup> y MEX.<sup><a href="https://paperpile.com/c/TwRd3v/yvFyk">24</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
<p>
Valor expresado en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento (%)
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Manual metodológico para elaboración de Evaluaciones Económicas <sup><a href="https://paperpile.com/c/TwRd3v/xS95">26</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo programático anual de la intervención (USD)
   </td>
   <td>Costo de implementar y sostener la intervención en un año.
   </td>
   <td>Se deja la posibilidad al usuario de completar este dato si cuenta con él
   </td>
  </tr>
</table>



## Lista de Indicadores

**Resultados epidemiológicos**



1. **Cirrosis evitadas (n): **cantidad de casos de cirrosis que se logran evitar mediante el tratamiento.

    Ej: **Cirrosis evitadas n= 3.398. **En este caso, el modelo indica que el tratamiento tiene el potencial de evitar 3.398,0 casos de cirrosis en la población con infección por HCV.

2. **Carcinomas hepatocelulares evitados (n): **cantidad de casos de carcinoma hepatocelular que se logran evitar mediante el tratamiento.

    Ej: **Carcinomas hepatocelulares evitados n= 1.872. **En este caso, el modelo indica que el tratamiento tiene el potencial de evitar 1.872 casos de carcinomas hepatocelulares en la población con infección por HCV. 

3. **Muertes evitadas (n): **cantidad de muertes por enfermedades hepáticas que se logran evitar mediante el tratamiento.

    Ej: **Muertes evitadas n= 3.581. **En este caso, el modelo indica que el tratamiento tiene el potencial de evitar 3.581200 muertes por hepatopatías en la población con infección por HCV. 

4. **Años de vida salvados:** cantidad de años de vida ganados al prevenir muertes debido a infección por VHC.

    Ej: **Años de vida salvados n=200. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de prevenir la pérdida de 200 años de vida en la población en estudio. 

5. **Años de Vida Ajustados por Discapacidad (AVAD) evitados (años):** mide la cantidad de años de vida ajustados por discapacidad que se evitan como resultado de la implementación de la intervención.

    Ej: **AVAD evitados: n= 200. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar una pérdida de 200 AVAD en la población.


**Resultados económicos**



6. **Costo total de la intervención (USD): **se calcula multiplicando la cantidad de tratamientos instaurados por el tiempo de duración de los mismos contemplando el abandono y los costos de seguimiento del mismo. Se incluye, además, el costo programático de la intervención si lo hubiera.

    Ej: **Costo total de la vacunación (USD) = $2.589.564 USD: **el costo total de instaurar tratamiento a la cohorte infectada asciende a $2.589.564 USD.** ** 

7. **Costos evitados atribuibles a la intervención (USD): **representa el ahorro en costos de tratamiento de la progresión de la fibrosis hepática y sus consecuencias como la cirrosis descompensada y el hepatocarcinoma debido a la respuesta viral sostenida conseguida con el tratamiento.

    Ej: **Costos evitados atribuibles a la intervención (USD) = $3.255.983,1 USD: **el modelo indica que el tratamiento  tiene la capacidad de ahorrar $3.255.983,1 USD en eventos en salud asociados a la progresión de enfermedad.

8. **Diferencia de costos respecto al escenario basal (USD):** la diferencia de costos surge de restarle a los costos de la intervención los costos ahorrados por evitar la progresión del compromiso hepático incluyendo sus consecuencias como la cirrosis descompensada o el hepatocarcinoma.

    Ej: **Diferencia de costos respecto al escenario basal (USD) = $35.115 USD: **el modelo indica que la diferencia entre el costo de la intervención y los ahorros generados por la misma son $35.115 USD.

9. **Razón de costo-efectividad incremental (RCEI) por cirrosis evitada:** costo adicional del tratamiento antiviral por cada caso adicional de cirrosis que se logra prevenir, en comparación con la ausencia de tratamiento. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad de cirrosis evitada (intervención vs no intervención).

    Ej: **RCEI por cirrosis evitada (USD) = -$6.650,6 USD:** este valor indica que el nuevo tratamiento domina a no recibir tratamiento. Es decir que en promedio, prevenir un caso de cirrosis con el tratamiento ahorra $6.650,6 USD en comparación con no administrar tratamiento. 

10. **Razón de costo-efectividad incremental (RCEI) por vida salvada: **costo adicional del tratamiento antiviral por vida salvada adicional al evitar una muerte por hepatopatía en comparación con la ausencia de tratamiento. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad expresada muertes evitadas (intervención vs no intervención).

    Ej: **RCEI por vida salvada =** **-$6.310,1 USD: **este valor indica que el nuevo tratamiento domina a no recibir tratamiento, en promedio, prevenir un caso de muerte por hepatopatía con el tratamiento ahorra además $6.310,1 USD en comparación con no administrar tratamiento. 

11. **Razón de costo-efectividad incremental (RCEI) por Año de vida salvado (AVS):** costo adicional del tratamiento antirretroviral por cada AVS en comparación con la ausencia de tratamiento. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad en AVS (intervención vs no intervención).

    Ej: **RCEI por AVS =** $**375,2 USD: **el tratamiento antiviral cuesta $375,2 USD adicionales por cada AVS en comparación con la ausencia de tratamiento. 

12. **Razón de costo-efectividad incremental (RCEI) por Años de Vida Ajustados por Discapacidad (AVAD) evitada: **costo adicional del tratamiento antirretroviral por cada Año de Vida ajustado por discapacidad adicional que se evita en comparación con la ausencia de tratamiento. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad expresada en años de vida ajustados por discapacidad evitados (intervención vs no intervención).

    Ej: **RCEI por AVAD adicional =** $**347,1 USD: **el tratamiento antiviral cuesta $347,1 USD adicionales por cada AVAD evitado en comparación con la ausencia de tratamiento. 

13. **Retorno de Inversión (ROI) (%):** relación entre los beneficios económicos obtenidos y el costo del tratamiento antirretroviral. Un ROI positivo indica que el tratamiento antirretroviral no solo cubre su costo, sino que también genera un beneficio económico adicional. En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. Se define como los ingresos menos la inversión, dividido por la inversión. 

    Ej: **Retorno de Inversión (ROI) (%):** para un ROI del 14% por cada 1 USD invertido en el tratamiento antirretroviral, se obtiene un retorno de 0.14 USD además del capital inicial. 





## Referencias


    1.	[Hepatitis C. Accessed December 13, 2023. https://www.who.int/news-room/fact-sheets/detail/hepatitis-c](http://paperpile.com/b/TwRd3v/hRIeR)


    2.	[Schillie S, Wester C, Osborne M, Wesolowski L, Ryerson AB. CDC Recommendations for Hepatitis C Screening Among Adults - United States, 2020. MMWR Recomm Rep. 2020;69(2):1-17.](http://paperpile.com/b/TwRd3v/JTbGm)


    3.	[US Preventive Services Task Force, Owens DK, Davidson KW, et al. Screening for Hepatitis C Virus Infection in Adolescents and Adults: US Preventive Services Task Force Recommendation Statement. JAMA. 2020;323(10):970-975.](http://paperpile.com/b/TwRd3v/N1mbt)


    4.	[Mendizabal M, Piñero F, Ridruejo E, et al. Disease Progression in Patients With Hepatitis C Virus Infection Treated With Direct-Acting Antiviral Agents. Clin Gastroenterol Hepatol. 2020;18(11):2554-2563.e3.](http://paperpile.com/b/TwRd3v/EglvT)


    5.	[Ridruejo E, Aaeeh GO. Recomendaciones para el tratamiento de la hepatitis por Virus C: Actualización 2020. In: https://www aaeeh org ar/es/consensos-guias.](http://paperpile.com/b/TwRd3v/0nwgT)


    6.	[Polaris Observatory HCV Collaborators. Global change in hepatitis C virus prevalence and cascade of care between 2015 and 2020: a modelling study. Lancet Gastroenterol Hepatol. 2022;7(5):396-415.](http://paperpile.com/b/TwRd3v/ijuy5)


    7.	[Extended National Consumer Price Index. Instituto Brasileiro de Geografia e Estatística. Accessed September 17, 2023. https://www.ibge.gov.br/en/statistics/economic/prices-and-costs/17129-extended-national-consumer-price-index.html?=&t=o-que-e](http://paperpile.com/b/TwRd3v/86PCj)


    8.	[Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/TwRd3v/I2J7C)


    9.	[Índice de precios al consumidor (IPC). Banco de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/indice-precios-consumidor-ipc](http://paperpile.com/b/TwRd3v/MsYJs)


    10.	[Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/TwRd3v/6VvmC)


    11.	[Índice de Precios al Consumidor. Instituto Nacional de Estadística y Censos. Accessed September 17, 2023. https://www.ecuadorencifras.gob.ec/indice-de-precios-al-consumidor/](http://paperpile.com/b/TwRd3v/75xmu)


    12.	[Índice Nacional de Precios al Consumidor (INPC). Instituto Nacional de Estadística y Geografía (INEGI). Accessed September 17, 2023. https://www.inegi.org.mx/temas/inpc/](http://paperpile.com/b/TwRd3v/pRDm5)


    13.	[Gerencia Central de Estudios Económicos. ÍNDICE DE PRECIOS AL CONSUMIDOR (IPC). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/anuales/resultados/PM05197PA/html/1950/2023/](http://paperpile.com/b/TwRd3v/GPXER)


    14.	[Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/TwRd3v/brY1b)


    15.	[Converter 1 Dólar dos EUA para Real brasileiro. Conversor de moeda XE. Accessed September 17, 2023. https://www.xe.com/pt/currencyconverter/convert/?Amount=1&From=USD&To=BRL](http://paperpile.com/b/TwRd3v/p1lA9)


    16.	[de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/TwRd3v/JsL0p)


    17.	[Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/TwRd3v/ckmkF)


    18.	[Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/TwRd3v/QmtTq)


    19.	[Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/TwRd3v/CfxjP)


    20.	[Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/TwRd3v/oBQcY)


    21.	[Bardach A, Hernández-Vásquez A, Palacios A, et al. Epidemiology, Use of resources, and Costs of Medical Management of Hepatitis C in Argentina, Colombia, Uruguay, and Venezuela. Value in Health Regional Issues. 2019;20:180-190.](http://paperpile.com/b/TwRd3v/Egs1t)


    22.	[Benzaken AS, Girade R, Catapan E, et al. Hepatitis C disease burden and strategies for elimination by 2030 in Brazil. A mathematical modeling approach. Braz J Infect Dis. 2019;23(3):182-190.](http://paperpile.com/b/TwRd3v/FHNZi)


    23.	[Vargas CL, Espinoza MA, Giglio A, Soza A. Cost Effectiveness of Daclatasvir/Asunaprevir Versus Peginterferon/Ribavirin and Protease Inhibitors for the Treatment of Hepatitis c Genotype 1b Naïve Patients in Chile. PLoS One. 2015;10(11):e0141660.](http://paperpile.com/b/TwRd3v/yjxdS)


    24.	[Marquez LK, Fleiz C, Burgos JL, et al. Cost-effectiveness of hepatitis C virus (HCV) elimination strategies among people who inject drugs (PWID) in Tijuana, Mexico. Addiction. 2021;116(10):2734-2745.](http://paperpile.com/b/TwRd3v/yvFyk)


    25.	[Productos y precios del Fondo Estratégico. Organización Panamericana de la Salud. Accessed September 25, 2023. https://www.paho.org/es/fondo-estrategico-ops/productos-precios](http://paperpile.com/b/TwRd3v/EYkPv)


    26.	[Moreno M, Aurelio M, Castro H. Manual metodológico para la elaboración de Evaluaciones Económicas. IETS. Accessed December 26, 2023. https://www.iets.org.co/Archivos/64/Manual_evaluacion_economica.pdf](http://paperpile.com/b/TwRd3v/xS95)


    27.	[World Population Prospects - Population Division - United Nations. Accessed September 20, 2023. https://population.un.org/wpp/Download/Standard/Mortality/](http://paperpile.com/b/TwRd3v/nl9yu)




## Anexo


## Descripción parámetros internos del modelo


<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros globales</strong>
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
   <td>pF0_F1
   </td>
   <td>Probabilidad de F0 de pasar a F1.
   </td>
   <td>
    Thein y cols.<sup>27</sup>
   </td>
  </tr>
  <tr>
   <td>pF1_F2
   </td>
   <td>Probabilidad de F1 de pasar a F2.
   </td>
   <td>
    Thein y cols.<sup>27</sup>
   </td>
  </tr>
  <tr>
   <td>pF2_F3
   </td>
   <td>Probabilidad de F2 de pasar a F3.
   </td>
   <td>
    Thein y cols.<sup>27</sup>
   </td>
  </tr>
  <tr>
   <td>pF3_F4
   </td>
   <td>Probabilidad de F3 de pasar a F4.
   </td>
   <td>
    Thein y cols.<sup>27</sup>
   </td>
  </tr>
  <tr>
   <td>pF4_CD
   </td>
   <td>Probabilidad de F4 de pasar a CD.
   </td>
   <td>Fattovich y cols. <sup>28</sup>
   </td>
  </tr>
  <tr>
   <td>pF4_CHC
   </td>
   <td>Probabilidad de F4 de pasar a CHC.
   </td>
   <td>Fattovich y cols. <sup>28</sup>
   </td>
  </tr>
  <tr>
   <td>pCD_CHC
   </td>
   <td>Probabilidad de CD de pasar a CHC.
   </td>
   <td>Planas y cols.<sup>30</sup>
   </td>
  </tr>
  <tr>
   <td>pCD_MH
   </td>
   <td>Probabilidad de CD de pasar a MH.
   </td>
   <td>Planas y cols.<sup>30</sup>
   </td>
  </tr>
  <tr>
   <td>pCD1_CHC
   </td>
   <td>Probabilidad de CD de pasar a CHC
   </td>
   <td>Planas y cols.<sup>30</sup>
   </td>
  </tr>
  <tr>
   <td>pCD1_MH
   </td>
   <td>Probabilidad de CD de pasar a MH
   </td>
   <td>Planas y cols.<sup>30</sup>
   </td>
  </tr>
  <tr>
   <td>pCHC_MH
   </td>
   <td>Probabilidad de CHC de pasar a MH.
   </td>
   <td>Fattovich y cols. <sup>28</sup>
   </td>
  </tr>
  <tr>
   <td>pF4RVS_CD
   </td>
   <td>Probabilidad de F4RVS de pasar a CD.
   </td>
   <td>Cardoso y cols.<sup>29</sup>
   </td>
  </tr>
  <tr>
   <td>pF4RVS_CHC
   </td>
   <td>Probabilidad de F4RVS de pasar a CHC.
   </td>
   <td>Cardoso y cols.<sup>29</sup>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de mortalidad general por edad
   </td>
   <td>Probabilidad de morir debido a causa general por edad simple.
   </td>
   <td>NU<sup><a href="https://paperpile.com/c/TwRd3v/nl9yu">27</a></sup>
   </td>
  </tr>
</table>


<sup>a</sup>Se dividió la proporción de F0-F1 por dos para obtener dos estadios distintos.

