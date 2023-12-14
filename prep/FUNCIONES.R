##funciones

calcularUtilidadRestante <- function(ciclosPorAño, esperanzaVida, utilidad) {
  # Esta función devuelve un vector de utilidad restante por ciclo.
  # Para un ciclo dado, el vector contendrá cuánta utilidad (según la población general) le quedaba por vivir
  # para obtener los qalys perdidos ante una muerte prematura.
  
  # Vector que contendrá la utilidad restante de cada ciclo.
  uti <- numeric(101 * ciclosPorAño)
  
  # Recorremos desde 0 todos los ciclos comprendidos entre 0 y 100 años.
  for (i in 0:((101 * ciclosPorAño) - 1)) {
    # Para cada ciclo recorremos desde el ciclo siguiente hasta la cantidad de ciclos correspondiente a la esperanza de vida del país
    for (z in (i + 1):(esperanzaVida * ciclosPorAño)) {
      # A uti le asignamos el valor de la utilidad trimestral del año que corresponde al ciclo.
      # Ajuste para el índice (R empieza en 1, no en 0 como VBA)
      idx <- ((z - 1) %/% ciclosPorAño) + 1
      if (idx <= length(utilidad)) {
        uti[i + 1] <- uti[i + 1] + utilidad[idx]
      }
    }
  }
  
  return(uti)
}

cargarDistribucion <- function(edadMin, edadMax) {

  # Edad mínima y máxima con datos disponibles
  minDistEdad <- 18
  maxDistEdad <- 50
  
  # Ajustar rangos basados en los límites de edad proporcionados
  minR <- ifelse(edadMin <= minDistEdad, edadMin, minDistEdad)
  maxR <- ifelse(edadMax >= maxDistEdad, edadMax, maxDistEdad)
  
  # Crear un vector para almacenar la distribución basal
  distBasal <- numeric(edadMax - edadMin + 1)
  #names(distBasal) <- as.character(minR:maxR)
  
  # Cargar datos para el rango de edades (reemplazar con tu método de carga de datos)
  for (i in 0:32) {
    # Aquí debes reemplazar el acceso a la hoja de Excel por el método apropiado en R
    # Por ejemplo, si los datos están en un dataframe llamado 'datosExcel', podrías hacer algo así:
    # distBasal[as.character(18 + i)] <- datosExcel[6 + i, 8]
    distBasal[18 + i] <- distribucion_cohortes[5 + i, 8]
  }
  
  # Calcular la diferencia en años entre lo que se tiene y lo que se pide
  difAños <- 33 - (edadMax - edadMin + 1)
  dsAcumulada <- 0
  
  # Crear un vector para almacenar los resultados
  res <- numeric(edadMax - edadMin + 1)
  #names(res) <- as.character(edadMin:edadMax)
  
  # Calcular la probabilidad acumulada en el rango solicitado
  for (i in edadMin:edadMax ) {
    if (i < 18) {
      # Si la edad es menor a 18, asignar la misma probabilidad que a la edad 18
      distBasal[i] <- distBasal[18]
      dsAcumulada <- dsAcumulada + as.numeric(distBasal[18])
    } else if (i > 50) {
      # Si la edad es mayor a 50, asignar la misma probabilidad que a la edad 50
      distBasal[i] <- distBasal[50]
      dsAcumulada <- dsAcumulada + as.numeric(distBasal[50])
    } else {
      # Si la edad está en el rango, solo sumar esa probabilidad
      dsAcumulada <- dsAcumulada + as.numeric(distBasal[i])
    }
  }
  
  # Calcular la diferencia entre la probabilidad total deseada y la acumulada
  resto <- 1 - dsAcumulada
  
  # Calcular la modificación necesaria si hay una diferencia
  modificacion <- ifelse(resto != 0, resto / (edadMax - edadMin + 1), 0)
  
  # Inicializar la probabilidad acumulada después de realizar los ajustes
  drAcumulada <- 0
  
  # Aplicar el ajuste a cada elemento en el rango deseado
  for (i in edadMin:edadMax) {
    res[i] <- as.numeric(distBasal[i]) + modificacion
    # Acumular la probabilidad para verificar si suma 1 al final
    drAcumulada <- drAcumulada + res[i]
  }
  
  # Ajustar en caso de que la probabilidad total no sume exactamente 1
  if (drAcumulada != 1) {
    res[edadMin] <- res[edadMin] + (1 - drAcumulada)
  }
  
  
 return(res) 
}


