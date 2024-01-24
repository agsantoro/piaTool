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

# Model Card: Vacuna VPH


---


## Introducción 

El Virus del Papiloma Humano (VPH) constituye un importante desafío para la salud pública en América Latina, al ser el causante de diversas enfermedades, entre ellas, el cáncer de cuello uterino, verrugas genitales y otros tipos de neoplasias vinculadas. Frente a este desafío, varios países de la región han lanzado programas de vacunación contra el VPH, aprovechando la disponibilidad de diferentes vacunas preventivas, con el fin de disminuir la prevalencia de estas enfermedades.<sup><a href="https://paperpile.com/c/jo7Z6Z/d0XMt+ITau3">1,2</a></sup>

En particular, el cáncer de cuello uterino se destacó como la cuarta causa más común de cáncer y de muerte por cáncer en mujeres en 2020. En ese año, se estimó que surgieron 604.000 casos nuevos y se registraron más de 340.000 fallecimientos debido a esta enfermedad, lo que representa el 8% del total de muertes por cáncer en mujeres.<sup><a href="https://paperpile.com/c/jo7Z6Z/d0XMt+ITau3">1,2</a></sup> 

Las vacunas disponibles contra el VPH han mostrado efectividad para prevenir lesiones cervicales premalignas y cánceres, especialmente aquellos causados por los tipos de VPH de alto riesgo, como el VPH 16 y VPH 18. Estas vacunas están recomendadas para mujeres a partir de los 9 años de edad y están autorizadas para su uso hasta los 26 o 45 años, dependiendo de la vacuna específica. Además, algunas de estas vacunas también han sido aprobadas para su uso en hombres, ampliando así su alcance en la prevención de enfermedades asociadas al VPH.<sup><a href="https://paperpile.com/c/jo7Z6Z/6aRTs">3</a></sup>


## Nombre del Modelo

Interfaz rápida del virus del papiloma para modelado y economía (PRIME, su sigla del inglés _Papillomavirus Rapid Interface for Modelling and Economics_).


## Descripción del Modelo y Asunciones 

La herramienta PRIME, desarrollada por especialistas de la Escuela de Higiene y Medicina Tropical de Londres y la Université Laval en Quebec, en colaboración con la Organización Mundial de la Salud (OMS) en Ginebra, es un modelo innovador destinado a evaluar tanto el impacto en salud como la relación costo-efectividad de la vacunación contra el VPH en niñas para prevenir el cáncer de cuello uterino.<sup><a href="https://paperpile.com/c/jo7Z6Z/7jCp2">4</a></sup> Su propósito principal es facilitar el acceso a información de calidad y confiable, promoviendo decisiones informadas para mejorar la predictibilidad y maximizar el impacto en la salud pública. Además, PRIME no se limita al análisis epidemiológico del VPH; también considera el impacto económico de reducir la carga de la enfermedad a través de la vacunación.<sup><a href="https://paperpile.com/c/jo7Z6Z/U8jx5">5</a></sup>

Esta herramienta ha sido validada mediante la revisión de 17 estudios realizados en países de bajos y medianos ingresos y cuenta con el respaldo del Comité Asesor de Investigación e Implementación de Vacunas de la OMS. Ofrece estimaciones cautelosas sobre el impacto en salud y la relación costo-efectividad de vacunar a niñas antes del inicio de su actividad sexual. Ha sido empleada en 97 países para evaluar el impacto de las inversiones en vacunas realizadas por Gavi, la Alianza para las Vacunas, y a nivel nacional.<sup><a href="https://paperpile.com/c/jo7Z6Z/bh5GQ+noolc">6,7</a></sup>

PRIME utiliza un modelo estático de impacto proporcional que calcula el impacto de la vacunación en cohortes de diferentes edades. Estima la reducción en la incidencia, prevalencia y mortalidad del cáncer de cuello uterino en función de la cobertura de vacunación, la eficacia de la vacuna y la distribución de los tipos de VPH de alto riesgo. Para las vacunas bivalentes y cuadrivalentes se enfoca en el VPH 16/18, y para la vacuna monovalente incluye también el VPH 31/33/45/52/58.

