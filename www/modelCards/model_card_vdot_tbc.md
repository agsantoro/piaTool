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

# 6. Model Card: vDOT para TB


---


## Introducción

La TB continúa siendo un importante desafío para la salud mundial.<sup><a href="https://paperpile.com/c/PQ6jLI/kemT">1</a></sup> El tratamiento autosupervisado, representa un enfoque estándar en el que los pacientes asumen la responsabilidad de cumplir con la administración de su propio tratamiento. Esta metodología confía en la capacidad y el compromiso del paciente para adherirse de manera independiente a su régimen terapéutico, eliminando la necesidad de supervisión directa. Este enfoque difiere significativamente del Tratamiento de Observación Directa (DOT, su sigla del inglés _Directly Observed Therapy_), en el cual un profesional de la salud o una persona designada supervisa de manera directa la ingesta de cada dosis de medicación por parte del paciente.<sup><a href="https://paperpile.com/c/PQ6jLI/oePw">2</a></sup> Aunque efectivo, el DOT enfrenta desafíos, como la demanda de recursos y esfuerzos por parte de los servicios de salud, pacientes y familias. Estos desafíos han llevado a una baja adherencia al tratamiento, especialmente en comunidades marginadas. Además, el DOT en persona puede ser logísticamente difícil, interfiriendo con el trabajo y la vida diaria del paciente, y puede generar estigma o preguntas indeseadas de vecinos y compañeros. Las dificultades se agudizan durante mal tiempo, desastres naturales o pandemias, donde el DOT en persona no siempre es factible. En respuesta a estas limitaciones, han surgido enfoques centrados en el paciente, y el vDOT ha surgido como una alternativa tecnológica prometedora.<sup><a href="https://paperpile.com/c/PQ6jLI/oePw+cilS">2,3</a></sup>

El vDOT integra ventajas notables como la comodidad para pacientes y enfermeros, reducción en costos y tiempo de desplazamiento del personal, y una menor tasa de abandono del tratamiento, con el uso de tecnología de video para supervisión de pacientes. Este método implica monitorear a los pacientes tomando sus medicamentos a través de videos, ya sean grabaciones asincrónicas o en vivo, utilizando dispositivos como smartphones, tabletas o computadoras. Esta innovadora estrategia ha demostrado ser efectiva y viable, alineándose con una mayor adherencia al tratamiento. Además, el vDOT permite manejar un mayor número de pacientes con TB por cada observador de tratamiento en comparación con el método tradicional basado en la comunidad (DOT), manteniendo elevados niveles de satisfacción en los pacientes. Este enfoque destaca la importancia y el impacto de la tecnología en la mejora de la gestión y eficacia del tratamiento de condiciones críticas como la TB.<sup><a href="https://paperpile.com/c/PQ6jLI/CqHuG">4</a></sup>


## Nombre del modelo

Terapia Directamente Observada por Video (vDOT, su sigla del inglés _Video Directly Observed Therapy_) para tuberculosis (TB).


## Descripción del modelo y asunciones

Este modelo estático de árbol de decisiones compara tres escenarios: tratamiento con Video Directly Observed Therapy (VDOT), Directly Observed Therapy (DOT), y administración autosupervisada de medicación. Inspirado en el modelo de VDOT,<sup><a href="https://paperpile.com/c/PQ6jLI/O3ZK">5</a></sup> se analiza una cohorte hipotética de pacientes sin comorbilidades. En el escenario de administración autosupervisada, los pacientes toman todas las dosis de los fármacos sin supervisión. Por otro lado, el DOT implica que los pacientes acudan a un centro de salud para tomar la medicación bajo la observación de un profesional sanitario. El VDOT, en cambio, permite la supervisión a través de video.

En el modelo, los pacientes son expuestos a estas intervenciones, y se evalúa la posibilidad de un tratamiento exitoso, definido según la OMS como la curación o la finalización del tratamiento sin señales de fracaso. Un tratamiento exitoso implica que el paciente continúa su vida normal por el resto del año, que es el horizonte temporal del modelo. En caso contrario, se consideran distintos desenlaces, como la muerte (asumiendo que ocurre a la mitad del año tras 3 meses de tratamiento), el fracaso del tratamiento (se asume que se pierden a mitad del tratamiento), y la pérdida de seguimiento (se asume que se pierden a mitad del tratamiento). Los pacientes que presentan falla terapéutica requerirán continuar con tratamiento por lo que dura el horizonte temporal y estarán expuestos a complicaciones, mientras que los que pierden el seguimiento estarán expuestos a consumo de recursos de salud como consultas a emergencias y se asume que un 25% reiniciará en algún momento del año el tratamiento. Se asume que los pacientes presentan la utilidad de tuberculosis durante la duración del tratamiento o durante la pérdida de seguimiento y la de la población general una vez completado el esquema en el grupo de tratamiento exitoso.

