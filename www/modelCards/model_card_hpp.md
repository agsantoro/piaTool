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

# Model Card: Profilaxis de la Hemorragia posparto


---


## Introducción

La hemorragia posparto (HPP) es una condición crítica definida como la pérdida de al menos 500 ml de sangre dentro de las 24 horas siguientes al parto, y se considera severa si la pérdida supera los 1000 ml en el mismo período. Esta complicación es una de las causas principales de mortalidad materna a nivel mundial y en América Latina, siendo responsable de aproximadamente el 25% de todas las muertes maternas según la Organización Mundial de la Salud (OMS).<sup><a href="https://paperpile.com/c/JytdKk/Yrfpu+WWJoW">1,2</a></sup> Anualmente, alrededor de 14 millones de mujeres sufren de HPP, resultando en cerca de 70,000 muertes maternas globalmente.<sup><a href="https://paperpile.com/c/JytdKk/Yrfpu+WWJoW">1,2</a></sup> En América Latina y el Caribe, se registra una prevalencia de HPP severa del 3.3%.

Para prevenir la HPP durante el parto, se recomienda universalmente el uso de agentes uterotónicos, basándose en evidencia científica de calidad moderada. La oxitocina, administrada en una dosis de 10 unidades internacionales (UI) por vía intravenosa o intramuscular, es el uterotónico de elección para esta prevención, respaldado también por pruebas científicas de calidad moderada.<sup><a href="https://paperpile.com/c/JytdKk/OOdSg">3</a></sup>


## Nombre del Modelo

Profilaxis de la Hemorragia Posparto.


## Descripción del Modelo y Asunciones

Se ha elaborado un árbol de decisiones basado en un modelo de costo-efectividad previamente publicado, enfocado en la oxitocina, para evaluar el impacto de aumentar su cobertura en el ámbito de la atención médica en un país concreto.<sup><a href="https://paperpile.com/c/JytdKk/Ul19U">4</a></sup> Este modelo consta de dos ramas: una representa el uso estándar de oxitocina y la otra, una intervención que incrementa su uso a nivel institucional con el fin de alcanzar un objetivo específico.

Al elegir una de estas ramas, se analiza mediante nodos de probabilidad la incidencia de administrar oxitocina como parte del tratamiento y la posibilidad de que se produzca un evento de HPP, tanto en la práctica estándar como en la intervención.

La evaluación de los eventos de HPP considera los costos económicos asociados con eventos tanto severos como no severos. Además, se incluye un análisis de los Años de Vida Ajustados por Discapacidad (AVAD), teniendo en cuenta los AVAD vinculados a la vida post-histerectomía y a la muerte prematura, ponderando cada aspecto según su probabilidad. Este enfoque comprensivo permite una evaluación completa de la eficacia y los costos relacionados con la intervención de aumentar la cobertura de oxitocina.


## Limitaciones y Consideraciones

Existen ciertas limitaciones a considerar, dado que hay otras intervenciones disponibles para la profilaxis de la HPP que no se han incluido en el análisis. Además, la información sobre los parámetros epidemiológicos empleados en el modelo es limitada en algunos países, en particular respecto a la cobertura de la oxitocina en los sistemas de salud.

En términos económicos, la mayor limitación es el cálculo del costo de un episodio de hemorragia no severa y severa, ya que se utilizó un estudio multipaís realizado en 2013 para aproximar y actualizar los costos de estos episodios. Este es un dato que es altamente mejorable.


