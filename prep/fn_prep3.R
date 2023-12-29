options(scipen=999)
#source("FUNCIONES.R")
calcularUtilidadRestante <- function(ciclosPorAno, esperanzaVida, utilidad) {
  # Esta función devuelve un vector de utilidad restante por ciclo.
  # Para un ciclo dado, el vector contendrá cuánta utilidad (según la población general) le quedaba por vivir
  # para obtener los qalys perdidos ante una muerte prematura.
  
  # Vector que contendrá la utilidad restante de cada ciclo.
  uti <- numeric(101 * ciclosPorAno)
  
  # Recorremos desde 0 todos los ciclos comprendidos entre 0 y 100 años.
  for (i in 0:((101 * ciclosPorAno) - 1)) {
    # Para cada ciclo recorremos desde el ciclo siguiente hasta la cantidad de ciclos correspondiente a la esperanza de vida del país
    for (z in (i + 1):(esperanzaVida * ciclosPorAno)) {
      # A uti le asignamos el valor de la utilidad trimestral del año que corresponde al ciclo.
      # Ajuste para el índice (R empieza en 1, no en 0 como VBA)
      idx <- ((z - 1) %/% ciclosPorAno) + 1
      if (idx <= length(utilidad)) {
        uti[i + 1] <- uti[i + 1] + utilidad[idx]
      }
    }
  }
  
  return(uti)
}
escribirResultadosComparacion <- function(escenario, anosVividos, qalysVividos,
                                          LyPerdidos, qalysPerdidosMP, QalysPerdidosDIS,
                                          qalysPerdidos, muertesHIV, muertesTotales,
                                          casosHIV, casosHIVDx, TiempoSinDx, 
                                          CostoSano, CostoPrep, CostoHIV, 
                                          casosTotales, anosVividosD, qalysVividosD,
                                          anosPerdidosMPD, qalysPerdidosMPD, QalysPerdidosDD,
                                          qalysPerdidosD, cSanoD, cPrEPD, 
                                          cHIVd, cohorteSizeFinal) {
  resultados <- data.frame(
    Escenario = escenario,
    AnosVividos = c(anosVividos, anosVividosD),
    QALYsVividos = c(qalysVividos, qalysVividosD),
    LyPerdidos = c(LyPerdidos, anosPerdidosMPD),
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
  #nombreArchivo <- paste("prep/Resultados_Escenario_", escenario, ".xlsx", sep = "")
  #write.xlsx(resultados, file = nombreArchivo)
  
  return(resultados)
}



escribirOutput <- function(ciclo, ciclosPorAno, sanosSinPrep, sanosOffPrep, sanosOnPrep, infectadosSinDx,
                           infectadosPreDx, infectadosDx, muertosNoHiv, MuertosHIV, personasRiesgo, HIVTotales,
                           CasosNuevos, CasosAcumulados, nuevosDx, qalyNOHIV, qalyHIV, LyPerdidosMP, 
                           QalyPerdidosMP, Disutilidad, CostoSano, CostoPrep, CostoHIV) {
  # Crear una fila de datos
  fila_datos <- data.frame(
    Ciclo = ciclo,
    Ano = ciclo %/% ciclosPorAno,
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
  #write.table(fila_datos, file = "prep/resultados.csv", append = TRUE, sep = ",", col.names = FALSE, row.names = FALSE)
  
  return(fila_datos)
}

cargarDistribucion <- function(edadMin, edadMax, distribucion_cohortes) {
  
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
  
  # Calcular la diferencia en aos entre lo que se tiene y lo que se pide
  difAnos <- 33 - (edadMax - edadMin + 1)
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


####crear parametros

library(readxl)
library(dplyr)
library(rlang)

crearParametros <- function(linea) {
  # Leer los datos del archivo Excel
  parametros <- readxl::read_excel("prep/data/parametros.xlsx")
  
  # Lista de nombres de parámetros a extraer
  nombres_parametros <- c("Tamaño Cohorte:", "Tasa descuento:", "Edad Minima:", 
                          "Edad Final:", "Tipo Duracion:", "Duracion PrEP:", 
                          "Edad Maxima Inicial:", "PrEP upTake:", "Edad No Indicacion de PrEP",
                          "Limite edad Riesgo:", "Eficacia PrEP:", "Adherencia PrEP:",
                          "Limite edad Contagio:", "Cohorte Dinamica")
  
  nombres_parametros_nuevos <- c("cohorteSize", "tasaDescuento", "edadMinima", 
                                 "edadFinal", "tipoDuracion", "duracionPrEP", 
                                 "edadMaximaInicial", "PrEPuptake", "edadFinPrEP",
                                 "limiteEdadRiesgo", "eficaciaPrEP", "adherenciaPrEP",
                                 "limiteEdadContagiosos", "tipoCohorte")
  
  # Crear una lista vacía para almacenar los parámetros
  parametro <- list()
  
  # Bucle para extraer cada parámetro
  for (i in seq_along(nombres_parametros)) {
    nombre_original <- nombres_parametros[i]
    nombre_nuevo <- nombres_parametros_nuevos[i]
    
    parametro[[nombre_nuevo]] <- parametros %>%
      filter(Parametro == nombre_original) %>%
      select(!!sym(linea)) %>%
      as.numeric()
  }
  
  return(parametro)
}

###lista resultados

funcionCalculos <- function(parametros,pais) {
  

  #withProgress(message = "Ejecutando modelo", value=0, {#[LEAN2 tuve que sacar esto.]
    parametro1 <- list()
    parametro2 <- list()
    
    # Clasificar los elementos en las dos listas
    for (nombre in names(parametros)) {
      if (grepl("_nuevo$", nombre)) {
        parametro2[[gsub("_nuevo$", "", nombre)]] <- parametros[[nombre]]
      } else {
        parametro1[[nombre]] <- parametros[[nombre]]
      }
    }
    
    tipoCohorte=1
    tipoDuracion=1
    
    # Aplica funcionPrincipal para ambos escenarios
    #incProgress(0.2)
    funcionPrincipal("Baseline", pais, parametro1)
    resultados_baseline <<- resultados
    casosTotalesHIV <- resultados$CasosTotales[1]
    nuevosCasosHivDx <- resultados$CasosHIVDx[1]
    #incProgress(0.2)[LEAN2 tuve que sacar esto.]
    funcionPrincipal("Nuevo", pais, parametro2)
    resultados_nuevo <<- resultados
    casosTotalesHIV2 <- resultados$CasosTotales[1]
    nuevosCasosHivDx2 <- resultados$CasosHIVDx[1]
    
    # Cálculos de promedios, diferencias, etc.
    #Promedios
    if (tipoCohorte == 0) {
      
      AnosVividos_prom_escenario1 = resultados_baseline$AnosVividos[1] / parametro1$cohorteSize 
      AnosVividos_prom_escenario2 = resultados_nuevo$AnosVividos[1] / parametro2$cohorteSize
      qalysVividos_prom_escenario1 = resultados_baseline$QALYsVividos[1] / parametro1$cohorteSize 
      qalysVividos_prom_escenario2 = resultados_nuevo$QALYsVividos[1] / parametro2$cohorteSize
    }
    #LEAN2 TODO ESTO NO VA
    #32
    #LY_perdidos_MP_prom_escenario1 = resultados_baseline$LyPerdidos[1] / resultados_baseline$CasosTotales
    #LY_perdidos_MP_prom_escenario2 = resultados_nuevo$LyPerdidos[1] / resultados_nuevo$CasosTotales
    
    #33
    #qalys_perdidos_disc_prom_escenario1 = resultados_baseline$QALYsPerdidosDIS[1] / resultados_baseline$CasosTotales
    #qalys_perdidos_disc_prom_escenario2 = resultados_nuevo$QALYsPerdidosDIS[1] / resultados_nuevo$CasosTotales
    
    #34
    #qalys_perdidos_mp_prom_escenario1 = resultados_baseline$QALYsPerdidosMP[1] / resultados_baseline$CasosTotales
    #qalys_perdidos_mp_prom_escenario2 = resultados_nuevo$QALYsPerdidosMP[1] / resultados_nuevo$CasosTotales
    
    #35
    #qalys_perdidos_prom_escenario1 = resultados_baseline$QALYsPerdidos[1] / resultados_baseline$CasosTotales
    #qalys_perdidos_prom_escenario2 = resultados_nuevo$QALYsPerdidos[1] / resultados_nuevo$CasosTotales
    
    
    #41
    #qalys_perdidos_prom_escenario1 = resultados_baseline$TiempoSinDx[1] / resultados_baseline$CasosHIVDx
    #qalys_perdidos_prom_escenario2 = resultados_nuevo$TiempoSinDx[1] / resultados_nuevo$CasosHIVDx
    
    
    # ahora diferencias
    
    ##Columna total del excel
    #30
    AnosVividos_total <- resultados_nuevo$AnosVividos[1]-resultados_baseline$AnosVividos[1]
    
    #31
    qalysVividos_total <- resultados_nuevo$QALYsVividos[1]-resultados_baseline$QALYsVividos[1]
    
    #30d
    AnosVividos_total_d <- resultados_nuevo$AnosVividos[2]-resultados_baseline$AnosVividos[2]
    
    #31d
    qalysVividos_total_d <- resultados_nuevo$QALYsVividos[2]-resultados_baseline$QALYsVividos[2]
    #incProgress(0.2)[LEAN2 tuve que sacar esto.]
    #32
    
    LY_perdidos_MP_total <- resultados_nuevo$LyPerdidos[1]-resultados_baseline$LyPerdidos[1]
    LY_perdidos_MP_total_d <- resultados_nuevo$LyPerdidos[2] - resultados_baseline$LyPerdidos[2]
    
    #33
    
    qalys_perdidos_disc_total <-  resultados_nuevo$QALYsPerdidosDIS[1]-resultados_baseline$QALYsPerdidosDIS[1]
    qalys_perdidos_disc_total_d <-  resultados_nuevo$QALYsPerdidosDIS[2]-resultados_baseline$QALYsPerdidosDIS[2]
    #34
    
    qalys_perdidos_mp_total <-  resultados_nuevo$QALYsPerdidosMP[1]-resultados_baseline$QALYsPerdidosMP[1]
    
    #35
    
    qalys_perdidos_total <-  resultados_nuevo$QALYsPerdidos[1]-resultados_baseline$QALYsPerdidos[1]
    
    #36
    
    muertes_hiv_total <-  resultados_nuevo$MuertesHIV[1]-resultados_baseline$MuertesHIV[1]
    
    
    #37
    
    muertes_hiv_prop_total <-  resultados_nuevo$ProporcionMuertesHIV[1]-resultados_baseline$ProporcionMuertesHIV[1]
    #38
    
    casos_hiv_nuevos_total <-  resultados_nuevo$CasosHIV[1]-resultados_baseline$CasosHIV[1]
    
    #39
    nuevos_casos_HIV_dx_total= nuevosCasosHivDx2 - nuevosCasosHivDx
    #incProgress(0.2)[LEAN2 tuve que sacar esto.]
    
    # 40
    casos_totales_HIV_total <- casosTotalesHIV2 - casosTotalesHIV
    
    #41
    tiempo_sin_dx_total <-  resultados_nuevo$TiempoSinDx[1]-resultados_baseline$TiempoSinDx[1]
    
    #42
    costo_sano_testeo_total <-  resultados_nuevo$CostoSano[1]-resultados_baseline$CostoSano[1]
    #43
    costo_prep_total <-  resultados_nuevo$CostoPrep[1]-resultados_baseline$CostoPrep[1]
    #44
    costo_hiv_total <-  resultados_nuevo$CostoHIV[1]-resultados_baseline$CostoHIV[1]
    
    #45
    costo_total <-  resultados_nuevo$CostoTotal[1]-resultados_baseline$CostoTotal[1]
    
    
    costo_sano_testeo_total_d <- resultados_nuevo$CostoSano[2]-resultados_baseline$CostoSano[2]
    costo_prep_total_d <- resultados_nuevo$CostoPrep[2]-resultados_baseline$CostoPrep[2]
    costo_hiv_total_d <- resultados_nuevo$CostoHIV[2]-resultados_baseline$CostoHIV[2]
    costo_total_d <- resultados_nuevo$CostoTotal[2]-resultados_baseline$CostoTotal[2]
    
    #incProgress(0.2)
    
    #46
    
    Costo_incremental_Qaly <- costo_total/qalysVividos_total
    Costo_incremental_Qaly_d <- costo_total_d/qalysVividos_total_d
    Costo_incremental_AVAD <- costo_total / -(qalys_perdidos_disc_total + LY_perdidos_MP_total)
    Costo_incremental_AVAD_d <- costo_total_d / -(qalys_perdidos_disc_total_d + LY_perdidos_MP_total_d)
    
    #47  
    Costo_incremental_Ano_vida <- costo_total/ -(LY_perdidos_MP_total)
    Costo_incremental_Ano_vida_d <- costo_total_d/ -(LY_perdidos_MP_total_d)
    
    Costo_Incremental_VidaSalvada <- costo_total / -(muertes_hiv_total)
    Costo_Incremental_VidaSalvada_d <- costo_total_d / -(muertes_hiv_total)
    
    
    ROI <- -costo_total/costo_prep_total*100
    
    ROI_d <- -costo_total_d/costo_prep_total_d*100
    
    # Crear una lista para almacenar todos los resultados
    lista_resultados1 <<- data.frame(
      AnosVividos_total = AnosVividos_total,
      qalysVividos_total = qalysVividos_total,
      AnosVividos_total_d = AnosVividos_total_d,
      qalysVividos_total_d = qalysVividos_total_d,
      LY_perdidos_MP_total = LY_perdidos_MP_total, # Años de vida salvados
      qalys_perdidos_disc_total = (qalys_perdidos_disc_total ),# Años de vida ajustados por discapacidad evitados
      qalys_perdidos_mp_total = "qalys_perdidos_mp_total",
      qalys_perdidos_total = qalys_perdidos_total,
      muertes_hiv_total = muertes_hiv_total,
      muertes_hiv_prop_total = muertes_hiv_prop_total,
      casos_hiv_nuevos_total = casos_hiv_nuevos_total,
      nuevos_casos_HIV_dx_total = nuevos_casos_HIV_dx_total,
      casos_totales_HIV_total = casos_totales_HIV_total,
      tiempo_sin_dx_total = tiempo_sin_dx_total,
      costo_sano_testeo_total = costo_sano_testeo_total,
      costo_prep_total = costo_prep_total,
      costo_hiv_total = costo_hiv_total,
      costo_total = costo_total,
      costo_sano_testeo_total_d = costo_sano_testeo_total_d,
      costo_prep_total_d = costo_prep_total_d,
      costo_hiv_total_d = costo_hiv_total_d,
      costo_total_d = costo_total_d,
      Costo_incremental_Qaly = Costo_incremental_Qaly,
      Costo_incremental_Qaly_d = Costo_incremental_Qaly_d,
      Costo_incremental_Ano_vida = Costo_incremental_Ano_vida,
      Costo_incremental_Ano_vida_d = Costo_incremental_Ano_vida_d,
      ROI = ROI,
      ROI_d = ROI_d
    )
    
    # Crear una lista para almacenar todos los resultados
    lista_resultados1 <<- data.frame(
      AnosVividos_total = "",
      qalysVividos_total = "",
      AnosVividos_total_d = "",
      qalysVividos_total_d = "",
      AnosVidaSalvados = -LY_perdidos_MP_total, # Años de vida salvados
      AVADEvitados = -(qalys_perdidos_disc_total + LY_perdidos_MP_total),# Años de vida ajustados por discapacidad evitados
      AnosVidaSalvados_d = -LY_perdidos_MP_total_d,
      AVADEvitados_d = -(qalys_perdidos_disc_total_d + LY_perdidos_MP_total_d),
      muertesEvitadas = -(muertes_hiv_total), # Muertes evitadas
      muertes_hiv_prop_total = "",
      casosEvitados = -(casos_hiv_nuevos_total), #Casos de HIV evitados
      nuevos_casos_HIV_dx_total = "",
      casos_totales_HIV_total = "",
      tiempo_sin_dx_total = "",
      RCEIVidaSalvada = Costo_Incremental_VidaSalvada, #Razon de costo-efectividad incremental por vida salvada
      costoIntervencion = costo_prep_total, #Costo total de la intervención
      costosEvitados = -(costo_hiv_total + costo_sano_testeo_total), #Costos evitados atribuibles a la intervención
      diferenciaCostos = costo_total,#Diferencia de costos respecto al escenario basal
      RCEIVidaSalvada_d = Costo_Incremental_VidaSalvada_d, #Razon de costo-efectividad incremental por vida salvada descontada
      costoIntervencion_d = costo_prep_total_d, #Costo total de la intervención descontado
      costosEvitados_d = -(costo_hiv_total_d + costo_sano_testeo_total_d), #Costos evitados atribuibles a la intervención descontados
      diferenciaCostos_d = costo_total_d, #Diferencia de costos descontados
      RCEIAVAD = Costo_incremental_AVAD, #RCEI por año de vida ajustado por discapacidad evitado
      RCEIAVAD_d = Costo_incremental_Qaly_d, #Razon de costo-efectividad incremental por año de vida ajustado por discapacidad evitado descontada
      RCEIAnoVidaSalvado = Costo_incremental_Ano_vida, #Razon de costo-efectividad incremental por año de vida salvado 
      RCEIAnoVidaSalvado_d = Costo_incremental_Ano_vida_d, #Razon de costo-efectividad incremental por año de vida salvado descontada
      ROI = ROI, #Retorno sobre inversión
      ROI_d = ROI_d #Retorno sobre inversión
    )
    
    # Convertir el dataframe a formato largo
    lista_resultados <- stack(lista_resultados1)
    
    # Renombrar las columnas
    names(lista_resultados) <- c("Valor", "Parametro")
    
    # Ordena las columnas para que "Parametro" esté primero
    lista_resultados<- lista_resultados[, c("Parametro", "Valor")]
    
  #})#[LEAN2 tuve que sacar esto.]
  
  
  return(lista_resultados)
}



funcionPrincipal <- function(linea,paisCol, parametro){
  #[LEAN2]
  #Parametros Hardcodeados de configuración.
  tipoCohorte = 1
  tipoDuracion = 1
  calculoPorRiesgo <- 0
  riesgoHIV <- 0
  anosMaximosPrEP <- 5
  anosHastaClinica <- 10
  anosHastaComplicacion <- 10
  cohorteDinamicaIngresanEnfermos <- 1
  prevalenciaAnoMinimo = 0.012
# Usando list2env para crear variables en el entorno global
list2env(parametro, envir = .GlobalEnv)
  

input_prep <- readxl::read_excel("prep/data/inputs_prep.xlsx")

# datos_paises <- readxl::read_excel("prep/data/Datos_paises.xlsx")
# utilidades <- readxl::read_excel("prep/data/utilidades.xlsx")
# utilidades2 <- readxl::read_excel("prep/data/utilidades.xlsx", sheet = "Hoja2")
probabilidades <- readxl::read_excel("prep/data/probabilidades.xlsx")
parametros <- readxl::read_excel("prep/data/parametros.xlsx")
#costos <- readxl::read_excel("prep/data/Costos.xlsx")
#probabilidad_muerte <- readxl::read_excel("prep/data/PROBABILIDAD_MUERTE.xlsx")
probabilidad_muerte <-input_prep %>% filter(PAIS==paisCol & tipo=="PROBABILIDAD_MUERTE") %>% select(VALOR) %>% as.data.frame()
distribucion_cohortes <- readxl::read_excel("prep/data/DISTRIBUCION_COHORTES.xlsx")
utilidades2 <- input_prep %>% filter(PAIS==paisCol & tipo=="UTILIDAD") %>% select(VALOR) %>% as.data.frame()


casosIncidentes = input_prep %>%  filter(PAIS==paisCol & PARAMETRO=="Nuevos casos HIV en poblacion") %>% select(VALOR) %>% as.numeric()
casosPrevalentes = input_prep %>% filter(PAIS==paisCol & PARAMETRO=="Casos Prevalentes HIV en poblacion") %>% select(VALOR) %>% as.numeric()
prevalenciaHIV =input_prep %>% filter(PAIS==paisCol & PARAMETRO=="% de HIV en la poblacion") %>% select(VALOR) %>% as.numeric()
pHIVDiagnosticado = input_prep %>% filter(PAIS==paisCol & PARAMETRO=="% de hiv diagnosticados") %>% select(VALOR) %>% as.numeric()
pHIVTratado =input_prep %>% filter(PAIS==paisCol & PARAMETRO=="% de hiv tratados") %>% select(VALOR) %>% as.numeric()
pHIVControlado = input_prep %>% filter(PAIS==paisCol & PARAMETRO=="% de hiv controlados") %>% select(VALOR) %>% as.numeric()
esperanzaVida = input_prep %>% filter(PAIS==paisCol & PARAMETRO=="Esperanza de Vida") %>% select(VALOR) %>% as.numeric()


## PARAMETRO QUE NO ESTA EN LOS INPUTS
rrHIVDiagnosticadoNoTratados = 0.43 # ver luego


#'Seteos basales
testPorAno = 1 #definodo en hoja 6
escribir = "True"
ciclosPorAno = 4 #El modelo hace ciclos trimestrales
tasaDescuento = descuento / ciclosPorAno #Calculamos la tasa de descuento trimestral.


uHIV = input_prep %>% 
  filter(PAIS=="GLOBAL" & tipo=="UTILIDAD" & PARAMETRO=="Early HIV") %>%
  select(VALOR) %>% as.numeric()
uHIVTTO = input_prep %>% filter(PAIS=="GLOBAL" & tipo=="UTILIDAD" & PARAMETRO=="TTO") %>%  select(VALOR) %>% as.numeric()
  

cuHIV = uHIV / ciclosPorAno 
cuHIVTTO = uHIVTTO / ciclosPorAno 

##1

#[Modificado LEAN]
uPoblacion <- numeric(101)  # Crear un vector para almacenar los datos
cuPoblacion <- numeric(101)


for (z in 0:100) {
  uPoblacion[z + 1] <- utilidades2[z + 1,1]
  cuPoblacion[z + 1] <- uPoblacion[[z + 1]] / ciclosPorAno
}
#[/Modificado LEAN]

##
aReiniciarPrEP <- numeric(5)
aAbandonoPrEP <- numeric(5)

for (z in 1:5) {
  aReiniciarPrEP[z] <- probabilidades[6 + z, 2]
}

for (z in 1:5) {
  aAbandonoPrEP[z] <- probabilidades[z, 2]
}

# cargamos costos
# '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

cComplicacionesHIV =input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="COMPLICACIONES") %>%
  select(VALOR) %>% as.numeric()
cComplicacionesHIV = cComplicacionesHIV /ciclosPorAno

cDiagnostico =input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="DIAGNOSTICO") %>%
  select(VALOR) %>% as.numeric()

cSeguimientoHIV_anual = input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="SEGUIMIENTO") %>%
  select(VALOR) %>% as.numeric()

cSeguimientoHIV <- cSeguimientoHIV_anual/ciclosPorAno

cTratamientoHIV_anual =input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="TRATAMIENTO") %>%
  select(VALOR) %>% as.numeric()