En cuanto a los costos, se incluyen los del tratamiento, seguimiento y estudios complementarios. Para los pacientes con fracaso terapéutico, se añaden los costos de hospitalización por complicaciones mientras que para los de pérdida de seguimiento, se agregan consultas de emergencia. El costeo de VDOT y DOT se basó en el salario por hora de enfermería. Utilizando estudios previos, estimamos el costo por tiempo empleado en cada evento de DOT y VDOT. Para DOT, también se incluyó el costo del transporte del trabajador de salud al centro, basado en un viaje en transporte público en la capital de cada país. En cambio, para VDOT, al ser remoto, este costo no se consideró. Todos estos cálculos se realizaron desde la perspectiva del sistema de salud, sin incluir costos de bolsillo para los pacientes." 


## Limitaciones y consideraciones

El modelo se centra en pacientes con tuberculosis pulmonar que no presentan comorbilidades. No aborda otras características de la enfermedad o de los pacientes, que podrían implicar diferentes duraciones, seguimientos y resultados del tratamiento (por ejemplo comorbilidades como la diabetes mellitus o la infección por VIH). Además, debido a su corto horizonte temporal, el modelo no permite el análisis de resultados a largo plazo en pacientes que experimentan fracaso del tratamiento o pérdida de seguimiento.

Desde una perspectiva económica, la estimación de costos para Costa Rica, Ecuador, México y Perú se llevó a cabo a través de un método de estimación indirecta, basado en el PIB de cada país, debido a la falta de información específica de costos disponible para estos países. Además, para la definición de los esquemas de tratamiento y cantidad de exámenes que se hacen en el seguimiento, se hicieron simplificaciones con base a literatura y  guías de práctica clínica de Argentina, asumiendose igual para todos los países. Además, en el caso de costo de supervisión de un evento de DOT y de vDOT, al no contar con información específica de costos de estos eventos, se utilizó una aproximación mediante el costo de una hora de enfermería.


