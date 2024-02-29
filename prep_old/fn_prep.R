options(scipen=999)
source("prep/FUNCIONES.R")


funcionPrincipal <- function(linea,paisCol, parametro){
  tipoCohorte=1
  tipoDuracion=1
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


#'Definimos el numero de años que durara el modelo, el mismo corre hasta que el menor de la cohorte cumpla 100 años.
anosRango = edadFinal - edadMinima
#Definimos el numero de ciclos.
numeroCiclos = anosRango * ciclosPorAno


# Definimos la configuración
if (tipoDuracion == 0) {
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
  if (duracionPrEP < 5) {
    ciclosPrEPON <- duracionPrEP * ciclosPorAno
  } else {
    ciclosPrEPON <- 5 * ciclosPorAno
  }
}

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
}

pMuerteGeneral

pMuerteHIV <- numeric(101) 
for (z in 1:86) {
  tasaMortalidad <- probabilidades[z, 6]  
  pMuerteHIV[14 + z] <- 1 - exp(-(-log(1 - tasaMortalidad)) * (1 / ciclosPorAno))
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
modelo$ciclos[[1]]$InfectadoDx <- list(Personas = numeric(edadFinal))
modelo$ciclos[[1]]$InfectadoNoDx <- list(Personas = numeric(edadFinal))
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
#modelo$ciclos[[1]]$InfectadoDx$Total=0
modelo$ciclos[[1]]$MuerteGeneral$Total=0
modelo$ciclos[[1]]$MuerteHIV$Total=0

for (z in 1:ciclosPrEPON) {
  modelo$ciclos[[1]]$SanoOnPrEP[[z]]$Personas <- numeric(edadFinal)
}

for (z in 1:ciclosPrEPOFF) {
  modelo$ciclos[[1]]$SanoOffPrEP[[z]]$Personas <- numeric(edadFinal)
  
}


# Asignar valores iniciales
modelo$ciclos[[1]]$SanosTotal <- cohorteSize * (1 - prevalenciaHIV)
modelo$ciclos[[1]]$SanosOnPrEPTotal <- modelo$ciclos[[1]]$SanosTotal * PrEPuptake
modelo$ciclos[[1]]$SanosOffPrEPTotal<- 0
modelo$ciclos[[1]]$SanoSinPrEP$Total <- modelo$ciclos[[1]]$SanosTotal * (1 - PrEPuptake)
modelo$ciclos[[1]]$InfectadosTotal <- cohorteSize * prevalenciaHIV
modelo$ciclos[[1]]$InfectadoDx$Total <- modelo$ciclos[[1]]$InfectadosTotal * pHIVDiagnosticado
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
  modelo$ciclos[[1]]$InfectadoDx$Personas[i] <- modelo$ciclos[[1]]$InfectadoDx$Total * distribucionCohorte[i]
  modelo$ciclos[[1]]$InfectadoNoDx$Personas[i] <- modelo$ciclos[[1]]$InfectadoNoDxTotal * distribucionCohorte[i]
  totalCheck <- sum(totalCheck , modelo$ciclos[[1]]$SanoOnPrEP[[1]]$Personas[i] , 
    modelo$ciclos[[1]]$SanoSinPrEP$Personas[i],
    modelo$ciclos[[1]]$InfectadoDx$Personas[i] , 
    modelo$ciclos[[1]]$InfectadoNoDx$Personas[i], na.rm = T)
  
  
}




# Manejar la dinámica de la cohorte

#[MODIFICADO LEAN]
#Redundante ya lo hace abajo.
#if (tipoCohorte == 1) {
#  genteEntrante <- cohorteSize * distribucionCohorte[edadMinima]
#}
#[/MODIFICADO LEAN]

# Manejar la dinámica de la cohorte
genteEntrante <- ifelse(tipoCohorte == 1, cohorteSize * distribucionCohorte[edadMinima], 0)

# Calcular total de infectados
modelo$ciclos[[1]]$InfectadosTotal <- modelo$ciclos[[1]]$InfectadoDx$Total + modelo$ciclos[[1]]$InfectadoNoDxTotal

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
DiagnosticadosContagiosos <- modelo$ciclos[[1]]$InfectadoDx$Total
NoDiagnosticadosContagiosos <- modelo$ciclos[[1]]$InfectadoNoDxTotal +
  modelo$ciclos[[1]]$InfectadoPreDx$Total

