# ##### APP #####
source("functions/getCards.R", encoding = "UTF-8")
source("functions/getStyle.R", encoding = "UTF-8")
source("UI/start.R", encoding = "UTF-8")
source("UI/UI_avanzada.R", encoding = "UTF-8")
# source("UI/UI_main.R", encoding = "UTF-8")
source("UI/home.R", encoding = "UTF-8")
source("UI/UI_hpv.R", encoding = "UTF-8")
source("UI/UI_hpp.R", encoding = "UTF-8")
source("UI/UI_hepC.R", encoding = "UTF-8")
source("UI/UI_hearts.R", encoding = "UTF-8")
source("UI/UI_escenarios.R", encoding = "UTF-8")
source("UI/UI_routes.R", encoding = "UTF-8")
source("server/server_hpv.R", encoding = "UTF-8")

server <- function(input, output, session) {
  
  # implementa router
  router_server()
  
  # muestra div para guardar escenario
  observeEvent(input$saveScenario, {
    show("guardar_hpv", anim = T, animType = "slide")
    show("scenarioName", anim = T, animType = "slide")
    show("saveScenario2", anim = T, animType = "slide")
  })
  
  
  # crea listas para almacenar escenarios guardados
  
  # hpp
  hpp_scenarios = reactiveValues()
  hpp_scenarios$savedScenarios = list()
  
  # hpv
  scenarios = reactiveValues()
  scenarios$savedScenarios = list()
  
  # hearts 
  hearts_scenarios = reactiveValues()
  hearts_scenarios$savedScenarios = list()
  
  # hepc
  hepC_scenarios = reactiveValues()
  hepC_scenarios$savedScenarios = list()
  
  # guarda escenarios
  observeEvent(input$saveScenario2, {
    if (input$intervencion == "Vacuna contra el HPV") {
      if (input$scenarioName !="") {
        scnID = UUIDgenerate()
        scnName = input$scenarioName
        scenarios$savedScenarios[[scnName]] <- resultados()
        summaryScenarios = data.frame(outcomes=scenarios$savedScenarios[[1]]$outcomes[[1]])
        show("ver_escenarios_guardados")
        
        for (i in names(scenarios$savedScenarios)){
          summaryScenarios = cbind(summaryScenarios,data.frame(scenarios$savedScenarios[[i]]$outcomes[,"undisc"]))
        }
        
        colnames(summaryScenarios)[2:ncol(summaryScenarios)] = names(scenarios$savedScenarios)
        colnames(summaryScenarios)[1] = "Outcomes"
        summaryScenarios = summaryScenarios %>% mutate(across(c(2:ncol(summaryScenarios)), function(x) format(round(x,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)))
        
        if (is.null(input$savedScenarios)) {
          scenarios$summaryTable = summaryScenarios   
        } else {
          scenarios$summaryTable = summaryScenarios[,c("Outcomes",names(scenarios$savedScenarios))]   
        }
        
        # envía aviso de escenario guardado
        sendSweetAlert(
          session = session,
          title = "Escenario guardado",
          text = paste0("Nombre: ",scnName),
          type = "success",
          btn_labels = "Continuar",
          btn_colors = "#E95420"
          
        )
        
        # oculta div guardar escenario una vez guardado
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "fade")
        updateTextAreaInput(session,"scenarioName",value="")  
        
      } else {
        sendSweetAlert(
          session = session,
          title = "",
          text = "Debe definir un nombre para guardar el escenario.",
          type = "error"
        )
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "slide")
      }
      
    } else if (input$intervencion == "HEARTS") {
      
      if (input$scenarioName !="") {
        scnID = UUIDgenerate()
        scnName = input$scenarioName
        country_sel = str_to_title(input$country)
        
        metrica_baseline = names(run_hearts()$run[[country_sel]]$baseline)
        valores_baseline = unname(unlist(run_hearts()$run[[country_sel]]$baseline))
        metrica_target = names(run_hearts()$run[[country_sel]]$target)
        valores_target = unname(unlist(run_hearts()$run[[country_sel]]$target))
        
        table = left_join(
          data.frame(
            metrica = metrica_baseline,
            valores_baseline
          ),
          data.frame(
            metrica = metrica_target,
            valores_target
          ))
        
        table = table[7:17,c("metrica","valores_target")]
        colnames(table) = c("Indicador","Valor")  
        
        epi = run_hearts()$epi_outcomes
        colnames(epi) = colnames(table)
        
        costos = data.frame(
          Indicador=names(run_hearts()$costs_outcomes),
          Valor=unname(unlist(run_hearts()$costs_outcomes))
          
        ) 
        
        table = rbind(
          table,
          epi,
          costos
        )
        
        table$Valor = round(table$Valor,1)
        
        hearts_scenarios$savedScenarios[[scnName]] <- table
        
        sendSweetAlert(
          session = session,
          title = "Escenario guardado",
          text = paste0("Nombre: ",scnName),
          type = "success"
        )
        
        # oculta div guardar escenario una vez guardado
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "fade")
        updateTextAreaInput(session,"scenarioName",value="")
        show("ver_escenarios_guardados", anim = T, animType = "fade")
        
      } else {
        sendSweetAlert(
          session = session,
          title = "Error",
          text = "Debe definir un nombre para guardar el escenario.",
          type = "error"
        )
        
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "slide")
        
      }
      
    } else if (input$intervencion == "Hemorragia postparto") {
      if (input$scenarioName !="") {
        scnID = UUIDgenerate()
        scnName = input$scenarioName
        
        table = hpp_run()
        
        hpp_scenarios$savedScenarios[[scnName]] <- table
        
        sendSweetAlert(
          session = session,
          title = "Escenario guardado",
          text = paste0("Nombre: ",scnName),
          type = "success"
        )
        # oculta div guardar escenario una vez guardado
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "fade")
        updateTextAreaInput(session,"scenarioName",value="")
        show("ver_escenarios_guardados", anim = T, animType = "fade")
      } else {
        sendSweetAlert(
          session = session,
          title = "Error",
          text = "Debe definir un nombre para guardar el escenario.",
          type = "error"
        )
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "slide")
      }
    } else {
      if (input$scenarioName !="") {
        
        scnID = UUIDgenerate()
        scnName = input$scenarioName
        
        table = hepC_run()
        
        hepC_scenarios$savedScenarios[[scnName]] <- table
        
        sendSweetAlert(
          session = session,
          title = "Escenario guardado",
          text = paste0("Nombre: ",scnName),
          type = "success"
        )
        
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "fade")
        updateTextAreaInput(session,"scenarioName",value="")
        show("ver_escenarios_guardados", anim = T, animType = "fade")
      } else {
        sendSweetAlert(
          session = session,
          title = "Error",
          text = "Debe definir un nombre para guardar el escenario.",
          type = "error"
        )
        hide("guardar_hpv", anim = T, animType = "slide")
        hide("scenarioName", anim = T, animType = "slide")
        hide("saveScenario2", anim = T, animType = "slide")
        show("saveScenario", anim = T, animType = "slide")
      }
      
      
      
    }
    
    
  })
  
  observeEvent(input$toggle_avanzado_hpv, {
    for (i in names(parametersReactive())[4:15]) {
      isVisible <- shinyjs::toggleState(id = i)
      
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
    
  })
  
  # decide que ui avanzada muestra según intervención
  observeEvent(list(input$intervencion,
                    input$country), {
                      if (input$intervencion == "Vacuna contra el HPV") {
                        output$uiOutput_basica <- ui_hpv_basica(parametersReactive(),input,inputs_hpv())
                      } else if (input$intervencion == "HEARTS") {
                        output$uiOutput_basica <- ui_hearts(input, base_line)
                      } else if (input$intervencion == "Hemorragia postparto") {
                        output$uiOutput_basica <- ui_hpp(input)
                      } else if (input$intervencion == "Hepatitis C") {
                        output$uiOutput_basica <- ui_hepC(input, datosPais)
                      }
                    })
  
  # deshabilita botón para ver escenarios guardados
  hide("ver_escenarios_guardados")
  
  ##### HPV #####
  # lista de parámetros
  parametersReactive <- reactive({
    paramsList = list(
      birthCohortSizeFemale = as.numeric(parameters[parameters$Country==input$country,8]),
      cohortSizeAtVaccinationAgeFemale = as.numeric(parameters[parameters$Country==input$country,10]),
      coverageAllDosis = as.numeric(parameters[parameters$Country==input$country,11]),
      vaccineEfficacyVsHPV16_18 = as.numeric(parameters[parameters$Country==input$country,12]),
      targetAgeGroup = as.numeric(parameters[parameters$Country==input$country,13]),
      vaccinePricePerFIG = as.numeric(parameters[parameters$Country==input$country,14]),
      vaccineDeliveryCostPerFIG = as.numeric(parameters[parameters$Country==input$country,15]),
      totalVaccineCostPerFIG = as.numeric(parameters[parameters$Country==input$country,14])+as.numeric(parameters[parameters$Country==input$country,15]),
      cancerTreatmentCostPerEpisodeOverLifetime = as.numeric(parameters[parameters$Country==input$country,16]),
      DALYsForCancerDiagnosis = 0.08,
      DALYsForNonTerminalCancerSequelaePperYear = as.numeric(parameters[parameters$Country==input$country,22]),
      DALYsForTerminalCancer = 0.78,
      discountRate = as.numeric(parameters[parameters$Country==input$country,18]),
      proportionOfCervicalCancerCasesThatAreDueToHPV16_18 = as.numeric(parameters[parameters$Country==input$country,19]),
      GDPPerCapita = as.numeric(parameters[parameters$Country==input$country,20])
    )
    return(paramsList)
  })
  
  resultados  <-  reactive({
    
    getPrime(
      input,
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
  })
  
  
  
  ##### HEARTS #####
  
  run_hearts <- reactive({
    if (is.null(input$hearts_input_target_4)==F) {
      estimaToolCosts(
        str_to_title(input$country),
        population$population[population$country==str_to_title(input$country)],
        input$hearts_input_base_1,
        input$hearts_input_target_1,
        input$hearts_input_base_2,
        input$hearts_input_target_2,
        input$hearts_input_base_3,
        input$hearts_input_target_3,
        input$hearts_input_base_4,
        input$hearts_input_target_4
      )
    }
  })
  
  
  observeEvent(input$toggle_avanzado_hearts, {
    inputs_toggle = names(input)[substring(names(input),1,6)=="hearts"]
    inputs_hide = inputs_toggle[-grep(3,inputs_toggle)]
    
    for (i in c(inputs_hide, "titulo1","titulo2")) {
      isVisible <- shinyjs::toggleState(id = i)
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
  })
  
  
  server_hpv(input, 
             output, 
             parametersReactive(), 
             scenarios, 
             resultados,
             run_hearts, 
             hearts_scenarios, 
             hpp_run, 
             hpp_scenarios, 
             hepC_run,
             hepC_scenarios)
  
  ##### HPP #####
  
  hpp_run = reactive({
    
    if (length(input$hpp_costoIntervencion)>0) {
      resultados = resultados_comparados(str_to_title(input$country),
                                         input$hpp_uso_oxitocina_base,
                                         input$hpp_uso_oxitocina_taget,
                                         input$hpp_descuento,
                                         input$hpp_costoIntervencion)
      
      data.frame(
        Indicador = c("Costo promedio de un evento de Hemorragia Post Parto",
                      "Perdida de Qaly por un evento de Hemorragia Post Parto",
                      "Diferencia de costo",
                      "Hemorragias Post Parto Evitadas",
                      "Muertes por Hemorragias Post Parto Evitadas",
                      "Histerectomias por Hemorragias Post Parto Evitadas",
                      "Años de vida por muerte prematura salvados",
                      "Años de vida por discapacidad salvados"),
        Valor = c(resultados$base$"Costo_HPP",
                  resultados$base$"Dalys_Total",
                  resultados[["comparacion"]][["Diferencia de costo"]],
                  resultados[["comparacion"]][["Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Muertes por Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Histerectomias por Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Años de vida por muerte prematura salvados"]],
                  resultados[["comparacion"]][["Años de vida por discapacidad salvados"]])
      )
    }
    
  })
  
  
  observeEvent(input$toggle_avanzado_hpp, {
    inputs_hide = c("hpp_descuento","hpp_costoIntervencion")
    
    
    for (i in inputs_hide) {
      isVisible <- shinyjs::toggleState(id = i)
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
  })
  
  ##### HEP C #####
  
  hepC_run = reactive({
    if (length(input$cohorte) > 0) {
      hepC = hepC_full(
        input,
        output,
        input_pais = str_to_title(input$country),
        input_cohorte = input$cohorte,
        input_AtasaDescuento = input$AtasaDescuento,
        input_F0 = input$F0,
        input_F1 = input$F1,
        input_F2 = input$F2,
        input_F3 = input$F3,
        input_F4 = input$F4,
        input_aCostoF0F2 = input$aCostoF0F2,
        input_aCostoF3 = input$aCostoF3,
        input_aCostoF4 = input$aCostoF4,
        input_aCostoDC = input$aCostoDC,
        input_aCostoHCC = input$aCostoHCC,
        input_pSVR = input$pSVR,
        input_tDuracion_Meses = input$tDuracion_Meses,
        input_pAbandono = input$pAbandono,
        input_Costo_Tratamiento = input$Costo_Tratamiento,
        input_Costo_Evaluacion = input$Costo_Evaluacion
      )
      
      hepC_indicators = names(hepC$Comparacion)
      hepC_values = unlist(hepC$Comparacion)
      
      hepCTable = data.frame(
        hepC_indicators,
        hepC_values
      )
      
      rownames(hepCTable) = NULL
      colnames(hepCTable) = c("Indicador", "Valor")
      hepCTable
    }
    
    
  })
  
  observeEvent(input$toggle_avanzado_hepC, {
    input_names = c(
      "Costos de fibrosis descompensada" = "aCostoDC", 
      "Costos de estadíos de fibrosis F0 a F2" = "aCostoF0F2", 
      "Costos de estadío de fibrosis F3" = "aCostoF3", 
      "Costos de estadío de fibrosis F4" = "aCostoF4", 
      "Costos de carcinoma hepatocelular" = "aCostoHCC", 
      "Tasa de descuento" = "AtasaDescuento", 
      "Tamaño de la cohorte" = "cohorte", 
      "Costo de la evaluación de la respuesta al tratamiento" = "Costo_Evaluacion", 
      "Costo de tratamiento de 4 semanas de Epclusa" = "Costo_Tratamiento", 
      "Probabilidad de encontrarse en estadio de fibrosis F0 al diagnóstico" = "F0", 
      "Probabilidad de encontrarse en estadio de fibrosis F1 al diagnóstico" = "F1", 
      "Probabilidad de encontrarse en estadio de fibrosis F2 al diagnóstico" = "F2", 
      "Probabilidad de encontrarse en estadio de fibrosis F3 al diagnóstico" = "F3", 
      "Probabilidad de encontrarse en estadio de fibrosis F4 al diagnóstico" = "F4", 
      "Proporción de pacientes que abandonan el tratamiento." = "pAbandono", 
      "Eficacia de Sofosbuvir / velpatasvir" = "pSVR", 
      "Duración del tratamiento" = "tDuracion_Meses"
    )
    inputs_hide = input_names[1:14]
    
    
    for (i in inputs_hide) {
      isVisible <- shinyjs::toggleState(id = i)
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
  })
  
  
  
}

shinyApp(ui, server)