cTratamientoHIV <- cTratamientoHIV_anual/ciclosPorAno

cPrEPTratamiento_anual = input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="PREP_TTO") %>%
  select(VALOR) %>% as.numeric()

cPrEPTratamiento <- cPrEPTratamiento_anual/ciclosPorAno


cPrEPSeguimiento_anual = input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="PREP_SEGUIMIENTO") %>%
  select(VALOR) %>% as.numeric()

cPrEPSeguimiento <- cPrEPSeguimiento_anual/ciclosPorAno

  cPrEPTest_anual = input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="PREP_TEST") %>%
  select(VALOR) %>% as.numeric()

cPrEPTest <-  cPrEPTest_anual/ciclosPorAno

cConsulta = input_prep %>% 
  filter(PAIS==paisCol & tipo=="COSTOS" & PARAMETRO=="CONSULTA") %>%
  select(VALOR) %>% as.numeric()

# 'Cargamos la array de utilidad restante.
utilidadRestante = calcularUtilidadRestante(ciclosPorAno, esperanzaVida, cuPoblacion)


#'Calculamos cada cuantos ciclos se testea.
testeoNoPrEP = ciclosPorAno / testPorAno

#'Asignamos el tamaño final de la cohorte al tamaño inicial.

cohorteSizeFinal = cohorteSize