El modelo utilizado en la herramienta PRIME se centra en una "cohorte cerrada", lo que significa que sigue a un grupo específico de mujeres desde los 12 años a lo largo de toda su vida. Este enfoque permite evaluar de manera detallada los resultados del seguimiento. Respecto a la cobertura de vacunación, el modelo proyecta un aumento en la cobertura del 30% desde el porcentaje actual de cada país (conocido como cobertura basal) en términos absolutos, o hasta alcanzar una cobertura total del 90%. Es importante destacar que, en situaciones donde la cobertura basal de un país ya es del 90%, el modelo establece como objetivo alcanzar una cobertura del 95%. Este enfoque asegura que incluso en países con altas tasas de vacunación, se sigan buscando mejoras para maximizar la protección contra el VPH.

A excepción de Chile y Costa Rica, la herramienta PRIME calcula los costos médicos directos anuales asociados al cáncer de cuello uterino utilizando una metodología adaptada del estudio de Chen y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/LTtcF">8</a></sup> Esta metodología ajusta los costos en función del Producto Interno Bruto (PIB) per cápita y la prevalencia de cáncer de cuello uterino en cada país, basándose en datos del estudio de Dieleman y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/I9rXZ">9</a></sup> Los costos de la vacuna contra el VPH se obtienen de los precios fijados en 2020 por el Programa Ampliado de Inmunizaciones (PAI) de la Organización Panamericana de la Salud (OPS)<sup><a href="https://paperpile.com/c/jo7Z6Z/YzDgB">10</a></sup> y se ajustan a 2023 considerando la inflación en Estados Unidos. Además, se asume que los costos de transporte, almacenamiento y aplicación de la vacuna representan el 37% del valor total del esquema de vacunación completo por niña, según lo indicado por Jit y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/7jCp2">4</a></sup> Aunque la herramienta proporciona datos basales para todos los países referentes al año 2014, se han actualizado aquellos datos considerados relevantes para este análisis. Cabe destacar que los usuarios pueden modificar los parámetros basales en la herramienta según lo requieran.

La herramienta PRIME, por tanto, es una plataforma valiosa para analizar la relación costo-efectividad de vacunar a niñas contra el VPH, enfocándose en la prevención del cáncer de cuello uterino. Ofrece una visión integral, permitiendo a los usuarios estimar la carga global del cáncer cervicouterino, evaluar cómo el incremento en la cobertura de la vacunación contra el VPH puede impactar en diferentes edades, y calcular tanto los costos de atención médica derivados del tratamiento del cáncer de cuello uterino como los costos asociados a la vacunación. Adicionalmente, facilita la estimación de los ahorros potenciales que podrían lograrse aumentando la cobertura de vacunación.<sup><a href="https://paperpile.com/c/jo7Z6Z/U8jx5">5</a></sup>


## Limitaciones y Consideraciones

La OMS apoya el uso de la herramienta PRIME por su capacidad para proporcionar estimaciones prudentes y bien fundamentadas sobre el impacto en la salud y la relación costo-efectividad de vacunar a niñas antes de su iniciación sexual. PRIME ha sido empleado en 97 países para valorar el impacto de las inversiones en vacunas a nivel nacional.<sup><a href="https://paperpile.com/c/jo7Z6Z/bh5GQ+noolc">6,7</a></sup>

Sin embargo, es importante destacar que PRIME tiene ciertas limitaciones. No está diseñada para evaluar la inmunidad de rebaño ni el impacto de la vacunación en varones. En esencia, se enfoca en calcular los beneficios estimados para la salud derivados de la vacunación contra el VPH en niñas de 9 a 14 años, adoptando un enfoque conservador en sus estimaciones.

