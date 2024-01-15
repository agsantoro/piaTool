descontarValor <- function(tasa_descuento_anual,num_periodos) {
  va <- ((1 - (1 + tasa_descuento_anual) ^ (-num_periodos+1)) / tasa_descuento_anual)
  va <- (va + 1) * -1
  return(va)
  
}






hpp = function (pais, 
                usoOxitocina, 
                eficacia_Intervencion,
                pHPP, #Probabilidad de tener una hemorragia post parto.
                pHPP_Severa, #Probabilidad de que esa hemorragia post parto sea severa.
                pHisterectomia, #Probabilidad de tener una histerectomia ante una HPP severa.
                eficaciaOxitocina, #reducción de la probabilidad de HPP ante oxitocina.
                uHisterectomia, #Utilidad de una histerectomia.
                descuento, #Tasa de descuento (INPUT)
                costoIntervencion = 0 #Costo de la intervención  (INPUT)
) {
  # Carga información de países
  # load("hpp/data/datosPais.RData")
  # write.xlsx(datosPais,file="hpp/data/datosPais.xlsx")
  datosPais = read.xlsx("hpp/data/datosPais.xlsx")
  
  # filtra por país seleccionado
  datosPais = datosPais[datosPais$pais==pais,]
  
  #Calculamos el costo promedio de un caso de HPP ponderado por el porcentaje de casos severos y no severos.
  costoHPPNoSevera = datosPais$value[datosPais$indicador == 'COSTO.mHPP']
  costoHPPSevera = datosPais$value[datosPais$indicador == 'COSTO.sHPP']
  Costo_HPP = (costoHPPNoSevera * (1 - pHPP_Severa) + costoHPPSevera * pHPP_Severa)
  
  #Calculamos los dalys por muerte prematura.
  #Calculamos la perdida de qalys promedio de un caso de HPP ponderado por la probabilidad de muerte y de histerectomia (dado que el caso sea severo).
  #para eso estimamos la probabilidad actual de HPP del pais que estara determinado por la probabilidad de HPP con y sin oxitocina ponderado por el uso de oxitocina basal del pais
  
  pHPPCountry = (datosPais$value[datosPais$indicador=="USO.DE.OXITOCINA"] * eficaciaOxitocina * pHPP) + ((1 - datosPais$value[datosPais$indicador=="USO.DE.OXITOCINA"]) * pHPP)
  #Estimamos el numero de HPP para el pais
  numeroPartos = datosPais$value[datosPais$indicador == "PARTOS.ANUALES"] 
  nHPPCountry = pHPPCountry * numeroPartos 
  
  #Calculamos el Case Fatality Ratio.
  mortalidadMaterna = datosPais$value[datosPais$indicador == "MORTALIDAD.MATERNA"]
  propMortalidadHPP = datosPais$value[datosPais$indicador == "pMORTALIDAD.MATERNA.POR.HPP"]
  pCFR = (mortalidadMaterna * propMortalidadHPP) / (100000 * pHPPCountry)
  
  
  
  #Calculamos la cantidad de años descontados desde la edad al parto y la expectativa de vida.
  expectativaAlParto = datosPais$value[datosPais$indicador == "EXPECTATIVA.DE.VIDA.A.LA.EDAD.DE.PARTO"]  
  edadAlParto = datosPais$value[datosPais$indicador == "EDAD.AL.PARTO"]
  añosDescontados = descontarValor(descuento, (expectativaAlParto - edadAlParto))*-1
  
  #Calculamos el valor descontado de qalys perdidos por una histerectomia
  Dalys_Histerectomia = (1 - uHisterectomia) * añosDescontados
  
  #Dalys por muerte prematuro al valer 0 la utilidad se pierde 1 por año asique es igual al valor de años descontados.
  Dalys_MuertePrematura = añosDescontados
  
  #Dalys por histerectomia.
  Dalys_Total = Dalys_Histerectomia * (pHPP_Severa * pHisterectomia) + (Dalys_MuertePrematura * pCFR)
  
  ####################
  
  ramaSecundaria = function (poblacion, pHPP) {
    list (
      poblacion = poblacion,
      pHPP = pHPP,
      noHPP = poblacion * (1 - pHPP),
      siHPP = poblacion * pHPP
    )
  }
  
  
  
  # función almacena datos de corrida
  
  rama = function (pUsoOxitocina, poblacion, pHPP, eficaciaOxitocina) {
    list(
      usoOxitocina = pUsoOxitocina,
      poblacion = poblacion,
      pHPP = pHPP,
      eficaciaOxitocina = eficaciaOxitocina,
      costoHPP = 0,
      qalyLost = 0,
      costoIntervencion = costoIntervencion,
      recibeOxitocina = ramaSecundaria(poblacion * pUsoOxitocina, pHPP * eficaciaOxitocina),
      noRecibeOxitocina = ramaSecundaria(poblacion * (1-pUsoOxitocina), pHPP)
    )
  }
  
  if (usoOxitocina == datosPais$value[datosPais$indicador=="USO.DE.OXITOCINA"]) {
    runRama = rama(usoOxitocina,numeroPartos,pHPP,eficaciaOxitocina)
  } else {
    runRama = rama(usoOxitocina * datosPais$value[datosPais$indicador=="pINSTITUCIONALES"],numeroPartos, pHPP, eficaciaOxitocina)
  }
  
  # setea parámetros escenario
  
  setearCostos = function(costoHPP, costoOxitocina) {
    list(
      costoHPP = costoHPP,
      costoOxitocina = costoOxitocina
    )
  }
  
  runSetearCostos = setearCostos(Costo_HPP,datosPais$value[datosPais$indicador=="COSTO.Oxitocina"])
  
  setearCostoIntervencion = function(costoIntervencion) {
    list(
      costoIntervencion = costoIntervencion
    )
  }  
  
  
  runSetearCostoIntervencion = setearCostoIntervencion(costoIntervencion)
  
  
  setearQalyLost = function(qalyLost) {
    list(
      qalyLost = qalyLost
    )
  }
  
  runSetearQalyLost = setearQalyLost(Dalys_Total)    
  
  # Calcula indicadores para resultados
  getCosto = function() {
    (runRama$recibeOxitocina$siHPP * runSetearCostos$costoHPP + runRama$noRecibeOxitocina$siHPP * runSetearCostos$costoHPP) + (runSetearCostos$costoOxitocina * runRama$poblacion * runRama$usoOxitocina) + runSetearCostoIntervencion[[1]]
  }
  
  
  getQalyLost = function() {
    runRama$recibeOxitocina$siHPP * runSetearQalyLost$qalyLost + runRama$noRecibeOxitocina$siHPP * runSetearQalyLost$qalyLost
  }
  
  
  getHPP = function() {
    runRama$recibeOxitocina$siHPP + runRama$noRecibeOxitocina$siHPP
  }
  
  getMuertes = function() {
    runRama$recibeOxitocina$siHPP + runRama$noRecibeOxitocina$siHPP * pCFR
  }
  
  # Resultados corrida
  resultados = list(
    costoIntervencion = costoIntervencion,
    Dalys_Histerectomia = Dalys_Histerectomia,
    mHPP = getMuertes(),
    hpp = getHPP(),
    nHPPCountry = nHPPCountry,
    pCFR = pCFR,
    QalyLost=getQalyLost(),
    Costo_HPP = Costo_HPP,
    Dalys_Total = Dalys_Total,
    pHPP_Severa=pHPP_Severa,
    pHisterectomia=pHisterectomia,
    Dalys_MuertePrematura=Dalys_MuertePrematura,
    getCosto = getCosto(),
    poblacionAfectada = datosPais$value[datosPais$indicador=="PARTOS.ANUALES"] * usoOxitocina
    
  )
  return(resultados)
}


