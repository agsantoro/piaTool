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

# 5. Model Card: PrEP oral para VIH


---


## Introducción

En las últimas décadas, la pandemia del VIH ha planteado desafíos considerables a la comunidad científica y médica, instándole a idear estrategias efectivas para prevenir la transmisión de este virus. La PrEP es una estrategia fundamental en el enfoque de prevención combinada, que abarca un espectro de métodos preventivos adaptados a las necesidades de las personas en riesgo de contraer el virus del VIH. Este enfoque holístico incluye educación, el uso consistente de preservativos, pruebas y tratamiento del VIH, junto con otras estrategias de prevención de enfermedades de transmisión sexual. 

La PrEP oral, que implica que las personas VIH seronegativas utilicen medicamentos antirretrovirales, ha demostrado ser altamente eficaz para reducir significativamente el riesgo de infección por el VIH.<sup><a href="https://paperpile.com/c/UE5nfU/jXuw">1</a></sup> La integración de la PrEP en este enfoque integral permite abordar la epidemia del VIH considerando las diversas necesidades y contextos de las personas en riesgo. Esta estrategia ha demostrado su eficacia, especialmente en poblaciones con un alto riesgo de exposición al virus, como hombres que tienen sexo con hombres (HSH), parejas serodiscordantes y trabajadores sexuales.  Aunque la PrEP oral diaria fue recomendada para personas con un riesgo sustancial de VIH por la OMS en 2014, la disponibilidad de PrEP es aún limitada en América Latina.<sup><a href="https://paperpile.com/c/UE5nfU/meL4">2</a></sup> Dentro de las opciones de PrEP disponibles,<sup><a href="https://paperpile.com/c/UE5nfU/jXuw">1</a></sup> la PrEP oral, que implica la toma de comprimidos, es a la fecha, la más ampliamente disponible en paises de Latino America. 


## Nombre del Modelo

Profilaxis pre exposición (PrEP, su sigla del inglés _Pre-Exposure Prophylaxis_) oral para la prevención del VIH (Virus de la Inmunodeficiencia Humana).

Descripción del Modelo y Asunciones

Se desarrolló un modelo de transición de estados con ciclos trimestrales para estudiar una población con alto riesgo de infección por HIV. Este modelo utiliza datos de transmisión basados en la prevalencia e incidencia de casos conocidos.<sup><a href="https://paperpile.com/c/UE5nfU/Knt1">3</a></sup>  A lo largo del tiempo, sigue a una cohorte dinámica de pacientes con prevalencia conocida de VIH, hasta que todos sus miembros iniciales fallezcan o alcancen los 100 años. Esta cohorte incluye individuos de edades distribuidas según lo observado en estudios sobre el uso de profilaxis preexposición (PrEP), con nuevas incorporaciones anuales.

La intervención PrEP implica la administración diaria de Tenofovir/emtricitabina y pruebas trimestrales. Se ofrece a la cohorte durante un período de 1 a 5 años. Los individuos sanos pueden optar por PrEP y son susceptibles a la infección por HIV hasta una edad establecida (por ejemplo, 60 años). Los que reciben PrEP tienen la posibilidad de abandonar el tratamiento y, dentro de los primeros 5 años de abandono, reiniciarlo, un patrón común en la literatura.<sup><a href="https://paperpile.com/c/UE5nfU/RzWo+S9Tr">4,5</a></sup>

La probabilidad de contraer HIV se calcula cada ciclo, basándose en la prevalencia del VIH y la tasa de transmisión, ajustada por el porcentaje de diagnósticos conocidos y pacientes controlados (asumidos como no transmisores). Los usuarios de PrEP tienen un riesgo reducido de infección, determinado por la eficacia y adherencia a la PrEP.

La detección del VIH depende de la tasa de diagnósticos conocidos en cada país y del promedio de pruebas realizadas anualmente para identificar la enfermedad. Se asume que los individuos que se infectan mientras están bajo la PrEP son diagnosticados al término del ciclo debido a la frecuencia de las pruebas. Las personas infectadas reciben tratamiento en función de la disponibilidad y las prácticas médicas en cada país. Aquellos que no reciben tratamiento, así como los que están en tratamiento pero no logran controlar la infección, enfrentan un mayor riesgo de complicaciones y una probabilidad incrementada de morir a causa del VIH, en comparación con la población general. Por otro lado, la probabilidad de mortalidad para las personas sanas se considera igual a la del promedio de la población general.