if (calculoPorRiesgo == 0)#[LEAN2]
{
  casosDiagnosticados = casosPrevalentes * pHIVDiagnosticado
  casosNoDiagnosticados = casosPrevalentes - casosDiagnosticados
  casosTratados = casosDiagnosticados * pHIVTratado
  # 'Estos son los casos no tratados dentro de los diagnosticados...
  casosNoTratados = casosDiagnosticados - casosTratados
  # 'Casos no controlados dentro de los tratados.
  casosNoControlados = casosTratados * (1 - pHIVControlado)
  
  #'Calculamos la tasaTransmision para pacientes infectados no diagnosticados.
  
  tasaTransmision <- (casosIncidentes / pHIVDiagnosticado) / (casosNoDiagnosticados + (rrHIVDiagnosticadoNoTratados * (casosNoTratados + casosNoControlados)))
  
  #'Calculamos la tasa de transmision para pacientes diagnosticados pero no tratados y para aquellos tratados no controlados.
  tasaTransmisionNoControlados = tasaTransmision * rrHIVDiagnosticadoNoTratados
}
else
{
  
  casosDiagnosticados = (cohorteSize * prevalenciaHIV) * pHIVDiagnosticado
  casosNoDiagnosticados = (cohorteSize * prevalenciaHIV) - casosDiagnosticados
  casosTratados = casosDiagnosticados * pHIVTratado
  casosNoTratados = casosDiagnosticados - casosTratados #Estos son los casos no tratados dentro de los diagnosticados...
  casosNoControlados = casosTratados * (1 - pHIVControlado) #Casos no controlados dentro de los tratados.
  
  #Calculamos la tasaTransmision para pacientes infectados no diagnosticados.
  tasaTransmision = (((cohorteSize - (cohorteSize * prevalenciaHIV)) * riesgoHIV)) / (casosNoDiagnosticados + (rrHIVDiagnosticadoNoTratados * (casosNoTratados + casosNoControlados)))
  #Calculamos la tasa de transmision para pacientes diagnosticados pero no tratados y para aquellos tratados no controlados.
  tasaTransmisionNoControlados = tasaTransmision * rrHIVDiagnosticadoNoTratados
  
  
}#[/LEAN2]

#'Definimos el numero de años que durara el modelo, el mismo corre hasta que el menor de la cohorte cumpla 100 años.
anosRango = edadFinal - edadMinima
#Definimos el numero de ciclos.
numeroCiclos = anosRango * ciclosPorAno


if (duracionPrEP == 0)#[LEAN2]
{
  ciclosPrEPON <- 5
  ciclosPrEPOFF <- 5
# Definimos la configuración
} else if (tipoDuracion == 0) {
  # Un usuario recibe PrEP por la duración que hayan asignado
  if (duracionPrEP == 99) {
    # La intervención dura hasta la edad de fin de indicación de PrEP
    # El estadio onPrep tiene 5 años de túneles para tener probabilidades distintas
    # Al llegar al último año se asume que es la probabilidad final de abandono de PrEP
    ciclosPrEPON <- 5 * ciclosPorAno
  } else {
    # Si duración PrEP es distinta a 99 se le da un túnel por cada año
    ciclosPrEPON <- duracionPrEP * ciclosPorAno
  }
} else if (tipoDuracion == 1) {
  # La medida dura lo que hayan asignado en duración
  # Es decir, todos reciben PrEP durante el mismo tiempo
  if (anosMaximosPrEP > duracionPrEP | anosMaximosPrEP == 0)
  {
    anosMaximosPrEP = duracionPrEP
  }
  if (anosMaximosPrEP < 5)
  {
    ciclosPrEPON <- anosMaximosPrEP * ciclosPorAno
  } else {
    ciclosPrEPON <- 5 * ciclosPorAno
  }
}#[/LEAN2]

#ciclosPrEPoff siempre tiene 5 años d tuneles con distintas probabilidades.
ciclosPrEPOFF = 5 * ciclosPorAno

pAbandonoPrEP <- list()
for (z in 1:ciclosPrEPON) {
  if (z <= 5 * ciclosPorAno)
  {
    rTemp <- -log(1 - as.numeric(aAbandonoPrEP[((z - 1) %/% ciclosPorAno) + 1]))
    pAbandonoPrEP[z] <- 1 - exp(-rTemp * (1 / ciclosPorAno))
  }
  else
    
  {
    pAbandonoPrEP[z] <- pAbandonoPrEP[5 * ciclosPorAno]
  }
}

pReiniciarPrEP <- list()
for (z in 1:ciclosPrEPOFF) {
  if (z <= 5 * ciclosPorAno)
  {
    rTemp <- -log(1 - as.numeric(aReiniciarPrEP[((z - 1) %/% ciclosPorAno) + 1]))
    pReiniciarPrEP[z] <- 1 - exp(-rTemp * (1 / ciclosPorAno))
  }
  else
  {
    pReiniciarPrEP[z] <- pReiniciarPrEP[5 * ciclosPorAno]
    
  }
}

pMuerteGeneral <- NULL
pMuerteGeneral <- numeric(101)  
for (z in 1:86) {
  pMuerteGeneral[14+z] <- 1 - exp(-probabilidad_muerte[z , 1] * (1 / ciclosPorAno))
  print(pMuerteGeneral[14+z])
}

pMuerteGeneral

pMuerteHIV <- numeric(101) 
for (z in 1:86) {
  tasaMortalidad <- probabilidades[z, 6]  
  pMuerteHIV[14 + z] <- 1 - exp(-(-log(1 - tasaMortalidad)) * (1 / ciclosPorAno))
  print(pMuerteHIV[14 + z])
}

##

distribucionCohorte <- cargarDistribucion(edadMinima, edadMaximaInicial, distribucion_cohortes)


##creo modelo #######
modelo <- list()
modelo$ciclos <- vector("list", numeroCiclos + 1)  # +1 porque R indexa desde 1



# Inicializar estructuras para el primer ciclo
modelo$ciclos[[1]]$SanoOnPrEP <- vector("list", ciclosPrEPON)
modelo$ciclos[[1]]$SanoOffPrEP <- vector("list", ciclosPrEPOFF)
modelo$ciclos[[1]]$SanoSinPrEP <- list(Personas = numeric(edadFinal))
#modelo$ciclos[[1]]$InfectadoDx <- list(Personas = numeric(edadFinal))#[LEAN2]
#modelo$ciclos[[1]]$InfectadoNoDx <- list(Personas = numeric(edadFinal))#[LEAN2]
modelo$ciclos[[1]]$InfectadoDx <- vector("list", ciclosPorAno * anosHastaComplicacion)#[LEAN2]
modelo$ciclos[[1]]$InfectadoNoDx <- vector("list", ciclosPorAno * anosHastaClinica)#[LEAN2]
modelo$ciclos[[1]]$InfectadoPreDx <- list(Personas = numeric(edadFinal))
modelo$ciclos[[1]]$MuerteGeneral <- list(Personas = numeric(edadFinal))
modelo$ciclos[[1]]$MuerteHIV <- list(Personas = numeric(edadFinal))

modelo$ciclos[[1]]$nuevosCasos <- 0
modelo$ciclos[[1]]$nuevosCasosDx <- 0
modelo$ciclos[[1]]$CostoPrEP <- 0
modelo$ciclos[[1]]$CostoHIV <-0
modelo$ciclos[[1]]$CostoSano <- 0
modelo$ciclos[[1]]$CasosAcumulados <- 0
#modelo$ciclos[[1]]$SanosOffPrEPTotal <- 0
modelo$casosHIVDx <-0
modelo$casosHIV <-0
finalizados=0

i <- 1
# Suponiendo que 'escribir' es una variable lógica (TRUE/FALSE)
modelo$ciclos[[1]]$SanoSinPrEP$Total =0
modelo$ciclos[[i]]$InfectadoNoDxTotal=0
modelo$ciclos[[1]]$InfectadoPreDx$Total=0
modelo$ciclos[[1]]$InfectadoDxTotal=0#[LEAN2]
modelo$ciclos[[1]]$MuerteGeneral$Total=0
modelo$ciclos[[1]]$MuerteHIV$Total=0

for (z in 1:ciclosPrEPON) {
  modelo$ciclos[[1]]$SanoOnPrEP[[z]]$Personas <- numeric(edadFinal)
}


for (z in 1:ciclosPrEPOFF) {
  modelo$ciclos[[1]]$SanoOffPrEP[[z]]$Personas <- numeric(edadFinal)
}
#[LEAN2]
for (z in 1:(ciclosPorAno * anosHastaComplicacion)) {
  modelo$ciclos[[1]]$InfectadoDx[[z]]$Personas <- numeric(edadFinal)
  
}
for (z in 1:(ciclosPorAno * anosHastaClinica)) {
  modelo$ciclos[[1]]$InfectadoNoDx[[z]]$Personas <- numeric(edadFinal)
  print(modelo$ciclos[[1]]$InfectadoNoDx[[z]]$Personas[18])
}