escribir <- TRUE
i <- 1


modelo$CostoPrEP <-0
if (escribir) {
  # Llamada a la función 'escribirOutput' con los argumentos correspondientes
  # Aquí asumimos que todas las propiedades (.Total, etc.) están definidas adecuadamente
  result <- escribirOutput(0, ciclosPorAno, modelo$ciclos[[i]]$SanoSinPrEP$Total, modelo$ciclos[[i]]$SanosOffPrEPTotal, 
                 modelo$ciclos[[i]]$SanosOnPrEPTotal, modelo$ciclos[[i]]$InfectadoNoDxTotal, 
                 modelo$ciclos[[i]]$InfectadoPreDx$Total, modelo$ciclos[[i]]$InfectadoDx$Total, 
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


DiagnosticadosContagiosos <- modelo$ciclos[[1]]$InfectadoDx$Total

NoDiagnosticadosContagiosos <- modelo$ciclos[[1]]$InfectadoNoDxTotal +
  modelo$ciclos[[1]]$InfectadoPreDx$Total


#### inicia loop i #####
anosPasados <- 0
#numeroCiclos

for (i in 2:(numeroCiclos+1)) {

  #browser()
  # # Inicializar las estructuras para el i-ésimo ciclo

  

  modelo$ciclos[[i]]$SanoSinPrEP <- list(Personas = numeric(edadFinal), Total = 0)
  modelo$ciclos[[i]]$SanoOnPrEP <- vector("list", ciclosPrEPON)
  modelo$ciclos[[i]]$SanoOffPrEP <- vector("list", ciclosPrEPOFF)
  modelo$ciclos[[i]]$InfectadoDx <-list(Personas = numeric(edadFinal), Total = 0)
  modelo$ciclos[[i]]$InfectadoPreDx <-list(Personas = numeric(edadFinal),  Total = 0)
  modelo$ciclos[[i]]$InfectadoNoDx <-list(Personas = numeric(edadFinal))
  modelo$ciclos[[i]]$MuerteGeneral <-list(Personas = numeric(edadFinal))
  modelo$ciclos[[i]]$MuerteHIV <- list(Personas = numeric(edadFinal))
  modelo$ciclos[[i]]$nuevosCasos<- 0
  modelo$ciclos[[i]]$nuevosCasosDx<- 0
  modelo$ciclos[[i]]$InfectadoDx$Total <-0
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
        modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[edadMinima] <- genteEntrante * PrEPuptake
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[edadMinima] <- genteEntrante * (1 - PrEPuptake)
      } else {
        modelo$ciclos[[i]]$SanoSinPrEP$Personas[edadMinima] <- genteEntrante
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
    
    # Calculamos la probabilidad anual de tener HIV
    pAnualHIV <- ((tasaTransmision * NoDiagnosticadosContagiosos) +
                    (tasaTransmisionNoControlados * ((DiagnosticadosContagiosos * (1 - pHIVTratado)) +
                                                       (DiagnosticadosContagiosos * pHIVTratado * (1 - pHIVControlado))))) / personasRiesgo
    
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
      # Si la edad es mayor que el límite (ej: 100 años), se finaliza el ciclo de esa edad
      if (anoOffset == 1 ) {
        finalizados <-
          finalizados + modelo$ciclos[[i - 1]]$InfectadoDx$Personas[100] +
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[100] +
          modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[100] +
          modelo$ciclos[[i - 1]]$SanoSinPrEP$Personas[100]
      }
      break  # Salir del bucle de edad
    }
   
    
      
    # Inicializar contadores para este ciclo
    nuevosInfectadosSinPrEP <- 0
    nuevosInfectadosConPrEP <- 0
    conteoParcialSOFP <- 0
    conteoParcialSOP <- 0
    
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
    
    if (duracionPrEP < 99) {
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
    
    # Actualizamos los infectados no diagnosticados
    modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] <-
      modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] -
      (
        modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
          modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
      )
    
    # Los que no están en PrEP tienen un porcentaje de ser diagnosticados
    modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] <-
      modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] +
      (nuevosInfectadosSinPrEP * (1 - pHIVDiagnosticado))
    
    # Agregamos las muertes por causas generales y por HIV dentro de los Infectados no dx
    modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
      modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
      modelo$ciclos[[i - 1]]$InfectadoNoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    
    # Actualizamos los infectados diagnosticados
    modelo$ciclos[[i]]$InfectadoDx$Personas[j] <-
      modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] -
      (
        modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
          modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
      )
    
    # Agregamos las muertes por causas generales y por HIV dentro de los Infectados dx
    modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
      modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
    
    modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
      modelo$ciclos[[i - 1]]$InfectadoDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    
    #[LEAN] aca es i-1 porque arranca en 2 y vos queres que testee en el ciclo 5.
    
    if ((i-1) %% testeoNoPrEP == 0) {
      # Ciclo diagnóstico
      modelo$ciclos[[i]]$InfectadoDx$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoDx$Personas[j] +#[LEAN] aca es [I] y no [I-1] porque vos ya actualizaste los dx en este ciclo y le sacaste los muertos.
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset]) +
            modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
        )
      
      # Sin nuevos casos en este grupo para este ciclo
      modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] <- 0
      
      # Agregamos los nuevos casos diagnosticados
      modelo$ciclos[[i]]$InfectadoDx$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoDx$Personas[j] + #[LEAN] aca es [i] sino perdes todo lo q hiciste hasta ahora.
        (nuevosInfectadosSinPrEP * pHIVDiagnosticado) + nuevosInfectadosConPrEP
      
      # Agregamos las muertes por causas generales y por HIV dentro de los PreDx
      modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] <-
        modelo$ciclos[[i]]$MuerteGeneral$Personas[j - anoOffset] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
      
      modelo$ciclos[[i]]$MuerteHIV$Personas[j] <-
        modelo$ciclos[[i]]$MuerteHIV$Personas[j] +
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])
    } else {
      # No es un ciclo de diagnóstico
      modelo$ciclos[[i]]$InfectadoDx$Personas[j] <-
        modelo$ciclos[[i]]$InfectadoDx$Personas[j] + nuevosInfectadosConPrEP
      #[LEAN] mismo concepto...estas actualizando no mirando atras. no es [i-1]
      
      # Actualizamos los infectados PreDx
      modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] <-
        modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] -
        (
          modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteHIV[j - anoOffset])+
            modelo$ciclos[[i - 1]]$InfectadoPreDx$Personas[j - anoOffset] * as.numeric(pMuerteGeneral[j - anoOffset])
        )
      
      # Le sumamos los casos nuevos que vienen de la rama sin PrEP
      #[LEAN] igual que arriba estas actualizando este estado. no es [i-1]
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
    if ((i-1) %% testeoNoPrEP == 0) { #[LEAN] mismo concepto, testeamos en el ciclo 4 (aca es 5), i siempre vale mas que 0.
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
      
      #modelo$ciclos[[i]]$CostoSano <-modelo$ciclos[[i-1]]$CostoSano
      
      conteoParcialSOP <-
        modelo$ciclos[[i]]$SanoOnPrEP[[1]]$Personas[edadMinima]#sin menos 1.
    }#[LEAN] habia un problema con que cerrabas un if muy tempranamente al nicio del loop j
    
    
    # Actualizar costos asociados con el tratamiento y seguimiento de VIH
    modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV +
      (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * pHIVTratado * cTratamientoHIV) +
      (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * pHIVTratado * cSeguimientoHIV) +
      (((modelo$ciclos[[i]]$InfectadoDx$Personas[j] * (1 - pHIVTratado * pHIVControlado)) +
      modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] + modelo$ciclos[[i]]$InfectadoNoDx$Personas[j]
      ) * cComplicacionesHIV)
    
    
    # Actualizar costos de PrEP
    modelo$ciclos[[i]]$CostoPrEP <- modelo$ciclos[[i]]$CostoPrEP + (conteoParcialSOP * (cPrEPSeguimiento + cPrEPTratamiento + cPrEPTest))
    
    # Agregar costo de consulta para nuevos infectados con PrEP
    modelo$ciclos[[i]]$CostoHIV <- modelo$ciclos[[i]]$CostoHIV + nuevosInfectadosConPrEP * cConsulta
    
    # Actualizar la disutilidad[LEAN] Asignamos el del ciclo.
    #
    modelo$ciclos[[i]]$Disutilidad <-
      modelo$ciclos[[i]]$Disutilidad +
      ((
        modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] + modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] +
          (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * (1 - pHIVTratado))
      ) * cuHIV
      ) + modelo$ciclos[[i]]$InfectadoDx$Personas[j] * pHIVTratado * cuHIVTTO
    
    #browser()
    
    # Actualizar totales y acumulados
    modelo$ciclos[[i]]$MuerteHIV$Total <-modelo$ciclos[[i]]$MuerteHIV$Total + modelo$ciclos[[i]]$MuerteHIV$Personas[j]
    #[Lean] estas asignaciones son intraciclo para juntar toda la info de las edades.
    modelo$ciclos[[i]]$InfectadoDx$Total <-modelo$ciclos[[i]]$InfectadoDx$Total + modelo$ciclos[[i]]$InfectadoDx$Personas[j]
    modelo$ciclos[[i]]$InfectadoPreDx$Total <-modelo$ciclos[[i]]$InfectadoPreDx$Total + modelo$ciclos[[i]]$InfectadoPreDx$Personas[j]
    modelo$ciclos[[i]]$InfectadoNoDxTotal <-modelo$ciclos[[i]]$InfectadoNoDxTotal + modelo$ciclos[[i]]$InfectadoNoDx$Personas[j]
    modelo$ciclos[[i]]$SanoSinPrEP$Total <-modelo$ciclos[[i]]$SanoSinPrEP$Total + modelo$ciclos[[i]]$SanoSinPrEP$Personas[j]
    modelo$ciclos[[i]]$SanosOffPrEPTotal <-modelo$ciclos[[i]]$SanosOffPrEPTotal + conteoParcialSOFP
    modelo$ciclos[[i]]$SanosOnPrEPTotal <-modelo$ciclos[[i]]$SanosOnPrEPTotal + conteoParcialSOP
    
    modelo$ciclos[[i]]$SanosTotal <-modelo$ciclos[[i]]$SanosOnPrEPTotal + modelo$ciclos[[i]]$SanosOffPrEPTotal + modelo$ciclos[[i]]$SanoSinPrEP$Total
    modelo$ciclos[[i]]$InfectadosTotal <-modelo$ciclos[[i]]$InfectadoPreDx$Total + modelo$ciclos[[i]]$InfectadoNoDxTotal + modelo$ciclos[[i]]$InfectadoDx$Total
    modelo$ciclos[[i]]$nuevosCasos <-modelo$ciclos[[i]]$nuevosCasos + nuevosInfectadosSinPrEP + nuevosInfectadosConPrEP
    modelo$ciclos[[i]]$nuevosCasosDx <-modelo$ciclos[[i]]$nuevosCasosDx +  (nuevosInfectadosSinPrEP * pHIVDiagnosticado)  + nuevosInfectadosConPrEP
    
    modelo$ciclos[[i]]$CasosAcumulados <-modelo$ciclos[[i]]$CasosAcumulados + nuevosInfectadosSinPrEP + nuevosInfectadosConPrEP
    # Calcular QALY para personas con VIH
    
    
    modelo$ciclos[[i]]$qalyHIV <- modelo$ciclos[[i]]$qalyHIV + 
      (modelo$ciclos[[i]]$InfectadoPreDx$Personas[j] + modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] + (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * (1 - pHIVTratado))) * (cuPoblacion[j + 1] - cuHIV) +
      (modelo$ciclos[[i]]$InfectadoDx$Personas[j] * pHIVTratado * (cuPoblacion[j + 1] - cuHIVTTO))
   
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
      DiagnosticadosContagiosos <-DiagnosticadosContagiosos + modelo$ciclos[[i]]$InfectadoDx$Personas[j]
      NoDiagnosticadosContagiosos <-NoDiagnosticadosContagiosos + modelo$ciclos[[i]]$InfectadoNoDx$Personas[j] + modelo$ciclos[[i]]$InfectadoPreDx$Personas[j]
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
        modelo$ciclos[[i]]$InfectadoDx$Total
    ) / ciclosPorAno
  modelo$anosVividosD <-
    modelo$anosVividosD + (((
      modelo$ciclos[[i]]$SanoSinPrEP$Total +
        modelo$ciclos[[i]]$SanosOffPrEPTotal + modelo$ciclos[[i]]$SanosOnPrEPTotal +
        modelo$ciclos[[i]]$InfectadoNoDxTotal + modelo$ciclos[[i]]$InfectadoPreDx$Total +
        modelo$ciclos[[i]]$InfectadoDx$Total
    ) / ciclosPorAno
    ) / (1 + tasaDescuento) ^ (i-1))

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
    modelo$qalysPerdidosD + (modelo$ciclos[[i]]$QalyPerdidoHIVMP + modelo$ciclos[[i]]$Disutilidad) / (1 + tasaDescuento) ^ (i-1)
  
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
                             modelo$ciclos[[i]]$InfectadoDx$Total,
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
modelo$muertesHIV <- modelo$ciclos[[numeroCiclos]]$MuerteHIV$Total