Limitaciones en relación a la parte económica, se destaca que para el cálculo del costo de cáncer de cuello uterino, se utilizó un estudio publicado en Estados Unidos <sup><a href="https://paperpile.com/c/jo7Z6Z/OcJ3P">11</a></sup> como punto de partida debido a la falta de información disponible para todos los países analizados. Esta referencia se empleó para estimar el costo a lo largo de la vida relacionado con el cáncer de cuello uterino en cada uno de los países analizados. Sin embargo, es importante señalar que esta aproximación de costos puede ser refinada con datos más específicos y actualizados para cada país. Por otro lado, el cálculo del costo asociado con la administración, entrega y almacenamiento de la vacuna se llevó a cabo como un porcentaje del precio de la vacuna, siguiendo el enfoque utilizado en estudios anteriores. No obstante, esta métrica de costos también puede ser perfeccionada para ofrecer una representación más precisa y detallada. 

En resumen, tanto el parámetro de costos relacionado con el cáncer de cuello uterino como el asociado a la logística de la vacunación son aspectos que podrían ser mejorados con información más específica y actualizada, lo que contribuiría a una evaluación más precisa y completa de los costos involucrados.


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
   <td>Porcentaje de cobertura objetivo (esquema completo)
   </td>
   <td>El porcentaje esperado de niñas en el grupo de edad relevante que recibirán el esquema completo de la vacuna luego de la intervención.
   </td>
   <td>Nogueira-Rodrigues y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/9o7B">12</a></sup>
   </td>
  </tr>
  <tr>
   <td>Grupo de edad objetivo
   </td>
   <td>Edad a la que normalmente se administran las vacunas contra el VPH. Tenga en cuenta que PRIME solo es adecuado para evaluar las vacunas contra el HPV administradas a niñas en las edades recomendadas por la OMS, de 9 a 13 años.
   </td>
   <td>Asunción
   </td>
  </tr>
  <tr>
   <td>Tamaño de la cohorte en edad de vacunación (mujeres) 
   </td>
   <td>Número de mujeres en el país correspondientes a la edad de vacunación de rutina, definida por el "grupo de edad objetivo". 
   </td>
   <td>Instituto de estadística de cada uno de los 8 países
   </td>
  </tr>
  <tr>
   <td>Porcentaje de cobertura basal (esquema completo)
   </td>
   <td>Se refiere al porcentaje de mujeres que actualmente reciben vacuna contra el VPH.
   </td>
   <td>Nogueira-Rodrigues y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/9o7B">12</a></sup>
   </td>
  </tr>
  <tr>
   <td>Eficacia de la vacuna contra el VPH 16/18 (%)
   </td>
   <td>Indica la reducción del riesgo de infecciones persistentes y lesiones precancerosas por los tipos 16 y 18 del VPH.
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de casos de cáncer de cuello de útero debidos al VPH 16/18
   </td>
   <td>Porcentaje de casos de cáncer de cuello uterino que son atribuibles a las cepas 16 y 18 del VPH.
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Años de vida ajustados por discapacidad por diagnóstico de cáncer de cuello uterino 
   </td>
   <td>Miden la carga total del cáncer de cuello uterino combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/jo7Z6Z/9I3gQ">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>Años de vida ajustados por discapacidad por secuelas de cáncer de cuello uterino
   </td>
   <td>Miden la carga total de las secuelas de cáncer de cuello uterino combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/jo7Z6Z/9I3gQ">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>Años de vida ajustados por discapacidad por cáncer de cuello uterino terminal
   </td>
   <td>Miden la carga total del cáncer de cuello uterino terminal combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/jo7Z6Z/9I3gQ">14</a></sup>
   </td>
  </tr>
</table>


(*) A modo de ser conservadores se ha optado por este valor de eficacia de la vacuna, extraído de una población de mujeres mayores de 15 años, por lo que se estima que muchas de ellas habrían ya tenido relaciones sexuales al momento del estudio.


<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros de costos</strong>
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
   <td>Costo de vacunación (esquema completo) (USD)
   </td>
   <td>Costo de vacunación de esquema completo por niña inmunizada.
   </td>
   <td>PAI OPS 2020 actualizado por inflación hasta abril de 2023 (USD oficial a tasa de cambio nominal de cada país para).<sup><a href="https://paperpile.com/c/jo7Z6Z/YzDgB">10</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costos administrativos de la vacuna (esquema completo) (USD)
   </td>
   <td>Costo de administración, entrega y almacenamiento de la vacuna por cada esquema completo de vacunación por niña.
   </td>
   <td>Asunción según Jit y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/7jCp2">4</a></sup>
