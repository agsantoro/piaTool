library(readxl)

source("functions/createLifetable.R")

# mortality and incidence data
mortall = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "mortall")
mortcecx = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "mortcecx")
mortcecx[is.na(mortcecx)] = 0
incidence = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "incidence")

# dalys params
dalys = readxl::read_xlsx("xlsx/PRIME_v2.3.xlsx", sheet = "Model", range = "AV2:AW6")
colnames(dalys)[1]="event"

getPrime = function (
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
  standardisedCohortSize_vacAge[age<input$targetAgeGroup] = 0
  for (i in (length(standardisedCohortSize_vacAge[age<input$targetAgeGroup])):(length(standardisedCohortSize_vacAge))) {
    standardisedCohortSize_vacAge[i] = standardisedCohortSize_brith[i]/standardisedCohortSize_brith[age==input$targetAgeGroup]
  }
  
  discountFactor = rep(NA,101) 
  discountFactor[age<=input$targetAgeGroup] = 1
  discountFactor[age>input$targetAgeGroup] = 1/((1+input$discountRate)^(age[age>input$targetAgeGroup]-input$targetAgeGroup))
  
  cumDiscFactor = c(0,cumsum(discountFactor))[1:101]
  
  standardisedCohortSizeDisc = standardisedCohortSize_vacAge * discountFactor
  
  ##### PRE VACCINATION #####
  
  ceCx16_18IncidencePreVac = as.numeric(incidence[incidence$`Country ¦ Age [10]`==input$country,-1]) * input$proportionOfCervicalCancerCasesThatAreDueToHPV16_18
  ceCx16_18IncidencePreVac[is.na(ceCx16_18IncidencePreVac)] = 0
  
  ceCx16_18IncidencePreVacDisc = ceCx16_18IncidencePreVac * discountFactor
  ceCx16_18IncidencePreVacDisc[is.na(ceCx16_18IncidencePreVacDisc)] = 0
  
  ceCx16_18MortalityPreVac = as.numeric(mortcecx[mortcecx$`Country ¦ Age [11]`==input$country,-1]) * input$proportionOfCervicalCancerCasesThatAreDueToHPV16_18
  
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
  
  cancerDisabilitiesLostPreVacDisc = ((ceCx16_18IncidencePreVac - ceCx16_18MortalityPreVac) * dalys$DALYs[3] + ceCx16_18MortalityPreVac * dalys$DALYs[4]) / (1 + input$discountRate) ^ (age - 12)
  
  cancerCareCostsPreVac = ceCx16_18IncidencePreVac * input$cancerTreatmentCostPerEpisodeOverLifetime
  
  cancerCareCostsPreVacDisc = cancerCareCostsPreVac / (1+input$discountRate) ^ (age - 12)
  
  
  ##### POST VACCINATION #####
  
  ceCx16_18IncidencePostVac = c()
  ceCx16_18IncidencePostVac[age<input$targetAgeGroup] = ceCx16_18IncidencePreVac[age<input$targetAgeGroup]
  ceCx16_18IncidencePostVac[age>=input$targetAgeGroup] = ceCx16_18IncidencePreVac[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  ceCx16_18IncidencePostVacDisc = c()
  ceCx16_18IncidencePostVacDisc[age<input$targetAgeGroup] = ceCx16_18IncidencePreVacDisc[age<input$targetAgeGroup]
  ceCx16_18IncidencePostVacDisc[age>=input$targetAgeGroup] = ceCx16_18IncidencePreVacDisc[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  ceCx16_18MortalityPostVac = c()
  ceCx16_18MortalityPostVac[age<input$targetAgeGroup] = ceCx16_18MortalityPreVac[age<input$targetAgeGroup]
  ceCx16_18MortalityPostVac[age>=input$targetAgeGroup] = ceCx16_18MortalityPreVac[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  ceCx16_18MortalityPostVacDisc = c()
  ceCx16_18MortalityPostVacDisc[age<input$targetAgeGroup] = ceCx16_18MortalityPreVacDisc[age<input$targetAgeGroup]
  ceCx16_18MortalityPostVacDisc[age>=input$targetAgeGroup] = ceCx16_18MortalityPreVacDisc[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  lifeYearsLostPostVac = c()
  lifeYearsLostPostVac[age<input$targetAgeGroup] = lifeYearsLostPreVac[age<input$targetAgeGroup]
  lifeYearsLostPostVac[age>=input$targetAgeGroup] = lifeYearsLostPreVac[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  lifeYearsLostPostVacDisc = c()
  lifeYearsLostPostVacDisc[age<input$targetAgeGroup] = lifeYearsLostPreVacDisc[age<input$targetAgeGroup]
  lifeYearsLostPostVacDisc[age>=input$targetAgeGroup] = lifeYearsLostPreVacDisc[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  cancerDisabilitiesLostPostVac = c()
  cancerDisabilitiesLostPostVac[age<input$targetAgeGroup] = cancerDisabilitiesLostPreVac[age<input$targetAgeGroup]
  cancerDisabilitiesLostPostVac[age>=input$targetAgeGroup] = cancerDisabilitiesLostPreVac[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  cancerDisabilitiesLostPostVacDisc = c()
  cancerDisabilitiesLostPostVacDisc[age<input$targetAgeGroup] = cancerDisabilitiesLostPreVacDisc[age<input$targetAgeGroup]
  cancerDisabilitiesLostPostVacDisc[age>=input$targetAgeGroup] = cancerDisabilitiesLostPreVacDisc[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  cancerCareCostsPostVac = c()
  cancerCareCostsPostVac[age<input$targetAgeGroup] = cancerCareCostsPreVac[age<input$targetAgeGroup]
  cancerCareCostsPostVac[age>=input$targetAgeGroup] = cancerCareCostsPreVac[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  cancerCareCostsPostVacDisc = c()
  cancerCareCostsPostVacDisc[age<input$targetAgeGroup] = cancerCareCostsPreVacDisc[age<input$targetAgeGroup]
  cancerCareCostsPostVacDisc[age>=input$targetAgeGroup] = cancerCareCostsPreVacDisc[age>=input$targetAgeGroup] * (1 - input$coverageAllDosis * input$vaccineEfficacyVsHPV16_18)
  
  
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
  y1 = c(rep(NA,(input$targetAgeGroup+1)),y1[1:(length(y1)-(input$targetAgeGroup+1))])
  y1[age>75] = NA
  
  y2 = ceCx16_18IncidencePostVac * 100000
  y2=c(rep(NA,(input$targetAgeGroup+1)),y2[1:(length(y1)-(input$targetAgeGroup+1))])
  y2[age>75] = NA
  
  dataPlot = data.frame(
    x=0:100,
    y1,
    y2)
  
  plot =
    highchart() %>%
    hc_add_series(data = dataPlot, name="Pre-vaccinartion", type = "line", hcaes(x = x, y = y1)) %>% hc_xAxis(min = 0, max = 80) %>%
    hc_add_series(data = dataPlot, name = "Pos-vaccination", type = "line", hcaes(x = x, y = y2)) %>% hc_xAxis(min = 0, max = 80) %>%
    hc_title(
      text = "Effect of vaccination on incidence of cervical cancer by age",
      margin = 20,
      align = "left",
      style = list(color = "black", useHTML = TRUE)
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
    "GDP per capita"=input$GDPPerCapita
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
    "GDP per capita"=input$GDPPerCapita
  )
  
  outcomes = data.frame(
    outcomes = names(disc),
    undisc = undisc,
    disc = disc
  ) 
  
  rownames(outcomes) = c(1:nrow(outcomes))
  
  return(
    list(
      model=model,
      plot=plot,
      outcomes=outcomes
    )
  )
}

resultados= getPrime(
  input$country,
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
  input$GDPPerCapita,
  mortall,
  mortcecx,
  incidence,
  dalys,
  parameters
)