## Limitaciones y Consideraciones

El modelo desarrollado para esta intervención tiene limitaciones epidemiológicas importantes que deben considerarse cuidadosamente en su interpretación y aplicación. Su enfoque se centra específicamente en los datos epidemiológicos relativos a hombres que tienen sexo con hombres (HSH), una población clave en el riesgo de transmisión del VIH. Sin embargo, esta focalización puede restringir la aplicabilidad de los resultados a otras poblaciones. Al centrarse exclusivamente en HSH, el modelo no aborda todas las vías de transmisión del VIH ni contempla infecciones por fuera de la cohorte, lo que podría llevar a una subestimación de la efectividad de la PrEP en contextos donde la transmisión heterosexual es común. Esta limitación es particularmente relevante en el caso de las mujeres transgénero, otro grupo crítico en la epidemia del VIH. Es crucial reconocer y tener en cuenta esta limitación al interpretar los resultados del modelo y considerar la necesidad de investigaciones adicionales y adaptaciones para evaluar con mayor precisión la eficacia de la PrEP en diferentes poblaciones en riesgo de infección por el VIH. 

El propósito principal del modelo es evaluar una intervención de prevención, por lo que el detalle en la modelización de la evolución de pacientes infectados con VIH no es exhaustivo, aunque esta sea una aproximación común en estudios de este tipo.<sup><a href="https://paperpile.com/c/UE5nfU/ZSDz">6</a></sup>  Además, dado que el modelo no se centra en el tratamiento del VIH, no se consideran variaciones en el porcentaje de pacientes tratados, su adherencia al tratamiento, ni el porcentaje de pacientes con control viral efectivo. Por lo tanto, se asume que estos factores permanecen constantes a lo largo del tiempo, basados en los valores establecidos para cada país, al igual que la probabilidad específica de muerte asociada a esta enfermedad. Además, el modelo está diseñado para pacientes sin comorbilidades ni problemas de resistencia a los antirretrovirales.

Desde el punto de vista económico, la estimación de costos para países como Costa Rica, Ecuador, México y Perú se realizó mediante un método de estimación indirecta, basado en el PIB de cada país. Esto se debió a la falta de información específica sobre costos en estos lugares. Además, la definición de los regímenes de tratamiento y la cantidad de exámenes realizados durante el seguimiento se basaron en prácticas observadas específicamente en Argentina, asumiendo que estas serían similares en los demás países mencionados.


## Descripción General de los Parámetros


