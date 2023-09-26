descontarValor <- function(valor, ciclos, rate, usoOxitocina) {
  Acumulado <- 0
  rate <- as.numeric(rate)
  
  for (i in 0:(as.integer(ciclos) - 1)) {
    Acumulado <- Acumulado + (as.numeric(valor) / ((1 + rate) ^ as.numeric(i)))
  }
  
  if (ciclos > as.integer(ciclos)) {
    resto <- as.numeric(ciclos - as.integer(ciclos))
    restoRate <- rate * resto
    restoValor <- valor * resto
    Acumulado <- Acumulado + (restoValor / ((1 + restoRate) ^ ciclos))
  }
  
  return(Acumulado)
}


hpp = function (pais, 
                usoOxitocina, 
                eficacia_Intervencion = 0.30234,
                pHPP = 0.12, #Probabilidad de tener una hemorragia post parto.
                pHPP_Severa = 0.18, #Probabilidad de que esa hemorragia post parto sea severa.
                pHisterectomia = 0.03, #Probabilidad de tener una histerectomia ante una HPP severa.
                eficaciaOxitocina = 0.5, #reducción de la probabilidad de HPP ante oxitocina.
                uHisterectomia = 0.985, #Utilidad de una histerectomia.
                descuento = 0.05, #Tasa de descuento (INPUT)
                costoIntervencion = 0 #Costo de la intervención  (INPUT)
) {
  # Carga información de países
  load("hpp/data/datosPais.RData")
  
  # filtra por país seleccionado
  datosPais = datosPais[datosPais$pais==pais,]
  
  
  #Calculamos el costo promedio de un caso de HPP ponderado por el porcentaje de casos severos y no severos.
  costoHPPNoSevera = datosPais$value[datosPais$indicador == 'COSTO.mHPP']
  costoHPPSevera = datosPais$value[datosPais$indicador == 'COSTO.sHPP']
  Costo_HPP = (costoHPPNoSevera * (1 - pHPP_Severa) + costoHPPSevera * pHPP_Severa)
  
  #Calculamos los dalys por muerte prematura.
  #Calculamos la perdida de qalys promedio de un caso de HPP ponderado por la probabilidad de muerte y de histerectomia (dado que el caso sea severo).
  #para eso estimamos la probabilidad actual de HPP del pais que estara determinado por la probabilidad de HPP con y sin oxitocina ponderado por el uso de oxitocina basal del pais
  
  pHPPCountry = (usoOxitocina * eficaciaOxitocina * pHPP) + ((1 - usoOxitocina) * pHPP)
  
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
  añosDescontados = descontarValor(-1, (expectativaAlParto - edadAlParto), descuento)
  
  #Calculamos el valor descontado de qalys perdidos por una histerectomia
  Dalys_Histerectomia = (1 - uHisterectomia) * añosDescontados
  
  #Dalys por muerte prematuro al valer 0 la utilidad se pierde 1 por año asique es igual al valor de años descontados.
  Dalys_MuertePrematura = añosDescontados
  
  #Dalys por histerectomia.
  Dalys_Total = Dalys_Histerectomia * (pHPP_Severa * pHisterectomia) + (Dalys_MuertePrematura * pCFR)
  
  ####################
  
  # ramaSecundaria = function (poblacion, pHPP) {
  #   list (
  #     poblacion = poblacion,
  #     pHPP = pHPP,
  #     noHPP = poblacion * (1 - pHPP),
  #     siHPP = poblacion * pHPP
  #   )
  # }
  # 
  
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
      recibeOxitocina = poblacion * pUsoOxitocina * pHPP * eficaciaOxitocina *.99,
      noRecibeOxitocina = poblacion * (1-pUsoOxitocina) * pHPP *.99
    )
  }
  
  runRama = rama(usoOxitocina,694000,pHPP,eficaciaOxitocina)
  
  
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
    (runRama$recibeOxitocina * runSetearCostos$costoHPP + runRama$noRecibeOxitocina * runSetearCostos$costoHPP) + (runSetearCostos[[2]] * runRama$poblacion * runRama$usoOxitocina) + runSetearCostoIntervencion[[1]]
  }
  
  getQalyLost = function() {
    runRama$recibeOxitocina * runSetearQalyLost[[1]] + runRama$noRecibeOxitocina * runSetearQalyLost[[1]]
  }
  
  getHPP = function() {
    runRama$recibeOxitocina + runRama$noRecibeOxitocina
  }
  
  getMuertes = function() {
    runRama$recibeOxitocina + runRama$noRecibeOxitocina * pCFR
  }
  
  # Resultados corrida
  
  resultados = list(
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
    getCosto = getCosto()
  )
  return(resultados)
}


resultados_comparados = function(pais,
                                 uso_oxitocina_base,
                                 uso_oxitocina_target,
                                 descuento,
                                 costoIntervencion) {
  base = hpp(
    pais,
    uso_oxitocina_base,
    eficacia_Intervencion = 0.30234,
    pHPP = 0.12, #Probabilidad de tener una hemorragia post parto.
    pHPP_Severa = 0.18, #Probabilidad de que esa hemorragia post parto sea severa.
    pHisterectomia = 0.03, #Probabilidad de tener una histerectomia ante una HPP severa.
    eficaciaOxitocina = 0.5, #reducción de la probabilidad de HPP ante oxitocina.
    uHisterectomia = 0.985, #Utilidad de una histerectomia.
    descuento = descuento, #Tasa de descuento (INPUT)
    costoIntervencion = 0 #Costo de la intervención  (INPUT)
  )
    
  target = hpp(
    pais,
    uso_oxitocina_target,
    eficacia_Intervencion = 0.30234,
    pHPP = 0.12, #Probabilidad de tener una hemorragia post parto.
    pHPP_Severa = 0.18, #Probabilidad de que esa hemorragia post parto sea severa.
    pHisterectomia = 0.03, #Probabilidad de tener una histerectomia ante una HPP severa.
    eficaciaOxitocina = 0.5, #reducción de la probabilidad de HPP ante oxitocina.
    uHisterectomia = 0.985, #Utilidad de una histerectomia.
    descuento = descuento, #Tasa de descuento (INPUT)
    costoIntervencion = costoIntervencion #Costo de la intervención  (INPUT)
  )
  
  comparacion = list(
    "Diferencia de costo" = base$getCosto - target$getCosto,
    "Hemorragias Post Parto Evitadas" = base$hpp-target$hpp,
    "Muertes por Hemorragias Post Parto Evitadas" = (base$hpp-target$hpp) * base$pCFR,
    "Histerectomias por Hemorragias Post Parto Evitadas" = (base$hpp - target$hpp) * (base$pHPP_Severa * base$pHisterectomia),
    "Años de vida por muerte prematura salvados" = base$Dalys_MuertePrematura * ((base$hpp - target$hpp) * base$pCFR),
    "Años de vida por discapacidad salvados" = base$Dalys_Histerectomia * ((base$hpp - target$hpp) * (base$pHPP_Severa * base$pHisterectomia))
  )  
  
  list(base=base,
       target=target,
       comparacion=comparacion)
    
}

# 
# a=resultados_comparados(
#   pais = "Argentina",
#   uso_oxitocina_base = 0.71818,
#   uso_oxitocina_target = 0.80339,
#   descuento = 0,
#   costoIntervencion = 7.8
# )$base$getCosto
# 
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