###CARGAR DISTRIBUCION

cargarDistribucion2 <- function(edadMin, edadMax) {
  # Definir las edades mínima y máxima disponibles en los datos
  minDistEdad <- 18
  maxDistEdad <- 50
  
  # Ajustar los rangos según los parámetros y los datos disponibles
  minR <- ifelse(edadMin <= minDistEdad, minDistEdad, edadMin)
  maxR <- ifelse(edadMax >= maxDistEdad, maxDistEdad, edadMax)
  
  # Inicializar vectores
  distBasal <- numeric(maxR - minR + 1)
  names(distBasal) <- minR:maxR
  
  # Asumiendo que los datos se cargan de una hoja de cálculo
  # Necesitarás adaptar esta parte para cargar los datos correctamente
  # datos <- readxl::read_excel("ruta/a/tu/archivo.xlsx", sheet = "Hoja5")
  
  # Cargar los datos en el rango disponible
  for (i in 1:33) {
    distBasal[18 + i] <- as.numeric(distribucion_cohortes[5 + i, 8])  # Ajusta los índices según tus datos
  }
  
  # Acumular y ajustar la distribución
  difAños = 33 - (edadMax - edadMin + 1)
  dsAcumulada <- 0
  for (i in edadMin:edadMax) {
    if (i < 18) {
      distBasal[i] <- distBasal[18]
      dsAcumulada <- dsAcumulada + distBasal[18]
    } else if (i > 50) {
      distBasal[i] <- distBasal[50]
      dsAcumulada <- dsAcumulada + distBasal[50]
    }
    dsAcumulada <- dsAcumulada + distBasal[i]
  }
  
  resto <- 1 - dsAcumulada
  modificacion <- ifelse(resto != 0, resto / (edadMax - edadMin + 1), 0)
  
  drAcumulada <- 0
  res <- vector("numeric", length = edadMax - edadMin + 1)
  for (i in edadMin:edadMax) {
    res[i] <- distBasal[i] + modificacion
    drAcumulada <- drAcumulada + res[i]
  }
  
  if (drAcumulada != 1) {
    res[edadMin] <- res[edadMin] + (1 - drAcumulada)
  }
  
  return(res)
}
##

escribirOutput <- function(ciclo, ciclosPorAño, sanosSinPrep, sanosOffPrep, sanosOnPrep, infectadosSinDx,
                           infectadosPreDx, infectadosDx, muertosNoHiv, MuertosHIV, personasRiesgo, HIVTotales,
                           CasosNuevos, CasosAcumulados, nuevosDx, qalyNOHIV, qalyHIV, LyPerdidosMP, 
                           QalyPerdidosMP, Disutilidad, CostoSano, CostoPrep, CostoHIV) {
  # Crear una fila de datos
  fila_datos <- data.frame(
    Ciclo = ciclo,
    Ano = ciclo %/% ciclosPorAño,
    SanosSinPrep = sanosSinPrep,
    SanosOffPrep = sanosOffPrep,
    SanosOnPrep = sanosOnPrep,
    InfectadosSinDx = infectadosSinDx,
    InfectadosPreDx = infectadosPreDx,
    InfectadosDx = infectadosDx,
    MuertosNoHiv = muertosNoHiv,
    MuertosHIV = MuertosHIV,
    Total = MuertosHIV + muertosNoHiv + infectadosDx + infectadosPreDx + infectadosSinDx + sanosOnPrep + sanosOffPrep + sanosSinPrep,
    PersonasRiesgo = personasRiesgo,
    HIVTotales = HIVTotales,
    CasosNuevos = CasosNuevos,
    NuevosDx = nuevosDx,
    CasosAcumulados = CasosAcumulados,
    QalyNOHIV = qalyNOHIV,
    QalyHIV = qalyHIV,
    TotalQALY = qalyHIV + qalyNOHIV,
    LyPerdidosMP = LyPerdidosMP,
    QalyPerdidosMP = QalyPerdidosMP,
    Disutilidad = Disutilidad,
    CostoSano = CostoSano,
    CostoPrep = CostoPrep,
    CostoHIV = CostoHIV
  )
  
  # Agregar la fila a un data frame global o escribir en un archivo
  # Opción 1: Agregar a un data frame global (debes crear 'resultados_df' antes)
  # resultados_df <- rbind(resultados_df, fila_datos)
  
  # Opción 2: Escribir/adjuntar a un archivo CSV
  write.table(fila_datos, file = "prep/resultados.csv", append = TRUE, sep = ",", col.names = FALSE, row.names = FALSE)
}