<table>
  <tr>
   <td colspan="4" >
    <strong>Parámetros globales.</strong>
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
   <td><strong>Tipo de parámetros</strong>
   </td>
  </tr>
  <tr>
   <td>Edad minima inicial
   </td>
   <td>Edad mínima de los participantes en la cohorte inicial del estudio de distribución etaria.
   </td>
   <td>Asunción
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Edad máxima inicial
   </td>
   <td>Edad máxima de los integrantes de la cohorte inicial en el estudio de distribución por edades.
   </td>
   <td>Asunción
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Aceptabilidad de PrEP en la población
   </td>
   <td>Mide la disposición y actitud positiva de la población hacia el uso de la PrEP para prevenir el VIH.
   </td>
   <td>Soares y cols.<sup><a href="https://paperpile.com/c/UE5nfU/SjsM">7</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Duración de PrEP
   </td>
   <td>Se refiere al período de tiempo durante el cual una persona toma la PrEP para prevenir la infección por VIH.
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Edad de fin de indicación de PrEP
   </td>
   <td>Asunción del modelo que define la edad máxima para el uso de PrEP en la prevención del VIH, utilizada para análisis o simulaciones.
   </td>
   <td>Asunción 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Limite edad de riesgo
   </td>
   <td>Asunción del modelo que establece la edad desde la cual el riesgo de contagio del VIH por vía sexual se considera mínima.
   </td>
   <td>Asunción 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Limite edad de contagio
   </td>
   <td>Asunción del modelo que establece la edad desde la cual se considera que el papel de la persona en la transmisión del VIH es mínima.
   </td>
   <td>Asunción 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Eficacia PrEP en la población
   </td>
   <td>Se refiere a la efectividad de la PrEP para prevenir el VIH en un grupo poblacional específico, evaluando su éxito en reducir la incidencia de infección en diferentes contextos y grupos demográficos.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Adherencia PrEP en la población
   </td>
   <td>Se refiere al grado en que las personas siguen el régimen de tratamiento de la PrEP para la prevención del VIH, incluyendo la consistencia y regularidad en la toma del medicamento.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de abandono de PrEP año 1
   </td>
   <td>Porcentaje de individuos que interrumpen su tratamiento de PrEP durante el primer año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de abandono de PrEP año 2
   </td>
   <td>Porcentaje de individuos que interrumpen su tratamiento de PrEP durante el segundo año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de abandono de PrEP año 3
   </td>
   <td>Porcentaje de individuos que interrumpen su tratamiento de PrEP durante el tercer año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de abandono de PrEP año 4
   </td>
   <td>Porcentaje de individuos que interrumpen su tratamiento de PrEP durante el cuarto año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de abandono de PrEP año 5
   </td>
   <td>Porcentaje de individuos que interrumpen su tratamiento de PrEP durante el quinto año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de reiniciar PrEP año 1
   </td>
   <td>Porcentaje de individuos que retoman el tratamiento con PrEP después de haberlo interrumpido, dentro del primer año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de reiniciar PrEP año 2
   </td>
   <td>Porcentaje de individuos que retoman el tratamiento con PrEP después de haberlo interrumpido, dentro del segundo año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de reiniciar PrEP año 3
   </td>
   <td>Porcentaje de individuos que retoman el tratamiento con PrEP después de haberlo interrumpido, dentro del tercer año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de reiniciar PrEP año 4
   </td>
   <td>Porcentaje de individuos que retoman el tratamiento con PrEP después de haberlo interrumpido, dentro del cuarto año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de reiniciar PrEP año 5
   </td>
   <td>Porcentaje de individuos que retoman el tratamiento con PrEP después de haberlo interrumpido, dentro del quinto año de uso.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/UE5nfU/RzWo">4</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Riesgo relativo (RR) de contagio conociendo diagnóstico de VIH
   </td>
   <td>RR de transmisión del VIH en personas que ya han sido diagnosticadas con el virus, comparado con aquellas que no tienen dicho diagnóstico.
   </td>
   <td>Marks y cols.<sup><a href="https://paperpile.com/c/UE5nfU/f3xL">8</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Cantidad de Test de HIV por año en la población
   </td>
   <td>Asunción del modelo sobre la cantidad anual de pruebas de VIH realizadas en una población específica.
   </td>
   <td>Asunción 
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Años hasta inicio de clínica sugerente de Síndrome de Inmunodeficiencia Adquirida (SIDA).
   </td>
   <td>Se refiere al tiempo transcurrido desde la infección por VIH hasta la aparición de síntomas clínicos que indican el desarrollo del SIDA.
   </td>
   <td>Asunción
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Disutilidad por infección aguda de VIH
   </td>
   <td>Se refiere a la reducción en la calidad de vida durante la fase aguda de la infección por VIH, caracterizada por síntomas iniciales y a menudo intensos.
   </td>
   <td>GBD<sup><a href="https://paperpile.com/c/UE5nfU/4p8t">9</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Distribución etaria de la cohorte inicial / población en riesgo que recibiría PrEP año 18
   </td>
   <td>Indica cómo se distribuyen las edades de las personas en un grupo en riesgo de VIH en el año 18 al 100.
   </td>
   <td>Spinelli y cols.<sup><a href="https://paperpile.com/c/UE5nfU/S9Tr">5</a></sup>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento anual
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Bill and Melinda Gates Foundation.<sup><a href="https://paperpile.com/c/UE5nfU/YzJ76">10</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="4" >
    <strong>Parámetros por países.</strong>
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
   <td><strong>Tipo de parámetro</strong>
   </td>
  </tr>
  <tr>
   <td>Nuevos casos de VIH en población
   </td>
   <td>Indica el número de personas que han sido recientemente diagnosticadas con el VIH en una población específica durante un período determinado.
   </td>
   <td>UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Básico
   </td>
  </tr>
  <tr>
   <td>Casos prevalentes HIV en población
   </td>
   <td>Indica el número total de personas que viven con el VIH en una población específica en un momento dado, incluyendo tanto los casos recién diagnosticados como aquellos diagnosticados previamente.
   </td>
   <td>UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Básico
   </td>
  </tr>
  <tr>
   <td>Casos prevalentes en la población en riesgo 
   </td>
   <td>Porcentaje de individuos en una población específica que están infectados con el VIH, representando la proporción de personas con VIH en relación al total de la población.
   </td>
   <td>UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Básico
   </td>
  </tr>
  <tr>
   <td>Personas que viven con VIH que conocen su estado
   </td>
   <td>Porcentaje de individuos infectados con VIH en una población que están conscientes de su diagnóstico.
   </td>
   <td>UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Personas que viven con VIH que reciben Terapia Antirretroviral (TAR)
   </td>
   <td>Porcentaje de individuos infectados con VIH en una población que están recibiendo TAR. 
   </td>
   <td>UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Personas que viven con VIH que tienen cargas virales suprimida
   </td>
   <td>Porcentaje de individuos infectados con VIH en una población cuyas cargas virales han sido reducidas a niveles muy bajos o indetectables gracias al tratamiento, indicando un control efectivo del virus.
   </td>
   <td>UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Probabilidad de muerte por VIH
   </td>
   <td>Indica la probabilidad de que una persona infectada con el VIH fallezca debido a la enfermedad o a complicaciones asociadas, dentro de la población que presenta casos prevalentes de VIH.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/UE5nfU/F0BF">12</a></sup> 
