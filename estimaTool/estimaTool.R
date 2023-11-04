library(dplyr)
library(tidyr)

load("estimaTool/base_line.RData")
load("estimaTool/targets_default.RData")
load("estimaTool/population.RData")

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
  `BASELINE_Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` = input$Prevalence_baseline,
  `TARGET_Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` = input$Prevalence_target,
  `BASELINE_Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` = input$Diagnosis_baseline,
  `TARGET_Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` = input$Diagnosis_target,
  `BASELINE_Tratamiento entre los diagnosticados (%)`= input$Treatment_baseline,
  `TARGET_Tratamiento entre los diagnosticados (%)`= input$Treatment_target,
  `BASELINE_Control de la hipertensión entre los tratados (%)` = input$Control_baseline,
  `TARGET_Control de la hipertensión entre los tratados (%)` = input$Control_target
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
  run[[country]]$population$`Población total` = as.numeric(Population)
  run[[country]]$baseline = list()
  run[[country]]$target = list()
  browser()
  run[[country]]$baseline$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` = `BASELINE_Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` * modifPrev$modificador[modifPrev$pais==country]
  run[[country]]$baseline$`Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` = `BASELINE_Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad`
  run[[country]]$baseline$`Tratamiento entre los diagnosticados (%)` = `BASELINE_Tratamiento entre los diagnosticados (%)`
  run[[country]]$baseline$`Control de la hipertensión entre los tratados (%)` = `BASELINE_Control de la hipertensión entre los tratados (%)`
  run[[country]]$target$`Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` = `TARGET_Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad`
  run[[country]]$target$`Tratamiento entre los diagnosticados (%)` = `TARGET_Tratamiento entre los diagnosticados (%)`
  run[[country]]$target$`Control de la hipertensión entre los tratados (%)` = `TARGET_Control de la hipertensión entre los tratados (%)`
  run[[country]]$baseline$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` = run[[country]]$baseline$`Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` * run[[country]]$baseline$`Tratamiento entre los diagnosticados (%)`
  run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` = run[[country]]$baseline$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$baseline$`Control de la hipertensión entre los tratados (%)`
  run[[country]]$target$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` = run[[country]]$target$`Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` * run[[country]]$target$`Tratamiento entre los diagnosticados (%)`
  run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` = run[[country]]$target$`Prevalence of treatment (taking medicine) for hypertension among adults aged 30-79 with hypertension, age-standardized` * run[[country]]$target$`Control de la hipertensión entre los tratados (%)`
  
  valor_x1 <- run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100
  valor_x2 <- run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100
  
  outcomesEpi = epi_model(
    run,
    round(valor_x1,1),
    round(valor_x2,1),
    country)
  
  run[[country]]$baseline$`Muertes por ECI por cada 100.000 habitantes que podrían evitarse` = round(outcomesEpi$dif_1,1)
  run[[country]]$baseline$`Muertes por ECI que podrían evitarse` = round(outcomesEpi$dif_1_pob,0)
  run[[country]]$baseline$`Muertes por ACV por cada 100.000 habitantes que podrían evitarse` = round(outcomesEpi$dif_2,1)
  run[[country]]$baseline$`Muertes por ACV que podrían evitarse` = round(outcomesEpi$dif_2_pob,0)
  run[[country]]$baseline$`Población (N) de nuevos hipertensos tratados entre adultos de 30-79 años con diagnóstico de hipertensión` = run[[country]]$population$`Población total` * run[[country]]$baseline$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` * run[[country]]$baseline$`Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` * run[[country]]$baseline$`Tratamiento entre los diagnosticados (%)`
  run[[country]]$baseline$`Población (N) de hipertensos controlados entre adultos de 30-79 años con hipertensión` = run[[country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` * run[[country]]$baseline$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` * run[[country]]$population$`Población total`
  run[[country]]$baseline$`Total de nuevos ECI evitados` = run[[country]]$baseline$`Muertes por ECI que podrían evitarse` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`Tasa de nuevos ECI evitados cada 100.00 habitantes` = run[[country]]$baseline$`Muertes por ECI por cada 100.000 habitantes que podrían evitarse` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`Total de nuevos ACV evitados` = run[[country]]$baseline$`Muertes por ACV que podrían evitarse` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`Tasa de ACV por 100.000 incidentes evitados` = run[[country]]$baseline$`Muertes por ACV por cada 100.000 habitantes que podrían evitarse` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Stroke" & fatality_weighted$gender == "Female"]))))
  run[[country]]$target$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` = run[[country]]$baseline$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad`
  run[[country]]$target$`Muertes por ECI por cada 100.000 habitantes que podrían evitarse` = run[[country]]$baseline$`Muertes por ECI por cada 100.000 habitantes que podrían evitarse`
  run[[country]]$target$`Muertes por ECI que podrían evitarse` = run[[country]]$baseline$`Muertes por ECI que podrían evitarse`
  run[[country]]$target$`Muertes por ACV por cada 100.000 habitantes que podrían evitarse` = run[[country]]$baseline$`Muertes por ACV por cada 100.000 habitantes que podrían evitarse`
  run[[country]]$target$`Muertes por ACV que podrían evitarse` = run[[country]]$baseline$`Muertes por ACV que podrían evitarse`
  run[[country]]$target$`Total de nuevos ACV evitados` = run[[country]]$baseline$`Total de nuevos ACV evitados`
  run[[country]]$target$`Tasa de ACV por 100.000 incidentes evitados` = run[[country]]$baseline$`Tasa de ACV por 100.000 incidentes evitados`
  run[[country]]$target$`Población (N) de nuevos hipertensos tratados entre adultos de 30-79 años con diagnóstico de hipertensión` = run[[country]]$population$`Población total` * run[[country]]$target$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` * run[[country]]$target$`Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad` * run[[country]]$target$`Tratamiento entre los diagnosticados (%)`
  run[[country]]$target$`Población (N) de hipertensos controlados entre adultos de 30-79 años con hipertensión` = run[[country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized` * run[[country]]$target$`Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad` * run[[country]]$population$`Población total`
  run[[country]]$target$`Total de nuevos ECI evitados` = run[[country]]$baseline$`Total de nuevos ECI evitados` = run[[country]]$baseline$`Muertes por ECI que podrían evitarse` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$target$`Tasa de nuevos ECI evitados cada 100.00 habitantes` = run[[country]]$target$`Muertes por ECI por cada 100.000 habitantes que podrían evitarse` / (sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  +  sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))) + sum(as.numeric(fatality_weighted$fatality_weighted[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) * sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"])) / (sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Male"]))  + sum(as.numeric(fatality_weighted$deaths[fatality_weighted$cause == "Ischemic heart disease" & fatality_weighted$gender == "Female"]))))
  run[[country]]$baseline$`Nueva población (N) tratada / Controlados actualmente previamente no controlados` = run[[country]]$target$`Población (N) de nuevos hipertensos tratados entre adultos de 30-79 años con diagnóstico de hipertensión` - run[[country]]$baseline$`Población (N) de nuevos hipertensos tratados entre adultos de 30-79 años con diagnóstico de hipertensión`
  run[[country]]$target$`Nueva población (N) tratada / Controlados actualmente previamente no controlados` =   run[[country]]$target$`Población (N) de hipertensos controlados entre adultos de 30-79 años con hipertensión` - run[[country]]$baseline$`Población (N) de hipertensos controlados entre adultos de 30-79 años con hipertensión`
  
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
          absolute = if (c=="Stroke") {"Muertes por ACV que podrían evitarse"} else {"Muertes por ECI que podrían evitarse"}
        } else {
          absolute = if (c=="Stroke") {"Total de nuevos ACV evitados"} else {"Total de nuevos ECI evitados"}
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
    outcome = "Total de AVAD evitados",
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
    `Costo anual de la intervención por paciente promedio  hipertenso tratado` = costs$value[costs$country==country & costs$parameter ==  "Costo anual de consulta médica en paciente promedio (*)"] + costs$value[costs$country==country & costs$parameter ==  "Costo farmacológico anual por paciente promedio (**)"],
    `Costos totales anuales de la intervención ponderado por la población objetivo alcanzada` = run[[country]]$baseline$`Nueva población (N) tratada / Controlados actualmente previamente no controlados` * costs$value[costs$country==country & costs$parameter ==  "Costo anual de consulta médica en paciente promedio (*)"] + run[[country]]$baseline$`Nueva población (N) tratada / Controlados actualmente previamente no controlados` * costs$value[costs$country==country & costs$parameter ==  "Costo farmacológico anual por paciente promedio (**)"],
    `Costos médicos directos evitados por evento cardiovasculares (ECI y ACV)` = run[[country]]$baseline$`Total de nuevos ECI evitados` * round(costs$value[costs$country==country & costs$parameter ==  "Evento de enfermedad cardiaca isquemica promedio  (***)"],3) + round(costs$value[costs$country==country & costs$parameter ==  "Evento de accidente cerebrovascular"],3) * run[[country]]$baseline$`Total de nuevos ACV evitados`
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