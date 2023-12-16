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

# 1. Model Card: Vacuna VPH


---


## Introducción 

El Virus del Papiloma Humano (VPH) constituye un importante desafío para la salud pública en América Latina, al ser el causante de diversas enfermedades, entre ellas, el cáncer de cuello uterino, verrugas genitales y otros tipos de neoplasias vinculadas. Frente a este desafío, varios países de la región han lanzado programas de vacunación contra el VPH, aprovechando la disponibilidad de diferentes vacunas preventivas, con el fin de disminuir la prevalencia de estas enfermedades.<sup><a href="https://paperpile.com/c/0j7Ywe/0MWMv+Dvz1N">1,2</a></sup>

En particular, el cáncer de cuello uterino se destacó como la cuarta causa más común de cáncer y de muerte por cáncer en mujeres en 2020. En ese año, se estimó que surgieron 604.000 casos nuevos y se registraron más de 340.000 fallecimientos debido a esta enfermedad, lo que representa el 8% del total de muertes por cáncer en mujeres.<sup><a href="https://paperpile.com/c/0j7Ywe/0MWMv+Dvz1N">1,2</a></sup> 

Las vacunas disponibles contra el VPH han mostrado efectividad para prevenir lesiones cervicales premalignas y cánceres, especialmente aquellos causados por los tipos de VPH de alto riesgo, como el VPH 16 y VPH 18. Estas vacunas están recomendadas para mujeres a partir de los 9 años de edad y están autorizadas para su uso hasta los 26 o 45 años, dependiendo de la vacuna específica. Además, algunas de estas vacunas también han sido aprobadas para su uso en hombres, ampliando así su alcance en la prevención de enfermedades asociadas al VPH.<sup><a href="https://paperpile.com/c/0j7Ywe/gWP0">3</a></sup>


## Nombre del Modelo

Interfaz rápida del virus del papiloma para modelado y economía (PRIME, su sigla del inglés _Papillomavirus Rapid Interface for Modelling and Economics_).


## Descripción del Modelo y Asunciones 

La herramienta PRIME, desarrollada por especialistas de la Escuela de Higiene y Medicina Tropical de Londres y la Université Laval en Quebec, en colaboración con la Organización Mundial de la Salud (OMS) en Ginebra, es un modelo innovador destinado a evaluar tanto el impacto en salud como la relación costo-efectividad de la vacunación contra el VPH en niñas para prevenir el cáncer de cuello uterino.<sup><a href="https://paperpile.com/c/0j7Ywe/FL75O">4</a></sup> Su propósito principal es facilitar el acceso a información de calidad y confiable, promoviendo decisiones informadas para mejorar la predictibilidad y maximizar el impacto en la salud pública. Además, PRIME no se limita al análisis epidemiológico del VPH; también considera el impacto económico de reducir la carga de la enfermedad a través de la vacunación.<sup><a href="https://paperpile.com/c/0j7Ywe/8h6E">5</a></sup>

Esta herramienta ha sido validada mediante la revisión de 17 estudios realizados en países de bajos y medianos ingresos y cuenta con el respaldo del Comité Asesor de Investigación e Implementación de Vacunas de la OMS. Ofrece estimaciones cautelosas sobre el impacto en salud y la relación costo-efectividad de vacunar a niñas antes del inicio de su actividad sexual. Ha sido empleada en 97 países para evaluar el impacto de las inversiones en vacunas realizadas por Gavi, la Alianza para las Vacunas, y a nivel nacional.<sup><a href="https://paperpile.com/c/0j7Ywe/arp4F+vR6dx">6,7</a></sup>

PRIME utiliza un modelo estático de impacto proporcional que calcula el impacto de la vacunación en cohortes de diferentes edades. Estima la reducción en la incidencia, prevalencia y mortalidad del cáncer de cuello uterino en función de la cobertura de vacunación, la eficacia de la vacuna y la distribución de los tipos de VPH de alto riesgo. Para las vacunas bivalentes y cuadrivalentes se enfoca en el VPH 16/18, y para la vacuna monovalente incluye también el VPH 31/33/45/52/58.

El modelo utilizado en la herramienta PRIME se centra en una "cohorte cerrada", lo que significa que sigue a un grupo específico de mujeres desde los 12 años a lo largo de toda su vida. Este enfoque permite evaluar de manera detallada los resultados del seguimiento. Respecto a la cobertura de vacunación, el modelo proyecta un aumento en la cobertura del 30% desde el porcentaje actual de cada país (conocido como cobertura basal) en términos absolutos, o hasta alcanzar una cobertura total del 90%. Es importante destacar que, en situaciones donde la cobertura basal de un país ya es del 90%, el modelo establece como objetivo alcanzar una cobertura del 95%. Este enfoque asegura que incluso en países con altas tasas de vacunación, se sigan buscando mejoras para maximizar la protección contra el VPH.

