

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


<h1>Documentación - Evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el VPH</h1>


---



<h3>1. Definiciones/Glosario marco general</h3>

La herramienta Papillomavirus Rapid Interface for Modelling and Economics (PRIME) es un modelo para evaluar el impacto en la salud y la relación costo-efectividad de la vacunación contra el virus del papiloma humano (VPH) en niñas para la prevención del cáncer de cuello uterino.<sup><a href="https://paperpile.com/c/ArO7rc/oDTDH">1</a></sup> Fue desarrollada por investigadores de la Escuela de Higiene y Medicina Tropical de Londres y la Université Laval en Quebec, en colaboración con la Organización Mundial de la Salud (OMS) en Ginebra. Esta herramienta permite evaluar la magnitud de la carga del cáncer cervicouterino, el impacto del aumento de cobertura de la vacunación contra el VPH para las niñas antes del debut sexual, los costos de atención médica incurridos como resultado del tratamiento del cáncer de cuello uterino, los costos asociados con la vacunación y los posibles ahorros que pueden resultar de un aumento de cobertura de la vacunación. Sin embargo, no permite evaluar la inmunidad de rebaño ni el impacto de la vacunación masculina. Por este motivo se asume que PRIME estima los beneficios para la salud estimados de la vacunación contra el VPH en niñas de 9 a 14 años de manera conservadora. 

La herramienta PRIME ha sido validada mediante la revisión de 17 estudios publicados llevados a cabo en países de ingresos bajos y medianos. La OMS, a través de su Comité Asesor de Investigación e Implementación de Vacunas, respalda este modelo para proporcionar una estimación cautelosa del impacto en la salud y la relación costo-efectividad de la vacunación de niñas antes de que inicien su actividad sexual. Además, PRIME ha sido utilizado para evaluar el impacto de las inversiones en vacunas realizadas por Gavi, la Alianza para las Vacunas, en 97 países, así como a nivel nacional.<sup><a href="https://paperpile.com/c/ArO7rc/ew0N0+vXk2A">2,3</a></sup>

PRIME es un modelo estático de impacto proporcional que calcula el impacto de la vacunación en cohortes de diferentes edades. Estima la reducción en la incidencia, prevalencia y mortalidad del cáncer de cuello uterino en función de la cobertura de vacunación, la eficacia de la vacuna y la distribución de los tipos de VPH de alto riesgo (VPH 16/18 para vacunas bivalentes y cuadrivalentes, y VPH 16/18/31/33/45/52/58 para la vacuna monovalente). Para este análisis se definió una ​cohorte cerrada que evalúa resultados del seguimiento de una cohorte de mujeres de 12 años a lo largo de toda su vida. El aumento de cobertura proyectada es del 30% desde el porcentaje de cobertura actual (basal) en términos absolutos o hasta alcanzar un 90% absoluto de cobertura. En caso de que la cobertura basal de algún país fuera estimada en 90%, se consideró como cobertura meta proyectada un valor de 95%.

