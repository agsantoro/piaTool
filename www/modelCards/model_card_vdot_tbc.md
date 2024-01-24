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

# Model Card: Tratamiento de Observación Directa por Video para Tuberculosis


---


## Introducción

La tuberculosis sigue siendo un reto significativo para la salud global.<sup><a href="https://paperpile.com/c/W3ldUH/TBGNF">1</a></sup> El tratamiento autosupervisado es un enfoque estándar donde los pacientes son responsables de su propio tratamiento, confiando en su capacidad y compromiso para seguir el régimen terapéutico sin supervisión externa. Este método contrasta con el Tratamiento de Observación Directa (DOT, su sigla del inglés _Directly Observed Therapy_), que requiere que un profesional de salud o una persona designada supervise directamente la ingesta de medicación del paciente.<sup><a href="https://paperpile.com/c/W3ldUH/BTOSn">2</a></sup> Aunque el DOT es efectivo, enfrenta desafíos como la alta demanda de recursos y esfuerzos por parte de los servicios de salud, pacientes y sus familias, llevando a veces a baja adherencia al tratamiento, especialmente en comunidades marginadas. El DOT presencial puede ser logísticamente complicado, interferir en la vida cotidiana del paciente, y causar estigma. Estas dificultades se intensifican en situaciones adversas como mal tiempo, desastres naturales o pandemias. Frente a estas limitaciones, han emergido enfoques centrados en el paciente, destacándose el tratamiento de observación directa por video (vDOT, su sigla del inglés _Video Directly Observed Therapy_) como una alternativa tecnológica prometedora.<sup><a href="https://paperpile.com/c/W3ldUH/BTOSn+jdqzE">2,3</a></sup>

El vDOT integra ventajas notables como la comodidad para pacientes y enfermeros, reducción en costos y tiempo de desplazamiento del personal, y una menor tasa de abandono del tratamiento, con el uso de tecnología de video para supervisión de pacientes. Este método implica monitorear a los pacientes tomando sus medicamentos a través de videos, ya sean grabaciones asincrónicas o en vivo, utilizando dispositivos como smartphones, tabletas o computadoras. Esta innovadora estrategia ha demostrado ser efectiva y viable, alineándose con una mayor adherencia al tratamiento. Además, el vDOT permite manejar un mayor número de pacientes con tuberculosis por cada observador de tratamiento en comparación con el método tradicional basado en la comunidad, manteniendo elevados niveles de satisfacción en los pacientes. Este enfoque destaca la importancia y el impacto de la tecnología en la mejora de la gestión y eficacia del tratamiento de condiciones críticas como la tuberculosis.<sup><a href="https://paperpile.com/c/W3ldUH/BfSdg">4</a></sup>


## Nombre del modelo

vDOT para tuberculosis.


## Descripción del modelo y asunciones

Este modelo estático de árbol de decisiones compara tres escenarios: tratamiento con vDOT, DOT, y tratamiento autosupervisado de medicación. Inspirado en el modelo de vDOT descripto por Fekadu y cols,<sup><a href="https://paperpile.com/c/W3ldUH/43v6c">5</a></sup> se analiza una cohorte hipotética de pacientes sin comorbilidades. En el escenario de autosupervisado, los pacientes toman todas las dosis de los fármacos sin supervisión. Por otro lado, el DOT implica que los pacientes acudan a un centro de salud para tomar la medicación bajo la observación de un profesional sanitario. El vDOT, en cambio, permite la supervisión a través de video.

En el modelo, los pacientes son expuestos a estas intervenciones, y se evalúa la posibilidad de un tratamiento exitoso, definido según la Organización Mundial de la Salud (OMS) como la curación o la finalización del tratamiento sin señales de fracaso.<sup><a href="https://paperpile.com/c/W3ldUH/A9OM">6</a></sup> Un tratamiento exitoso implica que el paciente continúe su vida normal por el resto del año, que es el horizonte temporal del modelo. En caso contrario, se consideran distintos desenlaces, como la muerte (asumiendo que ocurre a la mitad del año tras 3 meses de tratamiento), el fracaso del tratamiento (se asume que se pierden a mitad del tratamiento), y la pérdida de seguimiento (se asume que se pierden a mitad del tratamiento). Los pacientes que presentan falla terapéutica requerirán continuar con tratamiento por lo que dura el horizonte temporal y estarán expuestos a complicaciones, mientras que los que pierden el seguimiento estarán expuestos a consumo de recursos de salud como consultas a emergencias y se asume que un 25% reiniciará en algún momento del año el tratamiento. Se asume que los pacientes presentan la utilidad de tuberculosis durante la duración del tratamiento o durante la pérdida de seguimiento y la de la población general una vez completado el esquema en el grupo de tratamiento exitoso.

