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

# 4. Model Card: Profilaxis de la Hemorragia posparto


---


## Introducción

La hemorragia posparto (HPP) es una condición crítica definida como la pérdida de al menos 500 ml de sangre dentro de las 24 horas siguientes al parto, y se considera severa si la pérdida supera los 1000 ml en el mismo período. Esta complicación es una de las causas principales de mortalidad materna a nivel mundial y en América Latina, siendo responsable de aproximadamente el 25% de todas las muertes maternas según la Organización Mundial de la Salud (OMS).<sup><a href="https://paperpile.com/c/8HplYQ/3V83+PUpN">1,2</a></sup> Anualmente, alrededor de 14 millones de mujeres sufren de HPP, resultando en cerca de 70,000 muertes maternas globalmente.<sup><a href="https://paperpile.com/c/8HplYQ/3V83+PUpN">1,2</a></sup> En América Latina y el Caribe, se registra una prevalencia de HPP severa del 3.3%.

Para prevenir la HPP durante el parto, se recomienda universalmente el uso de agentes uterotónicos, basándose en evidencia científica de calidad moderada. La oxitocina, administrada en una dosis de 10 unidades internacionales (UI) por vía intravenosa o intramuscular, es el uterotónico de elección para esta prevención, respaldado también por pruebas científicas de calidad moderada.<sup><a href="https://paperpile.com/c/8HplYQ/yq9L">3</a></sup>


## Nombre del Modelo

Profilaxis de la HPP.


## Descripción del Modelo y Asunciones

Se ha elaborado un árbol de decisiones basado en un modelo de costo-efectividad previamente publicado, enfocado en la oxitocina, para evaluar el impacto de aumentar su cobertura en el ámbito de la atención médica en un país concreto.<sup><a href="https://paperpile.com/c/8HplYQ/wqpt3">4</a></sup> Este modelo consta de dos ramas: una representa el uso estándar de oxitocina y la otra, una intervención que incrementa su uso a nivel institucional con el fin de alcanzar un objetivo específico.

Al elegir una de estas ramas, se analiza mediante nodos de probabilidad la incidencia de administrar oxitocina como parte del tratamiento y la posibilidad de que se produzca un evento de HPP, tanto en la práctica estándar como en la intervención.

La evaluación de los eventos de HPP considera los costos económicos asociados con eventos tanto severos como no severos. Además, se incluye un análisis de los Años de Vida Ajustados por Discapacidad (AVAD), teniendo en cuenta los AVAD vinculados a la vida post-histerectomía y a la muerte prematura, ponderando cada aspecto según su probabilidad. Este enfoque comprensivo permite una evaluación completa de la eficacia y los costos relacionados con la intervención de aumentar la cobertura de oxitocina.


## Limitaciones y Consideraciones

Existen ciertas limitaciones a considerar, dado que hay otras intervenciones disponibles para la profilaxis de la HPP que no se han incluido en el análisis. Además, la información sobre los parámetros epidemiológicos empleados en el modelo es limitada en algunos países, en particular respecto a la cobertura de la oxitocina en los sistemas de salud.

En términos económicos, la mayor limitación es el cálculo del costo de un episodio de hemorragia no severa y severa, ya que se utilizó un estudio multipaís realizado en 2013 para aproximar y actualizar los costos de estos episodios. Este es un dato que es altamente mejorable.


## Descripción General de los Parámetros 


<table>
  <tr>
   <td colspan="4" >
    <strong>Parámetros por países</strong>
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
   <td>Cobertura actual del uso de oxitocina (%)
   </td>
   <td>Probabilidad de que se utilice oxitocina durante el parto en el país.
   </td>
   <td>Kamath y cols.<sup><a href="https://paperpile.com/c/8HplYQ/fKZ4o">5</a></sup>