<p>
Datos para abril de 2023 (USD oficial a tasa de cambio nominal de cada país)
   </td>
  </tr>
  <tr>
   <td>Costo total de vacunación (esquema completo) (USD)
   </td>
   <td>Costo total (precio de la vacuna más el costo administrativo) de esquema completo de vacunación por niña.
   </td>
   <td>Cálculo propio.
<p>
Datos para abril de 2023 (USD oficial a tasa de cambio nominal de cada país)
   </td>
  </tr>
  <tr>
   <td>Costo del tratamiento del cáncer (USD)
   </td>
   <td>Costo promedio del tratamiento de un cáncer cervical a lo largo de la vida
   </td>
   <td>Gómez y cols.<sup><a href="https://paperpile.com/c/jo7Z6Z/OcJ3P">11</a></sup>: CHL y CRC<sup>*</sup>.
<p>
Estimación indirecta<sup>**</sup>: ARG, BRA, COL, ECU, MEX y PER.
<p>
Datos expresados en dólares de abril de 2023 (USD oficial a tasa de cambio nominal de cada país).
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento (%)
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Manual metodológico para elaboración de Evaluaciones Económicas <sup><a href="https://paperpile.com/c/jo7Z6Z/FrPuk">15</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo programático anual de la intervención (USD)
   </td>
   <td>Costo de implementar y sostener la intervención en un año.
   </td>
   <td>xxx
   </td>
  </tr>
</table>


* Para Costa Rica se asume el mismo valor que en Chile.

** Los costos de Argentina, Brasil, Colombia, Ecuador, México y Perú  fueron calculados con base en el estudio de Gómez y cols. ajustando al PIB per cápita de cada país y a la prevalencia de cáncer de cuello uterino en cada país, mediante la metodología de estimación indirecta.


## Lista de Indicadores 

**Resultados epidemiológicos**



1. **Cánceres de cuello uterino evitados (n):** número de cánceres de cuello uterino prevenidos tras la intervención.

    Ej:  **Cánceres de cuello uterino evitados n = 4.382,2. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar 4.382,2 casos de cáncer de cuello uterino en la población.

2. **Muertes evitadas (n)**: número de muertes prevenidas tras la implementación de la intervención. 

    Ej: **Muertes evitadas n= 2.062,6. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de prevenir 2.062,6 muertes en la población. 

3. **Años de vida salvados:** ** **cantidad de años que se preservarán al evitar muertes prematuras causadas por el cáncer de cuello uterino en la población.

    Ej: **Años de vida salvados n=1.500. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de 1500 años debido a muertes prematuras en la población. 

4. **Años de Vida Ajustados por Discapacidad evitados:** especifica la cantidad de años que se salvaron de la carga de discapacidad causada por el cáncer de cuello uterino en la población.

    Ej: **Años de vida ajustados por discapacidad evitados n= 48.753,6. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de 48.753,6 años debida a la discapacidad provocada por el cáncer cervical  en la población.


**Resultados económicos**



5. **Costo total de la intervención (USD):** se calcula multiplicando la cantidad de niñas de 12 años incluidas de la muestra, los costos totales de vacunación (costos de la vacuna, de aplicación y de entrega), ponderado el aumento de la cobertura de la vacunación contra el VPH sumado al costo programático de la intervención si lo hubiera.

    Ej: **Costo total de la vacunación (USD) = $2.589.564 USD: **el costo total de vacunar completamente a la cantidad de niñas incluidas en la muestra considerando el aumento de cobertura, asciende a $2.589.564 USD.** ** 

6. **Costos evitados atribuibles a la intervención (USD):** representa el ahorro en costos de tratamiento del cáncer de cuello uterino debido a los casos prevenidos por la vacunación. 

    Ej: **Costos evitados atribuibles a la intervención = $3.255.983,1 USD: **el modelo indica que la vacunación tiene la capacidad de ahorrar $3.255.983,1 USD en tratamiento de cáncer de cuello uterino gracias a los casos de cáncer evitados. 