## Descripción general de los parámetros


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
   <td>Riesgo Relativo (RR) del tratamiento exitoso con DOT vs SAT 
   </td>
   <td>RR de éxito en el tratamiento de la TB comparando el DOT con el tratamiento autosupervisado.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/u44A">6</a></sup>
   </td>
   <td>Basico
   </td>
  </tr>
  <tr>
   <td>RR tratamiento exitoso vDOT vs DOT
   </td>
   <td>RR de éxito en el tratamiento de la tuberculosis al comparar el vDOT con el DOT.
   </td>
   <td>Ridho y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/J8qr">7</a></sup>
   </td>
   <td>Basico
   </td>
  </tr>
  <tr>
   <td>Adherencia a vDOT (al menos 80% de las observaciones)
   </td>
   <td>Proporción que refleja la adherencia adecuada al vDOT para la TB, estableciendo que un paciente cumple con el tratamiento de manera correcta si asiste y completa al menos el 80% de las sesiones de medicación supervisadas.
   </td>
   <td>Story y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/Oo4j">8</a></sup>
   </td>
   <td>Basico
   </td>
  </tr>
  <tr>
   <td>Probabilidad de tratamiento exitoso con SAT
   </td>
   <td>Proporción de pacientes que responden positivamente al tratamiento autosupervisado  en comparación con el total de pacientes tratados para TB.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/u44A">6</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Probabilidad de muerte dado tratamiento no exitoso con SAT
   </td>
   <td>Proporción de pacientes que fallecen tras no responder positivamente al tratamiento autosupervisado  para TB.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/u44A">6</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Probabilidad de falla dado tratamiento no exitoso con SAT
   </td>
   <td>Proporción de pacientes que responden negativamente al  al tratamiento con tratamiento autosupervisado.
   </td>
   <td>Alipanah y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/u44A">6</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>RR de muerte DOT vs SAT
   </td>
   <td>Riesgo relativo de mortalidad en pacientes bajo DOT frente a aquellos que gestionan su tratamiento autosupervisado.
   </td>
   <td>Ridolfi y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/9Nso">9</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>RR de falla DOT vs SAT
   </td>
   <td>Riesgo relativo de falla terapéutica en pacientes bajo DOT frente a aquellos que gestionan su tratamiento autosupervisado.
   </td>
   <td>Ridolfi y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/9Nso">9</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Adherencia a DOT (al menos 80% de las observaciones)
   </td>
   <td>Proporción que refleja la adherencia adecuada al DOT para la TB, estableciendo que un paciente cumple con el tratamiento de manera correcta si asiste y completa al menos el 80% de las sesiones de medicación supervisadas.
   </td>
   <td>Story y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/Oo4j">8</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>RR de muerte vDOT vs DOT
   </td>
   <td>Riesgo relativo de mortalidad en pacientes bajo vDOT frente a aquellos que reciben tratamiento DOT.
   </td>
   <td>Asunción
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>RR de falla vDOT vs DOT
   </td>
   <td>Riesgo relativo de falla terapéutica en pacientes bajo DOT frente a aquellos que reciben tratamiento  DOT.
   </td>
   <td>Asunción
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Cantidad de dosis supervisadas mediante vDOT por semana
   </td>
   <td>Número total de veces que un paciente con TB recibe supervisión para la toma de sus medicamentos a través de vDOT durante una semana.
   </td>
   <td>Definido por el usuario
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Cantidad de dosis supervisadas mediante DOT por semana
   </td>
   <td>Número total de veces que un paciente con TB recibe supervisión para la toma de sus medicamentos a través de DOT durante una semana.
   </td>
   <td>Definido por el usuario
   </td>
   <td>Avanzado
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="4" >
    <strong>Parámetros por países. </strong>
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
   <td>Costo tratamiento de inducción
   </td>
   <td>Costo mensual del tratamiento de inducción para tuberculosis
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/PQ6jLI/WUmJM">10</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo tratamiento de consolidación
   </td>
   <td>Costo mensual del tratamiento de consolidación para tuberculosis
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/PQ6jLI/WUmJM">10</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de seguimiento
   </td>
   <td>Costo mensual de controles médicos (no contempla exámenes complementarios)
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr">11</a></sup>, Brasil<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr+Z7n1X">11,12</a></sup>, Chile<sup><a href="https://paperpile.com/c/PQ6jLI/qVRK7">13</a>,<a href="https://paperpile.com/c/PQ6jLI/oiPp0">14</a></sup> y Colombia<sup><a href="https://paperpile.com/c/PQ6jLI/kgncn">15</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de exámenes complementarios
   </td>
   <td>Costo promedio mensual de exámenes complementarios
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr">11</a></sup>, Brasil<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr+Z7n1X">11,12</a></sup>, Chile<sup><a href="https://paperpile.com/c/PQ6jLI/qVRK7">13</a>,<a href="https://paperpile.com/c/PQ6jLI/oiPp0">14</a></sup> y Colombia<sup><a href="https://paperpile.com/c/PQ6jLI/kgncn">15</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo internación por tuberculosis
   </td>
   <td>Costo promedio de 1 día de internación por falla terapéutica en tuberculosis.
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr">11</a></sup>, Brasil<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr+Z7n1X">11,12</a></sup>, Chile<sup><a href="https://paperpile.com/c/PQ6jLI/qVRK7">13</a>,<a href="https://paperpile.com/c/PQ6jLI/oiPp0">14</a></sup> y Colombia<sup><a href="https://paperpile.com/c/PQ6jLI/kgncn">15</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de un evento DOT
   </td>
   <td>Costo de supervisión de una dosis de DOT.
   </td>
   <td>Se asumió como una porción del costo de la hora de una enfermera para todos los países <sup><a href="https://paperpile.com/c/PQ6jLI/Z9xw">16</a>,<a href="https://paperpile.com/c/PQ6jLI/Jxvz">17</a>, <a href="https://paperpile.com/c/PQ6jLI/T0vU">18</a>,<a href="https://paperpile.com/c/PQ6jLI/Dk3G">19</a>,<a href="https://paperpile.com/c/PQ6jLI/5QYU">20</a>,<a href="https://paperpile.com/c/PQ6jLI/5tmU+bXoT+zER4">21–23</a></sup>
   </td>
   <td>
    Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de un evento vDOT
   </td>
   <td>Costo de supervisión de una dosis de vDOT
   </td>
   <td>Se asumió como una porción del costo de la hora de una enfermera para todos los países <sup><a href="https://paperpile.com/c/PQ6jLI/Z9xw">16</a>,<a href="https://paperpile.com/c/PQ6jLI/Jxvz">17</a>, <a href="https://paperpile.com/c/PQ6jLI/T0vU">18</a>,<a href="https://paperpile.com/c/PQ6jLI/Dk3G">19</a>,<a href="https://paperpile.com/c/PQ6jLI/5QYU">20</a>,<a href="https://paperpile.com/c/PQ6jLI/5tmU+bXoT+zER4">21–23</a></sup>
   </td>
   <td>
    Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo programático DOT
   </td>
   <td>Costo de implementar y sostener DOT
   </td>
   <td>Se deja la posibilidad al usuario de completar este dato si cuenta con él
   </td>
   <td>
    Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo programático de vDOT
   </td>
   <td>Costo de implementar y mantener vDOT
   </td>
   <td>Se deja la posibilidad al usuario de completar este dato si cuenta con él
   </td>
   <td>
    Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo de consulta a emergencias
   </td>
   <td>Costo de 1 consulta a emergencias en pacientes con TBC activa
   </td>
   <td>Nomencladores específicos para Argentina<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr">11</a></sup>, Brasil<sup><a href="https://paperpile.com/c/PQ6jLI/evvmr+Z7n1X">11,12</a></sup>, Chile<sup><a href="https://paperpile.com/c/PQ6jLI/qVRK7">13</a>,<a href="https://paperpile.com/c/PQ6jLI/oiPp0">14</a></sup> y Colombia<sup><a href="https://paperpile.com/c/PQ6jLI/kgncn">15</a></sup>, estimación indirecta* para Costa Rica, Ecuador, México y Perú.
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo tratamiento inducción en MR
   </td>
   <td>Costo mensual del tratamiento de inducción promedio para TBC multiresistente
   </td>
   <td>Fondo estratégico de la OPS<sup><a href="https://paperpile.com/c/PQ6jLI/WUmJM">10</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Costo tratamiento consolidación en MR
   </td>
   <td>Costo mensual del tratamiento de consolidación promedio para TBC multiresistente
   </td>
   <td>Fondo estratégico de la OPS <sup><a href="https://paperpile.com/c/PQ6jLI/WUmJM">10</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Utilidad de la población general
   </td>
   <td>Utilidad de la población general para la mediana de edad de TBC
   </td>
   <td>EQ-5D<sup><a href="https://paperpile.com/c/PQ6jLI/VQEE">24</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
  <tr>
   <td>Mediana de edad de Tuberculosis
   </td>
   <td>Mediana de edad de los pacientes con diagnóstico de tuberculosis para el país
   </td>
   <td>Morgado y cols.<sup><a href="https://paperpile.com/c/PQ6jLI/vA8k">25</a></sup>
   </td>
   <td>Avanzado
   </td>
  </tr>