A excepción de Chile y Costa Rica, la herramienta PRIME calcula los costos médicos directos anuales asociados al cáncer de cuello uterino utilizando una metodología adaptada del estudio de Chen y cols.<sup><a href="https://paperpile.com/c/0j7Ywe/6PjNZ">8</a></sup> Esta metodología ajusta los costos en función del Producto Interno Bruto (PIB) per cápita y la prevalencia de cáncer de cuello uterino en cada país, basándose en datos del estudio de Dieleman y cols.<sup><a href="https://paperpile.com/c/0j7Ywe/zLyHR">9</a></sup> Los costos de la vacuna contra el VPH se obtienen de los precios fijados en 2020 por el Programa Ampliado de Inmunizaciones (PAI) de la OPS<sup><a href="https://paperpile.com/c/0j7Ywe/AQzyP">10</a></sup> y se ajustan a 2023 considerando la inflación en Estados Unidos. Además, se asume que los costos de transporte, almacenamiento y aplicación de la vacuna representan el 37% del valor total del esquema de vacunación completo por niña, según lo indicado por Jit y cols.<sup><a href="https://paperpile.com/c/0j7Ywe/FL75O">4</a></sup> Aunque la herramienta proporciona datos basales para todos los países referentes al año 2014, se han actualizado aquellos datos considerados relevantes para este análisis. Cabe destacar que los usuarios pueden modificar los parámetros basales en la herramienta según lo requieran.

La herramienta PRIME, por tanto, es una plataforma valiosa para analizar la relación costo-efectividad de vacunar a niñas contra el VPH, enfocándose en la prevención del cáncer de cuello uterino. Ofrece una visión integral, permitiendo a los usuarios estimar la carga global del cáncer cervicouterino, evaluar cómo el incremento en la cobertura de la vacunación contra el VPH puede impactar en diferentes edades, y calcular tanto los costos de atención médica derivados del tratamiento del cáncer de cuello uterino como los costos asociados a la vacunación. Adicionalmente, facilita la estimación de los ahorros potenciales que podrían lograrse aumentando la cobertura de vacunación.<sup><a href="https://paperpile.com/c/0j7Ywe/8h6E">5</a></sup>


## Limitaciones y Consideraciones

La OMS apoya el uso de la herramienta PRIME por su capacidad para proporcionar estimaciones prudentes y bien fundamentadas sobre el impacto en la salud y la relación costo-efectividad de vacunar a niñas antes de su iniciación sexual. PRIME ha sido empleado en 97 países para valorar el impacto de las inversiones en vacunas a nivel nacional.<sup><a href="https://paperpile.com/c/0j7Ywe/arp4F+vR6dx">6,7</a></sup>

Sin embargo, es importante destacar que PRIME tiene ciertas limitaciones. No está diseñada para evaluar la inmunidad de rebaño ni el impacto de la vacunación en varones. En esencia, se enfoca en calcular los beneficios estimados para la salud derivados de la vacunación contra el VPH en niñas de 9 a 14 años, adoptando un enfoque conservador en sus estimaciones.

