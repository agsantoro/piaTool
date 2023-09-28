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

# Documentación - Evaluación del impacto epidemiológico y de costo efectividad del tratamiento de Hepatitis C crónica

-----


## 1. Definiciones/Glosario marco general

Se ha desarrollado un modelo mixto que combina un árbol de decisiones para simular la etapa de tratamiento y un modelo de transición de estados que representa la progresión de la enfermedad (MATCH: Análisis basado en Markov de Tratamientos para la Hepatitis C Crónica). Este modelo se basa en el enfoque utilizado por Aggarwal y cols. y ha servido como base para una aplicación web similar que hemos tomado como referencia, conocida como Hep C Treatment Calculator.<sup><a href="https://paperpile.com/c/6pF7hc/paaa+ce2U">1,2</a></sup>

En este modelo, una cohorte de pacientes con infección crónica por hepatitis C en diferentes etapas de fibrosis hepática (F0-F4) y sin tratamiento previo entra en un escenario de toma de decisiones donde pueden recibir tratamiento o no. De no recibirlo pasan a la siguiente fase, donde se simula la progresión natural de la enfermedad. En el grupo de pacientes que reciben tratamiento, se realiza una división inicial entre aquellos que completan el tratamiento y los que lo abandonan. Los que completan el tratamiento pueden lograr una Respuesta Viral Sostenida (RVS) o no. Se asume que los pacientes que abandonan el tratamiento o no alcanzan la RVS experimentarán la progresión natural de la hepatitis C.

La fase de transición entre estados involucra la clasificación inicial de fibrosis hepática (F0, F1, F2, F3 y F4 - cirrosis compensada -) y sus equivalentes para aquellos que han logrado la RVS (F0RVS, F1RVS, F2RVS, F3RVS, F4RVS). Los individuos pueden avanzar gradualmente desde F0 hasta llegar a F4, y aquellos en el estado F4 tienen la posibilidad de desarrollar cirrosis descompensada (CD) o carcinoma hepatocelular (CHC). A su vez, desde el estadio de CD también pueden progresar a CHC. Los pacientes con CD o CHC enfrentan un riesgo de mortalidad debido a su enfermedad hepática y pueden llegar al estado de mortalidad por hepatopatía. El estadio de cirrosis descompensada se divide en dos subestadios, uno para el primer año y otro para los años siguientes (CD1), con tasas de cáncer y mortalidad diferenciadas. Finalmente, en todos los estadios existe un riesgo de mortalidad por causas generales.

Los pacientes que logran la RVS en el tratamiento, cuando están en las etapas de fibrosis desde F0 hasta F3 (es decir, aquellos en los estadios F0RVS a F3RVS), se consideran curados y no continúan progresando en la enfermedad, teniendo la posibilidad de morir según las tasas de mortalidad de la población general. En cambio, aquellos que ya se encontraban en el estadio de cirrosis (F4RVS) al recibir el tratamiento tienen una posibilidad, aunque reducida, de desarrollar CHC o CD.

## 2. Descripción general de los parámetros