En cuanto a los costos, se incluyen los del tratamiento, seguimiento y estudios complementarios. Para los pacientes con fracaso terapéutico, se añaden los costos de hospitalización por complicaciones mientras que para los de pérdida de seguimiento, se agregan consultas de emergencia. El costeo de vDOT y DOT se basó en el salario por hora de enfermería. Utilizando estudios previos, estimamos el costo por tiempo empleado en cada evento de DOT y vDOT. Para DOT, también se incluyó el costo del transporte del trabajador de salud al centro, basado en un viaje en transporte público en la capital de cada país. En cambio, para vDOT, al ser remoto, este costo no se consideró. Todos estos cálculos se realizaron desde la perspectiva del sistema de salud, sin incluir costos de bolsillo para los pacientes." 


## Limitaciones y consideraciones

El modelo se enfoca exclusivamente en pacientes con tuberculosis pulmonar sin comorbilidades. No considera otros aspectos de la enfermedad o características específicas de los pacientes, que podrían influir en la duración del tratamiento, su seguimiento y los resultados. Por ejemplo, no se abordan comorbilidades como la diabetes mellitus o la infección por el virus de la inmunodeficiencia humana. Además, su limitado alcance temporal impide el análisis de efectos a largo plazo en pacientes que sufren fracaso terapéutico o pérdida de seguimiento.

Desde una perspectiva económica, la estimación de costos para Costa Rica, Ecuador, México y Perú se llevó a cabo a través de un método de estimación indirecta, basado en el Producto Interno Bruto (PIB) de cada país, debido a la falta de información específica de costos disponible para estos países. Además, para la definición de los esquemas de tratamiento y cantidad de exámenes que se hacen en el seguimiento, se hicieron simplificaciones con base a literatura y  guías de práctica clínica de Argentina, asumiéndose igual para todos los países. Además, en el caso de costo de supervisión de un evento de DOT y de vDOT, al no contar con información específica de costos de estos eventos, se utilizó una aproximación mediante el costo de una hora de enfermería.