resultados_comparados = function(pais,
                                 uso_oxitocina_base,
                                 uso_oxitocina_target,
                                 descuento,
                                 costoIntervencion) {
  load("hpp/data/datosPais.RData")
  datosPais = datosPais[datosPais$pais==pais,]
  
  base = hpp(
    pais,
    usoOxitocina = uso_oxitocina_base, 
    eficacia_Intervencion = 0.30230,
    pHPP = 0.108, #Probabilidad de tener una hemorragia post parto.
    pHPP_Severa = 0.1759, #Probabilidad de que esa hemorragia post parto sea severa.
    pHisterectomia = 0.03, #Probabilidad de tener una histerectomia ante una HPP severa.
    eficaciaOxitocina = 0.51, #reducción de la probabilidad de HPP ante oxitocina.
    uHisterectomia = 0.985, #Utilidad de una histerectomia.
    descuento = descuento, #Tasa de descuento (INPUT)
    costoIntervencion = costoIntervencion #Costo de la intervención  (INPUT)
  )
  
  target = hpp(
    pais,
    usoOxitocina = uso_oxitocina_target, 
    eficacia_Intervencion = 0.30230,
    pHPP = 0.108, #Probabilidad de tener una hemorragia post parto.
    pHPP_Severa = 0.1759, #Probabilidad de que esa hemorragia post parto sea severa.
    pHisterectomia = 0.03, #Probabilidad de tener una histerectomia ante una HPP severa.
    eficaciaOxitocina = 0.51, #reducción de la probabilidad de HPP ante oxitocina.
    uHisterectomia = 0.985, #Utilidad de una histerectomia.
    descuento = descuento, #Tasa de descuento (INPUT)
    costoIntervencion = costoIntervencion #Costo de la intervención  (INPUT)
  )
  
  comparacion = list(
    "Diferencia de costo" = target$getCosto - base$getCosto,
    "Diferencia de Qualys" = target$QalyLost - base$QalyLost,
    "Hemorragias Post Parto Evitadas" = base$hpp-target$hpp,
    "Muertes por Hemorragias Post Parto Evitadas" = (base$hpp-target$hpp) * base$pCFR,
    "Histerectomias por Hemorragias Post Parto Evitadas" = (base$hpp - target$hpp) * (base$pHPP_Severa * base$pHisterectomia),
    "Años de vida por muerte prematura salvados" = base$Dalys_MuertePrematura * ((base$hpp - target$hpp) * base$pCFR),
    "Años de vida por discapacidad salvados" = base$Dalys_Histerectomia * ((base$hpp - target$hpp) * (base$pHPP_Severa * base$pHisterectomia)),
    "Población base afectada" = datosPais$value[datosPais$indicador=="PARTOS.ANUALES"] * uso_oxitocina_base,
    "Población intervención afectada" = round(datosPais$value[datosPais$indicador=="PARTOS.ANUALES"] * uso_oxitocina_target * datosPais$value[datosPais$indicador=="pINSTITUCIONALES"],0),
    "Costo Oxitocina" = paste0("U$S ",datosPais$value[datosPais$indicador=="COSTO.Oxitocina"]),
    "Ahorro" = -1 * (target$getCosto - base$getCosto)
  )  
  
  # costo-efectividad
  
  #ICER
  if (comparacion$`Diferencia de costo` > 0 & comparacion$`Diferencia de Qualys` < 0) {
    comparacion$ICER <- round(comparacion$`Diferencia de costo` / abs(comparacion$`Diferencia de Qualys`), 3)
  } else if (comparacion$`Diferencia de costo` <= 0 & comparacion$`Diferencia de Qualys` < 0) {
    comparacion$ICER <- 'Costo-Ahorrativo'
  } else {
    comparacion$ICER <- 'Dominada'
  }
  
  #ICERL
  if (comparacion$`Diferencia de costo` > 0 & comparacion$`Años de vida por muerte prematura salvados` > 0) {
    comparacion$ICERL <- round(comparacion$`Diferencia de costo` / comparacion$`Años de vida por muerte prematura salvados`, 3)
  } else if (comparacion$`Diferencia de costo` <= 0 & comparacion$`Años de vida por muerte prematura salvados` > 0) {
    comparacion$ICERL <- 'Costo-Ahorrativo'
  } else {
    comparacion$ICERL <- 'Dominada'
  }
  
  #ICERM
  if (comparacion$`Diferencia de costo` > 0 & comparacion$`Muertes por Hemorragias Post Parto Evitadas` > 0) {
    comparacion$ICERM <- round(comparacion$`Diferencia de costo` / comparacion$`Muertes por Hemorragias Post Parto Evitadas`, 3)
  } else if (comparacion$`Diferencia de costo` <= 0 & comparacion$`Muertes por Hemorragias Post Parto Evitadas` > 0) {
    comparacion$ICERM <- 'Costo-Ahorrativo'
  } else {
    comparacion$ICERM <- 'Dominada'
  }
  
  # inversión
  comparacion$Inversion = (target$costoIntervencion + ((comparacion$`Población intervención afectada` - comparacion$`Población base afectada`) * datosPais$value[datosPais$indicador=="COSTO.Oxitocina"]))
  
  # ROI
  comparacion$ROI = round((((-comparacion$`Diferencia de costo`)) / comparacion$Inversion) * 100, 2)
  
  # Costo cada 100 mil
  comparacion$`Costo cada mil` = round((target$getCosto - base$getCosto) / (datosPais$value[datosPais$indicador=='PARTOS.ANUALES'] * datosPais$value[datosPais$indicador=='pINSTITUCIONALES']) * 1000,1)
  
  # Qalys cada 100 mil
  comparacion$`Qalys cada mil` = round((target$QalyLost - base$QalyLost) / (datosPais$value[datosPais$indicador=='PARTOS.ANUALES'] * datosPais$value[datosPais$indicador=='pINSTITUCIONALES']) * 1000,1)
  list(base=base,
       target=target,
       comparacion=comparacion)
  
}


a=resultados_comparados(
  pais = "Argentina",
  uso_oxitocina_base = 0.711,
  uso_oxitocina_target = 0.80087,
  descuento = 0.05,
  costoIntervencion = 0
)$comparacion

# b=resultados_comparados(
#   pais = "Argentina",
#   uso_oxitocina_base = 0.71818,
#   uso_oxitocina_target = 0.80339,
#   descuento = 0,
#   costoIntervencion = 7.8
# )$target$getCosto
# 
# 
# 
# 
# 
# a2=resultados_comparados(
#   pais = "Argentina",
#   uso_oxitocina_base = 0.71818,
#   uso_oxitocina_target = 0.80339,
#   descuento = 0,
#   costoIntervencion = 7.8
# )$base$getCosto
# 
# b2=resultados_comparados(
#   pais = "Argentina",
#   uso_oxitocina_base = 0.71818,
#   uso_oxitocina_target = 0.80339,
#   descuento = 0,
#   costoIntervencion = 7.8
# )$target$getCosto
# 
# 