<table>
  <tr>
   <td colspan="3" >
    <strong>Tabla 1. Parámetros por países.</strong>
   </td>
  </tr>
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
   <td>Prevalencia de Hepatitis C<sup>a</sup>
   </td>
   <td>Porcentaje de personas infectadas con el VHC (mayores de 0 años).
   </td>
   <td>Polaris Observatory HCV Collaborator<sup><a href="https://paperpile.com/c/6pF7hc/7JzD">3</a></sup>
   </td>
  </tr>
  <tr>
   <td>Probabilidad de mortalidad general por edad
   </td>
   <td>Probabilidad de morir debido a causa general por edad simple.
   </td>
   <td>NU<sup><a href="https://paperpile.com/c/6pF7hc/61Bp">4</a></sup>
   </td>
  </tr>
  <tr>
   <td>F0
   </td>
   <td>Probabilidad de encontrarse en estadio de fibrosis F0 al diagnóstico. 
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>F1
   </td>
   <td>Probabilidad de encontrarse en estadio de fibrosis F1 al diagnóstico.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>F2
   </td>
   <td>Probabilidad de encontrarse en estadio de fibrosis F2 al diagnóstico. 
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>F3
   </td>
   <td>Probabilidad de encontrarse en estadio de fibrosis F3 al diagnóstico. 
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>F4
   </td>
   <td>Probabilidad de encontrarse en estadio de fibrosis F4 al diagnóstico. 
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costos de fibrosis F0 a F2
   </td>
   <td>Costos de estadíos de fibrosis F0 a F2 en el país para julio de 2023. 
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/6pF7hc/gAh8+Dgjp+xBdG+Vphr+xDQe+zu0f+CNRG">6–12</a></sup> en dólares<sup><a href="https://paperpile.com/c/6pF7hc/sfBC+cva4+vPVZ+hMs3+gf3s+NJ5n+FXvt">13–19</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup>, BRA,<sup><a href="https://paperpile.com/c/6pF7hc/WwlU">21</a></sup> COL,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup> y CHL.<sup><a href="https://paperpile.com/c/6pF7hc/NZ6o">22</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
   </td>
  </tr>
  <tr>
   <td>Costo de fibrosis F3
   </td>
   <td>Costo de estadio de fibrosis F3 en el país para julio de 2023. 
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/6pF7hc/gAh8+Dgjp+xBdG+Vphr+xDQe+zu0f+CNRG">6–12</a></sup> en dólares<sup><a href="https://paperpile.com/c/6pF7hc/sfBC+cva4+vPVZ+hMs3+gf3s+NJ5n+FXvt">13–19</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup> BRA,<sup><a href="https://paperpile.com/c/6pF7hc/WwlU">21</a></sup> COL,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup> y CHL.<sup><a href="https://paperpile.com/c/6pF7hc/NZ6o">22</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
   </td>
  </tr>
  <tr>
   <td>Costo de cirrosis compensada
   </td>
   <td>Costo de cirrosis compensada en el país para julio 2023. 
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/6pF7hc/gAh8+Dgjp+xBdG+Vphr+xDQe+zu0f+CNRG">6–12</a></sup> en dólares<sup><a href="https://paperpile.com/c/6pF7hc/sfBC+cva4+vPVZ+hMs3+gf3s+NJ5n+FXvt">13–19</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup>, BRA,<sup><a href="https://paperpile.com/c/6pF7hc/WwlU">21</a></sup> COL,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup> y CHL.<sup><a href="https://paperpile.com/c/6pF7hc/NZ6o">22</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
   </td>
  </tr>
  <tr>
   <td>Costo de cirrosis descompensada
   </td>
   <td>Costo de cirrosis descompensada en el país para julio 2023.
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/6pF7hc/gAh8+Dgjp+xBdG+Vphr+xDQe+zu0f+CNRG">6–12</a></sup> en dólares<sup><a href="https://paperpile.com/c/6pF7hc/sfBC+cva4+vPVZ+hMs3+gf3s+NJ5n+FXvt">13–19</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup>, BRA,<sup><a href="https://paperpile.com/c/6pF7hc/WwlU">21</a></sup> COL,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup>CHL<sup><a href="https://paperpile.com/c/6pF7hc/NZ6o">22</a></sup> y MEX.<sup><a href="https://paperpile.com/c/6pF7hc/Nxtq">23</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
   </td>
  </tr>
  <tr>
   <td>Costo de cáncer de hígado
   </td>
   <td>Costo de cáncer de hígado en el país para julio de 2023.
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/6pF7hc/gAh8+Dgjp+xBdG+Vphr+xDQe+zu0f+CNRG">6–12</a></sup> en dólares<sup><a href="https://paperpile.com/c/6pF7hc/sfBC+cva4+vPVZ+hMs3+gf3s+NJ5n+FXvt">13–19</a></sup> para: ARG,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup>, BRA,<sup><a href="https://paperpile.com/c/6pF7hc/WwlU">21</a></sup> COL,<sup><a href="https://paperpile.com/c/6pF7hc/SUOL">20</a></sup>CHL<sup><a href="https://paperpile.com/c/6pF7hc/NZ6o">22</a></sup> y MEX.<sup><a href="https://paperpile.com/c/6pF7hc/Nxtq">23</a></sup>
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
   </td>
  </tr>
  <tr>
   <td>Régimen de AAD (antivirales de acción directa) de 4 semanas
   </td>
   <td>Costo de tratamiento de 4 semanas de Epclusa para julio de 2023. 
   </td>
   <td>Organización Panamericana de la Salud<sup><a href="https://paperpile.com/c/6pF7hc/NSWF">24</a></sup>.
   </td>
  </tr>
  <tr>
   <td>Costo de evaluación de la respuesta al tratamiento
   </td>
   <td>Costo de la evaluación de la respuesta al tratamiento (incluye consulta con especialista, laboratorio general, entre otras) en el país para julio de 2023.
   </td>
   <td>Valores ajustados por inflación<sup><a href="https://paperpile.com/c/6pF7hc/xBdG+Dgjp">7,8</a></sup> en dólares<sup><a href="https://paperpile.com/c/6pF7hc/sfBC+cva4+vPVZ+hMs3+gf3s+NJ5n+FXvt">13–19</a></sup> para: ARG, BRA, CHL y COL.
