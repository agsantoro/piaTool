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

# Model Card: Profilaxis prexposición oral para la prevención del VIH


---


## Introducción

En las últimas décadas, la pandemia del Virus de la Inmunodeficiencia Humana (VIH) ha planteado desafíos considerables a la comunidad científica y médica, instándole a idear estrategias efectivas para prevenir la transmisión de este virus. La profilaxis pre exposición (PrEP, su sigla del inglés _Pre-Exposure Prophylaxis_) oral es una estrategia fundamental en el enfoque de prevención combinada, que abarca un espectro de métodos preventivos adaptados a las necesidades de las personas en riesgo de contraer el virus del VIH. Este enfoque holístico incluye educación, el uso consistente de preservativos, pruebas y tratamiento del VIH, junto con otras estrategias de prevención de enfermedades de transmisión sexual. 

La PrEP oral, que implica que las personas VIH seronegativas utilicen medicamentos antirretrovirales, ha demostrado ser altamente eficaz para reducir significativamente el riesgo de infección por el VIH.<sup><a href="https://paperpile.com/c/usbJYy/ejmXr">1</a></sup> La integración de la PrEP en este enfoque integral permite abordar la epidemia del VIH considerando las diversas necesidades y contextos de las personas en riesgo. Esta estrategia ha demostrado su eficacia, especialmente en poblaciones con un alto riesgo de exposición al virus, como hombres que tienen sexo con hombres (HSH), parejas serodiscordantes y trabajadores sexuales. Aunque la PrEP oral diaria fue recomendada para personas con un riesgo sustancial de VIH por la OMS en 2014, la disponibilidad de PrEP es aún limitada en América Latina.<sup><a href="https://paperpile.com/c/usbJYy/SHlHN">2</a></sup> Dentro de las opciones de PrEP disponibles,<sup><a href="https://paperpile.com/c/usbJYy/ejmXr">1</a></sup> la PrEP oral, que implica la toma de comprimidos, es a la fecha, la más ampliamente disponible en paises de América Latina. 


## Nombre del Modelo

PrEP oral para la prevención del VIH.

Descripción del Modelo y Asunciones

Se desarrolló un modelo de transición de estados con ciclos trimestrales para estudiar una población con alto riesgo de infección por VIH. Este modelo utiliza datos de transmisión basados en la prevalencia e incidencia de casos conocidos.<sup><a href="https://paperpile.com/c/usbJYy/a63iD">3</a></sup> A lo largo del tiempo, sigue a una cohorte dinámica de pacientes con prevalencia conocida de VIH, hasta que todos sus miembros iniciales fallezcan o alcancen los 100 años. Esta cohorte incluye individuos de edades distribuidas según lo observado en estudios sobre el uso de PrEP, con nuevas incorporaciones anuales.

La intervención PrEP implica la administración diaria de Tenofovir/emtricitabina y pruebas trimestrales. Se ofrece a la cohorte durante un período de 1 a 5 años. Los individuos sanos pueden optar por PrEP y son susceptibles a la infección por HIV hasta una edad establecida (por ejemplo, 60 años). Los que reciben PrEP tienen la posibilidad de abandonar el tratamiento y, dentro de los primeros 5 años de abandono, reiniciarlo, un patrón común en la literatura.<sup><a href="https://paperpile.com/c/usbJYy/RuzJU+kkoDY">4,5</a></sup>

La probabilidad de contraer HIV se calcula cada ciclo, basándose en la prevalencia del VIH y la tasa de transmisión, ajustada por el porcentaje de diagnósticos conocidos y pacientes controlados (asumidos como no transmisores). Los usuarios de PrEP tienen un riesgo reducido de infección, determinado por la eficacia y adherencia a la PrEP.

La detección del VIH depende de la tasa de diagnósticos conocidos en cada país y del promedio de pruebas realizadas anualmente para identificar la enfermedad. Se asume que los individuos que se infectan mientras están bajo la PrEP son diagnosticados al término del ciclo debido a la frecuencia de las pruebas. Las personas infectadas reciben tratamiento en función de la disponibilidad y las prácticas médicas en cada país. Aquellos que no reciben tratamiento, así como los que están en tratamiento pero no logran controlar la infección, enfrentan un mayor riesgo de complicaciones y una probabilidad incrementada de morir a causa del VIH, en comparación con la población general. Por otro lado, la probabilidad de mortalidad para las personas sanas se considera igual a la del promedio de la población general.


## Limitaciones y Consideraciones