## Descripción general de los parámetros


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
   <td>Riesgo relativo tratamiento exitoso vDOT vs DOT
   </td>
   <td>Riesgo relativo de éxito en el tratamiento de la tuberculosis al comparar vDOT con el DOT.
   </td>
   <td>Ridho y cols.<sup><a href="https://paperpile.com/c/W3ldUH/ATdT2">8</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de adherencia a vDOT
   </td>
   <td>Porcentaje que refleja la adherencia adecuada al vDOT para la tuberculosis, estableciendo que un paciente cumple con el tratamiento de manera correcta si asiste y completa al menos el 80% de las sesiones de medicación supervisadas.
   </td>
   <td>Story y cols.<sup><a href="https://paperpile.com/c/W3ldUH/GyU93">9</a></sup>
   </td>
  </tr>
  <tr>
   <td>Cantidad de dosis supervisadas mediante vDOT por semana
   </td>
   <td>Número total de veces que un paciente con tuberculosis recibe supervisión para la toma de sus medicamentos a través de vDOT durante una semana.
   </td>
   <td>Definido por el usuario
   </td>
  </tr>
  <tr>
   <td>Duración del tratamiento completo de la tuberculosis pulmonar (meses)
   </td>
   <td>Período total de tiempo requerido para completar un régimen terapéutico estándar para la tuberculosis pulmonar, que típicamente dura alrededor de 6 meses. Sin embargo, esta duración puede variar dependiendo de la resistencia a los medicamentos, la gravedad de la enfermedad, y otras condiciones médicas del paciente.
   </td>
   <td>OMS/OPS<sup><a href="https://paperpile.com/c/W3ldUH/lXaU">14</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de tratamiento exitoso mediante tratamiento autosupervisado
   </td>
   <td>Porcentaje de pacientes que responden positivamente al tratamiento autosupervisado  en comparación con el total de pacientes tratados para tuberculosis.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/W3ldUH/2GlOn">7</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje  de falla terapéutica dado tratamiento no exitoso mediante tratamiento autosupervisado
   </td>
   <td>Porcentaje de pacientes que responden negativamente al tratamiento autosupervisado.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/W3ldUH/2GlOn">7</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de muerte dado tratamiento no exitoso mediante tratamiento autosupervisado
   </td>
   <td>Porcentaje de pacientes que fallecen tras no responder positivamente al tratamiento autosupervisado para tuberculosis.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/W3ldUH/2GlOn">7</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo relativo de falla terapéutica con vDOT vs DOT
   </td>
   <td>Riesgo relativo de falla terapéutica en pacientes bajo vDOT frente a aquellos que reciben DOT.
   </td>
   <td>Asunción
   </td>
  </tr>
  <tr>
   <td>Riesgo relativo de muerte mediante vDOT vs DOT
   </td>
   <td>Riesgo relativo de mortalidad en pacientes bajo vDOT frente a aquellos que reciben tratamiento DOT.
   </td>
   <td>Asunción
   </td>
  </tr>
  <tr>
   <td>Riesgo Relativo del tratamiento exitoso con DOT vs tratamiento autosupervisado 
   </td>
   <td>Riesgo relativo de éxito en el tratamiento de la tuberculosis comparando el DOT con el tratamiento autosupervisado.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/W3ldUH/2GlOn">7</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo relativo de falla terapéutica del DOT vs tratamiento autosupervisado
   </td>
   <td>Riesgo relativo de falla terapéutica en pacientes bajo DOT frente a aquellos que gestionan su tratamiento autosupervisado.
   </td>
   <td>Ridolfi y cols.<sup><a href="https://paperpile.com/c/W3ldUH/AvrSh">10</a></sup>
   </td>
  </tr>
  <tr>
   <td>Riesgo relativo de muerte de DOT vs tratamiento autosupervisado
   </td>
   <td>Riesgo relativo de mortalidad en pacientes bajo DOT frente a aquellos que gestionan su tratamiento autosupervisado.
   </td>
   <td>Ridolfi y cols.<sup><a href="https://paperpile.com/c/W3ldUH/AvrSh">10</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de adherencia al DOT
   </td>
   <td>Porcentaje que refleja la adherencia adecuada al DOT para tuberculosis, estableciendo que un paciente cumple con el tratamiento de manera correcta si asiste y completa al menos el 80% de las sesiones de medicación supervisadas.
   </td>
   <td>Story y cols.<sup><a href="https://paperpile.com/c/W3ldUH/GyU93">9</a></sup>
   </td>
  </tr>
  <tr>
   <td>Cantidad de dosis supervisadas mediante DOT por semana
   </td>
   <td>Número total de veces que un paciente con tuberculosis recibe supervisión para la toma de sus medicamentos a través de DOT durante una semana.
   </td>
   <td>Definido por el usuario
   </td>
  </tr>
  <tr>
   <td>Mediana de edad de diagnóstico de tuberculosis
   </td>
   <td>Mediana de edad de los pacientes con diagnóstico de tuberculosis para el país.
   </td>
   <td>Morgado y cols.<sup><a href="https://paperpile.com/c/W3ldUH/C45Ea">12</a></sup>
   </td>
  </tr>
  <tr>
   <td>Tamaño de la cohorte
   </td>
   <td>Número de personas diagnosticadas con tuberculosis pulmonar activa sin comorbilidades en un año, que son incluidas en el análisis.
   </td>
   <td> (Cohorte hipotética)
   </td>
  </tr>
  <tr>
   <td>Utilidad de la población general
   </td>
   <td>Utilidad de la población general para la mediana de edad de tuberculosis.
   </td>
   <td>EQ-5D<sup><a href="https://paperpile.com/c/W3ldUH/RuKAt">11</a></sup>
   </td>
  </tr>
  <tr>
   <td>Disutilidad por tuberculosis activa
   </td>
   <td>Proporción de reducción en la calidad de vida que experimentan las personas afectadas por la tuberculosis activa.
   </td>
   <td>Calculado a partir del peso por discapacidad del Global Burden of Disease<sup><a href="https://paperpile.com/c/W3ldUH/7Pbw">13</a></sup>
   </td>
  </tr>
  <tr>
   <td>Porcentaje de pacientes con falla terapéutica que requieren internación
   </td>
   <td>Porcentaje de pacientes que, tras no responder satisfactoriamente al tratamiento contra la tuberculosis, requieren hospitalización.
   </td>
   <td>Asunción
   </td>
  </tr>
  <tr>
   <td>Duración de la internación por tuberculosis (días)
   </td>
   <td>Indica el número promedio de días que un paciente con tuberculosis esta hospitalizado tras no responder adecuadamente a un tratamiento inicial.
   </td>
   <td>Opinión de experto
   </td>
  </tr>