## Descripción General de los Parámetros 


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
   <td>Cobertura esperada del uso de oxitocina (%) 
   </td>
   <td>Porcentaje de uso de oxitocina durante el parto en el país luego de la intervención
   </td>
   <td>Definido por el usuario
   </td>
  </tr>
  <tr>
   <td>Partos anuales<sup>a</sup>
   </td>
   <td>Número de partos registrados en el país por año.
   </td>
   <td>OMS<sup><a href="https://paperpile.com/c/JytdKk/lJp3e">27</a></sup>
   </td>
  </tr>
  <tr>
   <td>Partos institucionales (%)
   </td>
   <td>Porcentaje de partos institucionales para el país.
   </td>
   <td>UNICEF<sup><a href="https://paperpile.com/c/JytdKk/JHNqD">29</a></sup>
   </td>
  </tr>
  <tr>
   <td>Mortalidad materna<sup>a</sup>
   </td>
   <td>Número de muertes maternas por cada 100.000 partos en el país.
   </td>
   <td>UNICEF<sup><a href="https://paperpile.com/c/JytdKk/U0FCq">30</a></sup>
   </td>
  </tr>
  <tr>
   <td>Mortalidad materna por hemorragia postparto (%)
   </td>
   <td>Porcentaje de muertes maternas atribuibles a HPP en el país.
   </td>
   <td>Souza y cols.<sup><a href="https://paperpile.com/c/JytdKk/U2MAH">31</a></sup>
<p>
Donoso y cols.<sup><a href="https://paperpile.com/c/JytdKk/GMljM">32</a></sup>
<p>
Secretaria de Salud de México<sup><a href="https://paperpile.com/c/JytdKk/2poZP">33</a></sup>
<p>
Ministerio de Salud de Perú<sup><a href="https://paperpile.com/c/JytdKk/402ly">34</a></sup>
   </td>
  </tr>
  <tr>
   <td>Cobertura actual del uso de oxitocina (%)
   </td>
   <td>Porcentaje de uso de oxitocina durante el parto en el país.
   </td>
   <td>Kamath y cols.<sup><a href="https://paperpile.com/c/JytdKk/N3XvB">5</a></sup>
<p>
OPS<sup><a href="https://paperpile.com/c/JytdKk/YbKlw">6</a></sup>
   </td>
  </tr>
  <tr>
   <td>Edad promedio al parto<sup>b</sup>
   </td>
   <td>Edad materna promedio en el momento del parto en el país.
   </td>
   <td>NU<sup><a href="https://paperpile.com/c/JytdKk/NPLsq">28</a></sup>
   </td>
  </tr>
  <tr>
   <td>Años de vida ajustados por calidad por  histerectomía
   </td>
   <td>Utilidad de vivir un año con una histerectomía.
   </td>
   <td>Tufts Medical Center<sup><a href="https://paperpile.com/c/JytdKk/rq1F7">40</a></sup>
<p>
Briones y cols.<sup><a href="https://paperpile.com/c/JytdKk/JsxOc">41</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo de HPP sin profilaxis (%)
   </td>
   <td>Porcentaje de que al momento del parto se presente una HPP (≥500 ml) en ausencia de intervención profiláctica.
   </td>
   <td>Sosa y cols.<sup><a href="https://paperpile.com/c/JytdKk/dv0ji">36</a></sup>
   </td>
  </tr>
  <tr>
   <td>RR de HPP con oxitocina 
   </td>
   <td>Riesgo relativo de desarrollar HPP en pacientes que recibieron oxitocina en comparación con aquellos que no la recibieron.
   </td>
   <td>Salati y cols.<sup><a href="https://paperpile.com/c/JytdKk/cahum">39</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo de HPP severa dado HPP (%)<sup>a </sup>
   </td>
   <td>Porcentaje condicional estimado de que ocurra una HPP severa (≥1000 ml) después de haber experimentado una HPP.
   </td>
   <td>Sosa y cols.<sup><a href="https://paperpile.com/c/JytdKk/dv0ji">36</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo de histerectomía dado HPP severa (%)
   </td>
   <td>Porcentaje estimado de que una mujer que experimenta una HPP severa requiera una histerectomía como resultado de esta complicación.
   </td>
   <td>Huque y cols.<sup><a href="https://paperpile.com/c/JytdKk/8TNSQ">37</a></sup> 