<p>
CEPAL<sup><a href="https://paperpile.com/c/UE5nfU/GqG4">13</a></sup>
<p>
UNAIDS<sup><a href="https://paperpile.com/c/UE5nfU/gHaL">11</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Utilidad de poblacion general año 0 al 100
   </td>
   <td>Se refiere a valores anuales que representan la evaluación de la calidad de vida de la población general a lo largo de un período que abarca desde el año 0 hasta el año 100.
   </td>
   <td>OMS
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Tasa mortalidad año 15 al 100
   </td>
   <td>Se refiere a una medida que indica la proporción de personas que fallecen en cada año dentro de un período de tiempo que va desde el año 15 hasta el año 100.
   </td>
   <td>OMS<sup><a href="https://paperpile.com/c/UE5nfU/VLvr">14</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de diagnóstico
   </td>
   <td>Incluye una prueba de anticuerpos VIH y una consulta con el médico clínico
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/UE5nfU/2pFn">15</a></sup>, Brasil<sup><a href="https://paperpile.com/c/UE5nfU/2pFn+5H0k">15,16</a></sup>, Chile<sup><a href="https://paperpile.com/c/UE5nfU/sekT">17</a>,<a href="https://paperpile.com/c/UE5nfU/n42o">18</a></sup> y Colombia<sup><a href="https://paperpile.com/c/UE5nfU/DXH8">19</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de seguimiento
   </td>
   <td>Incluye consultas médicas, pruebas de laboratorio, estudios de imagen y consejería y educación sexual
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/UE5nfU/2pFn">15</a></sup>, Brasil<sup><a href="https://paperpile.com/c/UE5nfU/2pFn+5H0k">15,16</a></sup>, Chile<sup><a href="https://paperpile.com/c/UE5nfU/sekT">17</a>,<a href="https://paperpile.com/c/UE5nfU/n42o">18</a></sup> y Colombia<sup><a href="https://paperpile.com/c/UE5nfU/DXH8">19</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de tratamiento VIH
   </td>
   <td>Incluye Dolutegravir, Lamivudine, Tenofovir, Efavirenz, Emtricitabine, Darunavir, Ritonavir, Emtricitabina y Abacavir
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/UE5nfU/acTe">20</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de tratamiento PrEP
   </td>
   <td>Incluye Emtricitabine/Tenofovir
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/UE5nfU/acTe">20</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de testeo PrEP
   </td>
   <td>Incluye tests VIH y creatinina
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/UE5nfU/2pFn">15</a></sup>, Brasil<sup><a href="https://paperpile.com/c/UE5nfU/2pFn+5H0k">15,16</a></sup>, Chile<sup><a href="https://paperpile.com/c/UE5nfU/sekT">17</a>,<a href="https://paperpile.com/c/UE5nfU/n42o">18</a></sup> y Colombia<sup><a href="https://paperpile.com/c/UE5nfU/DXH8">19</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de seguimiento PrEP
   </td>
   <td>Costo total de las consultas
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/UE5nfU/2pFn">15</a></sup>, Brasil<sup><a href="https://paperpile.com/c/UE5nfU/2pFn+5H0k">15,16</a></sup>, Chile<sup><a href="https://paperpile.com/c/UE5nfU/sekT">17</a>,<a href="https://paperpile.com/c/UE5nfU/n42o">18</a></sup> y Colombia<sup><a href="https://paperpile.com/c/UE5nfU/DXH8">19</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de consulta infectólogo
   </td>
   <td>Incluye una consulta con infectólogo
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/UE5nfU/2pFn">15</a></sup>, Brasil<sup><a href="https://paperpile.com/c/UE5nfU/2pFn+5H0k">15,16</a></sup>, Chile<sup><a href="https://paperpile.com/c/UE5nfU/sekT">17</a>,<a href="https://paperpile.com/c/UE5nfU/n42o">18</a></sup> y Colombia<sup><a href="https://paperpile.com/c/UE5nfU/DXH8">19</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de complicaciones asociados al VIH
   </td>
   <td>Se asume una porción del costo total de tratamiento de VIH siguiendo el estudio de Luz y cols.<sup><a href="https://paperpile.com/c/UE5nfU/WuxS">21</a></sup>
   </td>
   <td>Luz y cols.<sup><a href="https://paperpile.com/c/UE5nfU/WuxS">21</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