prevalencia <- list()

for (z in 1:100)
{
  if (z >= 15)
  {
    prevalencia[z] = as.numeric(distribucion_cohortes[5 + (z - 14), 10])
  }
  else
  {
    prevalencia[z] = 0
  }
}

prevInfectados <- 0
for (z in edadMinima:edadMaximaInicial)
{
  prevInfectados = prevInfectados + (cohorteSize * distribucionCohorte[z] * prevalencia[[z]])
}

# Asignar valores iniciales

#modelo$ciclos[[1]]$SanosTotal <- cohorteSize * (1 - prevalenciaHIV)
modelo$ciclos[[1]]$SanosTotal <- cohorteSize - prevInfectados
modelo$ciclos[[1]]$SanosOnPrEPTotal <- modelo$ciclos[[1]]$SanosTotal * PrEPuptake
modelo$ciclos[[1]]$SanosOffPrEPTotal<- 0
modelo$ciclos[[1]]$SanoSinPrEP$Total <- modelo$ciclos[[1]]$SanosTotal * (1 - PrEPuptake)
#modelo$ciclos[[1]]$InfectadosTotal <- cohorteSize * prevalenciaHIV
modelo$ciclos[[1]]$InfectadosTotal <- prevInfectados

#modelo$ciclos[[1]]$InfectadoDx$Total <- modelo$ciclos[[1]]$InfectadosTotal * pHIVDiagnosticado
modelo$ciclos[[1]]$InfectadoDxTotal <- modelo$ciclos[[1]]$InfectadosTotal * pHIVDiagnosticado
modelo$ciclos[[1]]$InfectadoNoDxTotal <- modelo$ciclos[[1]]$InfectadosTotal * (1 - pHIVDiagnosticado)

modelo$ciclos[[1]]$MuerteGeneral$Total <-0
#modelo$ciclos[[2]]$MuerteGeneral$Total <-0
modelo$ciclos[[1]]$InfectadoPreDx$Total <- 0
# Distribuir la población inicial en los estados
totalCheck <- 0
#[LEAN] 
#Esto es innecesario correrlo desde 1, deberia correrse desde edad minima. Pero si lo corres asi en cada ciclo son 18 iteraciones innecesarias por ciclo.
for (i in 1 : edadMaximaInicial) {
  
  modelo$ciclos[[1]]$SanoOnPrEP[[1]]$Personas[i] <- modelo$ciclos[[1]]$SanosOnPrEPTotal * distribucionCohorte[i]
  modelo$ciclos[[1]]$SanoSinPrEP$Personas[i] <- modelo$ciclos[[1]]$SanoSinPrEP$Total * distribucionCohorte[i]
  
  modelo$ciclos[[1]]$InfectadoDx[[1]]$Personas[i] <- (cohorteSize * distribucionCohorte[i] * prevalencia[[i]]) * pHIVDiagnosticado   #modelo$ciclos[[1]]$InfectadoDx$Total * distribucionCohorte[i]
  modelo$ciclos[[1]]$InfectadoNoDx[[1]]$Personas[i] <- (cohorteSize * distribucionCohorte[i] * prevalencia[[i]]) * (1 - pHIVDiagnosticado)  #modelo$ciclos[[1]]$InfectadoNoDxTotal * distribucionCohorte[i]
  totalCheck <- sum(totalCheck , modelo$ciclos[[1]]$SanoOnPrEP[[1]]$Personas[i] , 
    modelo$ciclos[[1]]$SanoSinPrEP$Personas[i],
    modelo$ciclos[[1]]$InfectadoDx[[1]]$Personas[i] , 
    modelo$ciclos[[1]]$InfectadoNoDx[[1]]$Personas[i], na.rm = T)
  
  
}


# Manejar la dinámica de la cohorte

if (tipoCohorte == 1)
{
  genteEntrante <- cohorteSize  * distribucionCohorte[edadMinima]
  
  if (cohorteDinamicaIngresanEnfermos == 1)
  {
    enfermoEntrante <- genteEntrante * prevalenciaAnoMinimo
    sanoEntrante <- genteEntrante - enfermoEntrante
  }
  else
  {
    sanoEntrante <- genteEntrante
  }
}
else
{
  genteEntrante <- 0
  sanoEntrante <- 0
  enfermoEntrante <- 0
}






# Calcular total de infectados
modelo$ciclos[[1]]$InfectadosTotal <- modelo$ciclos[[1]]$InfectadoDxTotal + modelo$ciclos[[1]]$InfectadoNoDxTotal
#[/LEAN2]

# Las personas en riesgo son los sanos
personasRiesgo <- modelo$ciclos[[1]]$SanosTotal


# Calculamos el modificador de eficacia basado en la adherencia
efModifier <- (0.13 / 0.86) * eficaciaPrEP

# Calculamos el riesgo relativo (rrPrEP) basado en la adherencia
if (adherenciaPrEP >= 0.8) {
  rrPrEP <- 1 - eficaciaPrEP
} else if (adherenciaPrEP <= 0.2) {
  rrPrEP <- 1
} else {
  rrPrEP <- 1 - (eficaciaPrEP - (efModifier * ((0.8 - adherenciaPrEP) / 0.1)))
}

# Aseguramos que rrPrEP esté entre 0 y 1
rrPrEP <- min(max(rrPrEP, 0), 1)

# Asignar la cantidad de individuos diagnosticados contagiosos y no diagnosticados
DiagnosticadosContagiosos <- modelo$ciclos[[1]]$InfectadoDxTotal#[LEAN2]
NoDiagnosticadosContagiosos <- modelo$ciclos[[1]]$InfectadoNoDxTotal + modelo$ciclos[[1]]$InfectadoPreDx$Total

escribir <- TRUE
i <- 1


modelo$CostoPrEP <-0
if (escribir) {
  # Llamada a la función 'escribirOutput' con los argumentos correspondientes
  # Aquí asumimos que todas las propiedades (.Total, etc.) están definidas adecuadamente
  result <- escribirOutput(0, ciclosPorAno, modelo$ciclos[[i]]$SanoSinPrEP$Total, modelo$ciclos[[i]]$SanosOffPrEPTotal, 
                 modelo$ciclos[[i]]$SanosOnPrEPTotal, modelo$ciclos[[i]]$InfectadoNoDxTotal, 
                 modelo$ciclos[[i]]$InfectadoPreDx$Total, modelo$ciclos[[i]]$InfectadoDxTotal, 
                 modelo$ciclos[[i]]$MuerteGeneral$Total, modelo$ciclos[[i]]$MuerteHIV$Total, 
                 personasRiesgo, modelo$ciclos[[i]]$InfectadosTotal, 0, 0, modelo$ciclos[[i]]$nuevosCasosDx, 
                 0, 0, 0, 0, 0, 0, 0, 0)
}


# Establecer la edad inicial para el loop

edadLoopInicial <- edadMinima
# Si la cohorte es dinámica, la edad inicial siempre será edadMinima.
# Si no es dinámica, la lógica para ajustar edadLoopInicial deberá ser añadida.

cicloCounter <- 0
finalizados=0
modelo$anosVividos <- 0
modelo$anosVividosD <-0
modelo$qalysVividos <-0
modelo$qalysVividosD <-0
modelo$anosPerdidosMPHIV <-0
modelo$qalysPerdidosMPHIVD <-0
modelo$qalysPerdidosMPHIV <-0
modelo$qalysPerdidosDiscHIV <-0
modelo$qalysPerdidosDiscHIVD <-0
modelo$qalysPerdidos <-0
modelo$TiempoSinDx <- 0
modelo$CostoSano <- 0
modelo$CostoHIV <-0
modelo$CostoHIVD <-0
modelo$CostoPrEPD <-0
modelo$CostoPrEP <-0
modelo$CostoSano <- 0
modelo$CostoSanoD <- 0
modelo$qalysPerdidosD <-0
modelo$anosPerdidosMPHIVD <-0


#### inicia loop i #####
anosPasados <- 0
#numeroCiclos