<p>
Gülmezoglu y cols.<sup><a href="https://paperpile.com/c/JytdKk/1xBMI">38</a></sup>
   </td>
  </tr>
</table>


* Los costos de Costa Rica y México debido a que no se contó con información específica, fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.


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
   <td>Costo de oxitocina (USD)
   </td>
   <td>Costo de 10 UI de oxitocina.
   </td>
   <td>Páginas oficiales de precios de medicamentos: ARG,<sup><a href="https://paperpile.com/c/JytdKk/RKtOl">7</a></sup> BRA,<sup><a href="https://paperpile.com/c/JytdKk/Etf8S">8</a></sup> COL,<sup><a href="https://paperpile.com/c/JytdKk/cY3Yz">9</a></sup> ECU<sup><a href="https://paperpile.com/c/JytdKk/hbAnx">10</a></sup> y PER.<sup><a href="https://paperpile.com/c/JytdKk/5ZiWw">11</a></sup> 
<p>
Actualizado por inflación: CHL.<sup><a href="https://paperpile.com/c/JytdKk/YGf4s">12</a></sup>
<p>
Estimación indirecta*:<sup> </sup>CRC, MEX.
<p>
Valores expresados en USD oficial a tasa de cambio nominal de cada país para julio de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de episodio de hemorragia postparto no severa (USD)<sup>e </sup>
   </td>
   <td>Costo total de tratar un episodio de hemorragia post parto no severa (&lt; 1000 ml) .
   </td>
   <td>Pichon-Riviere y cols.<sup><a href="https://paperpile.com/c/JytdKk/Ul19U">4</a></sup> actualizado por inflación en dólares.<sup><a href="https://paperpile.com/c/JytdKk/9fxJg+YGf4s+zY09D+08fDA+KAJqD+D4oTg+DoquU+8HqGB+EY2Ut+GKoMP+OItqy+tfqXI+5KZK0+JifvH">12–25</a></sup>
<p>
Valores expresados en USD oficial a tasa de cambio nominal de cada país para julio de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de episodio de hemorragia postparto severa (USD)
   </td>
   <td>Costo total de tratar un episodio de hemorragia post parto severa (≥1000 ml).
   </td>
   <td>Pichon-Riviere y cols.<sup><a href="https://paperpile.com/c/JytdKk/Ul19U">4</a></sup> actualizado por inflación en dólares.<sup><a href="https://paperpile.com/c/JytdKk/9fxJg+YGf4s+zY09D+08fDA+KAJqD+D4oTg+DoquU+8HqGB+EY2Ut+GKoMP+OItqy+tfqXI+5KZK0+JifvH">12–25</a></sup>
<p>
Valores expresados en USD oficial a tasa de cambio nominal de cada país para julio de 2023.
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento (%)
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Manual metodológico para elaboración de Evaluaciones Económicas <sup><a href="https://paperpile.com/c/JytdKk/8T9T">26</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo programático anual de la intervención (USD)
   </td>
   <td>Costo de implementar y sostener la intervención en un año.
   </td>
   <td>Se deja la posibilidad al usuario de completar este dato si cuenta con él
<p>
Valores expresados en USD oficial a tasa de cambio nominal de cada país
   </td>
  </tr>
</table>



## Lista de indicadores

**Resultados epidemiológicos **



1. **Hemorragias posparto evitadas (n): **número de hemorragias posparto evitadas en la población en estudio tras la implementación de la intervención.

    Ej: **Hemorragias posparto evitadas n= 3.512,6. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 3.512,6 casos de hemorragia posparto en la población en estudio. 

2. **Muertes evitadas (n): **número de muertes maternas evitadas en la población en estudio  debido a la intervención.

    Ej: **Muertes evitadas n= 3,5. **En este caso el modelo indica que la intervención propuesta tiene el potencial de evitar 3,5. muertes en la población en estudio. 