</table>



## Lista de indicadores

**Resultados epidemiológicos**



1. **Tratamientos exitosos (n): **se refiere a la cantidad de pacientes que completaron satisfactoriamente su tratamiento de TB bajo el monitoreo de VDOT.

    Ej: **Tratamientos exitosos (VDOT): n = 733,2. **En este caso, el modelo indica que la implementación de VDOT podría resultar en aproximadamente 733 casos exitosos de tratamiento.

2. **Porcentaje de éxito (%): **mide la proporción de pacientes que completan exitosamente su tratamiento de TB bajo la intervención de VDOT, expresado como un porcentaje.

    Ej: **Porcentaje de éxito (VDOT): % = 0,7. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de

3. **Pérdida de seguimiento (n): **mide el número de pacientes que, mientras reciben tratamiento mediante VDOT para la TB, dejan de participar en el programa de tratamiento y no pueden ser rastreados o reenganchados.

    Ej: **Pérdida de seguimiento (VDOT): n = 176,1. **En este caso, el modelo indica que la implementación de VDOT podría reducir la perdida de seguimiento de 176 pacientes aproximadamente.

4. **Muertes: **número de pacientes que fallecen mientras reciben tratamiento para la tuberculosis bajo la VDOT.

    Ej: **Muertes (VDOT): n = 61,4. **En este caso, el modelo indica que la  implementación de VDOT podría implicar la muerte de 61 pacientes aproximadamente