for (i in 2:(numeroCiclos+1)) {

  #browser()
  # # Inicializar las estructuras para el i-ésimo ciclo

  

  modelo$ciclos[[i]]$SanoSinPrEP <- list(Personas = numeric(edadFinal), Total = 0)
  modelo$ciclos[[i]]$SanoOnPrEP <- vector("list", ciclosPrEPON)
  modelo$ciclos[[i]]$SanoOffPrEP <- vector("list", ciclosPrEPOFF)
  modelo$ciclos[[i]]$InfectadoDx <- vector("list", ciclosPorAno * anosHastaComplicacion) #list(Personas = numeric(edadFinal), Total = 0)#[LEAN2]
  modelo$ciclos[[i]]$InfectadoPreDx <-list(Personas = numeric(edadFinal),  Total = 0)
  modelo$ciclos[[i]]$InfectadoNoDx <- vector("list", ciclosPorAno * anosHastaClinica)  # list(Personas = numeric(edadFinal)) #[LEAN2]
  modelo$ciclos[[i]]$MuerteGeneral <-list(Personas = numeric(edadFinal))
  modelo$ciclos[[i]]$MuerteHIV <- list(Personas = numeric(edadFinal))
  modelo$ciclos[[i]]$nuevosCasos<- 0
  modelo$ciclos[[i]]$nuevosCasosDx<- 0
  modelo$ciclos[[i]]$InfectadoDxTotal <-0 #[LEAN2]
  modelo$ciclos[[i]]$InfectadoPreDx$Total <-0
  modelo$ciclos[[i]]$InfectadoNoDxTotal <-0
  modelo$ciclos[[i]]$SanoSinPrEP$Total <-0
  modelo$ciclos[[i]]$SanosOffPrEPTotal <-0
  modelo$ciclos[[i]]$SanosOnPrEPTotal <-0
  modelo$ciclos[[i]]$qalyHIV <-0
  modelo$ciclos[[i]]$qalyNOHIV <-0
  modelo$ciclos[[i]]$LyPerdidosHIVMP <- 0
  modelo$ciclos[[i]]$QalyPerdidoHIVMP <- 0
  modelo$ciclos[[i]]$Disutilidad <- 0
  modelo$ciclos[[i]]$CostoHIV <- 0
  modelo$ciclos[[i]]$CostoPrEP <- 0
  modelo$ciclos[[i]]$CostoSano <- 0
  for (z in 1:(ciclosPrEPON)) {
    modelo$ciclos[[i]]$SanoOnPrEP[[z]]$Personas <-numeric(edadFinal)
  }
  for (z in 1:(ciclosPrEPOFF)) {
    modelo$ciclos[[i]]$SanoOffPrEP[[z]]$Personas <- numeric(edadFinal)
  }
  #[LEAN2]
  for (z in 1:(ciclosPorAno * anosHastaClinica)) {
    modelo$ciclos[[i]]$InfectadoNoDx[[z]]$Personas <- numeric(edadFinal)
  }
  for (z in 1:(ciclosPorAno * anosHastaComplicacion)) {
    modelo$ciclos[[i]]$InfectadoDx[[z]]$Personas <- numeric(edadFinal)
  }
  #[/LEAN2]
  
  # Lógica para el contador de ciclos
  if (cicloCounter == 4) {
    cicloCounter <- 0
  }
  cicloCounter <- cicloCounter + 1
  

  #anoOffset <- 1
  # Si estamos en un ciclo múltiplo de 4, significa que ha pasado 1 año
  if (i %in% seq(5, numeroCiclos + 1, by = ciclosPorAno)) {
    anoOffset <- 1
    # Establecemos anoOffset en 1 para poder envejecer la población
    anosPasados <- anosPasados + 1
    # Sumamos un año
    # Si la cohorte es dinámica, la edad inicial del bucle sigue siendo la edad mínima
    if (tipoCohorte == 1) {
      edadLoopInicial <- edadMinima
      # Ha pasado 1 año, necesitamos ingresar nuevas personas a los estados
      if (tipoDuracion == 0 || (tipoDuracion == 1 && i < ciclosPorAno * duracionPrEP)) {
        modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[edadMinima] <- sanoEntrante * PrEPuptake #[LEAN2]
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[edadMinima] <- sanoEntrante * (1 - PrEPuptake)#[LEAN2]
      } else {
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[edadMinima] <- sanoEntrante#[LEAN2]
      }
      # Ajustamos el tamaño de la cohorte final
      cohorteSizeFinal <- cohorteSizeFinal + genteEntrante
    } else if (tipoCohorte == 0) {
      # Si la cohorte es estática, actualizamos la edad mínima para no iterar en estados vacíos
      edadLoopInicial <- edadMinima + anosPasados
    }
  } else {
    # Si no es múltiplo de 4, anoOffset es 0
    anoOffset <- 0
  }
  

  #browser()
 
        
  #Si hay personas en riesgo de contagiarse tenemos que calcular la probabilidad
  # Cálculo de la probabilidad de tener HIV en el ciclo
  # Verificamos si hay personas en riesgo de contagiarse
  

  
  if (personasRiesgo > 0) {
    
    
    if (calculoPorRiesgo == 2)#[LEAN2]
    {
      pAnualHIV <- riesgoHIV
    }
    else
    {
      # Calculamos la probabilidad anual de tener HIV
      pAnualHIV <- ((tasaTransmision * NoDiagnosticadosContagiosos) +
                      (tasaTransmisionNoControlados * ((DiagnosticadosContagiosos * (1 - pHIVTratado)) +
                                                         (DiagnosticadosContagiosos * pHIVTratado * (1 - pHIVControlado))))) / personasRiesgo
    }#[/LEAN2]

    # Limitamos la probabilidad anual a un máximo de 0.99
    if (pAnualHIV >= 1) {
      pAnualHIV <- 0.99
    }
    
    # Convertimos la probabilidad en tasa
    rAnualHIV <- -log(1 - pAnualHIV) # dividido por 1, que es equivalente a no cambiarlo
    
    # Recalculamos la probabilidad en el ciclo
    pCicloHIV <- 1 - exp(-rAnualHIV * (1 / ciclosPorAno))
  }
  
  

  # Inicializar variables para el siguiente ciclo
  DiagnosticadosContagiosos <- 0
  NoDiagnosticadosContagiosos <- 0
  personasRiesgo <- 0
  
 
  # Actualizar muertes totales y casos acumulados

    modelo$ciclos[[i]]$MuerteGeneral$Total <- modelo$ciclos[[i - 1]]$MuerteGeneral$Total
    modelo$ciclos[[i]]$MuerteHIV$Total <-modelo$ciclos[[i - 1]]$MuerteHIV$Total
    modelo$ciclos[[i]]$CasosAcumulados <-modelo$ciclos[[i - 1]]$CasosAcumulados
  
    #(edadMaximaInicial + anosPasados)
#inicia loop j --------------    
    #((edadMaximaInicial+ anosPasados)- 10)
  for (j in edadLoopInicial:(edadMaximaInicial+ anosPasados)) {

    
    if (j > (edadFinal)) {
      #if (i == 205)
      #{
      #  browser()
      #}
      # Si la edad es mayor que el límite (ej: 100 años), se finaliza el ciclo de esa edad
      if (anoOffset == 1 ) {#[LEAN2]
        finalizados <- finalizados + modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[100] + modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[100]
        for (z in 1:(ciclosPorAno*anosHastaComplicacion))
        {
          finalizados = finalizados + modelo$ciclos[[i - 1]]$InfectadoDx[[z]]$Personas[100]
        }
        for (z in 1:(ciclosPorAno*anosHastaClinica))
        {
          finalizados = finalizados + modelo$ciclos[[i - 1]]$InfectadoNoDx[[z]]$Personas[100]
        }
      }#[/LEAN2]
      break  # Salir del bucle de edad
    }
   
    
      
    # Inicializar contadores para este ciclo
    nuevosInfectadosSinPrEP <- 0
    nuevosInfectadosConPrEP <- 0
    conteoParcialSOFP <- 0
    conteoParcialSOP <- 0
    #[LEAN2]
    InfectadosNoDxParcial <- 0
    InfectadosDxParcial <- 0
    NoDxPasanADx <- 0
    
    if (tipoCohorte == 1 && cohorteDinamicaIngresanEnfermos == 1 && j == edadMinima && anoOffset == 1)
    {
      nuevosInfectadosSinPrEP = enfermoEntrante
    }
    #[/LEAN2]
    
    # Establecer la probabilidad de contagio de HIV a 0 si se supera el límite de edad de riesgo
    if (j > limiteEdadRiesgo) {
      pCicloHIV <- 0
    }
    
    # Manejo de cohortes dinámicas
    if (!(tipoCohorte == 1 && j == edadMinima && anoOffset == 1)) {
      
      # Cálculos para los sanos sin PrEP y ajustes por muerte general y contagio de HIV
  
      #browser()
      
      modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] <-
        modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[j - anoOffset] * pCicloHIV +
            modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
        )
      
      # Continuar con más cálculos y lógica dentro del bucle de edad
    
    #[LEAN] borro el i >= duracion porque i aca parte de 2 en este bucle.
    if (j <= edadFinPrEP &&
        !(tipoDuracion == 1 && i > duracionPrEP * ciclosPorAno)) {
      # Si todavía puede reiniciar PrEP
      
      
      #aca ya tiene asignado una cantidad de gente y suma gente a este mismo año [LEAN]
      modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] <-
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] +
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] -
            (
              modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
                modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * pCicloHIV +
                modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * as.numeric(pReiniciarPrEP[ciclosPrEPOFF])
            )
        
      
      # Para aquellos que reinician PrEP
      modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[j] <-
        modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * as.numeric(pReiniciarPrEP[ciclosPrEPOFF])
      
      # Contador de los que reinician PrEP
      conteoParcialSOP <-
        conteoParcialSOP + modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * as.numeric(pReiniciarPrEP[ciclosPrEPOFF])
      
    } else {
      # Si no pueden reiniciar PrEP
      modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] <-
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] +
        (
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] -
            (
              modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
                modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * pCicloHIV
            )
        )
    }
    
    # Actualizar las muertes generales y los nuevos infectados
    modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
      modelo$ciclos[[i - 1]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
      modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    nuevosInfectadosSinPrEP <-
      nuevosInfectadosSinPrEP + modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[j - anoOffset] * pCicloHIV +
      modelo$ciclos[[i - 1]]$SanoOffPrEP[[ciclosPrEPOFF]]$Personas[j - anoOffset] * pCicloHIV
    # '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HANDLING DE SANOS SIN PrEP Y LOS QUE ESTABAN EN EL ULTIMO CICLO DE SANO OFF PrEP.
    #
    #             'Los que estan en PrEP
    # 'Pueden discontinuar PrEP, morir por muerte general, contraer HIV
    #             'Y se sumaran aquellos que habiendo dejado PrEP vuelvan a iniciarla.
    #
    # 'Nos fijamos si estamos evaluando una edad dentro de la indicación de PrEP.
    #             'y si tipoDuracion = 1 nos fijamos que no este fuera de epoca de la indicación.
    
    #[LEAN] SACO I >= porque I ARRANCA EN 2
    if (j <= edadFinPrEP &&
        !(tipoDuracion == 1 && i > duracionPrEP * ciclosPorAno)) {
      # Verifica si estamos evaluando una edad dentro de la indicación de PrEP
      for (z in 2:(ciclosPrEPON -1 )) {
        # Actualiza las personas en PrEP en el estado actual (z)
        
       # browser()
       
        modelo$ciclos[[i]]$SanoOnPrEP[[z]]$Personas[j] <-
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] -
          (
            modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP +
              modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
          )
        
        # Resta los que abandonaron PrEP
        modelo$ciclos[[i]]$SanoOnPrEP[[z]]$Personas[j] <-
          modelo$ciclos[[i]]$SanoOnPrEP[[z]]$Personas[j] -
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[z - 1])
        
        # Agrega los nuevos abandonadores de PrEP al primer estado de SanoOffPrEP
        modelo$ciclos[[i]]$SanoOffPrEP[[1]]$Personas[j] <-
          modelo$ciclos[[i]]$SanoOffPrEP[[1]]$Personas[j] +
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[z - 1])
        
        # Actualiza muertes generales y nuevos infectados
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
          modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
        
        nuevosInfectadosConPrEP <-
          nuevosInfectadosConPrEP + modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP
        
        
        # Contadores para los que entran y salen de PrEP
        conteoParcialSOP <-conteoParcialSOP + modelo$ciclos[[i]]$SanoOnPrEP[[z]]$Personas[j]
        conteoParcialSOFP <-conteoParcialSOFP + modelo$ciclos[[i - 1]]$SanoOnPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(as.numeric(pAbandonoPrEP[z - 1]))
      }
    #} El IF NO CERRABA ACA.[LEAN]
    
    if (duracionPrEP < 99 && (tipoDuracion == 0 || (anosMaximosPrEP < duracionPrEP))) {
      # Maneja el último estadio de OnPrEP
      modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] <-
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] +
        (
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] -
            (
              modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP +
                modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
            )
        )
      
      nuevosInfectadosConPrEP <- nuevosInfectadosConPrEP +
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP
      
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    } else {
      
      modelo$ciclos[[i]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j] <-
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP +
            modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
            modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[ciclosPrEPON])
        )
      #[LEAN] Aca esta calculando los que abandonan entonces los suma al primer ciclo offPrEP
      #estaba puesto z y z aca no vale nada.
      modelo$ciclos[[i]]$SanoOffPrEP[[1]]$Personas[j] <-
        modelo$ciclos[[i]]$SanoOffPrEP[[1]]$Personas[j] +
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[ciclosPrEPON])
      
      conteoParcialSOFP <-
        conteoParcialSOFP + modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[ciclosPrEPON])
      
      
      
      
      nuevosInfectadosConPrEP <-
        nuevosInfectadosConPrEP + modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP
      
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      
      conteoParcialSOP <-
        conteoParcialSOP + modelo$ciclos[[i]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j]
    }
    
    # Agregar a los que estaban en el estado anterior de OnPrEP
    modelo$ciclos[[i]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j] <-
      modelo$ciclos[[i]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j] +
      modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] -
      (
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP +
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      )
    
    # Agregar nuevos infectados y manejar abandonos de PrEP
    nuevosInfectadosConPrEP <- nuevosInfectadosConPrEP +
      modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP
    
    modelo$ciclos[[i]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j] <-
      modelo$ciclos[[i]]$SanoOnPrEP[[ciclosPrEPON]]$Personas[j] -
      modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[ciclosPrEPON - 1])
    
    conteoParcialSOP <- conteoParcialSOP +
      (
        modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] -
          (
            modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP +
              modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
              modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[ciclosPrEPON - 1])
          )
      )
    
    modelo$ciclos[[i]]$SanoOffPrEP[[1]]$Personas[j] <-
      modelo$ciclos[[i]]$SanoOffPrEP[[1]]$Personas[j] +
      modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * as.numeric(pAbandonoPrEP[ciclosPrEPON - 1])
    
    conteoParcialSOFP <- conteoParcialSOFP +
      modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] *as.numeric(pAbandonoPrEP[ciclosPrEPON - 1])
    
    modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
      modelo$ciclos[[i - 1]]$SanoOnPrEP[[ciclosPrEPON - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    #ESTO ERA UN ELSE IF del ANTERIOR
    }
    else if (j == edadFinPrEP + 1 &&
        anoOffset == 1 ||
        (tipoDuracion == 1 && i == (duracionPrEP * ciclosPorAno)+1)){#ACA es +1 PORQUE I arranca en 2 [LEAN]
      for (z in 1:ciclosPrEPON) {
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] <-
          modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] +#aca no mira el ciclo anterior sino q lo suma al q esta
          (
            modelo$ciclos[[i - 1]]$SanoOnPrEP[[z]]$Personas[j - anoOffset] -
              (
                modelo$ciclos[[i - 1]]$SanoOnPrEP[[z]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
                  modelo$ciclos[[i - 1]]$SanoOnPrEP[[z]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP
              )
          )
        
        nuevosInfectadosConPrEP <- nuevosInfectadosConPrEP +
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[z]]$Personas[j - anoOffset] * pCicloHIV * rrPrEP
        
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
          modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
          modelo$ciclos[[i - 1]]$SanoOnPrEP[[z]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      }
    }
    
    
    
    #[LEAN] aca es i > porque I arranca en 2 y el bucle es z in 2:(ciclosPrEPOFF) porque lo que hace es ir pasando desde el 
    #ciclo previo al siguiente entonces tiene q llegar al ultimo para poder traer los del anteultimo
    if (j <= edadFinPrEP &&
        !(tipoDuracion == 1 && i > duracionPrEP * ciclosPorAno)) {
      for (z in 2:(ciclosPrEPOFF)) {
        modelo$ciclos[[i]]$SanoOffPrEP[[z]]$Personas[j] <-
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] -
          (
            modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * pCicloHIV +
              modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
              modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pReiniciarPrEP[z - 1])
          )
        
        modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[j] <-
          modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[j] +
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pReiniciarPrEP[z - 1])
        
        nuevosInfectadosSinPrEP <- nuevosInfectadosSinPrEP +
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * pCicloHIV
        
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
          modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
        
        conteoParcialSOFP <-
          conteoParcialSOFP + modelo$ciclos[[i]]$SanoOffPrEP[[z]]$Personas[j]
        conteoParcialSOP <-
          conteoParcialSOP + modelo$ciclos[[i - 1]]$SanoOffPrEP[[z - 1]]$Personas[j - anoOffset] * as.numeric(pReiniciarPrEP[z - 1])
      }
    #}[LEAN] mismo que antes, aca no cerraba el if.
    }
    else if (j == edadFinPrEP + 1 &&
        anoOffset == 1 ||
        (tipoDuracion == 1 && i == (duracionPrEP * ciclosPorAno)+1)) {#aca es +1 porque i arranca en 2 [LEAN]
      for (z in 1:(ciclosPrEPOFF - 1)) {
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] <-
          modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] + #[LEAN] aca es [i] no [i-1] sino perdes a todos los sanos que tenias hasta ese momento.
          (
            modelo$ciclos[[i - 1]]$SanoOffPrEP[[z]]$Personas[j - anoOffset] -
              (
                modelo$ciclos[[i - 1]]$SanoOffPrEP[[z]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
                  modelo$ciclos[[i - 1]]$SanoOffPrEP[[z]]$Personas[j - anoOffset] * pCicloHIV
              )
          )
        
        nuevosInfectadosSinPrEP <- nuevosInfectadosSinPrEP +
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[z]]$Personas[j - anoOffset] * pCicloHIV
        
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
          modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
          modelo$ciclos[[i - 1]]$SanoOffPrEP[[z]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      }
    }
    #[LEAN2]
    
    

    
    
    for (z in 2:(ciclosPorAno * anosHastaClinica))
    {
      modelo$ciclos[[i]]$InfectadoNoDx[[z]]$Personas[j] <-
        modelo$ciclos[[i - 1]]$InfectadoNoDx[[z - 1]]$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoNoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
            modelo$ciclos[[i - 1]]$InfectadoNoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
        )
      InfectadosNoDxParcial = InfectadosNoDxParcial + modelo$ciclos[[i]]$InfectadoNoDx[[z]]$Personas[j]
      
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$InfectadoNoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
        modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
        modelo$ciclos[[i - 1]]$InfectadoNoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    }

    NoDxPasanADx = modelo$ciclos[[i - 1]]$InfectadoNoDx[[ciclosPorAno * anosHastaClinica]]$Personas[j - anoOffset] - (modelo$ciclos[[i - 1]]$InfectadoNoDx[[ciclosPorAno * anosHastaClinica]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) + modelo$ciclos[[i - 1]]$InfectadoNoDx[[ciclosPorAno * anosHastaClinica]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset]))
    
    modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
      modelo$ciclos[[i - 1]]$InfectadoNoDx[[ciclosPorAno * anosHastaClinica]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
      modelo$ciclos[[i - 1]]$InfectadoNoDx[[ciclosPorAno * anosHastaClinica]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    
    modelo$ciclos[[i]]$InfectadoNoDx[[1]]$Personas[j] <- ((nuevosInfectadosSinPrEP) * (1 - pHIVDiagnosticado))
    
    InfectadosNoDxParcial = InfectadosNoDxParcial + modelo$ciclos[[i]]$InfectadoNoDx[[1]]$Personas[j]
    
    for (z in 2:(ciclosPorAno * anosHastaComplicacion))
    {
      # Actualizamos los infectados diagnosticados
      modelo$ciclos[[i]]$InfectadoDx[[z]]$Personas[j] <-
        modelo$ciclos[[i - 1]]$InfectadoDx[[z - 1]]$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
            modelo$ciclos[[i - 1]]$InfectadoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
        )
      InfectadosDxParcial = InfectadosDxParcial + modelo$ciclos[[i]]$InfectadoDx[[z]]$Personas[j]
      # Agregamos las muertes por causas generales y por HIV dentro de los Infectados dx
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$InfectadoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
        modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
        modelo$ciclos[[i - 1]]$InfectadoDx[[z - 1]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    }
    
    modelo$ciclos[[i]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j] <- modelo$ciclos[[i]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j] +
      modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] -
      (
        modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
          modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
      )
    
    modelo$ciclos[[i]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j] <- modelo$ciclos[[i]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j] + NoDxPasanADx
    
    InfectadosDxParcial = InfectadosDxParcial + NoDxPasanADx + modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] - (modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) + modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset]))
    
    # Agregamos las muertes por causas generales y por HIV dentro de los Infectados dx
    modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
      modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
      modelo$ciclos[[i - 1]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    
    
    
    # Actualizamos los infectados no diagnosticados
    #modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] <-
    #  modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] -
    #  (
    #    modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
    #      modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    #  )
    
    # Los que no están en PrEP tienen un porcentaje de ser diagnosticados
    #modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] <-
    #  modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] +
    #  (nuevosInfectadosSinPrEP * (1 - pHIVDiagnosticado))
    
    # Agregamos las muertes por causas generales y por HIV dentro de los Infectados no dx
    #modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
    #  modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
    #  modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    #modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
    #  modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
    #  modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    
    # Actualizamos los infectados diagnosticados
    #modelo$ciclos[[i]]$InfectadoDx$Personas[j] <-
    #  modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] -
    #  (
    #    modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
    #      modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    #  )
    
    # Agregamos las muertes por causas generales y por HIV dentro de los Infectados dx
    #modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
    #  modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
    #  modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    #modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
    #  modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
    #  modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    
    #[LEAN] aca es i-1 porque arranca en 2 y vos queres que testee en el ciclo 5.
    
    if ((i-1) %% testeoNoPrEP == 0) {
      # Ciclo diagnóstico
      modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
            modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
        )
      
      # Sin nuevos casos en este grupo para este ciclo
      modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] <- 0
      
      # Agregamos los nuevos casos diagnosticados
      modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] + (nuevosInfectadosSinPrEP * pHIVDiagnosticado) + nuevosInfectadosConPrEP
      
      InfectadosDxParcial = InfectadosDxParcial + ((nuevosInfectadosSinPrEP * pHIVDiagnosticado) + nuevosInfectadosConPrEP) +  modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
            modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
        )
      
      # Agregamos las muertes por causas generales y por HIV dentro de los PreDx
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
        modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    } else {
      # No es un ciclo de diagnóstico
      modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] + nuevosInfectadosConPrEP
      
      InfectadosDxParcial = InfectadosDxParcial + nuevosInfectadosConPrEP
      
      # Actualizamos los infectados PreDx
      modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] <-
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])+
            modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
        )
      
      # Le sumamos los casos nuevos que vienen de la rama sin PrEP
      modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] +
        nuevosInfectadosSinPrEP * pHIVDiagnosticado
      
      # Agregamos las muertes por causas generales y por HIV dentro de los PreDx
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
        modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    }
    
    # Si mueren antes de la esperanza de vida, agrega utilidad perdida
    if (j - anoOffset < esperanzaVida) {
      modelo$ciclos[[i]]$LyPerdidosHIVMP <- modelo$ciclos[[i]]$LyPerdidosHIVMP +
        (modelo$ciclos[[i]]$MuerteHIV$Personas[j] * (esperanzaVida - (j - anoOffset)))
      modelo$ciclos[[i]]$QalyPerdidoHIVMP <- modelo$ciclos[[i]]$QalyPerdidoHIVMP + (modelo$ciclos[[i]]$MuerteHIV$Personas[j] * utilidadRestante[(((j - anoOffset ) * ciclosPorAno ) + cicloCounter + 1)])
    }

    # Actualizar total de muertes generales
    modelo$ciclos[[i]]$MuerteGeneral$Total <-
      modelo$ciclos[[i]]$MuerteGeneral$Total +#[LEAN] aca es I porque sino, al analizar lagente de un año mas lo pisas.
      (
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] -
          modelo$ciclos[[i - 1]]$MuerteGeneral$Personas[j - anoOffset]
      )
    
    # Si es ciclo de testeo, agregar costos
    if ((i-1) %% testeoNoPrEP == 0) { 
      modelo$ciclos[[i]]$CostoSano <- modelo$ciclos[[i]]$CostoSano + #[LEAN] estas en un bucle J si pones I-1 lo pisa en la siguiente edad
        (cDiagnostico * (
          modelo$ciclos[[i]]$SanoSinPrEP$Personas[j] + conteoParcialSOFP
        ))
      
      modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV + #[LEAN] igual que arriba.
        ((
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] -
            (
              modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
                modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
            )
        ) *
          (cDiagnostico + cConsulta))
    } 
  } else {
      
      conteoParcialSOP <-
        modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[edadMinima]
      
      modelo$ciclos[[i]]$InfectadoNoDx[[1]]$Personas[j] = ((nuevosInfectadosSinPrEP) * (1 - pHIVDiagnosticado))
      InfectadosNoDxParcial = InfectadosNoDxParcial + modelo$ciclos[[i]]$InfectadoNoDx[[1]]$Personas[j]
      
      if (((i-1) %% testeoNoPrEP == 0))
      {
        modelo$ciclos[[i]]$InfectadoDx[[1]]$Personas[j] = ((nuevosInfectadosSinPrEP) * (pHIVDiagnosticado))
        InfectadosDxParcial = InfectadosDxParcial + ((nuevosInfectadosSinPrEP) * (pHIVDiagnosticado))
        
        modelo$ciclos[[i]]$CostoSano = modelo$ciclos[[i]]$CostoSano + (cDiagnostico * modelo$ciclos[[i]]$SanoSinPrEP$Personas[j])
        modelo$ciclos[[i]]$CostoHIV = modelo$ciclos[[i]]$CostoHIV + (nuevosInfectadosSinPrEP * (cDiagnostico + cConsulta))
      }
      else
      {
        modelo$ciclos[[i]]$InfectadoPreDx[1]$Personas[j] = modelo$ciclos[[i]]$InfectadoPreDx[1]$Personas[j] + nuevosInfectadosSinPrEP * pHIVDiagnosticado
      }
      
      
    }
    
    
    # Actualizar costos asociados con el tratamiento y seguimiento de VIH
    #modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV +
    #  (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * pHIVTratado * cTratamientoHIV) +
    #  (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * pHIVTratado * cSeguimientoHIV) +
    #  (((modelo$ciclos[[i]]$InfectadoDx$Personas[j] * (1 - pHIVTratado * pHIVControlado)) +
    #  modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] + modelo$ciclos[[i]]$InfectadoNoDx$Personas[j]
    #  ) * cComplicacionesHIV)
    
    modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV + (InfectadosDxParcial * pHIVTratado * (cTratamientoHIV + cSeguimientoHIV)) + ((modelo$ciclos[[i]]$InfectadoDx[[ciclosPorAno * anosHastaComplicacion]]$Personas[j] * (1 - (pHIVTratado * pHIVControlado))) * cComplicacionesHIV)#[LEAN2]
    modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV + (NoDxPasanADx * (cDiagnostico + cConsulta))#[LEAN2]
    
    # Actualizar costos de PrEP
    modelo$ciclos[[i]]$CostoPrEP <- modelo$ciclos[[i]]$CostoPrEP + (conteoParcialSOP * (cPrEPSeguimiento + cPrEPTratamiento + cPrEPTest))
    
    # Agregar costo de consulta para nuevos infectados con PrEP
    modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV + nuevosInfectadosConPrEP * cConsulta
    
    # Actualizar la disutilidad[LEAN] Asignamos el del ciclo.
    #
    modelo$ciclos[[i]]$Disutilidad <-
      modelo$ciclos[[i]]$Disutilidad +
      ((
        modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] + InfectadosNoDxParcial +
          (InfectadosDxParcial * (1 - pHIVTratado))
      ) * cuHIV
      ) + InfectadosDxParcial * pHIVTratado * cuHIVTTO#[LEAN2]
    
    #browser()
    
    # Actualizar totales y acumulados
    modelo$ciclos[[i]]$MuerteHIV$Total <-modelo$ciclos[[i]]$MuerteHIV$Total + modelo$ciclos[[i]]$MuerteHIV$Personas[j]
    #[Lean] estas asignaciones son intraciclo para juntar toda la info de las edades.
    modelo$ciclos[[i]]$InfectadoDxTotal <-modelo$ciclos[[i]]$InfectadoDxTotal + InfectadosDxParcial#[LEAN2]
    modelo$ciclos[[i]]$InfectadoPreDx$Total <-modelo$ciclos[[i]]$InfectadoPreDx$Total + modelo$ciclos[[i]]$InfectadoPreDx$Personas[j]
    modelo$ciclos[[i]]$InfectadoNoDxTotal <-modelo$ciclos[[i]]$InfectadoNoDxTotal + InfectadosNoDxParcial#[LEAN2]
    modelo$ciclos[[i]]$SanoSinPrEP$Total <-modelo$ciclos[[i]]$SanoSinPrEP$Total + modelo$ciclos[[i]]$SanoSinPrEP$Personas[j]
    modelo$ciclos[[i]]$SanosOffPrEPTotal <-modelo$ciclos[[i]]$SanosOffPrEPTotal + conteoParcialSOFP
    modelo$ciclos[[i]]$SanosOnPrEPTotal <-modelo$ciclos[[i]]$SanosOnPrEPTotal + conteoParcialSOP
    
    modelo$ciclos[[i]]$SanosTotal <-modelo$ciclos[[i]]$SanosOnPrEPTotal + modelo$ciclos[[i]]$SanosOffPrEPTotal + modelo$ciclos[[i]]$SanoSinPrEP$Total
    modelo$ciclos[[i]]$InfectadosTotal <-modelo$ciclos[[i]]$InfectadoPreDx$Total + modelo$ciclos[[i]]$InfectadoNoDxTotal + modelo$ciclos[[i]]$InfectadoDxTotal
    modelo$ciclos[[i]]$nuevosCasos <-modelo$ciclos[[i]]$nuevosCasos + nuevosInfectadosSinPrEP + nuevosInfectadosConPrEP
    modelo$ciclos[[i]]$nuevosCasosDx <-modelo$ciclos[[i]]$nuevosCasosDx +  (nuevosInfectadosSinPrEP * pHIVDiagnosticado)  + nuevosInfectadosConPrEP
    
    modelo$ciclos[[i]]$CasosAcumulados <-modelo$ciclos[[i]]$CasosAcumulados + nuevosInfectadosSinPrEP + nuevosInfectadosConPrEP
    # Calcular QALY para personas con VIH
    modelo$ciclos[[i]]$qalyHIV <- modelo$ciclos[[i]]$qalyHIV + 
      (modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] + InfectadosNoDxParcial + (InfectadosDxParcial * (1 - pHIVTratado))) * (cuPoblacion[j + 1] - cuHIV) +
      (InfectadosDxParcial * pHIVTratado * (cuPoblacion[j + 1] - cuHIVTTO))#[LEAN2]
   
     # Calcular QALY para personas sin VIH
    modelo$ciclos[[i]]$qalyNOHIV <- modelo$ciclos[[i]]$qalyNOHIV + (
      (
        conteoParcialSOFP + conteoParcialSOP + modelo$ciclos[[i]]$SanoSinPrEP$Personas[j]
      ) * cuPoblacion[j + 1]
    )
    

    
    # Establecer la población en riesgo
    if (j <= limiteEdadRiesgo) {
      
      personasRiesgo <- modelo$ciclos[[i]]$SanosTotal
    }
    
    # Si está por debajo del límite de edad contagiosa, agregar a aquellos que pueden contagiar
    if (j <= limiteEdadContagiosos) {
      DiagnosticadosContagiosos <-DiagnosticadosContagiosos + InfectadosDxParcial#[LEAN2]
      NoDiagnosticadosContagiosos <-NoDiagnosticadosContagiosos + InfectadosNoDxParcial  + modelo$ciclos[[i]]$InfectadoPreDx$Personas[j]#[LEAN2]
    }
    
    
  }##aca cierro loop j
  
  # Actualizar el total de casos de VIH diagnosticados y casos de VIH 
  modelo$casosHIVDx <-modelo$casosHIVDx + modelo$ciclos[[i]]$nuevosCasosDx
  modelo$casosHIV <-modelo$casosHIV + modelo$ciclos[[i]]$nuevosCasos
  