3. **Años de vida salvados (n): **especifica la cantidad de años de vida que se han preservado al prevenir muertes prematuras por HPP.

    Ej:** AVS n= 68,5. **En este caso el modelo indica que la intervención propuesta tiene el potencial de salvar 68,5 años de vida por muerte prematura en la población en estudio. 

4. **Años de vida ajustados por discapacidad evitados: **especifica la cantidad de años de vida ajustados por discapacidad que se han evitado previniendo la HPP.

    Ej:** Años de vida ajustados por discapacidad evitados n= 5,6. **En este caso el modelo indica que la intervención propuesta tiene el potencial de salvar 5,6 años ajustados por discapacidad en la población en estudio. 


**Resultados económicos**



5. **Costo total de la intervención (USD): **el costo total de la intervención se calcula a partir del aumento de la cobertura de dar 10 UI de oxitocina en cada nuevo parto (USD oficial a tasa de cambio nominal de cada país)

    Ej.: **Costo total de la intervención (USD) = $49.562 USD: **el costo total de aumentar la cobertura de oxitocina por cada nuevo parto, asciende a $49.562 USD.

6. **Costos evitados atribuibles a la intervención (USD): **Son los costos asociados al tratamiento y complicaciones de hemorragia postparto que se evitarían gracias a la intervención.

    Ej: **Costos evitados atribuibles a la intervención (USD) = $56.853 USD:** los costos evitados gracias a la prevención de eventos de hemorragia postparto atribuible a la intervención es de $56.853** **USD.

7. **Diferencia de costos respecto al escenario basal (USD): **la diferencia de costos está determinada por el costo total del aumento de la cobertura de la oxitocina en comparación con el costo total de no aumentar la cobertura de la oxitocina (USD oficial a tasa de cambio nominal de cada país).

    Ej.: **Diferencia de costos respecto al escenario basal (USD) = $6.254 USD: **el costo total de la intervención de aumentar la cobertura de oxitocina en comparación con el costo total de no aumentar la cobertura de dar la oxitocina, asciende a $6.254 USD.** **

8. **Razón de costo-efectividad incremental (RCEI) por vida salvada (VS) (USD): **costo adicional por cada vida que se salva como resultado de la implementación del uso de oxitocina en comparación con no utilizarlo.

    Ej: **RCEI por VS = $322 USD: **en promedio, cada vida salvada por la implementación del uso de oxitocina cuesta un adicional de $322 USD.

9. **Razón de costo-efectividad incremental por año de vida salvado (USD): **diferencia de costos dividido por el número de años salvados gracias a la intervención (aumentar cobertura de oxitocina) (USD oficial a tasa de cambio nominal de cada país)

    Ej.: **Razón de costo-efectividad incremental por año de vida salvado (USD) = $86 USD: **el costo de obtener un Año de Vida Salvado adicional gracias a aumentar la cobertura de oxitocina, asciende a $86 USD.

10. **Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD): **costo de obtener un Año de Vida Ajustado por Discapacidad adicional gracias al aumento de cobertura de la oxitocina (USD oficial a tasa de cambio nominal de cada país)

    Ej.: **Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD) = $8.541 USD: **obtener un Año de Vida Ajustado por Discapacidad adicional gracias al aumento de la cobertura en oxitocina cuesta $8.541 USD.

11. **Retorno de Inversión (%):** relación entre los beneficios económicos obtenidos y el costo del aumento del uso de oxitocina. Un ROI positivo indica que el aumento en el uso de oxitocina no solo cubre su costo, sino que también genera un beneficio económico adicional. En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. Se define como los ingresos menos la inversión, dividido por la inversión.

    Ej: **Retorno de Inversión (%) = 10%:** para un ROI del 10% por cada 1 USD invertido en el aumento del uso de oxitocina, se obtiene un retorno de 0.10 USD además del capital inicial. 



