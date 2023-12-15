library(readxl)
# parameters
parameters = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "Parameters")


# mortality and incidence data
mortall = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "mortall")


mortcecx = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "mortcecx")

mortcecx[is.na(mortcecx)] = 0

incidence = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "incidence")

source("functions/createLifetable.R", encoding = "UTF-8")

# dalys params
dalys = readxl::read_xlsx("xlsx/PRIME_v2.3_old.xlsx", sheet = "Model", range = "AV2:AW6")
colnames(dalys)[1]="event"

# model function
getPrime = function (
    input,
    country,
    birthCohortSizeFemale,
    cohortSizeAtVaccinationAgeFemale,
    coverageAllDosis,
    vaccineEfficacyVsHPV16_18,
    targetAgeGroup,
    vaccinePricePerFIG,
    vaccineDeliveryCostPerFIG,
    totalVaccineCostPerFIG,
    cancerTreatmentCostPerEpisodeOverLifetime,
    DALYsForCancerDiagnosis,
    DALYsForNonTerminalCancerSequelaePperYear,
    DALYsForTerminalCancer,
    discountRate,
    proportionOfCervicalCancerCasesThatAreDueToHPV16_18,
    GDPPerCapita,
    mortall,
    mortcecx,
    incidence,
    dalys,
    parameters) {
  # lifetable
  lifeTable = createLifetable("ARGENTINA")
  
  # model
  age = 0:100
  
  standardisedCohortSize_brith = lifeTable$lx
  
  standardisedCohortSize_vacAge = rep(NA,101) 
  standardisedCohortSize_vacAge[age<targetAgeGroup] = 0
  for (i in (length(standardisedCohortSize_vacAge[age<targetAgeGroup])):(length(standardisedCohortSize_vacAge))) {
    standardisedCohortSize_vacAge[i] = standardisedCohortSize_brith[i]/standardisedCohortSize_brith[age==targetAgeGroup]
  }
  
  discountFactor = rep(NA,101) 
  discountFactor[age<=targetAgeGroup] = 1
  discountFactor[age>targetAgeGroup] = 1/((1+discountRate)^(age[age>targetAgeGroup]-targetAgeGroup))
  
  cumDiscFactor = c(0,cumsum(discountFactor))[1:101]
  
  standardisedCohortSizeDisc = standardisedCohortSize_vacAge * discountFactor
  
  ##### PRE VACCINATION #####
  
  ceCx16_18IncidencePreVac = as.numeric(incidence[incidence$`Country ¦ Age [10]`==country,-1]) * proportionOfCervicalCancerCasesThatAreDueToHPV16_18
  ceCx16_18IncidencePreVac[is.na(ceCx16_18IncidencePreVac)] = 0
  
  ceCx16_18IncidencePreVacDisc = ceCx16_18IncidencePreVac * discountFactor
  ceCx16_18IncidencePreVacDisc[is.na(ceCx16_18IncidencePreVacDisc)] = 0
  
  ceCx16_18MortalityPreVac = as.numeric(mortcecx[mortcecx$`Country ¦ Age [11]`==country,-1]) * proportionOfCervicalCancerCasesThatAreDueToHPV16_18
  
  ceCx16_18MortalityPreVacDisc = ceCx16_18MortalityPreVac * discountFactor
  
  lifeTable$ExDisc = c()
  for (i in 1:101) {
    ageInt = floor(lifeTable$Ex[i])
    lifeTable$ExDisc[i]=cumDiscFactor[age==ageInt] + (lifeTable$Ex[i] - floor(lifeTable$Ex[i])) * discountFactor[age==ageInt]
  }
  lifeYearsLostPreVac = ceCx16_18MortalityPreVac * lifeTable$Ex
  lifeYearsLostPreVacDisc = ceCx16_18MortalityPreVacDisc * lifeTable$ExDisc
  
  cancerDisabilitiesPreVac = ceCx16_18MortalityPreVac * lifeTable$Ex
  
  cancerDisabilitiesPreVacDisc = ceCx16_18MortalityPreVacDisc * lifeTable$ExDisc
  
  cancerDisabilitiesLostPreVac = (ceCx16_18IncidencePreVac - ceCx16_18MortalityPreVac) * dalys$DALYs[1] + ceCx16_18MortalityPreVac * dalys$DALYs[2]
  
  cancerDisabilitiesLostPreVacDisc = ((ceCx16_18IncidencePreVac - ceCx16_18MortalityPreVac) * dalys$DALYs[3] + ceCx16_18MortalityPreVac * dalys$DALYs[4]) / (1 + discountRate) ^ (age - 12)
  
  cancerCareCostsPreVac = ceCx16_18IncidencePreVac * cancerTreatmentCostPerEpisodeOverLifetime
  
  cancerCareCostsPreVacDisc = cancerCareCostsPreVac / (1+discountRate) ^ (age - 12)
  
  
  ##### POST VACCINATION #####
  
  ceCx16_18IncidencePostVac = c()
  ceCx16_18IncidencePostVac[age<targetAgeGroup] = ceCx16_18IncidencePreVac[age<targetAgeGroup]
  ceCx16_18IncidencePostVac[age>=targetAgeGroup] = ceCx16_18IncidencePreVac[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  ceCx16_18IncidencePostVacDisc = c()
  ceCx16_18IncidencePostVacDisc[age<targetAgeGroup] = ceCx16_18IncidencePreVacDisc[age<targetAgeGroup]
  ceCx16_18IncidencePostVacDisc[age>=targetAgeGroup] = ceCx16_18IncidencePreVacDisc[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  ceCx16_18MortalityPostVac = c()
  ceCx16_18MortalityPostVac[age<targetAgeGroup] = ceCx16_18MortalityPreVac[age<targetAgeGroup]
  ceCx16_18MortalityPostVac[age>=targetAgeGroup] = ceCx16_18MortalityPreVac[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  ceCx16_18MortalityPostVacDisc = c()
  ceCx16_18MortalityPostVacDisc[age<targetAgeGroup] = ceCx16_18MortalityPreVacDisc[age<targetAgeGroup]
  ceCx16_18MortalityPostVacDisc[age>=targetAgeGroup] = ceCx16_18MortalityPreVacDisc[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  lifeYearsLostPostVac = c()
  lifeYearsLostPostVac[age<targetAgeGroup] = lifeYearsLostPreVac[age<targetAgeGroup]
  lifeYearsLostPostVac[age>=targetAgeGroup] = lifeYearsLostPreVac[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  lifeYearsLostPostVacDisc = c()
  lifeYearsLostPostVacDisc[age<targetAgeGroup] = lifeYearsLostPreVacDisc[age<targetAgeGroup]
  lifeYearsLostPostVacDisc[age>=targetAgeGroup] = lifeYearsLostPreVacDisc[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  cancerDisabilitiesLostPostVac = c()
  cancerDisabilitiesLostPostVac[age<targetAgeGroup] = cancerDisabilitiesLostPreVac[age<targetAgeGroup]
  cancerDisabilitiesLostPostVac[age>=targetAgeGroup] = cancerDisabilitiesLostPreVac[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  cancerDisabilitiesLostPostVacDisc = c()
  cancerDisabilitiesLostPostVacDisc[age<targetAgeGroup] = cancerDisabilitiesLostPreVacDisc[age<targetAgeGroup]
  cancerDisabilitiesLostPostVacDisc[age>=targetAgeGroup] = cancerDisabilitiesLostPreVacDisc[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  cancerCareCostsPostVac = c()
  cancerCareCostsPostVac[age<targetAgeGroup] = cancerCareCostsPreVac[age<targetAgeGroup]
  cancerCareCostsPostVac[age>=targetAgeGroup] = cancerCareCostsPreVac[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  cancerCareCostsPostVacDisc = c()
  cancerCareCostsPostVacDisc[age<targetAgeGroup] = cancerCareCostsPreVacDisc[age<targetAgeGroup]
  cancerCareCostsPostVacDisc[age>=targetAgeGroup] = cancerCareCostsPreVacDisc[age>=targetAgeGroup] * (1 - coverageAllDosis * vaccineEfficacyVsHPV16_18)
  
  
  ##### difference after vaccination #####
  
  ceCx16_18IncidenceDif = ceCx16_18IncidencePreVac - ceCx16_18IncidencePostVac
  
  ceCx16_18IncidenceDifDisc = ceCx16_18IncidencePreVacDisc - ceCx16_18IncidencePostVacDisc
  
  ceCx16_18MortalityDif = ceCx16_18MortalityPreVac - ceCx16_18MortalityPostVac
  
  ceCx16_18MortalityDifDisc = ceCx16_18MortalityPreVacDisc - ceCx16_18MortalityPostVacDisc
  
  lifeYearsLostDif = lifeYearsLostPreVac - lifeYearsLostPostVac
  
  lifeYearsLostDifDisc = lifeYearsLostPreVacDisc - lifeYearsLostPostVacDisc
  
  cancerDisabilitiesLostDif = cancerDisabilitiesLostPreVac - cancerDisabilitiesLostPostVac
  
  cancerDisabilitiesLostDifDisc = cancerDisabilitiesLostPreVacDisc - cancerDisabilitiesLostPostVacDisc
  
  cancerCareCostsDif = cancerCareCostsPreVac - cancerCareCostsPostVac
  
  cancerCareCostsDifDisc = cancerCareCostsPreVacDisc - cancerCareCostsPostVacDisc
  
  
  ##### model DF #####
  model = data.frame(
    age,
    cancerCareCostsDif,
    cancerCareCostsDifDisc,
    cancerCareCostsPostVac,
    cancerCareCostsPostVacDisc,
    cancerCareCostsPreVac,
    cancerCareCostsPreVacDisc,
    cancerDisabilitiesLostDif,
    cancerDisabilitiesLostDifDisc,
    cancerDisabilitiesLostPostVac,
    cancerDisabilitiesLostPostVacDisc,
    cancerDisabilitiesLostPreVac,
    cancerDisabilitiesLostPreVacDisc,
    cancerDisabilitiesPreVac,
    cancerDisabilitiesPreVacDisc,
    ceCx16_18IncidenceDif,
    ceCx16_18IncidenceDifDisc,
    ceCx16_18IncidencePostVac,
    ceCx16_18IncidencePostVacDisc,
    ceCx16_18IncidencePreVac,
    ceCx16_18IncidencePreVacDisc,
    ceCx16_18MortalityDif,
    ceCx16_18MortalityDifDisc,
    ceCx16_18MortalityPostVac,
    ceCx16_18MortalityPostVacDisc,
    ceCx16_18MortalityPreVac,
    ceCx16_18MortalityPreVacDisc,
    cumDiscFactor,
    discountFactor,
    lifeYearsLostDif,
    lifeYearsLostDifDisc,
    lifeYearsLostPostVac,
    lifeYearsLostPostVacDisc,
    lifeYearsLostPreVac,
    lifeYearsLostPreVacDisc,
    standardisedCohortSize_brith,
    standardisedCohortSize_vacAge,
    standardisedCohortSizeDisc
  )
  
  ##### incidence plot #####
  
  y1 = ceCx16_18IncidencePreVac * 100000
  y1 = c(rep(NA,(targetAgeGroup+1)),y1[1:(length(y1)-(targetAgeGroup+1))])
  y1[age>75] = NA
  
  y2 = ceCx16_18IncidencePostVac * 100000
  y2=c(rep(NA,(targetAgeGroup+1)),y2[1:(length(y1)-(targetAgeGroup+1))])
  y2[age>75] = NA
  
  dataPlot = data.frame(
    x=0:100,
    y1,
    y2)
  
  plot =
    highchart() %>%
    hc_add_series(data = dataPlot, name="Antes de la vacunación", type = "line", hcaes(x = x, y = y1)) %>% hc_xAxis(min = 0, max = 80) %>%
    hc_add_series(data = dataPlot, name = "Después de la vacunación", type = "line", hcaes(x = x, y = y2)) %>% hc_xAxis(min = 0, max = 80) %>%
    hc_title(
      text = "Efecto de la vacunación en la incidencia del cáncer de cuello de útero por edad",
      margin = 20,
      align = "center",
      style = list(color = "black", useHTML = TRUE)
    ) %>% hc_xAxis(
        title = list(
        text="Edad"
      )
    ) %>% hc_yAxis(
        title = list(
        text="Incidencia cáncer de cuello uterino relacionado con HPV-16/18"
      )
    )
  undisc = c(
    "Cohort size at birth (female)"=input$birthCohortSizeFemale,
    "Cohort size at vaccination age (female)"=input$cohortSizeAtVaccinationAgeFemale,
    "Cost of vaccination"=input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis,
    "Treatment costs saved"=sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Net cost"=-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis),
    "Cervical cancers prevented"=sum(model$ceCx16_18IncidenceDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Deaths prevented"=sum(model$ceCx16_18MortalityDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Life years saved"=sum(model$lifeYearsLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Nonfatal DALYs prevented"=sum(model$cancerDisabilitiesLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Incremental cost per cervical cancer prevented"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18IncidenceDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
    "Incremental cost per life saved"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18MortalityDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
    "Incremental cost per life year saved"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$lifeYearsLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
    "Incremental cost perDALY prevented"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/
      ((sum(model$lifeYearsLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(sum(model$cancerDisabilitiesLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)),
    "GDP per capita"=input$GDPPerCapita,
    "ROI" = ((sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)-(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis)*100
  )

  disc = c(
    "Cohort size at birth (female)"=input$birthCohortSizeFemale,
    "Cohort size at vaccination age (female)"=input$cohortSizeAtVaccinationAgeFemale,
    "Cost of vaccination"=input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis,
    "Treatment costs saved"=sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Net cost"=-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis),
    "Cervical cancers prevented"=sum(model$ceCx16_18IncidenceDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Deaths prevented"=sum(model$ceCx16_18MortalityDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Life years saved"=sum(model$lifeYearsLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Nonfatal DALYs prevented"=sum(model$cancerDisabilitiesLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
    "Incremental cost per cervical cancer prevented"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18IncidenceDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
    "Incremental cost per life saved"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18MortalityDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
    "Incremental cost per life year saved"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$lifeYearsLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
    "Incremental cost perDALY prevented"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/
      ((sum(model$lifeYearsLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(sum(model$cancerDisabilitiesLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)),
    "GDP per capita"=input$GDPPerCapita,
    "ROI" = ((sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)-(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis)*100
  )

  # undisc = c(
  #   "Tamaño de la cohorte de nacimiento (mujeres)"=input$birthCohortSizeFemale,
  #   "Tamaño de la cohorte en edad de vacunación (mujeres)"=input$cohortSizeAtVaccinationAgeFemale,
  #   "Costo total de la vacunación ($USD)"=input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis,
  #   "Costos de tratamiento ahorrados ($USD)"=sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Costo neto ($USD)"=-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis),
  #   "Cánceres de cuello uterino prevenidos (n)"=sum(model$ceCx16_18IncidenceDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Muertes prevenidas (n)"=sum(model$ceCx16_18MortalityDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Años de vida por muerte prematura evitados"=sum(model$lifeYearsLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Años de Vida Ajustados por Discapacidad evitados"=sum(model$cancerDisabilitiesLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Costo incremental por cáncer de cuello uterino prevenido ($USD)"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18IncidenceDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
  #   "Costo incremental por vida salvada ($USD)"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18MortalityDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
  #   "Costo incremental por Año de Vida Salvado ($USD)"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$lifeYearsLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
  #   "Costo incremental por Años de Vida Ajustados por Discapacidad prevenido ($USD)"=(-(sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/
  #     ((sum(model$lifeYearsLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(sum(model$cancerDisabilitiesLostDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)),
  #   "Producto Bruto Interno per Caápita"=input$GDPPerCapita,
  #   "Retorno de la Inversión (ROI)" = ((sum(model$cancerCareCostsDif*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)-(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis)*100
  # )
  # 
  # disc = c(
  #   "Tamaño de la cohorte de nacimiento (mujeres)"=input$birthCohortSizeFemale,
  #   "Tamaño de la cohorte en edad de vacunación (mujeres)"=input$cohortSizeAtVaccinationAgeFemale,
  #   "Costo total de la vacunación ($USD)"=input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis,
  #   "Costos de tratamiento ahorrados ($USD)"=sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Costo neto ($USD)"=-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis),
  #   "Cánceres de cuello uterino prevenidos (n)"=sum(model$ceCx16_18IncidenceDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Muertes prevenidas (n)"=sum(model$ceCx16_18MortalityDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Años de vida por muerte prematura evitados"=sum(model$lifeYearsLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Años de Vida Ajustados por Discapacidad evitados"=sum(model$cancerDisabilitiesLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale,
  #   "Costo incremental por cáncer de cuello uterino prevenido ($USD)"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18IncidenceDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
  #   "Costo incremental por vida salvada ($USD)"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$ceCx16_18MortalityDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
  #   "Costo incremental por Año de Vida Salvado ($USD)"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(sum(model$lifeYearsLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale),
  #   "Costo incremental por Años de Vida Ajustados por Discapacidad prevenido ($USD)"=(-(sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/
  #     ((sum(model$lifeYearsLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)+(sum(model$cancerDisabilitiesLostDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)),
  #   "Producto Bruto Interno per Caápita"=input$GDPPerCapita,
  #   "Retorno de la Inversión (ROI)" = ((sum(model$cancerCareCostsDifDisc*model$standardisedCohortSize_vacAge)*input$cohortSizeAtVaccinationAgeFemale)-(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis))/(input$totalVaccineCostPerFIG*input$cohortSizeAtVaccinationAgeFemale*input$coverageAllDosis)*100
  # )

  outcomes = data.frame(
    outcomes = names(disc),
    undisc = undisc,
    disc = disc
  )
  
  rownames(outcomes) = c(1:nrow(outcomes))
  
  inputsNames = c(
    "Tamaño de cohorte al nacimiento (mujeres)",
    "Tamaño de cohorte a la edad de vacunación (mujeres)",
    "Cobertura (todas las dosis)",
    "Eficacia de la vacuna frente al HPV 16/18",
    "Grupo de edad objetivo",
    "Precio de la vacuna por FIG",
    "Costo de entrega de la vacuna por FIG",
    "Costo total de la vacuna por FIG",
    "Costo del tratamiento del cáncer (por episodio, durante toda la vida)",
    "DALYs por diagnóstico de cáncer",
    "DALYs por secuelas no terminales del cáncer (por año)",
    "DALYs por cáncer terminal",
    "Tasa de descuento",
    "Proporción de casos de cáncer cervical debidos al HPV 16/18",
    "PIB per cápita"
  )
  
  inputsValues = c(
    input$birthCohortSizeFemale,
    input$cohortSizeAtVaccinationAgeFemale,
    input$coverageAllDosis,
    input$vaccineEfficacyVsHPV16_18,
    input$targetAgeGroup,
    input$vaccinePricePerFIG,
    input$vaccineDeliveryCostPerFIG,
    input$totalVaccineCostPerFIG,
    input$cancerTreatmentCostPerEpisodeOverLifetime,
    input$DALYsForCancerDiagnosis,
    input$DALYsForNonTerminalCancerSequelaePperYear,
    input$DALYsForTerminalCancer,
    input$discountRate,
    input$proportionOfCervicalCancerCasesThatAreDueToHPV16_18,
    input$GDPPerCapita
  )
  
  inputsTable = data.frame(
    Input = inputsNames,
    Value = inputsValues
  )
  
  return(
    list(
      model=model,
      dataPlot=dataPlot,
      plot=plot,
      outcomes=outcomes,
      inputsTable = inputsTable
    )
  )
}

# resultados= getPrime(
#   country,
#   birthCohortSizeFemale,
#   cohortSizeAtVaccinationAgeFemale,
#   coverageAllDosis,
#   vaccineEfficacyVsHPV16_18,
#   targetAgeGroup,
#   vaccinePricePerFIG,
#   vaccineDeliveryCostPerFIG,
#   totalVaccineCostPerFIG,
#   cancerTreatmentCostPerEpisodeOverLifetime,
#   DALYsForCancerDiagnosis,
#   DALYsForNonTerminalCancerSequelaePperYear,
#   DALYsForTerminalCancer,
#   discountRate,
#   proportionOfCervicalCancerCasesThatAreDueToHPV16_18,
#   GDPPerCapita,
#   mortall,
#   mortcecx,
#   incidence,
#   dalys,
#   parameters
# )