# Actualizar el total de muertes (incluyendo VIH, muertes generales y otras finalizaciones)
modelo$muertesTotales <- modelo$ciclos[[numeroCiclos]]$MuerteHIV$Total + modelo$ciclos[[numeroCiclos]]$MuerteGeneral$Total + finalizados



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
return(resultados)
return(result)
print("fin")

}

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
    descuento = 0.03,
    edadMinima = 18, ## parametro basico
    edadFinal = 100,
    #tipoDuracion = 1,##hardcodeada
    duracionPrEP = 99,## parametro basico
    edadMaximaInicial = 50,##parametro basico
    PrEPuptake = 0,##parametro basico
    edadFinPrEP = 50,
    limiteEdadRiesgo = 60,
    eficaciaPrEP = 0,
    adherenciaPrEP = 0,
    limiteEdadContagiosos = 65,
    #tipoCohorte = 1,#hardcordeada
    cohorteSize_nuevo = 100000 ,
    tasaDescuento_nuevo = 0.03,
    edadMinima_nuevo = 18 ,## parametro basico
    edadFinal_nuevo = 100 ,
    #tipoDuracion_nuevo = 0 ,#hardcodeada
    duracionPrEP_nuevo = 99 ,## parametro basico
    edadMaximaInicial_nuevo = 50 ,## parametro basico
    PrEPuptake_nuevo = 0.5,
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
    "Años de vida salvados",
    "QALYS perdidos por discapacidad",
    "QALYS perdidos por MP por VIH",
    "QALYS perdidos",
    "Muertes evitadas",
    "Muertes evitadas (%)",
    "Casos de VIH evitados",
    "Nuevos casos de VIH diagnosticados",
    "Casos totales de HIV",
    "Tiempo sin Dx (meses)",
    "Costo SANO",
    "Costo Total de la intervención",
    "Costo HIV",
    "Costo total",
    "Costo SANO (descontado)",
    "Costo total de la intervención (descontado)",
    "Costo HIV (descontado)",
    "Costo Total de la intervención (descontado)",
    "Razón de costo-efectividad incremental (RCEI) por Años de Vida Ajustados por Discapacidad (AVAD) Evitados",
    "Razón de costo-efectividad incremental (RCEI) por Años de Vida Ajustados por Discapacidad (AVAD) Evitados (descontado)",
    "Razón de costo-efectividad incremental (RCEI) por Año de vida salvado (AVS)",
    "Razón de costo-efectividad incremental (RCEI) por Año de vida salvado (AVS) (descontado)",
    "Retorno de Inversión",
    "Retorno de Inversión (descontado)"
  )
}

# lista_resultados <- funcionCalculos(parametros_prep, "ARGENTINA")