## Referencias


    1.	[WHO. WHO POSTPARTUM HAEMORRHAGE (PPH) SUMMIT. Published online March 2023. https://cdn.who.int/media/docs/default-source/hrp/projects/mph/project-brief-pph-summit.pdf?sfvrsn=3b0e505a_6&download=true](http://paperpile.com/b/JytdKk/Yrfpu)


    2.	[Patek K, Friedman P. Postpartum Hemorrhage-Epidemiology, Risk Factors, and Causes. Clin Obstet Gynecol. 2023;66(2):344-356.](http://paperpile.com/b/JytdKk/WWJoW)


    3.	[Quezada-Robles A, Quispe-Sarmiento F, Bendezu-Quispe G, Vargas-Fernández R. Fetal Macrosomia and Postpartum Hemorrhage in Latin American and Caribbean Region: Systematic Review and Meta-analysis. Rev Bras Ginecol Obstet. 2023;45(11):e706-e723.](http://paperpile.com/b/JytdKk/OOdSg)


    4.	[Pichon-Riviere A, Glujovsky D, Garay OU, et al. Oxytocin in Uniject Disposable Auto-Disable Injection System versus Standard Use for the Prevention of Postpartum Hemorrhage in Latin America and the Caribbean: A Cost-Effectiveness Analysis. PLoS One. 2015;10(6):e0129044.](http://paperpile.com/b/JytdKk/Ul19U)


    5.	[Kamath AM, Schaefer AM, Palmisano EB, et al. Access and use of oxytocin for postpartum haemorrhage prevention: a pre-post study targeting the poorest in six Mesoamerican countries. BMJ Open. 2020;10(3):e034084.](http://paperpile.com/b/JytdKk/N3XvB)


    6.	[Oct 22. Evaluación económica del uso de oxitocina en el sistema de inyección Uniject TM versus el uso estándar en ampollas para la prevención de la hemorragia posparto en el manejo activo de la tercera etapa del parto en América Latina y el Caribe. Accessed September 25, 2023. https://www.paho.org/es/documentos/evaluacion-economica-uso-oxitocina-sistema-inyeccion-uniject-tm-versus-uso-estandar](http://paperpile.com/b/JytdKk/YbKlw)


    7.	[SRV PRECIO. Accessed September 21, 2023. https://www.alfabeta.net/precio/srv](http://paperpile.com/b/JytdKk/RKtOl)


    8.	[Kairos preço de remedios. Kairos Web. Published September 28, 2019. Accessed September 21, 2023. https://br.kairosweb.com/](http://paperpile.com/b/JytdKk/Etf8S)


    9.	[Termómetro de precios de medicamentos. Colombia Potencia de la Vida. Accessed September 17, 2023. https://www.minsalud.gov.co/salud/MT/Paginas/termometro-de-precios.aspx](http://paperpile.com/b/JytdKk/cY3Yz)


    10.	[Henríquez-Trujillo AR, Lucio-Romero RA, Bermúdez-Gallegos K. Analysis of the cost-effectiveness of carbetocin for the prevention of hemorrhage following cesarean delivery in Ecuador. J Comp Eff Res. 2017;6(6):529-536.](http://paperpile.com/b/JytdKk/hbAnx)


    11.	[Observatorio Peruano de Productos Farmacéuticos. SISTEMA NACIONAL DE INFORMACIÓN DE PRECIOS DE PRODUCTOS FARMACÉUTICOS - SNIPPF. Accessed September 17, 2023. https://opm-digemid.minsa.gob.pe/#/consulta-producto](http://paperpile.com/b/JytdKk/5ZiWw)


    12.	[Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/JytdKk/YGf4s)


    13.	[Extended National Consumer Price Index. Instituto Brasileiro de Geografia e Estatística. Accessed September 17, 2023. https://www.ibge.gov.br/en/statistics/economic/prices-and-costs/17129-extended-national-consumer-price-index.html?=&t=o-que-e](http://paperpile.com/b/JytdKk/9fxJg)


    14.	[Índice de precios al consumidor (IPC). Banco de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/indice-precios-consumidor-ipc](http://paperpile.com/b/JytdKk/zY09D)


    15.	[Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/JytdKk/08fDA)


    16.	[Índice de Precios al Consumidor. Instituto Nacional de Estadística y Censos. Accessed September 17, 2023. https://www.ecuadorencifras.gob.ec/indice-de-precios-al-consumidor/](http://paperpile.com/b/JytdKk/KAJqD)


    17.	[Índice Nacional de Precios al Consumidor (INPC). Instituto Nacional de Estadística y Geografía (INEGI). Accessed September 17, 2023. https://www.inegi.org.mx/temas/inpc/](http://paperpile.com/b/JytdKk/D4oTg)


    18.	[Gerencia Central de Estudios Económicos. ÍNDICE DE PRECIOS AL CONSUMIDOR (IPC). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/anuales/resultados/PM05197PA/html/1950/2023/](http://paperpile.com/b/JytdKk/DoquU)


    19.	[Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/JytdKk/8HqGB)


    20.	[Converter 1 Dólar dos EUA para Real brasileiro. Conversor de moeda XE. Accessed September 17, 2023. https://www.xe.com/pt/currencyconverter/convert/?Amount=1&From=USD&To=BRL](http://paperpile.com/b/JytdKk/EY2Ut)


    21.	[de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/JytdKk/GKoMP)


    22.	[Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/JytdKk/OItqy)


    23.	[Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/JytdKk/tfqXI)


    24.	[Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/JytdKk/5KZK0)


    25.	[Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/JytdKk/JifvH)


    26.	[Moreno M, Aurelio M, Castro H. Manual metodológico para la elaboración de Evaluaciones Económicas. IETS. Accessed December 26, 2023. https://www.iets.org.co/Archivos/64/Manual_evaluacion_economica.pdf](http://paperpile.com/b/JytdKk/8T9T)


    27.	[Number of births (thousands). Accessed September 18, 2023. https://www.who.int/data/maternal-newborn-child-adolescent-ageing/indicator-explorer-new/MCA/number-of-births-(thousands)](http://paperpile.com/b/JytdKk/lJp3e)


    28.	[World Population Prospects - Population Division - United Nations. Accessed September 19, 2023. https://population.un.org/wpp/Download/Standard/MostUsed/](http://paperpile.com/b/JytdKk/NPLsq)


    29.	[Data Warehouse. UNICEF DATA. Cross-sector indicators Indicator: Institutional deliveries - percentage of deliveries in a health facility. Published October 31, 2019. Accessed September 15, 2023. https://data.unicef.org/resources/data_explorer/unicef_f/?ag=UNICEF&df=GLOBAL_DATAFLOW&ver=1.0&dq=ARG+BRA+CHL+COL+CRI+ECU+MEX+PER.MNCH_INSTDEL..&startPeriod=2007&endPeriod=2022&lastnobservations=1](http://paperpile.com/b/JytdKk/JHNqD)


    30.	[Data Warehouse. UNICEF DATA. Indicator: Maternal mortality ratio (number of maternal deaths per 100,000 live births) Data Source: WHO, UNICEF, UNFPA, World Bank Group and UNPD (MMEIG) - February 2023 Time period: 2020. Published October 31, 2019. Accessed September 15, 2023. https://data.unicef.org/resources/data_explorer/unicef_f/?ag=UNICEF&df=MNCH&ver=1.0&dq=ARG+BRA+CHL+COL+CRI+ECU+MEX+PER.MNCH_MMR.......&startPeriod=2016&endPeriod=2022&lastnobservations=1](http://paperpile.com/b/JytdKk/U0FCq)


    31.	[de Souza M de L, Laurenti R, Knobel R, Monticelli M, Brüggemann OM, Drake E. Mortalidad materna en Brasil debida a hemorragia.](http://paperpile.com/b/JytdKk/U2MAH)


    32.	[Donoso E CA. El cambio del perfil epidemiológico de la mortalidad materna en Chile dificultará el cumplimiento del 5o objetivo del Milenio. Rev Med Chile Supl.](http://paperpile.com/b/JytdKk/GMljM)


    33.	[de México S de S. INFORME SEMANAL DE NOTIFICACIÓN INMEDIATA DE MUERTE MATERNA. https://www.gob.mx/cms/uploads/attachment/file/757308/MM_2022_SE35.pdf](http://paperpile.com/b/JytdKk/2poZP)


    34.	[Epidemiológico B. Boletín Epidemiológico (Lima - Perú). Published online 2016. https://www.dge.gob.pe/portal/docs/vigilancia/boletines/2016/04.pdf](http://paperpile.com/b/JytdKk/402ly)


    35.	[ex - expectation of life at age x (GHE: Life tables). Accessed September 19, 2023. https://www.who.int/data/gho/data/indicators/indicator-details/GHO/gho-ghe-life-tables-ex-expectation-of-life-at-age-x](http://paperpile.com/b/JytdKk/gT0Xd)


    36.	[Sosa CG, Althabe F, Belizán JM, Buekens P. Risk factors for postpartum hemorrhage in vaginal deliveries in a Latin-American population. Obstet Gynecol. 2009;113(6):1313-1319.](http://paperpile.com/b/JytdKk/dv0ji)


    37.	[Huque S, Roberts I, Fawole B, Chaudhri R, Arulkumaran S, Shakur-Still H. Risk factors for peripartum hysterectomy among women with postpartum haemorrhage: analysis of data from the WOMAN trial. BMC Pregnancy Childbirth. 2018;18(1):186.](http://paperpile.com/b/JytdKk/8TNSQ)


    38.	[Gülmezoglu AM, Villar J, Ngoc NT, et al. WHO multicentre randomised trial of misoprostol in the management of the third stage of labour. Lancet. 2001;358(9283):689-695.](http://paperpile.com/b/JytdKk/1xBMI)


    39.	[Salati JA, Leathersich SJ, Williams MJ, Cuthbert A, Tolosa JE. Prophylactic oxytocin for the third stage of labour to prevent postpartum haemorrhage. Cochrane Database Syst Rev. 2019;4(4):CD001808.](http://paperpile.com/b/JytdKk/cahum)


    40.	[CEA Registry. Tufts Medical Center. Accessed September 24, 2023. https://healtheconomicsdev.tuftsmedicalcenter.org/cear2/search/weight0.aspx](http://paperpile.com/b/JytdKk/rq1F7)


    41.	[Briones JR, Talungchit P, Thavorncharoensap M, Chaikledkaew U. Economic evaluation of carbetocin as prophylaxis for postpartum hemorrhage in the Philippines. BMC Health Serv Res. 2020;20(1):975.](http://paperpile.com/b/JytdKk/JsxOc)


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
   <td>Expectativa de vida al momento del parto<sup>d</sup>
   </td>
   <td>Expectativa de vida a la que se espera que una mujer llegue después de haber dado a luz, teniendo en cuenta la edad promedio de parto<sup>b</sup> y la expectativa de vida de ese grupo etario específico.<sup>c</sup>
   </td>
   <td>NU, OMS<sup><a href="https://paperpile.com/c/JytdKk/gT0Xd+NPLsq">28,35</a></sup>
   </td>
  </tr>
</table>


<sup>a</sup>ARG, BRA, CHL, COL, CRC, ECU, MEX y PER (2020).

<sup>b</sup>ARG, PER (2020); BRA (2019); CHL, ECU (2014); COL (2016); CRC (2018); MEX (2015).

<sup>c</sup>ARG, BRA, CHL, COL, CRC, ECU, MEX y PER (2019).

<sup>d</sup>El parámetro resulta de sumar la edad promedio de parto y la expectativa de vida de ese rango etario.

* Los costos de Costa Rica y México debido a que no se contó con información específica, fueron calculados mediante estimación indirecta usando el PIB per cápita de cada país y la proporción del costo buscado en el PIB per cápita de los países con información.