Limitaciones en relación a la parte económica, se destaca que para el cálculo del costo de cáncer de cuello uterino, se utilizó un estudio publicado en Estados Unidos <sup><a href="https://paperpile.com/c/0j7Ywe/VBgOI">11</a></sup> como punto de partida debido a la falta de información disponible para todos los países analizados. Esta referencia se empleó para estimar el costo a lo largo de la vida relacionado con el cáncer de cuello uterino en cada uno de los países analizados. Sin embargo, es importante señalar que esta aproximación de costos puede ser refinada con datos más específicos y actualizados para cada país. Por otro lado, el cálculo del costo asociado con la administración, entrega y almacenamiento de la vacuna se llevó a cabo como un porcentaje del precio de la vacuna, siguiendo el enfoque utilizado en estudios anteriores. No obstante, esta métrica de costos también puede ser perfeccionada para ofrecer una representación más precisa y detallada. 

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
   <td>Tamaño de la cohorte de nacimiento (mujeres)
   </td>
   <td>Número de recién nacidas mujeres en el país en un año. 
   </td>
   <td>Instituto de estadística de cada uno de los 8 países
   </td>
  </tr>
  <tr>
   <td>Tamaño de la cohorte en edad de vacunación (mujeres)
   </td>
   <td>Número de mujeres en el país correspondientes a la edad de vacunación de rutina, definida por el "grupo de edad objetivo". Este parámetro por defecto incluye a mujeres de 12 años.
   </td>
   <td>Instituto de estadística de cada uno de los 8 países
   </td>
  </tr>
  <tr>
   <td>Cobertura objetivo (dos dosis)
   </td>
   <td>La proporción esperada de niñas en el grupo de edad relevante que recibirán el curso completo de la vacuna (ya sea 1 o 2 dosis)
   </td>
   <td>Nogueira - Rodrigues y cols.<sup><a href="https://paperpile.com/c/0j7Ywe/eJnud">12</a></sup>
   </td>
  </tr>
  <tr>
   <td>Eficacia de la vacuna contra el VPH 16/18
   </td>
   <td>Indica la reducción del riesgo de infecciones persistentes y lesiones precancerosas por los tipos 16 y 18 del VPH*.
   </td>
   <td>Arbyn y cols. (2018)<sup><a href="https://paperpile.com/c/0j7Ywe/jGf0j">13</a></sup>
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
   <td>AVAD por diagnóstico de cáncer de cuello uterino 
   </td>
   <td>Miden la carga total del cáncer de cuello uterino combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/0j7Ywe/Q6Lyc">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>AVAD por secuelas de cáncer de cuello uterino
   </td>
   <td>Miden la carga total de las secuelas de cáncer de cuello uterino combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/0j7Ywe/Q6Lyc">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>AVAD por cáncer de cuello uterino terminal
   </td>
   <td>Miden la carga total del cáncer de cuello uterino terminal combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/0j7Ywe/Q6Lyc">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>Proporción de casos de cáncer de cuello de útero debidos al VPH 16/18
   </td>
   <td>Proporción de casos de cáncer de cuello uterino que son atribuibles a las cepas 16 y 18 del VPH.
   </td>
   <td>.
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
   <td>Costo de vacunación completa
   </td>
   <td>Costo de vacunación completa por niña para abril de 2023.
   </td>
   <td>PAI OPS 2020 actualizado por inflación.<sup><a href="https://paperpile.com/c/0j7Ywe/AQzyP">10</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costos administrativos de la vacuna
   </td>
   <td>Costo de administración, entrega y almacenamiento de la vacuna por niña completamente inmunizada para abril de 2023.
   </td>
   <td>Asunción según Jit y cols.<sup><a href="https://paperpile.com/c/0j7Ywe/FL75O">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo total de vacunación
   </td>
   <td>Costo total (precio de la vacuna más el costo administrativo) por niña completamente inmunizada para abril de 2023.
   </td>
   <td>Cálculo propio.
   </td>
  </tr>
  <tr>
   <td>Costo del tratamiento del cáncer
   </td>
   <td>Costo promedio anual del tratamiento del cáncer cervical por episodio a lo largo de la vida, para abril de 2023.
   </td>
   <td>Gómez y cols.<sup><a href="https://paperpile.com/c/0j7Ywe/VBgOI">11</a></sup>: CHL y CRC<sup>*</sup>.
<p>
Estimación indirecta<sup>**</sup>: ARG, BRA, COL, ECU, MEX y PER.
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Bill and Melinda Gates Foundation.<sup><a href="https://paperpile.com/c/0j7Ywe/uuUsl">15</a></sup>
   </td>
  </tr>
  <tr>
   <td>PIB per cápita
   </td>
   <td>El Producto Interno Bruto (PIB) per cápita representa el valor total de todos los bienes y servicios producidos por un país durante un año específico, dividido por la población total de ese país.
   </td>
   <td>OECD. Estadísticas Económicas. <sup><a href="https://paperpile.com/c/0j7Ywe/NQM4">16</a></sup>
   </td>
  </tr>
</table>


* Para Costa Rica se asume el mismo valor que en Chile.

** Los costos de Argentina, Brasil, Colombia, Ecuador, México y Perú  fueron calculados con base en el estudio de Gómez y cols. ajustando al PIB per cápita de cada país y a la prevalencia de cáncer de cuello uterino en cada país, mediante la metodología de estimación indirecta.


## Lista de Indicadores 



1. **Cánceres de cuello uterino prevenidos (n):** número de cánceres de cuello uterino prevenidos tras la intervención.

    Ej:  **Cánceres de cuello uterino prevenidos en Argentina n = 4.382,2. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar 4.382,2 casos de cáncer de cuello uterino en la población argentina.

2. **Muertes prevenidas (n)**: número de muertes prevenidas tras la implementación de la intervención. 

    Ej: **Muertes prevenidas en Argentina n= 2.062,6. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de prevenir 2.062,6 muertes en la población argentina. 