</table>


* Los costos de Argentina, Brasil, Colombia, Ecuador, México y Perú  fueron calculados con base en el estudio de Gómez y cols. ajustando al PIB per cápita de cada país y a la prevalencia de cáncer de cuello uterino en cada país, mediante la metodología de estimación indirecta.


## Lista de indicadores

**Resultados epidemiológicos **



1. **Años de vida ajustados por discapacidad evitados: **mide el número de años que se evitan vivir con discapacidad como resultado de prevenir la infección por VIH con PrEP.

    **Ejem. 150 AVAD evitados**. Esto indica que la prevención del VIH mediante PrEP, se han preservado 150 años de vida sin las discapacidades que suelen asociarse con la infección por VIH.

2. **Años de vida salvados:** mide la cantidad de años de vida adicionales ganados como resultado de una PrEP para prevenir la infección por VIH.

    **Ejem. 200 años de vida salvados.** Esto indica que la prevención del VIH mediante PrEP, tiene el potencial de salvar 200 años de vida por muerte prematura y discapacidad en la población en estudio.

3. **Nuevos casos de VIH (n): **número de personas con VIH en un año.

    **Ejem. 200 nuevos casos.** Esto indica que la prevención del VIH mediante PrEP, tiene el potencial de prevenir 200 nuevos casos de VIH.

4. **Nuevos casos de VIH diagnosticados: **número de personas que son diagnosticadas con VIH en un año.

    **Ejem. 200 nuevos casos diagnosticados.** Esto indica que la prevención del VIH mediante PrEP, tiene el potencial de prevenir 200 nuevos casos de VIH diagnosticados.


**Resultados económicos **



