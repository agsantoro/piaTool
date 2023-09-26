library(dplyr)
library(tidyr)

load("estimaTool/base_line.RData")
load("estimaTool/targets_default.RData")
load("estimaTool/population.RData")


# input = list(
#   Country = country,
#   Population = population$population[population$country==country],
#   Prevalence_baseline = base_line$prevalence_of_hypertension[base_line$country==country],
#   Prevalence_target = targets_default$prevalence_of_hypertension[targets_default$country==country],
#   Diagnosis_baseline = base_line$prevalence_previous_diagnosis[base_line$country==country],
#   Diagnosis_target = targets_default$prevalence_previous_diagnosis[targets_default$country==country],
#   Treatment_baseline = base_line$treatment[base_line$country==country],
#   Treatment_target = targets_default$treatment[targets_default$country==country],
#   Control_baseline = base_line$control[base_line$country==country],
#   Control_target = targets_default$control[targets_default$country==country])

epi_model <- function(run, x1, x2, country) {
  if (x1 >= 0 && x1 <= 100 && x2 >= 0 && x2 <= 100) {
    valores_x <- data.frame(prevalencia = c(x1, x2))  # Crea un nuevo dataframe con los valores de x
    y_pronosticado_modelo1 <- as.data.frame(exp((-0.0294 * valores_x) +5.5305))
    y_pronosticado_modelo2 <- as.data.frame(exp((-0.0240177 * valores_x) + 4.57206))
    resultados <- data.frame(
      Modelo1_x1 = y_pronosticado_modelo1[1,1],
      Modelo1_x2 = y_pronosticado_modelo1[2,1],
      Modelo2_x1 = y_pronosticado_modelo2[1,1],
      Modelo2_x2 = y_pronosticado_modelo2[2,1]
    )
    resultados$dif_1 <- resultados[,1]-resultados[,2]
    resultados$dif_2 <- resultados[,3]-resultados[,4]
    pob <- as.numeric(run[[country]]$population)
    resultados$dif_1_pob <- resultados$dif_1*pob/100000 
    resultados$dif_2_pob <- resultados$dif_2* pob/100000 
    return(resultados)
  } else {
    stop("Los valores de x deben estar entre 0 y 100")
  }
}