7. **Diferencia de Costos respecto al escenario basal (USD): **la diferencia de costos surge de restarle a los costos de la intervención los costos ahorrados por cáncer de cuello uterino evitados gracias a la intervención.

    Ej: **Diferencia de Costos respecto al escenario basal (USD) = $35.115 USD: **el modelo indica que la diferencia entre el costo de la intervención y los ahorros generados por la misma son $35.115 USD.

8. **Razón de costo-efectividad incremental (RCEI) por cáncer de cuello uterino prevenido (USD): **costo adicional asociado con la implementación de la vacunación por cada caso de cáncer de cuello uterino que se evita.  

    _Aclaración: se reporta para los países cuyo costo neto ha sido positivo._


    Ej: **RCEI por cáncer de cuello uterino prevenido (USD =  $2.821,2 USD): **el costo adicional asociado con la implementación de la vacunación por cada caso de cáncer de cuello uterino que se evita es de $2.821,2 USD.

9. **Razón de costo-efectividad incremental (RCEI) por vida salvada (VS) (USD): **costo adicional por cada vida que se salva como resultado de la implementación de la vacunación. 

    Ej: **RCEI por VS = $5.994 USD: **en promedio, cada vida salvada por la implementación de la vacunación cuesta un adicional de $5.994 USD. ** **

10. **Razón de costo-efectividad incremental (RCEI) por Año de Vida Salvado (AVS) (USD):** costo adicional por cada año de vida salvado como resultado de la implementación de la vacunación.

    _Aclaración: se calcula para los países cuyo costo neto ha sido positivo._


    Ej: **RCEI AVS = $253,6 USD: **en promedio, cada año adicional de vida salvado con la implementación de la vacunación cuesta $253,6 USD.  

11. **Razón de costo-efectividad incremental (RCEI) por Años de Vida Ajustados por Discapacidad (Años de vida ajustados por discapacidad) prevenido (USD):** costo adicional por cada año de vida ajustado por discapacidad que se evita como resultado de la implementación de la vacunación. 

    _Aclaración: se calcula para los países cuyo costo neto ha sido positivo._


    Ej: **RCEI por Años de vida ajustados por discapacidad prevenido (USD) = $239 USD: **el costo adicional por cada año de vida ajustado por discapacidad que se evita como resultado de la implementación de la vacunación es de $239 USD.**  **

12. **Retorno de Inversión (ROI) (%):** relación entre los beneficios económicos obtenidos y el costo de la vacunación. Un ROI positivo indica que la vacunación no solo cubre su costo, sino que también genera un beneficio económico adicional (en intervenciones costo-ahorrativas). Se define como los ingresos menos la inversión, dividido por la inversión. En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. 

    Ej: **Retorno de la inversión = 35%:** por cada $1 USD invertido en la vacunación, se ganan 0.35 céntimos de USD además de recuperar el capital inicial.


**Nota aclaratoria **

El término “descontado” se refiere al proceso de ajustar los valores futuros de dinero a su equivalente en el presente. La tasa de descuento tomada como referencia es 5%.

El valor del dólar se toma según la tasa de cambio nominal a dólar para cada país. 


## 