5. **Costo de la intervención: **el costo total de implementar PrEP durante el tiempo definido (5 años, 10 años o toda la vida) para todas la cohorte de personas que recibirán tratamiento.

    Ej: **Costos de la intervención PrEP (USD):** el tratamiento de PrEP en el tiempo definido es de $589.431,3 USD para las personas de la cohorte que recibirán dicho tratamiento.

6. **Diferencia de costos (USD):** diferencia de costos entre la rama de intervención (PrEP) y no intervención (no PrEP).

    Ej: **Diferencia de costos (USD):** si se implementa PrEP se tendría una diferencia de costos de $1.584.025,5 USD en comparación con no PrEP.

7. **Razón de costo-efectividad incremental (ICER) por Años de Vida Ajustados por Calidad (AVAC): **hace referencia al costo adicional que debo invertir con la nueva intervención (PrEP) para ganar un año de vida ajustado por calidad en comparación con no PrEP. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad en AVAC (intervención vs no intervención).

    Ej: **Razón de costo incremental (ICER) por AVAC:** $78,8 USD me cuesta obtener un AVAC adicional al implementar la intervención (PrEP) en comparación con no PrEP.

8. **Razón de costo-efectividad incremental (ICER) por Año de vida salvado (AVS):** hace referencia al costo adicional de la intervención (PrEP) por cada año de vida salvado adicional en comparación con no PrEP. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad en AVS (intervención vs no intervención).

    Ej: **ICER por AVS: **al implementar la intervención, me cuesta $69.3 USD obtener un AVS adicional en comparación con la no intervención.

9. **ROI:** relación entre los beneficios y los costos obtenidos por la intervención. Un ROI positivo indica que la intervención no solo cubre su costo, sino que también genera un beneficio económico adicional.  En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. Se define como los ingresos menos la inversión, dividido por la inversión.

    Ej: **Retorno de Inversión (ROI) (%):** un ROI del 65% significa que por cada $1 USD invertido en la intervención, se obtiene un retorno de $0.65 USD de retorno de la inversión adicional. 


**Nota aclaratoria: **el término “descontado” se refiere al proceso de ajustar los valores futuros de dinero a su equivalente en el presente. La tasa de descuento tomada como referencia es 5%.


## 