</table>



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
   <td>Costo de una consulta de vDOT (USD)
   </td>
   <td>Costo de una consulta de supervisión de una dosis de terapia directamente observada por video.
   </td>
   <td>Se asumió como una porción del costo de la hora de una enfermera para todos los países.<sup><a href="https://paperpile.com/c/W3ldUH/z5KyI">21</a>,<a href="https://paperpile.com/c/W3ldUH/fMnrU">22</a>, <a href="https://paperpile.com/c/W3ldUH/mrvkL">23</a>,<a href="https://paperpile.com/c/W3ldUH/F1m6s">24</a>,<a href="https://paperpile.com/c/W3ldUH/StVbB">25</a>,<a href="https://paperpile.com/c/W3ldUH/72AbM+qeRjo+QXkF3">26–28</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo mensual de tratamiento de inducción (USD)
   </td>
   <td>Costo mensual del tratamiento farmacológico de inducción para tuberculosis.
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/W3ldUH/QIleb">15</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo mensual tratamiento de consolidación (USD) 
   </td>
   <td>Costo mensual del tratamiento de consolidación para tuberculosis (USD oficial a tasa de cambio nominal de cada país).
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/W3ldUH/QIleb">15</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo mensual de seguimiento (USD)
   </td>
   <td>Costo mensual de controles médicos (no contempla exámenes complementarios).
   </td>
   <td>Nomencladores específicos para Argentina,<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h">16</a></sup> Brasil,<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h+c5X1Y">16,17</a></sup> Chile<sup><a href="https://paperpile.com/c/W3ldUH/AJmjX">18</a>,<a href="https://paperpile.com/c/W3ldUH/tGyhd">19</a></sup> y Colombia,<sup><a href="https://paperpile.com/c/W3ldUH/XBsSZ">20</a></sup> estimación indirecta* para Costa Rica, Ecuador, México y Perú.
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo promedio mensual de exámenes complementarios (USD)
   </td>
   <td>Costo promedio mensual de exámenes complementarios.
   </td>
   <td>Nomencladores específicos para Argentina,<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h">16</a></sup> Brasil,<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h+c5X1Y">16,17</a></sup> Chile<sup><a href="https://paperpile.com/c/W3ldUH/AJmjX">18</a>,<a href="https://paperpile.com/c/W3ldUH/tGyhd">19</a></sup> y Colombia,<sup><a href="https://paperpile.com/c/W3ldUH/XBsSZ">20</a></sup> estimación indirecta* para Costa Rica, Ecuador, México y Perú.
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de una consulta de DOT (USD)
   </td>
   <td>Costo de una consulta de supervisión de una dosis de DOT.
   </td>
   <td>Se asumió como una porción del costo de la hora de una enfermera para todos los países.<sup><a href="https://paperpile.com/c/W3ldUH/z5KyI">21</a>, <a href="https://paperpile.com/c/W3ldUH/fMnrU">22</a>, <a href="https://paperpile.com/c/W3ldUH/mrvkL">23</a>,<a href="https://paperpile.com/c/W3ldUH/F1m6s">24</a>,<a href="https://paperpile.com/c/W3ldUH/StVbB">25</a>,<a href="https://paperpile.com/c/W3ldUH/72AbM+qeRjo+QXkF3">26–28</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo promedio de 1 día de internación por tuberculosis (USD)
   </td>
   <td>Costo promedio de 1 día de internación por falla terapéutica en tuberculosis (por complicación de patología o falta de adherencia al tratamiento).
   </td>
   <td>Nomencladores específicos para Argentina,<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h">16</a></sup> Brasil,<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h+c5X1Y">16,17</a></sup> Chile<sup><a href="https://paperpile.com/c/W3ldUH/AJmjX">18</a>,<a href="https://paperpile.com/c/W3ldUH/tGyhd">19</a></sup> y Colombia,<sup><a href="https://paperpile.com/c/W3ldUH/XBsSZ">20</a></sup> estimación indirecta* para Costa Rica, Ecuador, México y Perú.
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de consulta a emergencias (USD)
   </td>
   <td>Costo de 1 consulta a emergencias en pacientes con tuberculosis activa.
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h">16</a></sup>, Brasil<sup><a href="https://paperpile.com/c/W3ldUH/I5g1h+c5X1Y">16,17</a></sup>, Chile<sup><a href="https://paperpile.com/c/W3ldUH/AJmjX">18</a>,<a href="https://paperpile.com/c/W3ldUH/tGyhd">19</a></sup> y Colombia<sup><a href="https://paperpile.com/c/W3ldUH/XBsSZ">20</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de tratamiento mensual de inducción en tuberculosis  multirresistente (USD)
   </td>
   <td>Costo mensual del tratamiento de inducción promedio para tuberculosis multirresistente.
   </td>
   <td>Fondo estratégico de la OPS<sup><a href="https://paperpile.com/c/W3ldUH/QIleb">15</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Costo de tratamiento mensual de consolidación en tuberculosis MR (USD)
   </td>
   <td>Costo mensual del tratamiento de consolidación promedio para tuberculosis multirresistente.
   </td>
   <td>Fondo estratégico de la OPS<sup><a href="https://paperpile.com/c/W3ldUH/QIleb">15</a></sup>