## Referencias


    1.	[Cervical cancer. Published February 22, 2022. Accessed June 30, 2023. https://www.who.int/news-room/fact-sheets/detail/cervical-cancer](http://paperpile.com/b/jo7Z6Z/d0XMt)


    2.	[Cervical cancer. Published February 22, 2022. Accessed June 30, 2023. https://www.who.int/news-room/fact-sheets/detail/cervical-cancer](http://paperpile.com/b/jo7Z6Z/ITau3)


    3.	[Vacuna contra el virus del papiloma humano (VPH). Accessed December 13, 2023. https://www.paho.org/es/vacuna-contra-virus-papiloma-humano-vph](http://paperpile.com/b/jo7Z6Z/6aRTs)


    4.	[Jit M, Brisson M, Portnoy A, Hutubessy R. Cost-effectiveness of female human papillomavirus vaccination in 179 countries: a PRIME modelling study. Lancet Glob Health. 2014;2(7):e406-e414. doi:10.1016/S2214-109X(14)70237-2](http://paperpile.com/b/jo7Z6Z/7jCp2)


    5.	[Jit M, Abbas K, Fu H. Human Papilloma Virus (HPV) models. Accessed December 13, 2023. https://www.vaccineimpact.org/models/hpv/](http://paperpile.com/b/jo7Z6Z/U8jx5)


    6.	[Jit M, Brisson M. Potential lives saved in 73 countries by adopting multi‐cohort vaccination of 9–14‐year‐old girls against human papillomavirus. International Journal of Cancer. Published online 2018. https://onlinelibrary.wiley.com/doi/abs/10.1002/ijc.31321](http://paperpile.com/b/jo7Z6Z/bh5GQ)


    7.	[Abbas KM, van Zandvoort K, Brisson M, Jit M. Effects of updated demography, disability weights, and cervical cancer burden on estimates of human papillomavirus vaccination impact at the global, regional, and national levels: a PRIME modelling study. Lancet Glob Health. 2020;8(4):e536-e544. doi:10.1016/S2214-109X(20)30022-X](http://paperpile.com/b/jo7Z6Z/noolc)


    8.	[Chen S, Cao Z, Prettner K, et al. Estimates and Projections of the Global Economic Cost of 29 Cancers in 204 Countries and Territories From 2020 to 2050. JAMA Oncol. 2023;9(4):465-472. doi:10.1001/jamaoncol.2022.7826](http://paperpile.com/b/jo7Z6Z/LTtcF)


    9.	[Dieleman JL, Cao J, Chapin A, et al. US Health Care Spending by Payer and Health Condition, 1996-2016. JAMA. 2020;323(9):863-884. doi:10.1001/jama.2020.0734](http://paperpile.com/b/jo7Z6Z/I9rXZ)


    10.	[Precios de Programa Ampliado de Inmunizaciones -PAI- 2020. Accessed June 15, 2023. https://www.paho.org/es/file/82792/download?token=Mm5JrLtu](http://paperpile.com/b/jo7Z6Z/YzDgB)


    11.	[Gomez JA, Lepetic A, Demarteau N. Health economic analysis of human papillomavirus vaccines in women of Chile: perspective of the health care payer using a Markov model. BMC Public Health. 2014;14:1222. doi:10.1186/1471-2458-14-1222](http://paperpile.com/b/jo7Z6Z/OcJ3P)


    12.	[Nogueira-Rodrigues A. HPV Vaccination in Latin America: Global Challenges and Feasible Solutions. Am Soc Clin Oncol Educ Book. 2019;39:e45-e52. doi:10.1200/EDBK_249695](http://paperpile.com/b/jo7Z6Z/9o7B)


    13.	[Arbyn M, Xu L, Simoens C, Martin-Hirsch PP. Prophylactic vaccination against human papillomaviruses to prevent cervical cancer and its precursors. Cochrane Database Syst Rev. 2018;5(5). doi:10.1002/14651858.CD009069.pub3](http://paperpile.com/b/jo7Z6Z/Ck463)


    14.	[Global Burden of Disease (GBD). Institute for Health Metrics and Evaluation. Published March 29, 2014. Accessed June 15, 2023. https://www.healthdata.org/gbd](http://paperpile.com/b/jo7Z6Z/9I3gQ)


    15.	[Moreno M, Aurelio M, Castro H. Manual metodológico para la elaboración de Evaluaciones Económicas. IETS. Accessed December 26, 2023. https://www.iets.org.co/Archivos/64/Manual_evaluacion_economica.pdf](http://paperpile.com/b/jo7Z6Z/FrPuk)


    16.	[OCDE. OECD. https://www.oecd.org/espanol/estadisticas/pib-espanol.htm](http://paperpile.com/b/jo7Z6Z/G7k1F)
