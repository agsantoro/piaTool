# ##### APP #####
source("functions/getCards.R", encoding = "UTF-8")
source("functions/getStyle.R", encoding = "UTF-8")
source("UI/start.R", encoding = "UTF-8")
source("UI/UI_avanzada.R", encoding = "UTF-8")
# source("UI/UI_main.R", encoding = "UTF-8")
source("UI/home.R", encoding = "UTF-8")
source("UI/UI_hpv.R", encoding = "UTF-8")
# source("UI/UI_routes.R", encoding = "UTF-8")

ui <- fluidPage(
  router_ui(
    route("/", ui_home),
    route("avanzada", ui_avanzada)
  )
)

server <- function(input, output, session) {
  
  # implementa router
  router_server()
  
  # muestra div para guardar escenario
  observeEvent(input$saveScenario, {
    show("guardar_hpv", anim = T, animType = "slide")
    show("scenarioName", anim = T, animType = "slide")
    show("saveScenario2", anim = T, animType = "slide")
  })

  
  # crea lista para almacenar escenarios guardados
  scenarios = reactiveValues()
  scenarios$savedScenarios = list()
  
  # guarda escenarios
  observeEvent(input$saveScenario2, {
    if (input$scenarioName !="") {
      scnID = UUIDgenerate()
      scnName = input$scenarioName
      scenarios$savedScenarios[[scnName]] <- resultados()
      summaryScenarios = data.frame(outcomes=scenarios$savedScenarios[[1]]$outcomes[[1]])
      
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
    
  })
  
  observeEvent(input$toggle_avanzado_hpv, {
    for (i in names(parametersReactive())[4:15]) {
      isVisible <- shinyjs::toggleState(id = i)
      
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
    
  })
  
  ##### HPV #####
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
  
  
  observeEvent(input$intervencion, {
    
    if (input$intervencion == "Vacuna contra el HPV") {
      output$uiOutput_basica <- ui_hpv_basica(parametersReactive(),input,inputs_hpv())
    } else {
      output$uiOutput_basica = renderUI({
        tagList(h1("Hola"))
      })
    }
  })
  
  observeEvent(input$ver_avanzados_hpv, {
    if (input$ver_avanzados_hpv==F) {
      updatePrettySwitch(session, "ver_avanzados_hpv", label = "Ver configuración avanzada")
      for (i in names(parametersReactive())[4:15]) {
        hide(i, anim = T, animType = "fade")
      }  
    } else {
      updatePrettySwitch(session, "ver_avanzados_hpv", label = "Ocultar configuración avanzada")
      for (i in names(parametersReactive())[4:15]) {
        show(i, anim = T, animType = "slide")
        
      }
    }
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
  
  output$resultados_hpv = renderUI({
    if (input$intervencion == "Vacuna contra el HPV") {
      if (is.null(input$birthCohortSizeFemale)) {NULL} else {paste(resultados())}
      tagList(
        ui_grafico_hpv(resultados(),input),
        ui_tabla_hpv(resultados(),input)
      )  
    }
    
  })
  
}

shinyApp(ui, server)