<p>
Valores en USD oficial a tasa de cambio nominal de cada país para noviembre de 2023.
   </td>
  </tr>
  <tr>
   <td>Tasa de descuento (%) 
   </td>
   <td>Se utiliza para traer al presente los costos y beneficios en salud futuros.
   </td>
   <td>Manual metodológico para elaboración de Evaluaciones Económicas<sup><a href="https://paperpile.com/c/W3ldUH/Ffwur">29</a></sup>
   </td>
  </tr>
  <tr>
   <td>Costo programático anual de DOT (USD)
   </td>
   <td>Costo de implementar y mantener DOT en un año.
   </td>
   <td>Se ofrece la opción al usuario de completar este dato si dispone de la información necesaria.
   </td>
  </tr>
  <tr>
   <td>Costo programático anual de vDOT (USD)
   </td>
   <td>Costo de implementar y sostener vDOT en un año.
   </td>
   <td>Se ofrece la opción al usuario de completar este dato si dispone de la información necesaria.
   </td>
  </tr>
</table>



## Lista de indicadores

**Resultados epidemiológicos**



1. **Tratamientos exitosos (n): **se refiere a la cantidad de pacientes que completaron satisfactoriamente su tratamiento de tuberculosis bajo vDOT.

    Ej: **Tratamientos exitosos (n): n = 733,2. **En este caso, el modelo indica que la implementación de vDOT podría resultar en aproximadamente 733 casos exitosos de tratamiento.

2. **Muertes evitadas (n): **número de evitadas mientras reciben tratamiento para la tuberculosis bajo el vDOT.

    Ej: **Muertes evitadas: n = 61,4. **En este caso, el modelo indica que la  implementación del vDOT podría evitar la muerte de 61 pacientes aproximadamente

3. **Años de vida salvados: **mide la cantidad de años de vida perdidos por muerte prematura que se evitan como resultado del vDOT comparandolo con el tratamiento autosupervisado.

    Ej: **Años de vida salvados = 758,8. **En este caso, el modelo indica que el vDOT tiene el potencial de evitar 758.8 años de vida por muerte prematura en pacientes con tuberculosis.