3. **Años de vida por muerte prematura evitados:** ** **cantidad de años que se preservarán al evitar muertes prematuras causadas por el cáncer de cuello uterino en la población.

    Ej: **Años de vida por muerte prematura evitados en Argentina n=1.500. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de 1500 años debido a muertes prematuras en la población argentina. 

4. **Años de Vida Ajustados por Discapacidad (AVAD) evitados:** especifica la cantidad de años que se salvaron de la carga de discapacidad causada por el cáncer de cuello uterino en la población.

    Ej: **Años de vida por discapacidad evitados en Argentina n= 48.753,6. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de 48.753,6 años debida a la discapacidad en la población argentina.


**Resultados económicos**



5. **Costo total de la vacunación (USD):** se calcula multiplicando la cantidad de niñas de 12 años incluidas de la muestra, los costos totales de vacunación (costos de la vacuna, de aplicación y de entrega), por el aumento de la cobertura de la vacunación contra el VPH. 

    Ej: **Costo de la vacunación (USD): ** 

6. **Costos de tratamiento ahorrados (USD):** representa el ahorro en costos de tratamiento del cáncer de cuello uterino debido a los casos prevenidos por la vacunación. 

    Ej: **Costos de tratamiento ahorrados en Argentina $3.255.983,1 USD: **el modelo indica que la vacunación tiene la capacidad de ahorrar $3.255.983,1 USD en tratamiento de cáncer de cuello uterino gracias a los casos de cáncer evitados en Argentina. 

7. **Costo neto (USD):** es la diferencia entre el costo de vacunación y los costos de tratamiento ahorrados.

    Ej: **Costo neto en Argentina $12.363.114,8 USD: **el modelo indica que la diferencia entre el costo de vacunación y los costos de tratamiento ahorrado en Argentina son de $12.363.114,8 USD.

8. **Costo incremental por cáncer de cuello uterino prevenido (USD): **costo adicional asociado con la implementación de la vacunación por cada caso de cáncer de cuello uterino que se evita.  

    _Aclaración: se reporta para los países cuyo costo neto ha sido positivo._


    Ej: **Costo incremental por cáncer de cuello uterino prevenido en Argentina $2.821,2 USD: **el costo adicional asociado con la implementación de la vacunación por cada caso de cáncer de cuello uterino que se evita en Argentina es de $2.821,2 USD.

9. **Costo incremental por vida salvada (USD): **costo adicional por cada vida que se salva como resultado de la implementación de la vacunación. 

    Ej: **Costo incremental por vida salvada en Argentina $5.994 USD: **En promedio, cada vida salvada en Argentina por la implementación de la vacunación cuesta un adicional de $5.994 USD. ** **

10. **Costo incremental por Año de Vida Salvado (AVS) (USD):** costo adicional por cada año de vida salvado como resultado de la implementación de la vacunación.

    _Aclaración: se calcula para los países cuyo costo neto ha sido positivo._


    Ej: **Costo incremental por Año de Vida Salvado (AVS) en Argentina $253,6 USD: **En promedio, cada año adicional de vida salvado por la implementación de la vacunación cuesta $253,6 USD.  

11. **Costo incremental por Años de Vida Ajustados por Discapacidad (AVAD) prevenido (USD):** costo adicional por cada año de vida ajustado por discapacidad que se evita como resultado de la implementación de la vacunación. 

    _Aclaración: se calcula para los países cuyo costo neto ha sido positivo._


    Ej: **Costo incremental por Años de Vida Ajustados por Discapacidad (AVAD) prevenido en Argentina (USD): **en Argentina, el costo adicional por cada año de vida ajustado por discapacidad que se evita como resultado de la implementación de la vacunación es de $239 USD.**  **

12. **Retorno de Inversión (ROI) (%):** relación entre los beneficios económicos obtenidos y el costo de la vacunación. Un ROI positivo indica que la vacunación no solo cubre su costo, sino que también genera un beneficio económico adicional. Se define como los ingresos menos la inversión, dividido por la inversión. En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. 

    Ej: **Retorno de la inversión en Argentina = 35%:** por cada $1 USD invertido en la vacunación, se ganan 0.35 céntimos de USD del capital inicial.


**Nota aclaratoria **

El término “descontado” se refiere al proceso de ajustar los valores futuros de dinero a su equivalente en el presente. La tasa de descuento tomada como referencia es 5%.


## 