<p>
Estimación indirecta: CRC, MEX, ECU y PER.<sup>*</sup>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" >
    <strong>Tabla 2. Parámetros globales</strong>
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
   <td>Eficacia de Sofosbuvir/ velpatasvir
<p>
(Epclusa®)
   </td>
   <td>Porcentaje de la capacidad de un tratamiento antiviral específico que combina los medicamentos Sofosbuvir y Velpatasvir para eliminar o reducir la carga viral del VHC. 
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de abandono terapéutico
   </td>
   <td>Proporción de pacientes que abandonan el tratamiento.
   </td>
   <td>Mendizabal y cols.<sup><a href="https://paperpile.com/c/6pF7hc/DIXL">5</a></sup>
   </td>
  </tr>
  <tr>
   <td>Disability Weight de CHC
   </td>
   <td>Carga de discapacidad asociada al CHC en términos de la pérdida de calidad de vida que esta enfermedad puede causar en una persona.
   </td>
   <td>OMS<sup>31</sup>
   </td>
  </tr>
  <tr>
   <td>Disability Weight de CD
   </td>
   <td>Carga de discapacidad asociada a la CD en términos de la pérdida de calidad de vida que esta enfermedad puede causar en una persona.
   </td>
   <td>OMS<sup>31</sup>
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
</table>


<sup>a</sup>Se dividió la proporción de F0-F1 por dos para obtener dos estadios distintos.


## 3. Lista de indicadores

a.  **RVS logrados:** cantidad de pacientes en la cohorte que han conseguido alcanzar la respuesta viral sostenida como resultado del tratamiento.

    Ej: **RVS logrados n=200.** En este caso, el modelo indica que tratamiento tiene el potencial de logar 200 casos de RVS en la población en estudio.

b.  **Cirrosis evitadas:** cantidad de casos de cirrosis que se logran prevenir mediante el tratamiento.

    Ej: **Cirrosis evitadas n=200.** En este caso, el modelo indica que tratamiento tiene el potencial de evitar 200 casos de cirrosis en la población en estudio.

c.  **Cirrosis decompensadas evitadas:** cantidad de casos de cirrosis descompensadas que se logran prevenir mediante el tratamiento.

    Ej: **Cirrosis decompensadas evitadas n=200.** En este caso, el modelo indica que tratamiento tiene el potencial de evitar 200 casos de cirrosis descompensada en la población en estudio.

d.  **Carcinomas hepatocelulares evitados:** cantidad de casos de carcinoma hepatocelular que se logran prevenir mediante el tratamiento.

    Ej: **Carcinomas hepatocelulares evitados n=200.** En este caso, el modelo indica que tratamiento tiene el potencial de evitar 200 casos de carcinomas hepatocelulares en la población en estudio.

e.  **Muertes por hepatopatias evitadas:** cantidad de muertes por enfermedades hepáticas que se logran prevenir mediante el tratamiento.

    Ej: **Muertes por hepatopatias evitadas n=200.** En este caso, el modelo indica que el tratameinto tiene el potencial de evitar 200 muertes por hepatopatias en la población en estudio.

f.  **AVAD por discapacidad evitados:** Reducción en el número de AVAD debidos al tratamiento de hepatitis C.

    Ej: **AVAD por discapacidad evitados: n=200.** En este caso, el modelo indica que la intervención propuesta tiene el potencial de prevenir una pérdida de 200 AVAD en la población en estudio.

g.  **Años de vida salvados:** cantidad de años de vida ganados al prevenir muertes debido a por hepatopatia.

    Ej: **Años de vida salvados n=200.** En este caso, el modelo indica que la intervención propuesta tiene el potencial de prevenir la pérdida de 200 años de vida en la población en estudio.

h.  **Diferencia de costos:** Diferencia de costos entre la rama tratamiento y no tratamiento.

i.  **Razón de costo incremental por RVS:** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad de RVS (intervención vs no intervención)