El modelo desarrollado para esta intervención tiene limitaciones epidemiológicas importantes que deben considerarse cuidadosamente en su interpretación y aplicación. Su enfoque se centra específicamente en los datos epidemiológicos relativos a HSH, una población clave en el riesgo de transmisión del VIH. Sin embargo, esta focalización puede restringir la aplicabilidad de los resultados a otras poblaciones. Al centrarse exclusivamente en HSH, el modelo no aborda todas las vías de transmisión del VIH ni contempla infecciones por fuera de la cohorte, lo que podría llevar a una subestimación de la efectividad de la PrEP en contextos donde la transmisión heterosexual es común. Esta limitación es particularmente relevante en el caso de las mujeres transgénero, otro grupo crítico en la epidemia del VIH. Es crucial reconocer y tener en cuenta esta limitación al interpretar los resultados del modelo y considerar la necesidad de investigaciones adicionales y adaptaciones para evaluar con mayor precisión la eficacia de la PrEP en diferentes poblaciones en riesgo de infección por el VIH. 

El propósito principal del modelo es evaluar una intervención de prevención, por lo que el detalle en la modelización de la evolución de pacientes infectados con VIH no es exhaustivo, aunque esta sea una aproximación común en estudios de este tipo.<sup><a href="https://paperpile.com/c/usbJYy/CLS1s">6</a></sup>  Además, dado que el modelo no se centra en el tratamiento del VIH, no se consideran variaciones en el porcentaje de pacientes tratados, su adherencia al tratamiento, ni el porcentaje de pacientes con control viral efectivo. Por lo tanto, se asume que estos factores permanecen constantes a lo largo del tiempo, basados en los valores establecidos para cada país, al igual que la probabilidad específica de muerte asociada a esta enfermedad. Además, el modelo está diseñado para pacientes sin comorbilidades ni problemas de resistencia a los antirretrovirales.

Desde el punto de vista económico, la estimación de costos para países como Costa Rica, Ecuador, México y Perú se realizó mediante un método de estimación indirecta, basado en el PIB de cada país. Esto se debió a la falta de información específica sobre costos en estos lugares. Además, la definición de los regímenes de tratamiento y la cantidad de exámenes realizados durante el seguimiento se basaron en prácticas observadas específicamente en Argentina, asumiendo que estas serían similares en los demás países mencionados.


## Descripción General de los Parámetros


<table>
  <tr>
   <td colspan="4" >
    <strong>Parámetros Epidemiológicos.</strong>
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
   <td>Edad mínima inicial
   </td>
   <td>Edad mínima de los participantes en la cohorte inicial del estudio de distribución etaria.
   </td>
   <td>Asunción
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Edad máxima inicial
   </td>
   <td>Edad máxima de los integrantes de la cohorte inicial en el estudio de distribución por edades.
   </td>
   <td>Asunción
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Aceptabilidad del tratamiento con PrEP en la población
   </td>
   <td>Porcentaje de personas sanas en la cohorte que recibirán PrEP. Puede utilizarse para reflejar la disposición de la población hacia el uso de la PrEP o la cobertura de la intervención objetivo.
   </td>
   <td>Soares y cols.<sup><a href="https://paperpile.com/c/usbJYy/a9cxE">7</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Duración de tratamiento con PrEP
   </td>
   <td>Se refiere al período de tiempo durante el cual se implementará la intervención.
   </td>
   <td>
   </td>
   <td>Básico
   </td>
  </tr>
  <tr>
   <td>Edad de fin de indicación de PrEP
   </td>
   <td>Define la edad máxima para el uso de PrEP en la prevención del VIH, utilizada para análisis o simulaciones.
   </td>
   <td>Asunción 
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Límite de edad de riesgo
   </td>
   <td>Establece la edad desde la cual el riesgo de contagio del VIH por vía sexual se considera mínima.
   </td>
   <td>Asunción 
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Límite de edad de contagio
   </td>
   <td>Establece la edad desde la cual se considera que el papel de la persona en la transmisión del VIH es mínimo.
   </td>
   <td>Asunción 
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Eficacia PrEP en la población
   </td>
   <td>Porcentaje de reducción del riesgo de contagio de HIV en la población a analizar que recibe PrEP asumiendo adherencia perfecta.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/usbJYy/RuzJU">4</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Adherencia PrEP en la población
   </td>
   <td>Se refiere al grado en que las personas siguen el régimen de tratamiento de la PrEP para la prevención del VIH, incluyendo la consistencia y regularidad en la toma del medicamento. Impacta en la efectividad final de PrEP.
   </td>
   <td>Hojilla y cols<sup><a href="https://paperpile.com/c/usbJYy/RuzJU">4</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento anual
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Manual metodológico para elaboración de Evaluaciones Económicas <sup><a href="https://paperpile.com/c/usbJYy/RffA">8</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
</table>