<p>
OPS<sup><a href="https://paperpile.com/c/8HplYQ/Dgncg">6</a></sup>
   </td>
   <td>Básica
   </td>
  </tr>
  <tr>
   <td>Cobertura esperada del uso de oxitocina (%) 
   </td>
   <td>Probabilidad de que se utilice oxitocina durante el parto en el país luego de la intervención
   </td>
   <td>Magnitud de la intervención
   </td>
   <td>Básica
   </td>
  </tr>
  <tr>
   <td>Costo de oxitocina
   </td>
   <td>Costo de 10 UI de oxitocina en el país para julio 2023.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8HplYQ/Dc6vS">7</a></sup> BRA,<sup><a href="https://paperpile.com/c/8HplYQ/6QkIG">8</a></sup> COL,<sup><a href="https://paperpile.com/c/8HplYQ/jruqF">9</a></sup> ECU<sup><a href="https://paperpile.com/c/8HplYQ/Md0Nq">10</a></sup> y PER.<sup><a href="https://paperpile.com/c/8HplYQ/F0LQc">11</a></sup> 
<p>
Actualizado por inflación: CHL.<sup><a href="https://paperpile.com/c/8HplYQ/lzQlw">12</a></sup>
<p>
Estimación indirecta*:<sup> </sup>CRC, MEX.
   </td>
   <td>Avanzado 
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Bill and Melinda Gates Foundation.<sup><a href="https://paperpile.com/c/8HplYQ/h1xdd">13</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
</table>


* Los costos de Costa Rica y México debido a que no se contó con información específica, fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.


## Lista de indicadores

**Resultados epidemiológicos **



1. **HPP evitadas (n): **número de HPP evitadas en la población en estudio tras la implementación de la intervención.

    Ej: **HPP evitadas n= 3.512,6. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 3.512,6 casos de HPP en la población en estudio. 

2. **Histerectomías por HPP evitadas (n): **número de histerectomías evitadas evitadas en la población en estudio debido a  la implementación de la intervención

    Ej: **Histerectomías evitadas n= 19. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 19 histerectomías en la población en estudio. 

3. **Muertes por HPP evitadas (n): **número de muertes maternas evitadas en la población en estudio  debido a la intervención

    Ej: **Muertes evitadas n= 3,5. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 3,5. muertes en la población en estudio. 

4. **Años de vida salvados (n)**
    1. **AVS por muerte prematura: **especifica la cantidad de años de vida que se han preservado al prevenir muertes prematuras por HPP.

    Ej:** AVS por muerte prematura n= 68,5. **En este caso el modelo indica que la intervención propuesta tiene el potencial de salvar 68,5 años de vida por muerte prematura en la población en estudio. 

    2. **Años de vida ajustados por discapacidad evitados: **especifica la cantidad de años de vida ajustados por discapacidad que se han evitado previniendo la HPP.

    Ej:** AVS por discapacidad n= 5,6. **En este caso el modelo indica que la intervención propuesta tiene el potencial de salvar 5,6 años ajustados por discapacidad en la población en estudio. 


**Resultados económicos**



5. **Costo de la intervención (USD): **el costo total de la intervención se calcula a partir del costo costo de 10UI de oxitocina por cada nuevo parto abarcado al aumentar la cobertura.

    Ej.: **Costo de la intervención (USD): **

6. **Diferencia de costos: **la diferencia de costos está determinada por el costo de la oxitocina y el cambio en la probabilidad de una hemorragia post parto cuando hay una intervención contra el caso sin intervención.

    Ej.: **Diferencia de costos: **

7. **Razón de Costo-Efectividad incremental por año de vida salvado: **diferencia de costos dividido por el número de años salvados gracias a la intervención

    Ej.: **Razón de Costo-Efectividad incremental por año de vida salvado**

8. **Razón de Costo-Efectividad incremental (ICER) por Año de Vida Ajustado por Calidad (AVAC) evitado: **diferencia de costos dividido por el número de AVAD prevenidos gracias a la intervención

    Ej.: **Razón de Costo-Efectividad incremental (ICER) por Año de Vida Ajustado por Calidad (AVAC) evitado:**