## Referencias


    1.	[Health Organization W. Differentiated and simplified pre-exposure prophylaxis for HIV prevention: update to WHO implementation guidance: technical brief. Accessed December 8, 2023. https://apps.who.int/iris/bitstream/handle/10665/360861/9789240053694-eng.pdf?sequence=1](http://paperpile.com/b/UE5nfU/jXuw)


    2.	[Veloso VG, Cáceres CF, Hoagland B, et al. Same-day initiation of oral pre-exposure prophylaxis among gay, bisexual, and other cisgender men who have sex with men and transgender women in Brazil, Mexico, and Peru (ImPrEP): a prospective, single-arm, open-label, multicentre implementation study. Lancet HIV. 2023;10(2):e84-e96.](http://paperpile.com/b/UE5nfU/meL4)


    3.	[Pinkerton SD. HIV transmission rate modeling: a primer, review, and extension. AIDS Behav. 2012;16(4):791-796.](http://paperpile.com/b/UE5nfU/Knt1)


    4.	[Hojilla JC, Hurley LB, Marcus JL, et al. Characterization of HIV Preexposure Prophylaxis Use Behaviors and HIV Incidence Among US Adults in an Integrated Health Care System. JAMA Netw Open. 2021;4(8):e2122692.](http://paperpile.com/b/UE5nfU/RzWo)


    5.	[Spinelli MA, Scott HM, Vittinghoff E, et al. Missed Visits Associated With Future Preexposure Prophylaxis (PrEP) Discontinuation Among PrEP Users in a Municipal Primary Care Health Network. Open Forum Infect Dis. 2019;6(4):ofz101.](http://paperpile.com/b/UE5nfU/S9Tr)


    6.	[Siebert U, Alagoz O, Bayoumi AM, et al. State-transition modeling: a report of the ISPOR-SMDM Modeling Good Research Practices Task Force-3. Med Decis Making. 2012;32(5):690-700.](http://paperpile.com/b/UE5nfU/ZSDz)


    7.	[Soares F, Magno L, da Silva LAV, et al. Perceived Risk of HIV Infection and Acceptability of PrEP among Men Who Have Sex with Men in Brazil. Arch Sex Behav. 2023;52(2):773-782.](http://paperpile.com/b/UE5nfU/SjsM)


    8.	[Marks G, Crepaz N, Janssen RS. Estimating sexual transmission of HIV from persons aware and unaware that they are infected with the virus in the USA. AIDS. 2006;20(10):1447-1450.](http://paperpile.com/b/UE5nfU/f3xL)


    9.	[Global Burden of Disease Study 2019 (GBD 2019) Disability Weights. Accessed December 9, 2023. https://ghdx.healthdata.org/record/ihme-data/gbd-2019-disability-weights](http://paperpile.com/b/UE5nfU/4p8t)


    10.	[Bill and Melinda Gates Foundation Methods for Economic Evaluation Project (MEEP). NICE International. https://www.idsihealth.org/wp-content/uploads/2016/05/Gates-Reference-case-what-it-is-how-to-use-it.pdf](http://paperpile.com/b/UE5nfU/YzJ76)


    11.	[UNAIDS. Accessed December 12, 2023. https://www.unaids.org/en/regionscountries/countries](http://paperpile.com/b/UE5nfU/gHaL)


    12.	[GBD Results. Institute for Health Metrics and Evaluation. Accessed December 12, 2023. https://vizhub.healthdata.org/gbd-results/](http://paperpile.com/b/UE5nfU/F0BF)


    13.	[CEPAL. CELADE- División de Población de la CEPAL. Accessed December 12, 2023. https://www.cepal.org/es/subtemas/proyecciones-demograficas/america-latina-caribe-estimaciones-proyecciones-poblacion/estimaciones-proyecciones-excel](http://paperpile.com/b/UE5nfU/GqG4)


    14.	[WHO. THE GLOBAL HEALTH OBSERVATORY. Accessed December 15, 2023. https://www.who.int/data/gho/data/indicators/indicator-details/GHO/gho-ghe-life-tables-nmx-age-specific-death-rate-between-ages-x-and-x-plus-n](http://paperpile.com/b/UE5nfU/VLvr)


    15.	[Valores de Cartilla y Nomenclador. Accessed December 14, 2023. https://sistemas.amepla.org.ar/cartillaweb/iniciocartilla.aspx](http://paperpile.com/b/UE5nfU/2pFn)


    16.	[SIGTAP - Sistema de Gerenciamento da Tabela de Procedimentos, Medicamentos e OPM do SUS. Accessed December 14, 2023. http://sigtap.datasus.gov.br/tabela-unificada/app/sec/inicio.jsp](http://paperpile.com/b/UE5nfU/5H0k)


    17.	[Isapres - Isapres. Superintendencia de Salud, Gobierno de Chile. Accessed December 14, 2023. http://www.supersalud.gob.cl/664/w3-article-2528.html](http://paperpile.com/b/UE5nfU/sekT)


    18.	[Fonasa Chile. https://www.fonasa.cl/sites/Satellite?c=Page&cid=1520002032354&pagename=Fonasa2019%2FPage%2FF2_ContenidoDerecha](http://paperpile.com/b/UE5nfU/n42o)


    19.	[ISS2001. Min Salud. Accessed December 14, 2023. https://www.minsalud.gov.co/sites/rid/Lists/BibliotecaDigital/RIDE/VP/RBC/actualizacion-manual-tarifario-2018.pdf](http://paperpile.com/b/UE5nfU/DXH8)


    20.	[Productos y precios del Fondo Estratégico. Accessed December 14, 2023. https://www.paho.org/es/fondo-estrategico-ops/productos-precios](http://paperpile.com/b/UE5nfU/acTe)


    21.	[Luz PM, Osher B, Grinsztejn B, et al. The cost-effectiveness of HIV pre-exposure prophylaxis in men who have sex with men and transgender women at high risk of HIV infection in Brazil. J Int AIDS Soc. 2018;21(3):e25096.](http://paperpile.com/b/UE5nfU/WuxS)


