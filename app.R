# ##### APP #####
source("functions/getCards.R", encoding = "UTF-8")
source("functions/getStyle.R", encoding = "UTF-8")
source("functions/inputs_table_generator.R", encoding = "UTF-8")
source("UI/start.R", encoding = "UTF-8")
source("UI/UI_avanzada.R", encoding = "UTF-8")
# source("UI/UI_main.R", encoding = "UTF-8")
source("UI/home.R", encoding = "UTF-8")
source("UI/UI_hpv.R", encoding = "UTF-8")
source("UI/UI_hpp.R", encoding = "UTF-8")
source("UI/UI_hepC.R", encoding = "UTF-8")
source("UI/UI_hearts.R", encoding = "UTF-8")
source("UI/UI_tbc.R", encoding = "UTF-8")
source("UI/UI_prep.R", encoding = "UTF-8")
source("UI/UI_escenarios.R", encoding = "UTF-8")
source("UI/UI_routes.R", encoding = "UTF-8")
source("server/server_hpv.R", encoding = "UTF-8")

server <- function(input, output, session) {
  #hide("row_comparacion")
  hide("columna_borde")
  hide("columna_resultados_borde")
  
  output$descarga_comp <- downloadHandler(
    filename = function() {
      paste('piaTool-', Sys.Date(), '.xlsx', sep='')
    },
    content = function(file) {
      list_of_datasets = list()
      
      if (length(input$comparacion_intervencion)== 1) {
        
        if (length(input$comparacion_intervencion)== 1 & input$comparacion_intervencion[1] == "Vacuna contra el HPV") {
          for (i in input$comparacion_escenario) {
            pais = summary_scenarios$table$country[summary_scenarios$table$scenarioName==i]
            list_of_datasets[[paste0(i," (",pais,") ")]] = scenarios$savedScenarios[[i]]$outcomes
          }
        } else if (length(input$comparacion_intervencion)== 1 & input$comparacion_intervencion[1] == "HEARTS") {
          for (i in input$comparacion_escenario) {
            pais = summary_scenarios$table$country[summary_scenarios$table$scenarioName==i]
            list_of_datasets[[paste0(i," (",pais,") ")]] = hearts_scenarios$savedScenarios[[i]]
          }
        } else if (length(input$comparacion_intervencion)== 1 & input$comparacion_intervencion[1] == "Hemorragia postparto") {
          for (i in input$comparacion_escenario) {
            pais = summary_scenarios$table$country[summary_scenarios$table$scenarioName==i]
            list_of_datasets[[paste0(i," (",pais,") ")]] = hpp_scenarios$savedScenarios[[i]]
          }
        } else if (length(input$comparacion_intervencion)== 1 & input$comparacion_intervencion[1] == "Hepatitis C") {
          for (i in input$comparacion_escenario) {
            pais = summary_scenarios$table$country[summary_scenarios$table$scenarioName==i]
            list_of_datasets[[paste0(i," (",pais,") ")]] = hepC_scenarios$savedScenarios[[i]]
          }
        } else if (length(input$comparacion_intervencion)== 1 & input$comparacion_intervencion[1] == "VDOT Tuberculosis") {
          for (i in input$comparacion_escenario) {
            pais = summary_scenarios$table$country[summary_scenarios$table$scenarioName==i]
            list_of_datasets[[paste0(i," (",pais,") ")]] = tbc_scenarios$savedScenarios[[i]]
          }
        }
          else if (length(input$comparacion_intervencion)== 1 & input$comparacion_intervencion[1] == "Profilaxis Pre Exposición VIH") {
            for (i in input$comparacion_escenario) {
              pais = summary_scenarios$table$country[summary_scenarios$table$scenarioName==i]
              list_of_datasets[[paste0(i," (",pais,") ")]] = prep_scenarios$savedScenarios[[i]]
            }
        }
        
        list_of_datasets[["Inputs"]] = inputs_table_generator(
          input,
          output,
          inputs_scenarios,
          summary_scenarios
        )[[1]]
        
        data = list_of_datasets
        
        write.xlsx(data, file)
        
      } else {
        list_of_datasets = list()
        esc_hpv = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Vacuna contra el HPV"]
        esc_hearts = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="HEARTS"]
        esc_hpp = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Hemorragia postparto"]
        esc_hepC = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Hepatitis C"]
        esc_tbc = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="VDOT Tuberculosis"]
        esc_prep = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Profilaxis Pre Exposición VIH"]
        
        if ("Vacuna contra el HPV" %in% input$comparacion_intervencion) {
          for (i in esc_hpv) {
            list_of_datasets[[i]] = scenarios$savedScenarios[[i]]$outcomes
          }
        }
        if ("HEARTS" %in% input$comparacion_intervencion) {
          for (i in esc_hearts) {
            list_of_datasets[[i]] = hearts_scenarios$savedScenarios[[i]]
          }
        } 
        if ("Hemorragia postparto" %in% input$comparacion_intervencion) {
          for (i in esc_hpp) {
            list_of_datasets[[i]] = hpp_scenarios$savedScenarios[[i]]
          }
        } 
        if ("Hepatitis C" %in% input$comparacion_intervencion) {
          for (i in esc_hepC) {
            list_of_datasets[[i]] = hepC_scenarios$savedScenarios[[i]]
          }
        } 
        if ("VDOT Tuberculosis" %in% input$comparacion_intervencion) {
          for (i in esc_tbc) {
            list_of_datasets[[i]] = tbc_scenarios$savedScenarios[[i]]
          }
        }
        if ("Profilaxis Pre Exposición VIH" %in% input$comparacion_intervencion) {
          for (i in esc_prep) {
            list_of_datasets[[i]] = prep_scenarios$savedScenarios[[i]]
          }
        }
        
      
      
      tabla = inputs_table_generator_multiple(input,output, inputs_scenarios, summary_scenarios)
      
      intervenciones = names(tabla)
      tabla = lapply(intervenciones, function (i) {
        tabla[[i]] =
          lapply(tabla[[i]], function (j) {
            j = pivot_longer(
              j,
              names_to = "escenario",
              values_to = "valor",
              cols = 2
            )
          })
      })
      
      names(tabla) = intervenciones
      
      tabla = lapply(intervenciones, function (i) {
        tabla[[i]] = cbind(int=i,bind_rows(tabla[[i]]))  
      })
      
      
      tabla = bind_rows(tabla)
      
      list_of_inputs = list()
      
      
      for (i in unique(tabla$int)) {
        for (j in unique(tabla$escenario)) {
          if (nrow(tabla[tabla$int==i & tabla$escenario==j,])>0) {
            list_of_inputs[[paste(j,"Inputs")]] = tabla[tabla$int==i & tabla$escenario==j,]
          }
        }
      }
      
      
      
      # nombres_tabla = c()
      # 
      # 
      # nombres_tabla = lapply(seq_along(tabla), function(i) {
      #   nombres_tabla = c(nombres_tabla,paste0(tabla[[i]]$escenario[1],"_Inputs"))
      # })
      
      list_of_datasets = c(list_of_datasets, list_of_inputs)
      
      list_of_datasets = list_of_datasets[order(names(list_of_datasets))]
      
      data = list_of_datasets
      names(data) = substring(names(data),1,28)
      write.xlsx(data, file)
      }
    }
  )

  
  observeEvent(input$intervencion, {
    hide("saveScenario2")
    hide("scenarioName")
  })
  
  observeEvent(input$country, {
    if (length(input$country)>0) {
      show("columna_borde")
      show("header1", anim = T, animType = "fade")
      show("header2", anim = T, animType = "fade")
      show("saveScenarioDiv", anim = T, animType = "fade")
      delay(500,show("uiOutput_basica", anim = T, animType = "fade"))
      delay(500,show("resultados_hpv", anim = T, animType = "fade"))
      delay(500,show("saveScenario", anim = T, animType = "fade"))
      #delay(500,show("header_comparacion", anim = T, animType = "fade"))
    }
  })
  
  observeEvent(input$NVP, {
    if (nrow(summary_scenarios$table)!=0) {hide("no_esc")}
    if (input$NVP == "<div class = \"text-white\")>Escenarios guardados</div>") {
      if (nrow(summary_scenarios$table)>0) {
        show("row_comparacion", anim = T, animType = "fade")
        show("panel_comparacion", anim = T, animType = "fade")
        hide("columna_resultados_borde", anim = T, animType = "fade")
        hide("inputs_summary_table", anim = T, animType = "fade")
        shinyjs::click("restart")
        
        #show("columna_resultados_borde")
      }
      delay(500,show("filtro_intervencion", anim = T, animType = "fade"))
      delay(500,show("select_escenarios_guardados", anim = T, animType = "fade"))
      #delay(500,show("escenarios_guardados", anim = T, animType = "fade"))
      
      
      delay(500,show("header_comparacion", anim = T, animType = "fade"))
    } 
  })
  
  # implementa router
  router_server()
  
  # muestra div para guardar escenario
  observeEvent(input$saveScenario, {
    show("guardar_hpv", anim = T, animType = "slide")
    show("scenarioName", anim = T, animType = "slide")
    show("saveScenario2", anim = T, animType = "slide")
    #hide("saveScenario", anim = T, animType = "slide")
  })
  
  
  # crea listas para almacenar escenarios guardados
  
  # lista general
  summary_scenarios = reactiveValues()
  summary_scenarios$table = data.frame(
    country = as.character(),
    intervencion = as.character(),
    scenarioName = as.character()
  )
  
  # inputs escenarios
  inputs_scenarios = reactiveValues()
  inputs_scenarios$table = data.frame(
    country = as.character(),
    intervencion = as.character(),
    scenarioName = as.character(),
    inputName = as.character(),
    inputValue = as.numeric()
  )
  
  
  # prep
  prep_scenarios = reactiveValues()
  prep_scenarios$savedScenarios = list()
  
  
  # tbc
  tbc_scenarios = reactiveValues()
  tbc_scenarios$savedScenarios = list()
  
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
    if (input$scenarioName %in% summary_scenarios$table$scenarioName == F) {
      inputs_scenarios$table = rbind(
        inputs_scenarios$table,
        data.frame(
          country=str_to_title(input$country),
          intervencion=input$intervencion,
          scenarioName=input$scenarioName,
          inputName = names(unlist(reactiveValuesToList(input))),
          inputValue = unlist(reactiveValuesToList(input))
        )
      )
      
      summary_scenarios$table = rbind(
        summary_scenarios$table,
        data.frame(
          country=str_to_title(input$country),
          intervencion=input$intervencion,
          scenarioName=input$scenarioName
        )
      )
      
      rownames(inputs_scenarios$table) = 1:nrow(inputs_scenarios$table)
      
      
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
      } else if (input$intervencion == "Hepatitis C") {
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
        
        
        
      } else if (input$intervencion == "VDOT Tuberculosis") {
        if (input$scenarioName !="") {
          
          scnID = UUIDgenerate()
          scnName = input$scenarioName
          
          table = tbc_run()
          
          tbc_scenarios$savedScenarios[[scnName]] <- table
          
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
        
        
        
      } else if (input$intervencion == "Profilaxis Pre Exposición VIH") {
        if (input$scenarioName !="") {
          scnID = UUIDgenerate()
          scnName = input$scenarioName
          
          table = prep_run()
          table$Parametro = prep_outcomes_labels()
          
          prep_scenarios$savedScenarios[[scnName]] <- table
          
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
      
      
    } else {
      sendSweetAlert(
        session = session,
        title = "Error",
        text = "Ya existe un escenario con ese nombre.",
        type = "error"
      )
    }
    
  })
  
  observeEvent(input$toggle_avanzado_hpv, {
    for (i in names(parametersReactive())[4:16]) {
      isVisible <- shinyjs::toggleState(id = i)
      
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
    
  })
  
  observeEvent(input$toggle_tabla_inputs, {
    
    isVisible <- shinyjs::toggleState(id = "tabla_inputs")
      
    toggle(id = "tabla_inputs", anim = TRUE, animType = "slide", condition = isVisible)
    enable("tabla_inputs")
    
    
  })
  
  observeEvent(input$toggle_tabla_inputs_multiple, {
    isVisible <- shinyjs::toggleState(id = "prueba")
    
    toggle(id = "prueba", anim = TRUE, animType = "slide", condition = isVisible)
    enable("prueba")
    
    
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
                      } else if (input$intervencion == "VDOT Tuberculosis") {
                        output$uiOutput_basica <- ui_tbc(input)
                      } else if (input$intervencion == "Profilaxis Pre Exposición VIH") {
                        output$uiOutput_basica <- ui_prep(input)
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
      GDPPerCapita = as.numeric(parameters[parameters$Country==input$country,20]),
      coverageTarget = as.numeric(parameters[parameters$Country==input$country,23])
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
      input$coverageTarget,
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
  
  
  ##### TBC #####
  
  tbc_run <- reactive({
    params = get_tbc_params()
    
    if (length(input$VOTrrExito)!=0) {
      table = modelo_tbc(input$pExitoso,
                         input$pMuerte,
                         input$pFalla,
                         input$DOTrrMuerte,
                         input$DOTrrFalla,
                         input$DOTadherencia,
                         input$DOTrrExito,
                         input$VOTrrExito,
                         input$VOTadherencia,
                         input$VOTrrFalla,
                         input$VOTrrMuerte,
                         input$country,
                         input$cantidad_vot_semana,
                         input$cantidad_dot_semana,
                         datos_paises,
                         asunciones)
      table
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
  
  observeEvent(input$saveScenario, {
    
    show("scenarioName")
    show("saveScenario")
    
  })
  
  
  server_hpv(input, 
             output, 
             session,
             parametersReactive(), 
             scenarios, 
             resultados,
             run_hearts, 
             hearts_scenarios, 
             hpp_run, 
             hpp_scenarios, 
             hepC_run,
             hepC_scenarios,
             summary_scenarios,
             inputs_scenarios,
             inputs_table = inputs_table_generator(input,output, inputs_scenarios, summary_scenarios)[[1]],
             inputs_columns = inputs_table_generator(input,output, inputs_scenarios, summary_scenarios)[[2]],
             inputs_table_multiple = inputs_table_generator_multiple(input,output, inputs_scenarios, summary_scenarios),
             tbc_run,
             tbc_scenarios,
             prep_run,
             prep_scenarios)
  
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
                      "Años de vida por discapacidad salvados",
                      "Inversión",
                      "ROI",
                      "Costo cada mil",
                      "Qalys cada mil"),
        Valor = c(resultados$base$"Costo_HPP",
                  resultados$base$"Dalys_Total",
                  resultados[["comparacion"]][["Diferencia de costo"]],
                  resultados[["comparacion"]][["Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Muertes por Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Histerectomias por Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Años de vida por muerte prematura salvados"]],
                  resultados[["comparacion"]][["Años de vida por discapacidad salvados"]],
                  resultados[["comparacion"]][["Inversion"]],
                  resultados[["comparacion"]][["ROI"]],
                  resultados[["comparacion"]][["Costo cada mil"]],
                  resultados[["comparacion"]][["Qalys cada mil"]]
                  
                  )
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
  
  observeEvent(input$toggle_avanzado_tbc, {
    inputs_hide = names(get_tbc_params())[4:13]
    
    
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
  
  
  ##### prep #####
  
  prep_run = reactive({
    
    corrida = list(
      input$cohorteSize,
      input$descuento,
      input$edadMinima,
      input$edadFinal,
      input$duracionPrEP,
      input$edadMaximaInicial,
      input$PrEPuptake,
      input$edadFinPrEP,
      input$limiteEdadRiesgo,
      input$eficaciaPrEP,
      input$adherenciaPrEP,
      input$limiteEdadContagiosos,
      input$cohorteSize_nuevo,
      input$tasaDescuento_nuevo,
      input$edadMinima_nuevo,
      input$edadFinal_nuevo,
      input$duracionPrEP_nuevo,
      input$edadMaximaInicial_nuevo,
      input$PrEPuptake_nuevo,
      input$edadFinPrEP_nuevo,
      input$limiteEdadRiesgo_nuevo,
      input$eficaciaPrEP_nuevo,
      input$adherenciaPrEP_nuevo,
      input$limiteEdadContagiosos_nuevo
    )
    
    names(corrida) = names(get_prep_params())
  
    if (length(input$edadMinima)>0) {
      resultados = funcionCalculos(corrida,
                                   toupper(input$country))
      resultados
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
  
  observeEvent(input$toggle_avanzado_prep, {

    inputs_hide = names(get_prep_params())[!c(1:24) %in% c(3,5:7,15,17:19,23)]
    
    
    for (i in inputs_hide) {
      isVisible <- shinyjs::toggleState(id = i)
      toggle(id = i, anim = TRUE, animType = "slide", condition = isVisible)
      enable(i)
    }
  })
  
}

shinyApp(ui, server)