estimaToolCosts = function(
    
  country = input$Country,
    Population = input$Population,
    `BASELINE_Prevalence of hypertension among adults aged 30-79 years, age-standardized` = input$Prevalence_baseline,
    `TARGET_Prevalence of hypertension among adults aged 30-79 years, age-standardized` = input$Prevalence_target,
    `BASELINE_Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` = input$Diagnosis_baseline,
    `TARGET_Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` = input$Diagnosis_target,
    `BASELINE_Treatment among those aware of the condition (%)`= input$Treatment_baseline,
    `TARGET_Treatment among those aware of the condition (%)`= input$Treatment_target,
    `BASELINE_Hypertension control among those treated (%)` = input$Control_baseline,
    `TARGET_Hypertension control among those treated (%)` = input$Control_target
    ) {
  ##### MORTALITY DATA #####
  # loading data
  load("estimaTool/mortality_data.RData")
  
  # adding both sexes as rows
  mortality_data = 
    union_all(
      mortality_data,
      mortality_data %>% group_by(location,sex="Both",age,cause,metric,year) %>%
        summarise(val=sum(val))
    )

  # summarizing metrics
  mortality_data = mortality_data %>%
    left_join(
      mortality_data %>% group_by(location, sex, cause) %>%
        summarise(sum = sum(val))
    ) %>% mutate(proporcion = val/sum)
  

  ##### FATALITY DATA #####
  
  # loading fatality data
  load("estimaTool/fatality_data.RData")
  
  # wrangling data to calculated weighted fatality ratios 
  fatality_data = fatality_data %>% pivot_longer(names_to = "gender", cols = 3:4)
  
  male_ihd = mortality_data$val[mortality_data$location=="Brazil" & mortality_data$sex=="Male" & mortality_data$cause=="Ischemic heart disease"][-1]
  male_ihd = c(rep(male_ihd[1:9], each = 5),last(male_ihd))
  male_ihd_deaths = male_ihd
  male_ihd = male_ihd/sum(male_ihd)
  male_ihd = male_ihd * fatality_data$value[fatality_data$cause=="Ischemic heart disease" & fatality_data$gender=="male" & fatality_data$age %in% 35:80]
  
  female_ihd = mortality_data$val[mortality_data$location=="Brazil" & mortality_data$sex=="Female" & mortality_data$cause=="Ischemic heart disease"][-1]
  female_ihd = c(rep(female_ihd[1:9], each = 5),last(female_ihd))
  female_ihd_deaths = female_ihd
  female_ihd = female_ihd/sum(female_ihd)
  female_ihd = female_ihd * fatality_data$value[fatality_data$cause=="Ischemic heart disease" & fatality_data$gender=="female" & fatality_data$age %in% 35:80]
  
  male_stroke = mortality_data$val[mortality_data$location=="Brazil" & mortality_data$sex=="Male" & mortality_data$cause=="Stroke"][-1]
  male_stroke = c(rep(male_stroke[1:9], each = 5),last(male_stroke))
  male_stroke_deaths = male_stroke
  male_stroke = male_stroke/sum(male_stroke)
  male_stroke = male_stroke * fatality_data$value[fatality_data$cause=="Stroke" & fatality_data$gender=="male" & fatality_data$age %in% 35:80]
  
  female_stroke = mortality_data$val[mortality_data$location=="Brazil" & mortality_data$sex=="Female" & mortality_data$cause=="Stroke"][-1]
  female_stroke = c(rep(female_stroke[1:9], each = 5),last(female_stroke))
  female_stroke_deaths = female_stroke
  female_stroke = female_stroke/sum(female_stroke)
  female_stroke = female_stroke * fatality_data$value[fatality_data$cause=="Stroke" & fatality_data$gender=="female" & fatality_data$age %in% 35:80]
  
  fatality_weighted = cbind(
    age = 35:80,
    cause = c(rep("Ischemic heart disease", length(male_ihd) * 2), rep("Stroke", length(male_ihd) * 2)),
    gender = c(rep("Male", length(male_ihd)),rep("Female", length(male_ihd)),rep("Male", length(male_ihd)),rep("Female", length(male_ihd))),
    fatality_weighted = c(male_ihd,female_ihd,male_stroke,female_stroke),
    deaths = c(male_ihd_deaths,female_ihd_deaths,male_stroke_deaths,female_stroke_deaths)
  ) %>% as.data.frame()
  
  
  #### ESTIMA TOOL RUN #####
  
  run = list()
  run[[country]] = list()
  run[[country]]$population$`Total Population` = as.numeric(Population)
  run[[country]]$baseline = list()
  run[[country]]$target = list()
  
  run[[country]]$baseline$`Prevalence of hypertension among adults aged 30-79 years, age-standardized` = `BASELINE_Prevalence of hypertension among adults aged 30-79 years, age-standardized`
  run[[country]]$baseline$`Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` = `BASELINE_Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized`
  run[[country]]$baseline$`Treatment among those aware of the condition (%)` = `BASELINE_Treatment among those aware of the condition (%)`
  run[[country]]$baseline$`Hypertension control among those treated (%)` = `BASELINE_Hypertension control among those treated (%)`
  run[[country]]$target$`Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` = `TARGET_Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized`
  run[[country]]$target$`Treatment among those aware of the condition (%)` = `TARGET_Treatment among those aware of the condition (%)`
  run[[country]]$target$`Hypertension control among those treated (%)` = `TARGET_Hypertension control among those treated (%)`
  run[[country]]$baseline$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` = run[[country]]$baseline$`Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$baseline$`Treatment among those aware of the condition (%)`
  run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` = run[[country]]$baseline$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$baseline$`Hypertension control among those treated (%)`
  run[[country]]$target$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` = run[[country]]$target$`Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$target$`Treatment among those aware of the condition (%)`
  run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` = run[[country]]$target$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$target$`Hypertension control among those treated (%)`
  
  valor_x1 <- run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100
  valor_x2 <- run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100

  outcomesEpi = epi_model(
    run,
    round(valor_x1,1),
    round(valor_x2,1),
    country)
  
  run[[country]]$baseline$`IHD deaths per 100k pop that could be averted` = round(outcomesEpi$dif_1,1)
  run[[country]]$baseline$`IHD absolute deaths that could be averted` = round(outcomesEpi$dif_1_pob,0)
  run[[country]]$baseline$`Stroke deaths per 100k pop that could be averted` = round(outcomesEpi$dif_2,1)
  run[[country]]$baseline$`Stroke absolute deaths that could be averted` = round(outcomesEpi$dif_2_pob,0)
  run[[country]]$baseline$`Population (N) of new treated hypertension among adults aged 30-79 with a diagnosis of hyperension` = run[[country]]$population$`Total Population` * run[[country]]$baseline$`Prevalence of hypertension among adults aged 30-79 years, age-standardized` * run[[country]]$baseline$`Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$baseline$`Treatment among those aware of the condition (%)`
  run[[country]]$baseline$`Population (N) of controlled hypertension among adults aged 30-79 with hyperension` = run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` * run[[country]]$baseline$`Prevalence of hypertension among adults aged 30-79 years, age-standardized` * run[[country]]$population$`Total Population`
  run[[country]]$baseline$`IHD Total Incident events averted` = run[[country]]$baseline$`IHD absolute deaths that could be averted` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`IHD Rate 100k Incident events averted` = run[[country]]$baseline$`IHD deaths per 100k pop that could be averted` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`Stroke Total Incident events averted` = run[[country]]$baseline$`Stroke absolute deaths that could be averted` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`Stroke Rate 100k Incident events averted` = run[[country]]$baseline$`Stroke deaths per 100k pop that could be averted` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))))
  run[[country]]$target$`Prevalence of hypertension among adults aged 30-79 years, age-standardized` = run[[country]]$baseline$`Prevalence of hypertension among adults aged 30-79 years, age-standardized`
  run[[country]]$target$`IHD deaths per 100k pop that could be averted` = run[[country]]$baseline$`IHD deaths per 100k pop that could be averted`
  run[[country]]$target$`IHD absolute deaths that could be averted` = run[[country]]$baseline$`IHD absolute deaths that could be averted`
  run[[country]]$target$`Stroke deaths per 100k pop that could be averted` = run[[country]]$baseline$`Stroke deaths per 100k pop that could be averted`
  run[[country]]$target$`Stroke absolute deaths that could be averted` = run[[country]]$baseline$`Stroke absolute deaths that could be averted`
  run[[country]]$target$`Stroke Total Incident events averted` = run[[country]]$baseline$`Stroke Total Incident events averted`
  run[[country]]$target$`Stroke Rate 100k Incident events averted` = run[[country]]$baseline$`Stroke Rate 100k Incident events averted`
  run[[country]]$target$`Population (N) of new treated hypertension among adults aged 30-79 with a diagnosis of hyperension` = run[[country]]$population$`Total Population` * run[[country]]$target$`Prevalence of hypertension among adults aged 30-79 years, age-standardized` * run[[country]]$target$`Prevalence of previous diagnosis of hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$target$`Treatment among those aware of the condition (%)`
  run[[country]]$target$`Population (N) of controlled hypertension among adults aged 30-79 with hyperension` = run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` * run[[country]]$target$`Prevalence of hypertension among adults aged 30-79 years, age-standardized` * run[[country]]$population$`Total Population`
  run[[country]]$target$`IHD Total Incident events averted` = run[[country]]$baseline$`IHD Total Incident events averted` = run[[country]]$baseline$`IHD absolute deaths that could be averted` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$target$`IHD Rate 100k Incident events averted` = run[[country]]$target$`IHD deaths per 100k pop that could be averted` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`New population (N) treated / Now controlled from former non-controlled population` = run[[country]]$target$`Population (N) of new treated hypertension among adults aged 30-79 with a diagnosis of hyperension` - run[[country]]$baseline$`Population (N) of new treated hypertension among adults aged 30-79 with a diagnosis of hyperension`
  run[[country]]$target$`New population (N) treated / Now controlled from former non-controlled population` =   run[[country]]$target$`Population (N) of controlled hypertension among adults aged 30-79 with hyperension` - run[[country]]$baseline$`Population (N) of controlled hypertension among adults aged 30-79 with hyperension`
  
  ###### DISABILITY WEIGHT #####
  
  disability_weight = 0.0791335
  
  
  ##### EXPECTATION OF LIFE #####
  
  load("estimaTool/life_exp.RData")
  
  
  ##### averted events #####
  
  averted_by_age = data.frame()
  
  for ( e in c("Deaths", "Events")) {
    for (c in c("Ischemic heart disease","Stroke")) {
      for (i in unique(mortality_data$age)) {
        cause = c 
        country = country
        age=i
        gender="Male"
        event = e
        
        if (e == "Deaths") {
          absolute = if (c=="Stroke") {"Stroke absolute deaths that could be averted"} else {"IHD absolute deaths that could be averted"}
        } else {
          absolute = if (c=="Stroke") {"Stroke Total Incident events averted"} else {"IHD Total Incident events averted"}
        }
        
        prop = list(
          Male = sum(mortality_data$val[mortality_data$location==country & mortality_data$sex == "Male" & mortality_data$cause == cause]) / (sum(mortality_data$val[mortality_data$location==country & mortality_data$sex == "Male" & mortality_data$cause == cause]) + sum(mortality_data$val[mortality_data$location==country & mortality_data$sex == "Female" & mortality_data$cause == cause])),
          Female = sum(mortality_data$val[mortality_data$location==country & mortality_data$sex == "Female" & mortality_data$cause == cause]) / (sum(mortality_data$val[mortality_data$location==country & mortality_data$sex == "Male" & mortality_data$cause == cause]) + sum(mortality_data$val[mortality_data$location==country & mortality_data$sex == "Female" & mortality_data$cause == cause]))
        )
        
        dist = mortality_data$proporcion[mortality_data$location==country & mortality_data$sex == gender & mortality_data$cause == cause & mortality_data$age == age]
        deaths_esi_averted_male = run[[country]]$baseline[[absolute]] * prop[[gender]] * dist
        
        gender="Female"
        dist = mortality_data$proporcion[mortality_data$location==country & mortality_data$sex == gender & mortality_data$cause == cause & mortality_data$age == age]
        deaths_esi_averted_female = run[[country]]$baseline[[absolute]] * prop[[gender]] * dist
        
        add = data.frame(
          event,
          age= i,
          cause,
          Male = deaths_esi_averted_male,
          Female = deaths_esi_averted_female
        )
        averted_by_age = rbind(averted_by_age,add)
      }
    }
  }
  
  averted_by_age = averted_by_age %>% pivot_longer(names_to = "gender", cols = c("Male","Female")) %>% arrange(event,cause,gender)
  
  dalys_by_age = averted_by_age[averted_by_age$event=="Deaths",] %>% left_join(life_exp[life_exp$location==country,]) %>%
    mutate(yll=value*lex) %>%
    dplyr::select(cause,age,gender,yll) %>%
    left_join(averted_by_age[averted_by_age$event=="Events",]) %>%
    mutate(dalys=value*disability_weight) %>% 
    dplyr::select(cause,age,gender,yll,dalys) %>% 
    arrange(cause,gender,age)
  
  dalys_overall = dalys_by_age %>% group_by(age,gender) %>%
    summarise(yll=sum(yll),dalys=sum(dalys)) %>%
    mutate(dalys_overall=yll+dalys) %>% arrange(gender,age)
  
  epi_outcomes = data.frame(
    outcome = "Total Dalys averted",
    value = sum(dalys_overall$dalys_overall)
  )
  
  
  ##### epi-model params #####
  
  epi_model_y = c(
    y1 = run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`,
    y2 = run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`
  )
  
  ##### COSTS #####
  
  load("estimaTool/costs.RData")
  costs_outcomes = list(
    `Annual intervention cost per average treated hypertensive patient` = costs$value[costs$country==country & costs$parameter ==  "Costo anual de consulta médica en paciente promedio (*)"] + costs$value[costs$country==country & costs$parameter ==  "Costo farmacológico anual por paciente promedio (**)"],
    `Total annual intervention cost weighted by the target population reached` = run[[country]]$baseline$`New population (N) treated / Now controlled from former non-controlled population` * costs$value[costs$country==country & costs$parameter ==  "Costo anual de consulta médica en paciente promedio (*)"] + run[[country]]$baseline$`New population (N) treated / Now controlled from former non-controlled population` * costs$value[costs$country==country & costs$parameter ==  "Costo farmacológico anual por paciente promedio (**)"],
    `Direct medical costs avoided due to cardiovascular events (IHD and stroke)` = run[[country]]$baseline$`IHD Total Incident events averted` * round(costs$value[costs$country==country & costs$parameter ==  "Evento de enfermedad cardiaca isquemica promedio  (***)"],3) + round(costs$value[costs$country==country & costs$parameter ==  "Evento de accidente cerebrovascular"],3) * run[[country]]$baseline$`Stroke Total Incident events averted`
  )
  
  estimaToolModel = list(
    country = country,
    mortality_data = mortality_data,
    fatality_data = fatality_data,
    run = run,
    life_exp = life_exp,
    fatality_data = fatality_data,
    fatality_weighted = fatality_weighted,
    averted_by_age = averted_by_age,
    dalys_by_age = dalys_by_age,
    dalys_overall = dalys_overall,
    epi_outcomes = epi_outcomes,
    costs_outcomes = costs_outcomes,
    epi_model_y = epi_model_y,
    epi_model_outcomes = outcomesEpi
  )
  return(estimaToolModel)
}

#resultado = estimaToolCosts()





