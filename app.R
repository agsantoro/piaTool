# ##### APP #####
source("functions/getCards.R", encoding = "UTF-8")
source("functions/getStyle.R", encoding = "UTF-8")
source("UI/start.R", encoding = "UTF-8")
source("UI/UI_avanzada.R", encoding = "UTF-8")
# source("UI/UI_main.R", encoding = "UTF-8")
source("UI/home.R", encoding = "UTF-8")
source("UI/UI_hpv.R", encoding = "UTF-8")
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
  
  # hpv
  scenarios = reactiveValues()
  scenarios$savedScenarios = list()
  
  # hearts 
  hearts_scenarios = reactiveValues()
  hearts_scenarios$savedScenarios = list()
  
  # guarda escenarios
  observeEvent(input$saveScenario2, {
    browser()
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
      
    } else {
      
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
  observeEvent(input$intervencion, {
    if (input$intervencion == "Vacuna contra el HPV") {
      output$uiOutput_basica <- ui_hpv_basica(parametersReactive(),input,inputs_hpv())
    } else if (input$intervencion == "HEARTS") {
      output$uiOutput_basica <- ui_hearts(input, base_line)
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
  
  
  server_hpv(input, output, parametersReactive(), scenarios, resultados,run_hearts, hearts_scenarios)
  onclick("ver_escenarios_guardados", {
    server_hpv(input, output, parametersReactive(), scenarios, resultados,run_hearts, hearts_scenarios)})
   
}

shinyApp(ui, server)