Para el caso de los costos, los costos directos médicos anuales atribuidos al cáncer de cuello fueron calculados (con excepción del caso de Chile y Costa Rica, (ver Tabla 2) mediante la metodología utilizada en estudio publicado por Chen y cols.<sup><a href="https://paperpile.com/c/ArO7rc/PLwcT">4</a></sup>, la cual consiste en ajustar con base al producto interno bruto (PIB) per cápita y la prevalencia de cada uno de los países de análisis los costos de cáncer de cuello publicados en el estudio de Dieleman y cols.<sup><a href="https://paperpile.com/c/ArO7rc/vZQsG">5</a></sup> Los costos de la vacuna contra el VPH fueron tomados de los precios definidos para el 2020 por el Programa Ampliado de Inmunizaciones (PAI) de la OPS<sup><a href="https://paperpile.com/c/ArO7rc/uFSeP">6</a></sup> y ajustados a 2023 mediante la inflación de Estados Unidos. Los costos de transporte, almacenamiento y aplicación fueron asumidos como el 37% del valor del esquema completo de vacunación por niña siguiendo a Jit y cols. (2014).<sup><a href="https://paperpile.com/c/ArO7rc/oDTDH">1</a></sup>

Si bien la herramienta proporciona datos basales para todos los países para el año 2014, se actualizaron los datos que se consideraron pertinentes para este análisis.

Por otro lado es de mencionar que estos parámetros son los parámetros basales que se utilizan planificandose que los mismos puedan ser modificados por el usuario en la herramienta final a ser desarrollada durante el proyecto.





 <h3>2. Descripción general de los inputs (tablas) </h3>

   <h4> Tabla 1. Parámetros epidemiológicos </h4>


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
   <td>Tamaño de la cohorte de nacimiento (femenino)
   </td>
   <td>Número de niñas nacidas en un año.
   </td>
   <td>Instituto de estadística de cada uno de los 8 países
   </td>
  </tr>
  <tr>
   <td>Tamaño de la cohorte en edad de vacunación (mujeres)
   </td>
   <td>Número de niñas de 12 años (población objetivo) en un año.
   </td>
   <td>Instituto de estadística de cada uno de los 8 países (ver tabla 13.b)
   </td>
  </tr>
  <tr>
   <td>Cobertura dos dosis
   </td>
   <td>Porcentaje de cobertura actual de vacunación contra VPH.
   </td>
   <td>Nogueira-Rodrigues y cols. (2022)<sup><a href="https://paperpile.com/c/ArO7rc/eMVU9">7</a></sup>
   </td>
  </tr>
  <tr>
   <td>Eficacia de la vacuna contra el VPH 16/18
   </td>
   <td>Proporción de mujeres vacunadas que están protegidas contra VPH 16/18, en comparación con las no vacunadas
<p>
 (*)
   </td>
   <td>Arbyn y cols. (2018)<sup><a href="https://paperpile.com/c/ArO7rc/kZ0Ot">8</a></sup>
   </td>
  </tr>
  <tr>
   <td>Grupo de edad objetivo
   </td>
   <td>Edad objetivo a la que va destinada la vacunación (12 años).
   </td>
   <td>Asunción
   </td>
  </tr>
  <tr>
   <td>Peso de discapacidad por diagnóstico de cáncer de cuello uterino
   </td>
   <td>Carga de discapacidad que una persona experimenta debido al diagnóstico de cáncer de cuello uterino.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/ArO7rc/EZR8E">9</a></sup>
   </td>
  </tr>
  <tr>
   <td>Peso de discapacidad por secuelas de cáncer de cuello uterino
   </td>
   <td>Carga de discapacidad que una persona experimenta debido a secuelas de cáncer de cuello uterino.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/ArO7rc/EZR8E">9</a></sup>
   </td>
  </tr>
  <tr>
   <td>Peso de discapacidad para cáncer de cuello uterino terminal.
   </td>
   <td>Carga de discapacidad que una persona experimenta debido a cáncer a cuello uterino terminal.
   </td>
   <td>Global Burden of Disease<sup><a href="https://paperpile.com/c/ArO7rc/EZR8E">9</a></sup>
   </td>
  </tr>
</table>


(*) A modo de ser conservadores hemos optado por este valor de eficacia de la vacuna, extraído de una población de mujeres mayores de 15 años, por lo que se estima que muchas de ellas habrían ya tenido relaciones sexuales al momento del estudio.

<h4>Tabla 2. Parámetros de costos.</h4>


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
   <td>Costo de la vacuna
   </td>
   <td>Costo de la vacuna por niña completamente inmunizada para abril de 2023.
   </td>
   <td>PAI OPS 2020 actualizado por inflación.<sup><a href="https://paperpile.com/c/ArO7rc/uFSeP">6</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costos administrativos de la vacuna
   </td>
   <td>Costo de administración de la vacuna por niña completamente inmunizada para abril de 2023.
   </td>
   <td>Asunción según Jit y cols.<sup><a href="https://paperpile.com/c/ArO7rc/oDTDH">1</a></sup>
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
   <td>Costo del tratamiento del cáncer por episodio a lo largo de la vida, para abril de 2023.
   </td>
   <td>Gómez y cols.<sup><a href="https://paperpile.com/c/ArO7rc/4u9c">10</a></sup>: CHL y CRC<sup>*</sup>.
<p>
Estimación indirecta<sup>**</sup>: ARG, BRA, COL, ECU, MEX y PER.
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento
   </td>
   <td>Tasa de descuento del 3% utilizada en el modelo.
   </td>
   <td>Bill and Melinda Gates Foundation.<sup><a href="https://paperpile.com/c/ArO7rc/VgGX">11</a></sup>
   </td>
  </tr>
</table>


(*) Para Costa Rica se asume el mismo valor que en Chile.

(**) Los costos de Argentina, Brasil, Colombia, Ecuador, México y Perú  fueron calculados con base en el estudio de Gómez y cols. ajustando al PIB per cápita de cada país y a la prevalencia de cáncer de cuello uterino en cada país, mediante la metodología de estimación indirecta.





 <h3>3. Lista de indicadores, para cada indicador </h3>
 
a. **Cánceres de cuello uterino prevenidos:** número de cánceres de cuello uterino prevenidos tras la intervención.

    Ej: **Cánceres de cuello uterino prevenidos n=200. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar 200 casos de cáncer de cuello uterino en la población en estudio.

b. **Muertes prevenidas**: número de muertes prevenidas tras la implementación de la intervención. 

    Ej: **Muertes prevenidas n=200. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de prevenir 200 muertes en la población en estudio. 

c. **Años de vida por muerte prematura evitados:** ** **especifica la cantidad de años que se preservarían al evitar muertes prematuras causadas por el cáncer de cuello uterino en la población.

    Ej: **Años de vida por muerte prematura  evitados n=1500. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de 1500 años debido a muertes prematuras en la población en estudio. 

d. **Años de vida por discapacidad evitados:** especifica la cantidad de años que se salvarían de la carga de discapacidad causada por el cáncer de cuello uterino en la población.

    Ej: **Años de vida por discapacidad evitados n=1500. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de evitar la pérdida de 1500 años debida a la discapacidad en la población en estudio.

e. **Costo de la vacunación:** se calcula multiplicando la cantidad de niñas de 12 años incluidas de la muestra, los costos totales de vacunación (costos de la vacuna, de aplicación y de entrega), por el aumento de la cobertura de la vacunación contra el VPH. 
f. **Costos de tratamiento ahorrados:** los costos de tratamiento ahorrados se calcula multiplicando el costo de tratamiento de cáncer por el número de casos evitados gracias a la vacunación.
g. **Costo neto:** es la diferencia entre el costo de vacunación y los costos de tratamiento ahorrados.
h. **Costo incremental por cáncer de cuello uterino prevenido:** se reporta para los países cuyo costo neto ha sido positivo.
i. **Costo incremental por año de vida salvado:** se calcula para los países cuyo costo neto ha sido positivo.
j. **Costo incremental por AVAD prevenido:** se calcula para los países cuyo costo neto ha sido positivo.
k. **Retorno de la inversión: **se define como los ingresos menos la inversión, divido la inversión.



<h3>Referencias</h3>


    1.	[Jit M, Brisson M, Portnoy A, Hutubessy R. Cost-effectiveness of female human papillomavirus vaccination in 179 countries: a PRIME modelling study. Lancet Glob Health. 2014;2(7):e406-e414. doi:10.1016/S2214-109X(14)70237-2](http://paperpile.com/b/ArO7rc/oDTDH)


    2.	[Jit M, Brisson M. Potential lives saved in 73 countries by adopting multi‐cohort vaccination of 9–14‐year‐old girls against human papillomavirus. International Journal of Cancer. Published online 2018. https://onlinelibrary.wiley.com/doi/abs/10.1002/ijc.31321](http://paperpile.com/b/ArO7rc/ew0N0)


    3.	[Abbas KM, van Zandvoort K, Brisson M, Jit M. Effects of updated demography, disability weights, and cervical cancer burden on estimates of human papillomavirus vaccination impact at the global, regional, and national levels: a PRIME modelling study. Lancet Glob Health. 2020;8(4):e536-e544. doi:10.1016/S2214-109X(20)30022-X](http://paperpile.com/b/ArO7rc/vXk2A)


    4.	[Chen S, Cao Z, Prettner K, et al. Estimates and Projections of the Global Economic Cost of 29 Cancers in 204 Countries and Territories From 2020 to 2050. JAMA Oncol. 2023;9(4):465-472. doi:10.1001/jamaoncol.2022.7826](http://paperpile.com/b/ArO7rc/PLwcT)


    5.	[Dieleman JL, Cao J, Chapin A, et al. US Health Care Spending by Payer and Health Condition, 1996-2016. JAMA. 2020;323(9):863-884. doi:10.1001/jama.2020.0734](http://paperpile.com/b/ArO7rc/vZQsG)


    6.	[Precios de Programa Ampliado de Inmunizaciones -PAI- 2020. Accessed June 15, 2023. https://www.paho.org/es/file/82792/download?token=Mm5JrLtu](http://paperpile.com/b/ArO7rc/uFSeP)


    7.	[Nogueira-Rodrigues A. HPV Vaccination in Latin America: Global Challenges and Feasible Solutions. Am Soc Clin Oncol Educ Book. 2019;39:e45-e52. doi:10.1200/EDBK_249695](http://paperpile.com/b/ArO7rc/eMVU9)


    8.	[Arbyn M, Xu L, Simoens C, Martin-Hirsch PP. Prophylactic vaccination against human papillomaviruses to prevent cervical cancer and its precursors. Cochrane Database Syst Rev. 2018;5(5). doi:10.1002/14651858.CD009069.pub3](http://paperpile.com/b/ArO7rc/kZ0Ot)


    9.	[Global Burden of Disease (GBD). Institute for Health Metrics and Evaluation. Published March 29, 2014. Accessed June 15, 2023. https://www.healthdata.org/gbd](http://paperpile.com/b/ArO7rc/EZR8E)


    10.	[Gomez JA, Lepetic A, Demarteau N. Health economic analysis of human papillomavirus vaccines in women of Chile: perspective of the health care payer using a Markov model. BMC Public Health. 2014;14:1222. doi:10.1186/1471-2458-14-1222](http://paperpile.com/b/ArO7rc/4u9c)


    11.	[Bill and Melinda Gates Foundation Methods for Economic Evaluation Project (MEEP). NICE International. https://www.idsihealth.org/wp-content/uploads/2016/05/Gates-Reference-case-what-it-is-how-to-use-it.pdf](http://paperpile.com/b/ArO7rc/VgGX)