# Calcular los años vividos y descontados
  
  modelo$anosVividos <-
    modelo$anosVividos + (
      modelo$ciclos[[i]]$SanoSinPrEP$Total +
        modelo$ciclos[[i]]$SanosOffPrEPTotal + modelo$ciclos[[i]]$SanosOnPrEPTotal +
        modelo$ciclos[[i]]$InfectadoNoDxTotal + modelo$ciclos[[i]]$InfectadoPreDx$Total +
        modelo$ciclos[[i]]$InfectadoDxTotal
    ) / ciclosPorAno#[LEAN2]
  modelo$anosVividosD <-
    modelo$anosVividosD + (((
      modelo$ciclos[[i]]$SanoSinPrEP$Total +
        modelo$ciclos[[i]]$SanosOffPrEPTotal + modelo$ciclos[[i]]$SanosOnPrEPTotal +
        modelo$ciclos[[i]]$InfectadoNoDxTotal + modelo$ciclos[[i]]$InfectadoPreDx$Total +
        modelo$ciclos[[i]]$InfectadoDxTotal
    ) / ciclosPorAno
    ) / (1 + tasaDescuento) ^ (i-1))#[LEAN2]

  # Calcular QALYs vividos y descontados
  modelo$qalysVividos <-
    modelo$qalysVividos + modelo$ciclos[[i]]$qalyHIV + modelo$ciclos[[i]]$qalyNOHIV
  modelo$qalysVividosD <-
    modelo$qalysVividosD + ((modelo$ciclos[[i]]$qalyHIV + modelo$ciclos[[i]]$qalyNOHIV) / ((1 + tasaDescuento) ^ (i-1)))
  
  # Actualizar los años de vida perdidos debido al VIH y sus años descontados
  modelo$anosPerdidosMPHIV <-
    modelo$anosPerdidosMPHIV + modelo$ciclos[[i]]$LyPerdidosHIVMP
  modelo$anosPerdidosMPHIVD <-
    modelo$anosPerdidosMPHIVD + (modelo$ciclos[[i]]$LyPerdidosHIVMP / (1 + tasaDescuento) ^ (i-1))# i - 1
  
  # Actualizar QALYs perdidos debido al VIH y sus QALYs descontados
  modelo$qalysPerdidosMPHIV <-
    modelo$qalysPerdidosMPHIV + modelo$ciclos[[i]]$QalyPerdidoHIVMP
  modelo$qalysPerdidosMPHIVD <-
    modelo$qalysPerdidosMPHIVD + (modelo$ciclos[[i]]$QalyPerdidoHIVMP / (1 + tasaDescuento) ^ (i-1))
  
  # Actualizar QALYs perdidos debido a la discapacidad relacionada con el VIH y sus QALYs descontados
  modelo$qalysPerdidosDiscHIV <-
    modelo$qalysPerdidosDiscHIV + modelo$ciclos[[i]]$Disutilidad
  modelo$qalysPerdidosDiscHIVD <-
    modelo$qalysPerdidosDiscHIVD + (modelo$ciclos[[i]]$Disutilidad / (1 + tasaDescuento) ^ (i-1))
  
  # Actualizar QALYs perdidos totales y descontados
  modelo$qalysPerdidos <-
    modelo$qalysPerdidos + modelo$ciclos[[i]]$QalyPerdidoHIVMP + modelo$ciclos[[i]]$Disutilidad
  modelo$qalysPerdidosD <-
    modelo$qalysPerdidosD + (modelo$ciclos[[i]]$QalyPerdidoHIVMP + modelo$ciclos[[i]]$Disutilidad) / (1 + tasaDescuento) ^ (i-1)#[LEAN2]
  
  # Actualizar costos relacionados con el VIH, sanos y PrEP, y sus costos descontados
  modelo$CostoHIV <- modelo$CostoHIV + modelo$ciclos[[i]]$CostoHIV
  modelo$CostoHIVD <-
    modelo$CostoHIVD + (modelo$ciclos[[i]]$CostoHIV / (1 + tasaDescuento) ^ (i-1))
  modelo$CostoSano <-
    modelo$CostoSano + modelo$ciclos[[i]]$CostoSano
  modelo$CostoSanoD <-
    modelo$CostoSanoD + (modelo$ciclos[[i]]$CostoSano / (1 + tasaDescuento) ^ (i-1))
  
  
  modelo$CostoPrEP <-
    modelo$CostoPrEP + modelo$ciclos[[i]]$CostoPrEP
  modelo$CostoPrEPD <-
    modelo$CostoPrEPD + (modelo$ciclos[[i]]$CostoPrEP / (1 + tasaDescuento) ^ (i-1))
  
  # Actualizar tiempo sin diagnóstico
  modelo$TiempoSinDx <-
    modelo$TiempoSinDx + (modelo$ciclos[[i]]$InfectadoPreDx$Total * (12 / ciclosPorAno))
  
  if (escribir) {
    
    newres <- escribirOutput((i-1), 
                             ciclosPorAno,
                             modelo$ciclos[[i]]$SanoSinPrEP$Total,
                             modelo$ciclos[[i]]$SanosOffPrEPTotal,
                             modelo$ciclos[[i]]$SanosOnPrEPTotal,
                             modelo$ciclos[[i]]$InfectadoNoDxTotal,
                             modelo$ciclos[[i]]$InfectadoPreDx$Total,
                             modelo$ciclos[[i]]$InfectadoDxTotal,
                             (modelo$ciclos[[i]]$MuerteGeneral$Total + finalizados),
                             modelo$ciclos[[i]]$MuerteHIV$Total,
                             personasRiesgo,
                             modelo$ciclos[[i]]$InfectadosTotal,
                             modelo$ciclos[[i]]$nuevosCasos,
                             modelo$ciclos[[i]]$CasosAcumulados,
                             modelo$ciclos[[i]]$nuevosCasosDx,
                             modelo$ciclos[[i]]$qalyNOHIV,
                             modelo$ciclos[[i]]$qalyHIV,
                             modelo$ciclos[[i]]$LyPerdidosHIVMP,
                             modelo$ciclos[[i]]$QalyPerdidoHIVMP,
                             modelo$ciclos[[i]]$Disutilidad,
                             modelo$ciclos[[i]]$CostoSano,
                             modelo$ciclos[[i]]$CostoPrEP,
                             modelo$ciclos[[i]]$CostoHIV)


    result <- rbind(result, newres)
  } #if escribir
  
}#termina loop i