9. **Retorno de Inversión (ROI) (USD):** relación entre los beneficios económicos obtenidos y el costo del uso de oxitocina. Un ROI positivo indica que el uso de oxitocina no solo cubre su costo, sino que también genera un beneficio económico adicional. Se define como los ingresos menos la inversión, dividido por la inversión.

    Ej: **Retorno de Inversión (ROI) (USD):** para un ROI del xxx por cada 1 USD invertido en el uso de oxitocina, se obtiene un retorno de xxx USD además del capital inicial. 





## Referencias


    1.	[WHO. WHO POSTPARTUM HAEMORRHAGE (PPH) SUMMIT. Published online March 2023. https://cdn.who.int/media/docs/default-source/hrp/projects/mph/project-brief-pph-summit.pdf?sfvrsn=3b0e505a_6&download=true](http://paperpile.com/b/8HplYQ/3V83)


    2.	[Patek K, Friedman P. Postpartum Hemorrhage-Epidemiology, Risk Factors, and Causes. Clin Obstet Gynecol. 2023;66(2):344-356. doi:10.1097/GRF.0000000000000782](http://paperpile.com/b/8HplYQ/PUpN)


    3.	[Quezada-Robles A, Quispe-Sarmiento F, Bendezu-Quispe G, Vargas-Fernández R. Fetal Macrosomia and Postpartum Hemorrhage in Latin American and Caribbean Region: Systematic Review and Meta-analysis. Rev Bras Ginecol Obstet. 2023;45(11):e706-e723. doi:10.1055/s-0043-1772597](http://paperpile.com/b/8HplYQ/yq9L)


    4.	[Pichon-Riviere A, Glujovsky D, Garay OU, et al. Oxytocin in Uniject Disposable Auto-Disable Injection System versus Standard Use for the Prevention of Postpartum Hemorrhage in Latin America and the Caribbean: A Cost-Effectiveness Analysis. PLoS One. 2015;10(6):e0129044. doi:10.1371/journal.pone.0129044](http://paperpile.com/b/8HplYQ/wqpt3)


    5.	[Kamath AM, Schaefer AM, Palmisano EB, et al. Access and use of oxytocin for postpartum haemorrhage prevention: a pre-post study targeting the poorest in six Mesoamerican countries. BMJ Open. 2020;10(3):e034084. doi:10.1136/bmjopen-2019-034084](http://paperpile.com/b/8HplYQ/fKZ4o)


    6.	[Oct 22. Evaluación económica del uso de oxitocina en el sistema de inyección Uniject TM versus el uso estándar en ampollas para la prevención de la hemorragia posparto en el manejo activo de la tercera etapa del parto en América Latina y el Caribe. Accessed September 25, 2023. https://www.paho.org/es/documentos/evaluacion-economica-uso-oxitocina-sistema-inyeccion-uniject-tm-versus-uso-estandar](http://paperpile.com/b/8HplYQ/Dgncg)


    7.	[SRV PRECIO. Accessed September 21, 2023. https://www.alfabeta.net/precio/srv](http://paperpile.com/b/8HplYQ/Dc6vS)


    8.	[Kairos preço de remedios. Kairos Web. Published September 28, 2019. Accessed September 21, 2023. https://br.kairosweb.com/](http://paperpile.com/b/8HplYQ/6QkIG)


    9.	[Termómetro de precios de medicamentos. Colombia Potencia de la Vida. Accessed September 17, 2023. https://www.minsalud.gov.co/salud/MT/Paginas/termometro-de-precios.aspx](http://paperpile.com/b/8HplYQ/jruqF)


    10.	[Henríquez-Trujillo AR, Lucio-Romero RA, Bermúdez-Gallegos K. Analysis of the cost-effectiveness of carbetocin for the prevention of hemorrhage following cesarean delivery in Ecuador. J Comp Eff Res. 2017;6(6):529-536. doi:10.2217/cer-2017-0004](http://paperpile.com/b/8HplYQ/Md0Nq)


    11.	[Observatorio Peruano de Productos Farmacéuticos. SISTEMA NACIONAL DE INFORMACIÓN DE PRECIOS DE PRODUCTOS FARMACÉUTICOS - SNIPPF. Accessed September 17, 2023. https://opm-digemid.minsa.gob.pe/#/consulta-producto](http://paperpile.com/b/8HplYQ/F0LQc)


    12.	[Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/8HplYQ/lzQlw)


    13.	[Bill and Melinda Gates Foundation Methods for Economic Evaluation Project (MEEP). NICE International. https://www.idsihealth.org/wp-content/uploads/2016/05/Gates-Reference-case-what-it-is-how-to-use-it.pdf](http://paperpile.com/b/8HplYQ/h1xdd)


    14.	[Number of births (thousands). Accessed September 18, 2023. https://www.who.int/data/maternal-newborn-child-adolescent-ageing/indicator-explorer-new/MCA/number-of-births-(thousands)](http://paperpile.com/b/8HplYQ/PTGbL)


    15.	[World Population Prospects - Population Division - United Nations. Accessed September 19, 2023. https://population.un.org/wpp/Download/Standard/MostUsed/](http://paperpile.com/b/8HplYQ/oZTJS)


    16.	[Data Warehouse. UNICEF DATA. Cross-sector indicators Indicator: Institutional deliveries - percentage of deliveries in a health facility. Published October 31, 2019. Accessed September 15, 2023. https://data.unicef.org/resources/data_explorer/unicef_f/?ag=UNICEF&df=GLOBAL_DATAFLOW&ver=1.0&dq=ARG+BRA+CHL+COL+CRI+ECU+MEX+PER.MNCH_INSTDEL..&startPeriod=2007&endPeriod=2022&lastnobservations=1](http://paperpile.com/b/8HplYQ/8Ociw)


    17.	[Data Warehouse. UNICEF DATA. Indicator: Maternal mortality ratio (number of maternal deaths per 100,000 live births) Data Source: WHO, UNICEF, UNFPA, World Bank Group and UNPD (MMEIG) - February 2023 Time period: 2020. Published October 31, 2019. Accessed September 15, 2023. https://data.unicef.org/resources/data_explorer/unicef_f/?ag=UNICEF&df=MNCH&ver=1.0&dq=ARG+BRA+CHL+COL+CRI+ECU+MEX+PER.MNCH_MMR.......&startPeriod=2016&endPeriod=2022&lastnobservations=1](http://paperpile.com/b/8HplYQ/P3FN7)


    18.	[de Souza M de L, Laurenti R, Knobel R, Monticelli M, Brüggemann OM, Drake E. Mortalidad materna en Brasil debida a hemorragia.](http://paperpile.com/b/8HplYQ/DJYkr)


    19.	[Donoso E CA. El cambio del perfil epidemiológico de la mortalidad materna en Chile dificultará el cumplimiento del 5o objetivo del Milenio. Rev Med Chile Supl.](http://paperpile.com/b/8HplYQ/YvR8w)


    20.	[de México S de S. INFORME SEMANAL DE NOTIFICACIÓN INMEDIATA DE MUERTE MATERNA. https://www.gob.mx/cms/uploads/attachment/file/757308/MM_2022_SE35.pdf](http://paperpile.com/b/8HplYQ/kV3V0)


    21.	[Epidemiológico B. Boletín Epidemiológico (Lima - Perú). Published online 2016. https://www.dge.gob.pe/portal/docs/vigilancia/boletines/2016/04.pdf](http://paperpile.com/b/8HplYQ/qWHxY)


    22.	[ex - expectation of life at age x (GHE: Life tables). Accessed September 19, 2023. https://www.who.int/data/gho/data/indicators/indicator-details/GHO/gho-ghe-life-tables-ex-expectation-of-life-at-age-x](http://paperpile.com/b/8HplYQ/4xXFG)


    23.	[Extended National Consumer Price Index. Instituto Brasileiro de Geografia e Estatística. Accessed September 17, 2023. https://www.ibge.gov.br/en/statistics/economic/prices-and-costs/17129-extended-national-consumer-price-index.html?=&t=o-que-e](http://paperpile.com/b/8HplYQ/plPvr)


    24.	[Índice de precios al consumidor (IPC). Banco de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/indice-precios-consumidor-ipc](http://paperpile.com/b/8HplYQ/FqXmf)


    25.	[Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/8HplYQ/UVxNs)


    26.	[Índice de Precios al Consumidor. Instituto Nacional de Estadística y Censos. Accessed September 17, 2023. https://www.ecuadorencifras.gob.ec/indice-de-precios-al-consumidor/](http://paperpile.com/b/8HplYQ/J3nYp)


    27.	[Índice Nacional de Precios al Consumidor (INPC). Instituto Nacional de Estadística y Geografía (INEGI). Accessed September 17, 2023. https://www.inegi.org.mx/temas/inpc/](http://paperpile.com/b/8HplYQ/fSgeB)


    28.	[Gerencia Central de Estudios Económicos. ÍNDICE DE PRECIOS AL CONSUMIDOR (IPC). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/anuales/resultados/PM05197PA/html/1950/2023/](http://paperpile.com/b/8HplYQ/9jKeu)


    29.	[Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/8HplYQ/NmuNE)


    30.	[Converter 1 Dólar dos EUA para Real brasileiro. Conversor de moeda XE. Accessed September 17, 2023. https://www.xe.com/pt/currencyconverter/convert/?Amount=1&From=USD&To=BRL](http://paperpile.com/b/8HplYQ/HEWgU)


    31.	[de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/8HplYQ/fWMgV)


    32.	[Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/8HplYQ/jn9rC)


    33.	[Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/8HplYQ/gDBGe)


    34.	[Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/8HplYQ/LVVO8)


    35.	[Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/8HplYQ/aUpV4)


    36.	[Sosa CG, Althabe F, Belizán JM, Buekens P. Risk factors for postpartum hemorrhage in vaginal deliveries in a Latin-American population. Obstet Gynecol. 2009;113(6):1313-1319. doi:10.1097/AOG.0b013e3181a66b05](http://paperpile.com/b/8HplYQ/xgVVZ)


    37.	[Huque S, Roberts I, Fawole B, Chaudhri R, Arulkumaran S, Shakur-Still H. Risk factors for peripartum hysterectomy among women with postpartum haemorrhage: analysis of data from the WOMAN trial. BMC Pregnancy Childbirth. 2018;18(1):186. doi:10.1186/s12884-018-1829-7](http://paperpile.com/b/8HplYQ/VxITw)


    38.	[Gülmezoglu AM, Villar J, Ngoc NT, et al. WHO multicentre randomised trial of misoprostol in the management of the third stage of labour. Lancet. 2001;358(9283):689-695. doi:10.1016/s0140-6736(01)05835-4](http://paperpile.com/b/8HplYQ/JM3IP)


    39.	[Salati JA, Leathersich SJ, Williams MJ, Cuthbert A, Tolosa JE. Prophylactic oxytocin for the third stage of labour to prevent postpartum haemorrhage. Cochrane Database Syst Rev. 2019;4(4):CD001808. doi:10.1002/14651858.CD001808.pub3](http://paperpile.com/b/8HplYQ/EaJoL)


    40.	[CEA Registry. Tufts Medical Center. Accessed September 24, 2023. https://healtheconomicsdev.tuftsmedicalcenter.org/cear2/search/weight0.aspx](http://paperpile.com/b/8HplYQ/N4mbx)


    41.	[Briones JR, Talungchit P, Thavorncharoensap M, Chaikledkaew U. Economic evaluation of carbetocin as prophylaxis for postpartum hemorrhage in the Philippines. BMC Health Serv Res. 2020;20(1):975. doi:10.1186/s12913-020-05834-x](http://paperpile.com/b/8HplYQ/K7Zg3)


## Anexos


## Descripción parámetros internos del modelo


<table>
  <tr>
   <td colspan="3" >
    <strong>Parámetros por países</strong>
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
   <td>Partos anuales<sup>a</sup>
   </td>
   <td>Número de partos registrados en el país.
   </td>
   <td>OMS<sup><a href="https://paperpile.com/c/8HplYQ/PTGbL">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>Edad promedio al parto<sup>b</sup>
   </td>
   <td>Edad materna promedio en el momento del parto en el país.
   </td>
   <td>NU<sup><a href="https://paperpile.com/c/8HplYQ/oZTJS">15</a></sup>
   </td>
  </tr>
  <tr>
   <td>Partos institucionales
   </td>
   <td>Probabilidad de que un parto sea institucional para el país.
   </td>
   <td>UNICEF<sup><a href="https://paperpile.com/c/8HplYQ/8Ociw">16</a></sup>
   </td>
  </tr>
  <tr>
   <td>Mortalidad materna<sup>a</sup>
   </td>
   <td>Número de muertes maternas por cada 100,000 partos en el país.
   </td>
   <td>UNICEF<sup><a href="https://paperpile.com/c/8HplYQ/P3FN7">17</a></sup>
   </td>
  </tr>
  <tr>
   <td>Mortalidad materna por HPP
   </td>
   <td>Porcentaje de muertes maternas atribuibles a HPP en el país.
   </td>
   <td>Souza y cols.<sup><a href="https://paperpile.com/c/8HplYQ/DJYkr">18</a></sup>
<p>
Donoso y cols.<sup><a href="https://paperpile.com/c/8HplYQ/YvR8w">19</a></sup>
<p>
Secretaria de Salud de México<sup><a href="https://paperpile.com/c/8HplYQ/kV3V0">20</a></sup>
<p>
Ministerio de Salud de Perú<sup><a href="https://paperpile.com/c/8HplYQ/qWHxY">21</a></sup>
   </td>
  </tr>
  <tr>
   <td>Expectativa de vida al momento del parto<sup>d</sup>
   </td>
   <td>Expectativa de vida a la que se espera que una mujer llegue después de haber dado a luz, teniendo en cuenta la edad promedio de parto<sup>b</sup> y la expectativa de vida de ese grupo etario específico.<sup>c</sup>
   </td>
   <td>NU, OMS<sup><a href="https://paperpile.com/c/8HplYQ/4xXFG+oZTJS">15,22</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de episodio HPP no severa<sup>e</sup>
   </td>
   <td>Costo de hemorragia post parto no severa en el país para julio 2023.
   </td>
   <td>Pichon-Riviere y cols.<sup><a href="https://paperpile.com/c/8HplYQ/wqpt3">4</a></sup> actualizado por inflación en dólares.<sup><a href="https://paperpile.com/c/8HplYQ/plPvr+lzQlw+FqXmf+UVxNs+J3nYp+fSgeB+9jKeu+NmuNE+HEWgU+fWMgV+jn9rC+gDBGe+LVVO8+aUpV4">12,23–35</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de episodio HPP severa
   </td>
   <td>Costo de hemorragia post parto severa en el país para julio 2023.
   </td>
   <td>Pichon-Riviere y cols.<sup><a href="https://paperpile.com/c/8HplYQ/wqpt3">4</a></sup> actualizado por inflación en dólares.<sup><a href="https://paperpile.com/c/8HplYQ/plPvr+lzQlw+FqXmf+UVxNs+J3nYp+fSgeB+9jKeu+NmuNE+HEWgU+fWMgV+jn9rC+gDBGe+LVVO8+aUpV4">12,23–35</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo de oxitocina
   </td>
   <td>Costo de 10 UI de oxitocina en el país para julio 2023.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/8HplYQ/Dc6vS">7</a></sup> BRA,<sup><a href="https://paperpile.com/c/8HplYQ/6QkIG">8</a></sup> COL,<sup><a href="https://paperpile.com/c/8HplYQ/jruqF">9</a></sup> ECU<sup><a href="https://paperpile.com/c/8HplYQ/Md0Nq">10</a></sup> y PER.<sup><a href="https://paperpile.com/c/8HplYQ/F0LQc">11</a></sup> 
<p>
Actualizado por inflación: CHL.<sup><a href="https://paperpile.com/c/8HplYQ/lzQlw">12</a></sup>
<p>
Estimación indirecta<sup>*</sup>: CRC, MEX.
   </td>
  </tr>
</table>


<sup>a</sup>ARG, BRA, CHL, COL, CRC, ECU, MEX y PER (2020).

<sup>b</sup>ARG, PER (2020); BRA (2019); CHL, ECU (2014); COL (2016); CRC (2018); MEX (2015).

<sup>c</sup>ARG, BRA, CHL, COL, CRC, ECU, MEX y PER (2019).

<sup>d</sup>El parámetro resulta de sumar la edad promedio de parto y la expectativa de vida de ese rango etario.

* Los costos de Costa Rica y México debido a que no se contó con información específica, fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.


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
   <td>Riesgo de HPP sin profilaxis
   </td>
   <td>Probabilidad de que al momento del parto se presente una HPP (≥500 ml) en ausencia de intervención profiláctica.
   </td>
   <td>Sosa y cols.<sup><a href="https://paperpile.com/c/8HplYQ/xgVVZ">36</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo de HPP severa dado HPP<sup>a</sup>
   </td>
   <td>Probabilidad condicional estimada de que ocurra una HPP severa (≥1000 ml) después de haber experimentado una HPP.
   </td>
   <td>Sosa y cols.<sup><a href="https://paperpile.com/c/8HplYQ/xgVVZ">36</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo de histerectomía dado HPP severa
   </td>
   <td>Probabilidad estimada de que una mujer que experimenta una HPP severa requiera una histerectomía como resultado de esta complicación.
   </td>
   <td>Huque y cols.<sup><a href="https://paperpile.com/c/8HplYQ/VxITw">37</a></sup> 
<p>
Gülmezoglu y cols.<sup><a href="https://paperpile.com/c/8HplYQ/JM3IP">38</a></sup>
   </td>
  </tr>
  <tr>
   <td>RR de HPP con oxitocina
   </td>
   <td>Riesgo relativo de desarrollar HPP en pacientes que recibieron oxitocina en comparación con aquellos que no la recibieron.
   </td>
   <td>Salati y cols.<sup><a href="https://paperpile.com/c/8HplYQ/EaJoL">39</a></sup>
   </td>
  </tr>
  <tr>
   <td>AVAC histerectomía
   </td>
   <td>Utilidad de vivir un año con una histerectomía.
   </td>
   <td>Tufts Medical Center<sup><a href="https://paperpile.com/c/8HplYQ/N4mbx">40</a></sup>
<p>
Briones y cols.<sup><a href="https://paperpile.com/c/8HplYQ/K7Zg3">41</a></sup>
   </td>
  </tr>
  <tr>
   <td>Eficacia predeterminada de la intervención
   </td>
   <td>Porcentaje de reducción de la brecha en el uso institucional de oxitocina.
   </td>
   <td>Pichon-Riviere y cols.<sup><a href="https://paperpile.com/c/8HplYQ/wqpt3">4</a></sup>
   </td>
  </tr>
</table>


<sup>a</sup>Se calculó con la probabilidad de HPP severa (0,019) dividida por la probabilidad de HPP (0,108)