## Lista de indicadores

**Resultados epidemiológicos **



1. **Años de vida ajustados por discapacidad evitados: **mide el número de años ajustados por discapacidad que se evitan como resultado de prevenir la infección por VIH con PrEP. Engloban los años de vida salvados al evitar una muerte prematura contra la expectativa de vida del país y la pérdida de utilidad de padecer la infección durante los años de sobrevida.

    **Ej: Años de vida ajustados por discapacidad evitados = 150 AVAD evitados**. Esto indica que la prevención del VIH mediante PrEP, se han preservado 150 años de vida ajustados por discapacidad que suelen asociarse con la infección por VIH.

2. **Años de vida salvados:** mide la cantidad de años de vida adicionales salvados como resultado de evitar una muerte prematura (según la expectativa de vida del país) asociada a la infección por VIH.

    Ej.:** 200 años de vida salvados.** Esto indica que la prevención del VIH mediante PrEP, tiene el potencial de salvar 200 años de vida por muerte prematura.

3. **Casos de VIH evitados (n): **número de infecciones de VIH que se evitan atribuibles a la intervención.

    Ej.:** 200 casos de VIH evitados.** Esto indica que la prevención del VIH mediante PrEP, tiene el potencial de prevenir 200 nuevos casos de VIH.

4. **Muertes evitadas (n): **Indica el número de muertes asociadas a la infección por VIH que pueden evitarse gracias a la prevención de la infección por utilizar PrEP.

    Ej.: ** 20 muertes evitadas.** Esto expresa que gracias a la prevención de la infección atribuible a la intervención con PrEP podrían evitarse 20 muertes asociadas al VIH.


**Resultados económicos **



5. **Costo total de la intervención: **el costo de implementar PrEP durante el tiempo definido (5 años, 10 años o toda la vida) para el total de las personas que recibirán tratamiento incluyendo el costo programático de la intervención si se especificara.

    Ej: **Costos de la intervención PrEP (USD) = $589.431,3 USD:** el costo de implementar PrEP en el tiempo definido es en total de $589.431,3 USD.

6. **Razón de costo-efectividad incremental (RCEI) por Año de vida salvado (AVS):** hace referencia al costo adicional de la intervención (PrEP) por cada año de vida salvado adicional en comparación con no PrEP. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad expresada en AVS (intervención vs no intervención).

    Ej: **RCEI por AVS = $69.3 USD: **al implementar la intervención, me cuesta $69.3 USD obtener un AVS adicional en comparación con la no intervención.

7. **Retorno de Inversión (ROI) (%):** relación entre los beneficios y los costos obtenidos por la intervención. Un ROI positivo indica que la intervención no solo cubre su costo, sino que también genera un beneficio económico adicional.  En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. Se define como los ingresos/ahorros menos la inversión, dividido por la inversión.

    Ej: **Retorno de Inversión (ROI) (%):** un ROI del 65% significa que el 65% de la inversión se obtiene como ganancia luego de recuperar el capital invertido, es decir, por cada $1 USD invertido en la intervención, se obtiene un retorno de $0.65 USD de retorno de la inversión adicional. 


**Nota aclaratoria: **el término “descontado” se refiere al proceso de ajustar los valores futuros de dinero a su equivalente en el presente. La tasa de descuento tomada como referencia es 5%.


## 