###final fuera de loop i

# Actualizar años vividos por la cohorte
#modelo$anosVividos <- modelo$anosVividos + (cohorteSize / ciclosPorAno)



# Actualizar el total de muertes por VIH
modelo$muertesHIV <- modelo$ciclos[[numeroCiclos + 1]]$MuerteHIV$Total

# Actualizar el total de muertes (incluyendo VIH, muertes generales y otras finalizaciones)
modelo$muertesTotales <- modelo$ciclos[[numeroCiclos + 1]]$MuerteHIV$Total + modelo$ciclos[[numeroCiclos + 1]]$MuerteGeneral$Total + finalizados



casosTotales <- modelo$casosHIV + modelo$ciclos[[1]]$InfectadosTotal

resultados <<- escribirResultadosComparacion(
  linea, 
  modelo$anosVividos, 
  modelo$qalysVividos, 
  modelo$anosPerdidosMPHIV, 
  modelo$qalysPerdidosMPHIV, 
  modelo$qalysPerdidosDiscHIV, 
  modelo$qalysPerdidos, 
  modelo$muertesHIV, 
  
  modelo$muertesTotales, 
  modelo$casosHIV, 
  modelo$casosHIVDx, 
  modelo$TiempoSinDx, 
  modelo$CostoSano, 
  modelo$CostoPrEP, 
  modelo$CostoHIV, 
  casosTotales, 
  modelo$anosVividosD, 
  modelo$qalysVividosD, 
  modelo$anosPerdidosMPHIVD, 
  modelo$qalysPerdidosMPHIVD, 
  modelo$qalysPerdidosDiscHIVD, 
  modelo$qalysPerdidosD, 
  modelo$CostoSanoD, 
  modelo$CostoPrEPD, 
  modelo$CostoHIVD, 
  cohorteSizeFinal
)