5. **Años de vida ajustados por calidad (AVAC): **mide la cantidad de años de vida saludable que se ganan como resultado de VDOT. Los AVAC consideran no solo la cantidad, sino también la calidad de esos años.

    Ej: **Años de vida ajustados por calidad (VDOT): AVAC = 758,8. **En este caso, el modelo indica que VDOT tiene el potencial de aumentar en 758.8 AVAC en pacientes con TB

6. **Años de vida ajustados por calidad años perdidos: ** cantidad total de años de vida que no se viven debido a una muerte prematura en el contexto del tratamiento de TB mediante VDOT.

    Ej: **Años de vida ajustados por calidad años perdidos (VDOT): = 1.862,3. **En este caso, el modelo indica que VDOT, tiene el potencial de evitar 1.862,3 años de vida perdidos ajustados por calidad.

7. **Años de vida ajustados por calidad perdidos descontados: **los años de vida perdidos por la calidad de esos años y aplica un factor de descuento, reflejando la preferencia por los beneficios inmediatos sobre los beneficios futuros.

    Ej: **Años de vida ajustados por calidad perdidos descontados (VDOT): = 1.288,8. **En este caso, el modelo indica que la intervención propuesta tiene el potencial de reducir 1.288,8 años de vida perdidos ajustados por calidad y descontados.


**Resultados económicos**



8. **Costos de intervención (USD):** el costo total de la intervención (vDOT o DOT) durante la duración del tratamiento supervisado por el número de personas de la cohorte que recibirán la intervención.

    Ej: **Costos de la intervención vDOT (USD):** realizar vDOT durante la duración del tratamiento para las personas de la cohorte que recibirán la intervención vale $40.431,3 USD 

9. **Costos evitados por la intervención vDOT  (USD):** los costos evitados por eventos en salud asociados a TBC o tratamiento adicional de TBC por utilizar vDOT en lugar de DOT. Se calculan teniendo en cuenta el número de eventos evitados gracias al vDOT.

    Ej: **Costos médicos directos evitados por (USD):** el uso de vDOT evita $450.000,2 USD gracias a ahorros en atención médica de eventos en salud de TBC y tratamientos adicionales para TBC

10. **Costos totales: **es el costo por intervención, por el número total de personas que recibirán la intervención.

    Ej: **Costos totales: **el costos de que 2.500 pacientes con TBC reciban vDOT asciende a $65.000 USD

11. **Diferencia de costos (USD):** diferencia de costos entre la rama de intervención (DOT o vDOT) y no intervención (tratamiento auto supervisado).

    Ej: **Diferencia de costos (USD):** si se implementa vDOT se tendría una diferencia de costos de $568.025,5 USD en comparación con tratamiento auto supervisado.

12. **Razón de costo-efectividad incremental (ICER) por Año de vida salvado (AVS):** hace referencia al costo adicional de la intervención (DOT o vDOT) por cada año de vida salvado adicional en comparación con tratamiento auto supervisado. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad en AVS (intervención vs no intervención).

    Ej: **ICER por AVS: **al implementar la intervención, me cuesta $589 USD obtener un AVS adicional en comparación con la no intervención.

13. **Razón de costo-efectividad incremental (ICER) por Años de Vida Ajustados por Calidad (AVAC): **hace referencia al costo adicional que debo invertir con la nueva intervención (DOT o vDOT) para ganar un año de vida ajustado por calidad en comparación con tratamiento autosupervisado. Se trata de la diferencia en costos (intervención vs no intervención) dividido la diferencia en efectividad en AVAC (intervención vs no intervención).

    Ej: **Razón de costo incremental (ICER) por AVAC:** $347,1 USD me cuesta obtener un AVAC adicional al implementar la intervención (DOT o vDOT) en comparación con tratamiento auto supervisado. 

14. **Retorno de Inversión (ROI) (%):** relación entre los beneficios y los costos obtenidos por la intervención. Un ROI positivo indica que la intervención no solo cubre su costo, sino que también genera un beneficio económico adicional. En el caso de que el ROI sea negativo, significa que los beneficios económicos alcanzados con la vacunación no alcanzan para recuperar la inversión inicial. Se define como los ingresos menos la inversión, dividido por la inversión.

    Ej: **Retorno de Inversión (ROI) (%):** un ROI del 14% significa que por cada $1 USD invertido en la intervención, se obtiene un retorno de $0.14 USD de retorno de la inversión adicional. 