j.  **Razón de costo incremental por cirrosis evitada:** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad de cirrosis evitada (intervención vs no intervención)

k.  **Razón de costo incremental por cirrosis descompensada evitada:** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad de cirrosis evitada (intervención vs no intervención)

l.  **Razón de costo incremental por carcinoma hepatocelular evitado:** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad en carcinoma hepatocelular evitada (intervención vs no intervención)

m.  **Razón de costo incremental por muerte por hepatopatía evitada:** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad en muerte por hepatopatía evitada (intervención vs no intervención)

n.  **Razón de costo incremental por Años de Vida Ajustados por Calidad (AVAC):** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad en AVAC (intervención vs no intervención)

o.  **Razón de costo incremental por Año de Vida Salvado (AVG):** diferencia en costos (intervención vs no intervención) dividido diferencia en efectividad en AVS (intervención vs no intervención)

p.  **Retorno de Inversión:** se define como los ingresos menos la inversión, divido la inversión.

**Referencias**

```         
1.  [Chhatwal J. Hep C Treatment Calculator. Accessed September 26, 2023. https://www.hepccalculator.org/about-the-calculators/calculator](http://paperpile.com/b/6pF7hc/paaa)


2.  [Aggarwal R, Chen Q, Goel A, et al. Cost-effectiveness of hepatitis C treatment using generic direct-acting antivirals available in India. PLoS One. 2017;12(5):e0176503. doi:10.1371/journal.pone.0176503](http://paperpile.com/b/6pF7hc/ce2U)


3.  [Polaris Observatory HCV Collaborators. Global change in hepatitis C virus prevalence and cascade of care between 2015 and 2020: a modelling study. Lancet Gastroenterol Hepatol. 2022;7(5):396-415. doi:10.1016/S2468-1253(21)00472-6](http://paperpile.com/b/6pF7hc/7JzD)


4.  [World Population Prospects - Population Division - United Nations. Accessed September 20, 2023. https://population.un.org/wpp/Download/Standard/Mortality/](http://paperpile.com/b/6pF7hc/61Bp)


5.  [Mendizabal M, Piñero F, Ridruejo E, et al. Disease Progression in Patients With Hepatitis C Virus Infection Treated With Direct-Acting Antiviral Agents. Clin Gastroenterol Hepatol. 2020;18(11):2554-2563.e3. doi:10.1016/j.cgh.2020.02.044](http://paperpile.com/b/6pF7hc/DIXL)


6.  [Extended National Consumer Price Index. Instituto Brasileiro de Geografia e Estatística. Accessed September 17, 2023. https://www.ibge.gov.br/en/statistics/economic/prices-and-costs/17129-extended-national-consumer-price-index.html?=&t=o-que-e](http://paperpile.com/b/6pF7hc/gAh8)


7.  [Calculadora IPC. Instituto Nacional de Estadística. Accessed September 15, 2023. https://calculadoraipc.ine.cl/](http://paperpile.com/b/6pF7hc/Dgjp)


8.  [Índice de precios al consumidor (IPC). Banco de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/indice-precios-consumidor-ipc](http://paperpile.com/b/6pF7hc/xBdG)


9.  [Índice de precios al consumidor (IPC). Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=2732](http://paperpile.com/b/6pF7hc/Vphr)


10. [Índice de Precios al Consumidor. Instituto Nacional de Estadística y Censos. Accessed September 17, 2023. https://www.ecuadorencifras.gob.ec/indice-de-precios-al-consumidor/](http://paperpile.com/b/6pF7hc/xDQe)


11. [Índice Nacional de Precios al Consumidor (INPC). Instituto Nacional de Estadística y Geografía (INEGI). Accessed September 17, 2023. https://www.inegi.org.mx/temas/inpc/](http://paperpile.com/b/6pF7hc/zu0f)


12. [Gerencia Central de Estudios Económicos. ÍNDICE DE PRECIOS AL CONSUMIDOR (IPC). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/anuales/resultados/PM05197PA/html/1950/2023/](http://paperpile.com/b/6pF7hc/CNRG)


13. [Evolución de una moneda. Banco Central de la República Argentina. Accessed September 17, 2023. https://www.bcra.gob.ar/PublicacionesEstadisticas/Evolucion_moneda.asp](http://paperpile.com/b/6pF7hc/sfBC)


14. [Converter 1 Dólar dos EUA para Real brasileiro. Conversor de moeda XE. Accessed September 17, 2023. https://www.xe.com/pt/currencyconverter/convert/?Amount=1&From=USD&To=BRL](http://paperpile.com/b/6pF7hc/cva4)


15. [de Datos Estadísticos (BDE) B. Tipos de Cambio. Banco Central Chile. Accessed September 17, 2023. https://si3.bcentral.cl/siete/ES/Siete/Cuadro/CAP_TIPO_CAMBIO/MN_TIPO_CAMBIO4/DOLAR_OBS_ADO](http://paperpile.com/b/6pF7hc/vPVZ)


16. [Tasa Representativa del Mercado (TRM - Peso por dólar). Banco Central de la República | Colombia. Accessed September 17, 2023. https://www.banrep.gov.co/es/estadisticas/trm](http://paperpile.com/b/6pF7hc/hMs3)


17. [Tipo cambio de compra y de venta del dólar de los Estados Unidos de América. Banco Central de Costa Rica. Accessed September 17, 2023. https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?idioma=1&CodCuadro=%20400](http://paperpile.com/b/6pF7hc/gf3s)


18. [Portal del mercado cambiario. Banco de México. Accessed September 17, 2023. https://www.banxico.org.mx/tipcamb/main.do?page=tip&idioma=sp](http://paperpile.com/b/6pF7hc/NJ5n)


19. [Gerencia Central de Estudios Económicos. DÓLAR AMERICANO (US$). BANCO CENTRAL DE RESERVA DEL PERÚ. Accessed September 15, 2023. https://estadisticas.bcrp.gob.pe/estadisticas/series/mensuales/resultados/PN01234PM/html](http://paperpile.com/b/6pF7hc/FXvt)


20. [Bardach A, Hernández-Vásquez A, Palacios A, et al. Epidemiology, Use of resources, and Costs of Medical Management of Hepatitis C in Argentina, Colombia, Uruguay, and Venezuela. Value in Health Regional Issues. 2019;20:180-190. doi:10.1016/j.vhri.2019.06.004](http://paperpile.com/b/6pF7hc/SUOL)


21. [Benzaken AS, Girade R, Catapan E, et al. Hepatitis C disease burden and strategies for elimination by 2030 in Brazil. A mathematical modeling approach. Braz J Infect Dis. 2019;23(3):182-190. doi:10.1016/j.bjid.2019.04.010](http://paperpile.com/b/6pF7hc/WwlU)


22. [Vargas CL, Espinoza MA, Giglio A, Soza A. Cost Effectiveness of Daclatasvir/Asunaprevir Versus Peginterferon/Ribavirin and Protease Inhibitors for the Treatment of Hepatitis c Genotype 1b Naïve Patients in Chile. PLoS One. 2015;10(11):e0141660. doi:10.1371/journal.pone.0141660](http://paperpile.com/b/6pF7hc/NZ6o)


23. [Marquez LK, Fleiz C, Burgos JL, et al. Cost-effectiveness of hepatitis C virus (HCV) elimination strategies among people who inject drugs (PWID) in Tijuana, Mexico. Addiction. 2021;116(10):2734-2745. doi:10.1111/add.15456](http://paperpile.com/b/6pF7hc/Nxtq)


24. [Productos y precios del Fondo Estratégico. Organización Panamericana de la Salud. Accessed September 25, 2023. https://www.paho.org/es/fondo-estrategico-ops/productos-precios](http://paperpile.com/b/6pF7hc/NSWF)


27. Thein H, Yi Q, Dore G, et al. Estimation of stage specific fibrosis progression rates in chronic hepatitis C virus infection: A meta analysis and meta regression. Hepatology 2008;48:418-431.


28. Fattovich G, Giustina G, Degos F, et al. Morbidity and mortality in compensated cirrhosis type C: a retrospective follow-up study of 384 patients. Gastroenterology 1997;112:463-472.

29. Cardoso AC, Moucari R, Figueiredo-Mendes C, et al. Impact of peginterferon and ribavirin therapy on hepatocellular carcinoma: incidence and survival in hepatitis C patients with advanced fibrosis. Journal of Hepatology 2010;52:652-657.

30. Planas R, Ballesté B, Antonio Álvarez M, et al. Natural history of decompensated hepatitis C virus-related cirrhosis. A study of 200 patients. Journal of Hepatology 2004;40:823-830.

31. World Health Organization, Geneva. "WHO methods and data sources for global burden of disease estimates 2000-2011.
```