4. **Años de vida ajustados por discapacidad evitados: **mide la cantidad de años de años de vida ajustados por discapacidad que se evitan como resultado del vDOT

    Ej: **Años de vida ajustados por discapacidad evitados = 758,8. **En este caso, el modelo indica que el vDOT tiene el potencial de evitar 758.8 años de vida ajustados por discapacidad en pacientes con tuberculosis.


**Resultados económicos**



5. **Costo total de la intervención (USD):** el costo total del vDOT durante la duración del tratamiento por el número de personas de la cohorte que recibirán la intervención en USD oficial a tasa de cambio nominal de cada país.

    Ej: **(USD) = $40.431,3 USD:** realizar vDOT durante la duración del tratamiento para las personas de la cohorte que recibirán la intervención vale $40.431,3 USD. 

6. **Costos evitados atribuibles a la intervención (USD):** los costos evitados por eventos en salud asociados a tuberculosis o tratamiento adicional de tuberculosis por utilizar vDOT en lugar de tratamiento autosupervisado.

    Ej: **Costos evitados atribuibles a la intervención  (USD) = $450.000,2 USD:** el uso de vDOT evita $450.000,2 USD gracias a ahorros en atención médica de eventos en salud de tuberculosis y tratamientos adicionales para tuberculosis.

7. **Diferencia de costos respecto al escenario basal (USD):** diferencia de costos entre el vDOT y no intervención (tratamiento autosupervisado).

    Ej: **Diferencia de costos respecto al escenario basal (USD) = $568.025,5 USD:** si se implementa terapia directamente observada por video se tendría una diferencia de costos de $568.025,5 USD en comparación con tratamiento autosupervisado.

8. **Razón de costo-efectividad incremental por vida salvada (USD): **costo adicional por cada vida que se salva como resultado de la implementación de la intervención (vDOT o DOT).

    Ej: **Razón de costo-efectividad incremental por vida salvada (USD) = $12.546,3 USD: **en promedio, cada vida salvada en Argentina por la implementación de la intervención (vDOT o DOT) cuesta un adicional de $12.546,3 USD. 

9. **Razón de costo-efectividad incremental por Año de vida salvado:** hace referencia al costo adicional del vDOT por cada año de vida salvado adicional en comparación con tratamiento autosupervisado. Se trata de la diferencia en costos de la intervención dividido la diferencia en efectividad en años de vida salvados, entre el vDOT y el tratamiento autosupervisado.

    Ej: **RCEI por AVS = $589 USD: **al implementar el vDOT, cuesta $589 USD obtener un año de vida salvado adicional en comparación con el tratamiento autosupervisado.

10. **Razón de costo-efectividad incremental por Años de Vida Ajustados por Discapacidad evitados: **hace referencia al costo adicional que debo invertir con el vDOT para ganar un año de vida ajustado por discapacidad en comparación con tratamiento autosupervisado. Se trata de la diferencia en costos entre intervenciones dividido la diferencia en efectividad en años de vida ajustados por discapacidad entre intervenciones.

    Ej: **RCEI por AVAD = $347,1 USD:** implementar el vDOT cuesta $347,1 USD para obtener un año de vida ajustado por discapacidad adicional en comparación con tratamiento autosupervisado. 

11. **Retorno de Inversión (%):** relación entre los beneficios y los costos obtenidos por el vDOT. Un retorno de la inversión positivo indica que la intervención no solo cubre su costo, sino que también genera un beneficio económico adicional. En el caso de que el retorno de la inversión sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. Se define como los ingresos menos la inversión, dividido por la inversión.

    Ej: **Retorno de Inversión (%):** un retorno de la inversión del 14% significa que por cada $1 USD invertido en la intervención, se obtiene un retorno de $0.14 USD de retorno de la inversión adicional. 