**Nota aclaratoria: **el término “descontado” se refiere al proceso de ajustar los valores futuros de dinero a su equivalente en el presente. La tasa de descuento tomada como referencia es 5%.


## Referencias


    1.	[WHO. Global Tuberculosis 2023 Report. Published online November 7, 2023. Accessed December 9, 2023. https://iris.who.int/bitstream/handle/10665/373828/9789240083851-eng.pdf?sequence=1](http://paperpile.com/b/PQ6jLI/kemT)


    2.	[Mangan JM, Woodruff RS, Winston CA, et al. Recommendations for Use of Video Directly Observed Therapy During Tuberculosis Treatment - United States, 2023. MMWR Morb Mortal Wkly Rep. 2023;72(12):313-316.](http://paperpile.com/b/PQ6jLI/oePw)


    3.	[Individual, Family Health. Directly Observed Therapy (DOT) for the Treatment of Tuberculosis. Accessed December 9, 2023. https://www.health.state.mn.us/diseases/tb/lph/dot.html](http://paperpile.com/b/PQ6jLI/cilS)


    4.	[OPS/OMS. Perspectivas y contribuciones de la enfermería para promover la salud universal. Published online 2020:96. Accessed December 8, 2023. https://iris.paho.org/bitstream/handle/10665.2/52115/9789275322185_spa.pdf](http://paperpile.com/b/PQ6jLI/CqHuG)


    5.	[Fekadu G, Jiang X, Yao J, You JHS. Cost-effectiveness of video-observed therapy for ambulatory management of active tuberculosis during the COVID-19 pandemic in a high-income country. Int J Infect Dis. 2021;113:271-278.](http://paperpile.com/b/PQ6jLI/O3ZK)


    6.	[Alipanah N, Jarlsberg L, Miller C, et al. Adherence interventions and outcomes of tuberculosis treatment: A systematic review and meta-analysis of trials and observational studies. PLoS Med. 2018;15(7):e1002595.](http://paperpile.com/b/PQ6jLI/u44A)


    7.	[Ridho A, Alfian SD, van Boven JFM, et al. Digital Health Technologies to Improve Medication Adherence and Treatment Outcomes in Patients With Tuberculosis: Systematic Review of Randomized Controlled Trials. J Med Internet Res. 2022;24(2):e33062.](http://paperpile.com/b/PQ6jLI/J8qr)


    8.	[Story A, Aldridge RW, Smith CM, et al. Smartphone-enabled video-observed versus directly observed treatment for tuberculosis: a multicentre, analyst-blinded, randomised, controlled superiority trial. Lancet. 2019;393(10177):1216-1224.](http://paperpile.com/b/PQ6jLI/Oo4j)


    9.	[Ridolfi F, Peetluk L, Amorim G, et al. Tuberculosis Treatment Outcomes in Brazil: Different Predictors for Each Type of Unsuccessful Outcome. Clin Infect Dis. 2023;76(3):e930-e937.](http://paperpile.com/b/PQ6jLI/9Nso)


    10.	[Productos y precios del Fondo Estratégico. Accessed December 14, 2023. https://www.paho.org/es/fondo-estrategico-ops/productos-precios](http://paperpile.com/b/PQ6jLI/WUmJM)


    11.	[Valores de Cartilla y Nomenclador. Accessed December 14, 2023. https://sistemas.amepla.org.ar/cartillaweb/iniciocartilla.aspx](http://paperpile.com/b/PQ6jLI/evvmr)


    12.	[SIGTAP - Sistema de Gerenciamento da Tabela de Procedimentos, Medicamentos e OPM do SUS. Accessed December 14, 2023. http://sigtap.datasus.gov.br/tabela-unificada/app/sec/inicio.jsp](http://paperpile.com/b/PQ6jLI/Z7n1X)


    13.	[Isapres - Isapres. Superintendencia de Salud, Gobierno de Chile. Accessed December 14, 2023. http://www.supersalud.gob.cl/664/w3-article-2528.html](http://paperpile.com/b/PQ6jLI/qVRK7)


    14.	[Fonasa Chile. https://www.fonasa.cl/sites/Satellite?c=Page&cid=1520002032354&pagename=Fonasa2019%2FPage%2FF2_ContenidoDerecha](http://paperpile.com/b/PQ6jLI/oiPp0)


    15.	[ISS2001. Min Salud. Accessed December 14, 2023. https://www.minsalud.gov.co/sites/rid/Lists/BibliotecaDigital/RIDE/VP/RBC/actualizacion-manual-tarifario-2018.pdf](http://paperpile.com/b/PQ6jLI/kgncn)


    16.	[Federación de asociaciones de trabajadores de la sanidad argentina. Accessed December 14, 2023. https://www.sanidad.org.ar/ContentManager/Files/ContentFileManager/acciongremial/cct_pdfs/c122/cct122_acuerdo_2023.pdf](http://paperpile.com/b/PQ6jLI/Z9xw)


    17.	[Piso nacional da enfermagem. Accessed December 14, 2023. https://www.gov.br/saude/pt-br/assuntos/noticias/2023/agosto/arquivos/cartilha_piso-enfermagem_2023.pdf](http://paperpile.com/b/PQ6jLI/Jxvz)


    18.	[Salario de Enfermería en Colombia. Accessed December 14, 2023. https://co.computrabajo.com/salarios/enfermeria](http://paperpile.com/b/PQ6jLI/T0vU)


    19.	[Salario para Enfermera en Chile - Salario Medio. Talent.com. Accessed December 14, 2023. https://cl.talent.com/salary](http://paperpile.com/b/PQ6jLI/Dk3G)


    20.	[NOR-Honorarios y Salarios. Accessed December 14, 2023. https://www.enfermeria.cr/index.php/es/normativa/honorarios](http://paperpile.com/b/PQ6jLI/5QYU)


    21.	[Enfermeras: se sube el salario de arranque a $1.212 y se elevan salarios de coordinadoras y especialistas – Ministerio de Salud Pública. Accessed December 14, 2023. https://www.salud.gob.ec/enfermeras-se-sube-el-salario-de-arranque-a-1-212-y-se-elevan-salarios-de-coordinadoras-y-especialistas/](http://paperpile.com/b/PQ6jLI/5tmU)


    22.	[del Trabajo y Previsión Social S. Entran en vigor salarios mínimos 2023 en todo el país. gob.mx. Accessed December 14, 2023. http://www.gob.mx/stps/prensa/entran-en-vigor-salarios-minimos-2023-en-todo-el-pais?idiom=es](http://paperpile.com/b/PQ6jLI/bXoT)


    23.	[Instituto Nacional de Salud de Perú. Accessed December 14, 2023. https://cdn.www.gob.pe/uploads/document/file/3822870/Escala_Remunerativa_2022_NOV.pdf.pdf?v=1668005661](http://paperpile.com/b/PQ6jLI/zER4)


    24.	_[Self-Reported Population Health: An International Perspective Based on EQ-5D. Springer Netherlands](http://paperpile.com/b/PQ6jLI/VQEE)_


    25.	[Morgado A, Köhnenkampf R, Navarrete P, García P, Balcells ME. [Clinical and epidemiological profile of tuberculosis in a university hospital in Santiago, Chile]. Rev Med Chil. 2012;140(7):853-858.](http://paperpile.com/b/PQ6jLI/vA8k)


## 
    Anexos


<table>
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
   <td>RR de muerte DOT vs tratamiento autosupervisado
   </td>
   <td>RR de muerte en el tratamiento de la tuberculosis comparando el DOT con el tratamiento autosupervisado 
   </td>
   <td>
   </td>
   <td>No parametrizable
   </td>
  </tr>
  <tr>
   <td>RR de falla DOT vs tratamiento autosupervisado 
   </td>
   <td>RR de fracaso en el tratamiento de la TB al comparar el DOT con el tratamiento autosupervisado 
   </td>
   <td>
   </td>
   <td>No parametrizable
   </td>
  </tr>
  <tr>
   <td>RR de muerte vDOT vs DOT
   </td>
   <td>RR de muerte en el tratamiento de la tuberculosis comparando el vDOT con el DOT
   </td>
   <td>
   </td>
   <td>No parametrizable
   </td>
  </tr>
  <tr>
   <td>RR de falla vDOT vs DOT
   </td>
   <td>RR de fracaso al tratamiento de la tuberculosis comparando el vDOT con el DOT
   </td>
   <td>
   </td>
   <td>No parametrizable
   </td>
  </tr>
  <tr>
   <td>Cantidad de días promedio de internación ante falla
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>No parametrizable
   </td>
  </tr>
</table>