## Referencias


    1.	[Health Organization W. Differentiated and simplified pre-exposure prophylaxis for HIV prevention: update to WHO implementation guidance: technical brief. Accessed December 8, 2023. https://apps.who.int/iris/bitstream/handle/10665/360861/9789240053694-eng.pdf?sequence=1](http://paperpile.com/b/usbJYy/ejmXr)


    2.	[Veloso VG, Cáceres CF, Hoagland B, et al. Same-day initiation of oral pre-exposure prophylaxis among gay, bisexual, and other cisgender men who have sex with men and transgender women in Brazil, Mexico, and Peru (ImPrEP): a prospective, single-arm, open-label, multicentre implementation study. Lancet HIV. 2023;10(2):e84-e96.](http://paperpile.com/b/usbJYy/SHlHN)


    3.	[Pinkerton SD. HIV transmission rate modeling: a primer, review, and extension. AIDS Behav. 2012;16(4):791-796.](http://paperpile.com/b/usbJYy/a63iD)


    4.	[Hojilla JC, Hurley LB, Marcus JL, et al. Characterization of HIV Preexposure Prophylaxis Use Behaviors and HIV Incidence Among US Adults in an Integrated Health Care System. JAMA Netw Open. 2021;4(8):e2122692.](http://paperpile.com/b/usbJYy/RuzJU)


    5.	[Spinelli MA, Scott HM, Vittinghoff E, et al. Missed Visits Associated With Future Preexposure Prophylaxis (PrEP) Discontinuation Among PrEP Users in a Municipal Primary Care Health Network. Open Forum Infect Dis. 2019;6(4):ofz101.](http://paperpile.com/b/usbJYy/kkoDY)


    6.	[Siebert U, Alagoz O, Bayoumi AM, et al. State-transition modeling: a report of the ISPOR-SMDM Modeling Good Research Practices Task Force-3. Med Decis Making. 2012;32(5):690-700.](http://paperpile.com/b/usbJYy/CLS1s)


    7.	[Soares F, Magno L, da Silva LAV, et al. Perceived Risk of HIV Infection and Acceptability of PrEP among Men Who Have Sex with Men in Brazil. Arch Sex Behav. 2023;52(2):773-782.](http://paperpile.com/b/usbJYy/a9cxE)


    8.	[Moreno M, Aurelio M, Castro H. Manual metodológico para la elaboración de Evaluaciones Económicas. IETS. Accessed December 26, 2023. https://www.iets.org.co/Archivos/64/Manual_evaluacion_economica.pdf](http://paperpile.com/b/usbJYy/RffA)


    9.	[UNAIDS. Accessed December 12, 2023. https://www.unaids.org/en/regionscountries/countries](http://paperpile.com/b/usbJYy/0sobY)


    10.	[GBD Results. Institute for Health Metrics and Evaluation. Accessed December 12, 2023. https://vizhub.healthdata.org/gbd-results/](http://paperpile.com/b/usbJYy/ZqBxA)


    11.	[CEPAL. CELADE- División de Población de la CEPAL. Accessed December 12, 2023. https://www.cepal.org/es/subtemas/proyecciones-demograficas/america-latina-caribe-estimaciones-proyecciones-poblacion/estimaciones-proyecciones-excel](http://paperpile.com/b/usbJYy/NT7y3)


    12.	[WHO. THE GLOBAL HEALTH OBSERVATORY. Accessed December 15, 2023. https://www.who.int/data/gho/data/indicators/indicator-details/GHO/gho-ghe-life-tables-nmx-age-specific-death-rate-between-ages-x-and-x-plus-n](http://paperpile.com/b/usbJYy/s6k1V)


    13.	[Valores de Cartilla y Nomenclador. Accessed December 14, 2023. https://sistemas.amepla.org.ar/cartillaweb/iniciocartilla.aspx](http://paperpile.com/b/usbJYy/TuiJc)


    14.	[SIGTAP - Sistema de Gerenciamento da Tabela de Procedimentos, Medicamentos e OPM do SUS. Accessed December 14, 2023. http://sigtap.datasus.gov.br/tabela-unificada/app/sec/inicio.jsp](http://paperpile.com/b/usbJYy/VsFRY)


    15.	[Isapres - Isapres. Superintendencia de Salud, Gobierno de Chile. Accessed December 14, 2023. http://www.supersalud.gob.cl/664/w3-article-2528.html](http://paperpile.com/b/usbJYy/XSGVN)


    16.	[Fonasa Chile. https://www.fonasa.cl/sites/Satellite?c=Page&cid=1520002032354&pagename=Fonasa2019%2FPage%2FF2_ContenidoDerecha](http://paperpile.com/b/usbJYy/cB34N)


    17.	[ISS2001. Min Salud. Accessed December 14, 2023. https://www.minsalud.gov.co/sites/rid/Lists/BibliotecaDigital/RIDE/VP/RBC/actualizacion-manual-tarifario-2018.pdf](http://paperpile.com/b/usbJYy/jUa5q)


    18.	[Productos y precios del Fondo Estratégico. Accessed December 14, 2023. https://www.paho.org/es/fondo-estrategico-ops/productos-precios](http://paperpile.com/b/usbJYy/htAl9)


    19.	[Seng R, Mutuon P, Riou J, et al. Hospitalization of HIV positive patients: Significant demand affecting all hospital sectors. Rev Epidemiol Sante Publique. 2018;66(1):7-17.](http://paperpile.com/b/usbJYy/4zvz)