parametro <<-parametro
View(result)
return(resultados)
print("fin")

}

#linea <- "Baseline" # o "nuevo"
#parametro1 <- crearParametros(linea)

###Leo los datos
#debug(funcionPrincipal)
#funcionPrincipal("Baseline", "ARGENTINA", parametro)

#### aplico la fn para los dos escenarios-----

# linea <- "Baseline" # o "nuevo"
# parametro1 <- crearParametros(linea)
# 
# linea <- "Nuevo" # o "nuevo"
# parametro2 <- crearParametros(linea)

# parametros_prep <- list(cohorteSize = 100000,
#                    descuento = 0.03,
#                    edadMinima = 18, ## parametro basico
#                    edadFinal = 100,
#                    #tipoDuracion = 1,##hardcodeada
#                    duracionPrEP = 99,## parametro basico
#                    edadMaximaInicial = 50,##parametro basico
#                    PrEPuptake = 0,##parametro basico
#                    edadFinPrEP = 50,
#                    limiteEdadRiesgo = 60,
#                    eficaciaPrEP = 0,
#                    adherenciaPrEP = 0,
#                    limiteEdadContagiosos = 65,
#                    #tipoCohorte = 1,#hardcordeada
#                    cohorteSize_nuevo = 100000 ,
#                    tasaDescuento_nuevo = 0.03, 
#                    edadMinima_nuevo = 18 ,## parametro basico
#                    edadFinal_nuevo = 100 ,
#                    #tipoDuracion_nuevo = 0 ,#hardcodeada
#                    duracionPrEP_nuevo = 99 ,## parametro basico
#                    edadMaximaInicial_nuevo = 50 ,## parametro basico
#                    PrEPuptake_nuevo = 0.5, 
#                    edadFinPrEP_nuevo = 50, ## parametro basico
#                    limiteEdadRiesgo_nuevo = 60 ,
#                    eficaciaPrEP_nuevo = 0.86, 
#                    adherenciaPrEP_nuevo = 0.8 ,
#                    limiteEdadContagiosos_nuevo = 65 
#                    #tipoCohorte_nuevo = 1 #harcoddeada
#                    )

get_prep_params = function () {
  lista = list(
    cohorteSize = 100000,
    descuento = 0.05,
    edadMinima = 18, ## parametro basico
    edadFinal = 100,
    #tipoDuracion = 1,##hardcodeada
    duracionPrEP = 0,## parametro basico
    edadMaximaInicial = 50,##parametro basico
    PrEPuptake = 0,##parametro basico
    edadFinPrEP = 50,
    limiteEdadRiesgo = 60,
    eficaciaPrEP = 0,
    adherenciaPrEP = 0,
    limiteEdadContagiosos = 65,
    #tipoCohorte = 1,#hardcordeada
    cohorteSize_nuevo = 100000 ,
    tasaDescuento_nuevo = 0.05,
    edadMinima_nuevo = 18 ,## parametro basico
    edadFinal_nuevo = 100 ,
    #tipoDuracion_nuevo = 0 ,#hardcodeada
    duracionPrEP_nuevo = 1 ,## parametro basico
    edadMaximaInicial_nuevo = 50 ,## parametro basico
    PrEPuptake_nuevo = 0.1,
    edadFinPrEP_nuevo = 50, ## parametro basico
    limiteEdadRiesgo_nuevo = 60 ,
    eficaciaPrEP_nuevo = 0.86,
    adherenciaPrEP_nuevo = 0.8 ,
    limiteEdadContagiosos_nuevo = 65
    #tipoCohorte_nuevo = 1 #harcoddeada
    )
  return(lista)
}

get_prep_params_labels = function () {
  c(
    "Tamaño de la chorte (Baseline)",
    "Tasa de descuento anual (Baseline)",
    "Edad minima inicial (Baseline)", ## parametro basico
    "Edad Final",
    "Duración de PrEP (Baseline)",## parametro basico
    "Edad máxima inicial (Baseline)",##parametro basico
    "Aceptabilidad de PrEP en la población (Baseline)",##parametro basico
    "Edad de fin de indicación de PrEP (Baseline)",
    "Limite edad de riesgo (Baseline)",
    "Eficacia PrEP en la población (Baseline)",
    "Adherencia PrEP en la población (Baseline)",
    "Limite edad de contagio (Baseline)",
    "Tamaño de la chorte",
    "Tasa de descuento anual",
    "Edad minima inicial", ## parametro basico
    "Edad final",
    "Duración de PrEP",## parametro basico
    "Edad máxima inicial",##parametro basico
    "Aceptabilidad de PrEP en la población",##parametro basico
    "Edad de fin de indicación de PrEP",
    "Limite edad de riesgo",
    "Eficacia PrEP en la población",
    "Adherencia PrEP en la población",
    "Limite edad de contagio"
  )
}

prep_outcomes_labels = function() {
  c("Años vividos",
    "QALYS vividos",
    "Años vividos (descontado)",
    "QALYS vividos (descontado)",
    "LY PERDIDOS POR MP POR HIV",
    "QALYS PERDIDOS POR DISCAPACIDAD",
    "QALYS PERDIDOS POR MP POR HIV",
    "QALYS perdidos",
    "Muertes HIV",
    "% muertes HIV",
    "Nuevos casos de HIV ",
    "Nuevos casos de VIH diagnosticados",
    "Casos totales de HIV",
    "Tiempo sin Dx (meses)",
    "Costo SANO",
    "Costo PREP",
    "Costo HIV",
    "Costo Total de la intervención",
    "Costo SANO (descontado)",
    "Costo PREP (descontado)",
    "Costo HIV (descontado)",
    "Costo Total de la intervención (descontado)",
    "Costo incremental por Qaly",
    "Costo incremental por Qaly (descontado)",
    "Costo incremental por Año de vida",
    "Costo incremental por Año de vida (descontado)",
    "ROI",
    "ROI (descontado)"
  )
}

# lista_resultados <- funcionCalculos(parametros_prep, "ARGENTINA")

linea <- "Baseline"
#debug(funcionCalculos)
#debug(funcionPrincipal)
funcionCalculos(get_prep_params(), "ARGENTINA")