## Referencias


    1.	[Cervical cancer. Published February 22, 2022. Accessed June 30, 2023. https://www.who.int/news-room/fact-sheets/detail/cervical-cancer](http://paperpile.com/b/0j7Ywe/0MWMv)


    2.	[Cervical cancer. Published February 22, 2022. Accessed June 30, 2023. https://www.who.int/news-room/fact-sheets/detail/cervical-cancer](http://paperpile.com/b/0j7Ywe/Dvz1N)


    3.	[Vacuna contra el virus del papiloma humano (VPH). Accessed December 13, 2023. https://www.paho.org/es/vacuna-contra-virus-papiloma-humano-vph](http://paperpile.com/b/0j7Ywe/gWP0)


    4.	[Jit M, Brisson M, Portnoy A, Hutubessy R. Cost-effectiveness of female human papillomavirus vaccination in 179 countries: a PRIME modelling study. Lancet Glob Health. 2014;2(7):e406-e414. doi:10.1016/S2214-109X(14)70237-2](http://paperpile.com/b/0j7Ywe/FL75O)


    5.	[Jit M, Abbas K, Fu H. Human Papilloma Virus (HPV) models. Accessed December 13, 2023. https://www.vaccineimpact.org/models/hpv/](http://paperpile.com/b/0j7Ywe/8h6E)


    6.	[Jit M, Brisson M. Potential lives saved in 73 countries by adopting multi‐cohort vaccination of 9–14‐year‐old girls against human papillomavirus. International Journal of Cancer. Published online 2018. https://onlinelibrary.wiley.com/doi/abs/10.1002/ijc.31321](http://paperpile.com/b/0j7Ywe/arp4F)


    7.	[Abbas KM, van Zandvoort K, Brisson M, Jit M. Effects of updated demography, disability weights, and cervical cancer burden on estimates of human papillomavirus vaccination impact at the global, regional, and national levels: a PRIME modelling study. Lancet Glob Health. 2020;8(4):e536-e544. doi:10.1016/S2214-109X(20)30022-X](http://paperpile.com/b/0j7Ywe/vR6dx)


    8.	[Chen S, Cao Z, Prettner K, et al. Estimates and Projections of the Global Economic Cost of 29 Cancers in 204 Countries and Territories From 2020 to 2050. JAMA Oncol. 2023;9(4):465-472. doi:10.1001/jamaoncol.2022.7826](http://paperpile.com/b/0j7Ywe/6PjNZ)


    9.	[Dieleman JL, Cao J, Chapin A, et al. US Health Care Spending by Payer and Health Condition, 1996-2016. JAMA. 2020;323(9):863-884. doi:10.1001/jama.2020.0734](http://paperpile.com/b/0j7Ywe/zLyHR)


    10.	[Precios de Programa Ampliado de Inmunizaciones -PAI- 2020. Accessed June 15, 2023. https://www.paho.org/es/file/82792/download?token=Mm5JrLtu](http://paperpile.com/b/0j7Ywe/AQzyP)


    11.	[Gomez JA, Lepetic A, Demarteau N. Health economic analysis of human papillomavirus vaccines in women of Chile: perspective of the health care payer using a Markov model. BMC Public Health. 2014;14:1222. doi:10.1186/1471-2458-14-1222](http://paperpile.com/b/0j7Ywe/VBgOI)


    12.	[Nogueira-Rodrigues A. HPV Vaccination in Latin America: Global Challenges and Feasible Solutions. Am Soc Clin Oncol Educ Book. 2019;39:e45-e52. doi:10.1200/EDBK_249695](http://paperpile.com/b/0j7Ywe/eJnud)


    13.	[Arbyn M, Xu L, Simoens C, Martin-Hirsch PP. Prophylactic vaccination against human papillomaviruses to prevent cervical cancer and its precursors. Cochrane Database Syst Rev. 2018;5(5). doi:10.1002/14651858.CD009069.pub3](http://paperpile.com/b/0j7Ywe/jGf0j)


    14.	[Global Burden of Disease (GBD). Institute for Health Metrics and Evaluation. Published March 29, 2014. Accessed June 15, 2023. https://www.healthdata.org/gbd](http://paperpile.com/b/0j7Ywe/Q6Lyc)


    15.	[Bill and Melinda Gates Foundation Methods for Economic Evaluation Project (MEEP). NICE International. https://www.idsihealth.org/wp-content/uploads/2016/05/Gates-Reference-case-what-it-is-how-to-use-it.pdf](http://paperpile.com/b/0j7Ywe/uuUsl)


    16.	[OCDE. OECD. https://www.oecd.org/espanol/estadisticas/pib-espanol.htm](http://paperpile.com/b/0j7Ywe/NQM4)