library(openxlsx)

escribirResultadosComparacion <- function(escenario, añosVividos, qalysVividos, LyPerdidos, qalysPerdidosMP, QalysPerdidosDIS, qalysPerdidos, muertesHIV, muertesTotales, casosHIV, casosHIVDx, TiempoSinDx, CostoSano, CostoPrep, CostoHIV, casosTotales, añosVividosD, qalysVividosD, añosPerdidosMPD, qalysPerdidosMPD, QalysPerdidosDD, qalysPerdidosD, cSanoD, cPrEPD, cHIVd, cohorteSizeFinal) {
  resultados <- data.frame(
    Escenario = escenario,
    AñosVividos = c(añosVividos, añosVividosD),
    QALYsVividos = c(qalysVividos, qalysVividosD),
    LyPerdidos = c(LyPerdidos, añosPerdidosMPD),
    QALYsPerdidosMP = c(qalysPerdidosMP, qalysPerdidosMPD),
    QALYsPerdidosDIS = c(QalysPerdidosDIS, QalysPerdidosDD),
    QALYsPerdidos = c(qalysPerdidos, qalysPerdidosD),
    MuertesHIV = muertesHIV,
    ProporcionMuertesHIV = muertesHIV / muertesTotales,
    CasosHIV = casosHIV,
    CasosHIVDx = casosHIVDx,
    CasosTotales = casosTotales,
    TiempoSinDx = TiempoSinDx,
    CostoSano = c(CostoSano, cSanoD),
    CostoPrep = c(CostoPrep, cPrEPD),
    CostoHIV = c(CostoHIV, cHIVd),
    CostoTotal = c(CostoSano + CostoPrep + CostoHIV, cSanoD + cPrEPD + cHIVd),
    CohorteSizeFinal = cohorteSizeFinal
  )
  
  # Escribir el data frame en un archivo Excel
  nombreArchivo <- paste("Resultados_Escenario_", escenario, ".xlsx", sep = "")
  write.xlsx(resultados, file = nombreArchivo)
  
  return(resultados)
}


library(openxlsx)

escribirResultadosComparacion <- function(escenario, añosVividos, qalysVividos, LyPerdidos, qalysPerdidosMP, QalysPerdidosDIS, qalysPerdidos, muertesHIV, muertesTotales, casosHIV, casosHIVDx, TiempoSinDx, CostoSano, CostoPrep, CostoHIV, casosTotales, añosVividosD, qalysVividosD, añosPerdidosMPD, qalysPerdidosMPD, QalysPerdidosDD, qalysPerdidosD, cSanoD, cPrEPD, cHIVd, cohorteSizeFinal) {
  resultados <- data.frame(
    Escenario = escenario,
    AñosVividos = c(añosVividos, añosVividosD),
    QALYsVividos = c(qalysVividos, qalysVividosD),
    LyPerdidos = c(LyPerdidos, añosPerdidosMPD),
    QALYsPerdidosMP = c(qalysPerdidosMP, qalysPerdidosMPD),
    QALYsPerdidosDIS = c(QalysPerdidosDIS, QalysPerdidosDD),
    QALYsPerdidos = c(qalysPerdidos, qalysPerdidosD),
    MuertesHIV = muertesHIV,
    ProporcionMuertesHIV = muertesHIV / muertesTotales,
    CasosHIV = casosHIV,
    CasosHIVDx = casosHIVDx,
    CasosTotales = casosTotales,
    TiempoSinDx = TiempoSinDx,
    CostoSano = c(CostoSano, cSanoD),
    CostoPrep = c(CostoPrep, cPrEPD),
    CostoHIV = c(CostoHIV, cHIVd),
    CostoTotal = c(CostoSano + CostoPrep + CostoHIV, cSanoD + cPrEPD + cHIVd),
    CohorteSizeFinal = cohorteSizeFinal
  )
  
  # Escribir el data frame en un archivo Excel
  nombreArchivo <- paste("prep/Resultados_Escenario_", escenario, ".xlsx", sep = "")
  write.xlsx(resultados, file = nombreArchivo)
  
  return(resultados)
}