## Referencias


    1.	[WHO. Global Tuberculosis 2023 Report. Published online November 7, 2023. Accessed December 9, 2023. https://iris.who.int/bitstream/handle/10665/373828/9789240083851-eng.pdf?sequence=1](http://paperpile.com/b/W3ldUH/TBGNF)


    2.	[Mangan JM, Woodruff RS, Winston CA, et al. Recommendations for Use of Video Directly Observed Therapy During Tuberculosis Treatment - United States, 2023. MMWR Morb Mortal Wkly Rep. 2023;72(12):313-316. doi:10.15585/mmwr.mm7212a4](http://paperpile.com/b/W3ldUH/BTOSn)


    3.	[Individual, Family Health. Directly Observed Therapy (DOT) for the Treatment of Tuberculosis. Accessed December 9, 2023. https://www.health.state.mn.us/diseases/tb/lph/dot.html](http://paperpile.com/b/W3ldUH/jdqzE)


    4.	[OPS/OMS. Perspectivas y contribuciones de la enfermería para promover la salud universal. Published online 2020:96. Accessed December 8, 2023. https://iris.paho.org/bitstream/handle/10665.2/52115/9789275322185_spa.pdf](http://paperpile.com/b/W3ldUH/BfSdg)


    5.	[Fekadu G, Jiang X, Yao J, You JHS. Cost-effectiveness of video-observed therapy for ambulatory management of active tuberculosis during the COVID-19 pandemic in a high-income country. Int J Infect Dis. 2021;113:271-278. doi:10.1016/j.ijid.2021.10.029](http://paperpile.com/b/W3ldUH/43v6c)


    6.	[Günther G, Heyckendorf J, Zellweger JP, et al. Defining Outcomes of Tuberculosis (Treatment): From the Past to the Future. Respiration. 2021;100(9):843-852. doi:10.1159/000516392](http://paperpile.com/b/W3ldUH/A9OM)


    7.	[Alipanah N, Jarlsberg L, Miller C, et al. Adherence interventions and outcomes of tuberculosis treatment: A systematic review and meta-analysis of trials and observational studies. PLoS Med. 2018;15(7):e1002595. doi:10.1371/journal.pmed.1002595](http://paperpile.com/b/W3ldUH/2GlOn)


    8.	[Ridho A, Alfian SD, van Boven JFM, et al. Digital Health Technologies to Improve Medication Adherence and Treatment Outcomes in Patients With Tuberculosis: Systematic Review of Randomized Controlled Trials. J Med Internet Res. 2022;24(2):e33062. doi:10.2196/33062](http://paperpile.com/b/W3ldUH/ATdT2)


    9.	[Story A, Aldridge RW, Smith CM, et al. Smartphone-enabled video-observed versus directly observed treatment for tuberculosis: a multicentre, analyst-blinded, randomised, controlled superiority trial. Lancet. 2019;393(10177):1216-1224. doi:10.1016/S0140-6736(18)32993-3](http://paperpile.com/b/W3ldUH/GyU93)


    10.	[Ridolfi F, Peetluk L, Amorim G, et al. Tuberculosis Treatment Outcomes in Brazil: Different Predictors for Each Type of Unsuccessful Outcome. Clin Infect Dis. 2023;76(3):e930-e937. doi:10.1093/cid/ciac541](http://paperpile.com/b/W3ldUH/AvrSh)


    11.	_[Self-Reported Population Health: An International Perspective Based on EQ-5D. Springer Netherlands doi:10.1007/978-94-007-7596-1](http://paperpile.com/b/W3ldUH/RuKAt)_


    12.	[Morgado A, Köhnenkampf R, Navarrete P, García P, Balcells ME. [Clinical and epidemiological profile of tuberculosis in a university hospital in Santiago, Chile]. Rev Med Chil. 2012;140(7):853-858. doi:10.4067/S0034-98872012000700004](http://paperpile.com/b/W3ldUH/C45Ea)


    13.	[Global Burden of Disease Study 2019 (GBD 2019) Disability Weights. Accessed December 9, 2023. https://ghdx.healthdata.org/record/ihme-data/gbd-2019-disability-weights](http://paperpile.com/b/W3ldUH/7Pbw)


    14.	_[Manual operativo de la OMS sobre la tuberculosis. Módulo 4: Tratamiento. Tratamiento de la tuberculosis farmacosensible. OPS; 2023. doi:10.37774/9789275327364](http://paperpile.com/b/W3ldUH/lXaU)_


    15.	[Productos y precios del Fondo Estratégico. Accessed December 14, 2023. https://www.paho.org/es/fondo-estrategico-ops/productos-precios](http://paperpile.com/b/W3ldUH/QIleb)


    16.	[Valores de Cartilla y Nomenclador. Accessed December 14, 2023. https://sistemas.amepla.org.ar/cartillaweb/iniciocartilla.aspx](http://paperpile.com/b/W3ldUH/I5g1h)


    17.	[SIGTAP - Sistema de Gerenciamento da Tabela de Procedimentos, Medicamentos e OPM do SUS. Accessed December 14, 2023. http://sigtap.datasus.gov.br/tabela-unificada/app/sec/inicio.jsp](http://paperpile.com/b/W3ldUH/c5X1Y)


    18.	[Isapres - Isapres. Superintendencia de Salud, Gobierno de Chile. Accessed December 14, 2023. http://www.supersalud.gob.cl/664/w3-article-2528.html](http://paperpile.com/b/W3ldUH/AJmjX)


    19.	[Fonasa Chile. https://www.fonasa.cl/sites/Satellite?c=Page&cid=1520002032354&pagename=Fonasa2019%2FPage%2FF2_ContenidoDerecha](http://paperpile.com/b/W3ldUH/tGyhd)


    20.	[ISS2001. Min Salud. Accessed December 14, 2023. https://www.minsalud.gov.co/sites/rid/Lists/BibliotecaDigital/RIDE/VP/RBC/actualizacion-manual-tarifario-2018.pdf](http://paperpile.com/b/W3ldUH/XBsSZ)


    21.	[Federación de asociaciones de trabajadores de la sanidad argentina. Accessed December 14, 2023. https://www.sanidad.org.ar/ContentManager/Files/ContentFileManager/acciongremial/cct_pdfs/c122/cct122_acuerdo_2023.pdf](http://paperpile.com/b/W3ldUH/z5KyI)


    22.	[Piso nacional da enfermagem. Accessed December 14, 2023. https://www.gov.br/saude/pt-br/assuntos/noticias/2023/agosto/arquivos/cartilha_piso-enfermagem_2023.pdf](http://paperpile.com/b/W3ldUH/fMnrU)


    23.	[Salario de Enfermería en Colombia. Accessed December 14, 2023. https://co.computrabajo.com/salarios/enfermeria](http://paperpile.com/b/W3ldUH/mrvkL)


    24.	[Salario para Enfermera en Chile - Salario Medio. Talent.com. Accessed December 14, 2023. https://cl.talent.com/salary](http://paperpile.com/b/W3ldUH/F1m6s)


    25.	[NOR-Honorarios y Salarios. Accessed December 14, 2023. https://www.enfermeria.cr/index.php/es/normativa/honorarios](http://paperpile.com/b/W3ldUH/StVbB)


    26.	[Enfermeras: se sube el salario de arranque a $1.212 y se elevan salarios de coordinadoras y especialistas – Ministerio de Salud Pública. Accessed December 14, 2023. https://www.salud.gob.ec/enfermeras-se-sube-el-salario-de-arranque-a-1-212-y-se-elevan-salarios-de-coordinadoras-y-especialistas/](http://paperpile.com/b/W3ldUH/72AbM)


    27.	[del Trabajo y Previsión Social S. Entran en vigor salarios mínimos 2023 en todo el país. gob.mx. Accessed December 14, 2023. http://www.gob.mx/stps/prensa/entran-en-vigor-salarios-minimos-2023-en-todo-el-pais?idiom=es](http://paperpile.com/b/W3ldUH/qeRjo)


    28.	[Instituto Nacional de Salud de Perú. Accessed December 14, 2023. https://cdn.www.gob.pe/uploads/document/file/3822870/Escala_Remunerativa_2022_NOV.pdf.pdf?v=1668005661](http://paperpile.com/b/W3ldUH/QXkF3)


    29.	[Moreno M, Aurelio M, Castro H. Manual metodológico para la elaboración de Evaluaciones Económicas. IETS. Accessed December 26, 2023. https://www.iets.org.co/Archivos/64/Manual_evaluacion_economica.pdf](http://paperpile.com/b/W3ldUH/Ffwur)
