server_hpv = function (input, output, session, parameterReactive, scenarios, resultados, run_hearts, hearts_scenarios, hpp_run, hpp_scenarios, hepC_run, hepC_scenarios, summary_scenarios) {
  output$resultados_hpv = renderUI({
    if (input$intervencion == "Vacuna contra el HPV") {
      if (is.null(input$birthCohortSizeFemale)) {NULL} else {paste(resultados())}
      tagList(
        ui_grafico_hpv(resultados(),input),
        ui_tabla_hpv(resultados(),input)
      )  
    } else if (input$intervencion == "HEARTS") {
      tagList(
        ui_resultados_hearts(input, output, run_hearts),
      )
    } else if (input$intervencion == "Hemorragia postparto") {
      tagList(
        ui_resultados_hpp(input, output, hpp_run),
      )
    } else if (input$intervencion == "Hepatitis C") {
      tagList(
        ui_resultados_hepC(input, output, hepC_run),
      )
    }
    
  })
  
  output$prueba = renderUI({
    table = summary_scenarios$table
    
    tagList(
      selectizeInput(
        inputId = "comparacion_country",
        label = "Seleccionar país",
        choices = unique(table$country),
        multiple = T,
        selected = unique(table$country)
      ),
      selectizeInput(
        "comparacion_intervencion",
        "Seleccionar intervención",
        unique(table$intervencion),
        multiple = T
      ),
      selectizeInput(
        "comparacion_escenario",
        "Seleccionar escenario",
        unique(table$scenarioName),
        multiple = T
      ),
      br(),
      br()
      
    )
    
  })
  
  observeEvent(input$comparacion_country, {
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country,]
    updateSelectizeInput(session,"comparacion_intervencion", choices = table$intervencion, selected = table$intervencion)
    updateSelectizeInput(session,"comparacion_escenario", choices = table$scenarioName[table$intervencion %in% input$comparacion_intervencion], selected = table$intervencion)
    
  })
  
  observeEvent(input$comparacion_intervencion, {
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country &
                  table$intervencion %in% input$comparacion_intervencion,]
    updateSelectizeInput(session,"comparacion_escenario", choices = table$scenarioName, selected = table$scenarioName)
  })
  
  # output$filtro_pais_comparacion = renderUI({
  #   tagList(
  #     pickerInput(
  #       "selectCountrySaved",
  #       "Seleccionar país",
  #       choices = c()
  #     )
  #   )
  # })
  # 
  # output$filtro_intervencion = renderUI({
  #   intervenciones_con_escenarios_guardados = c(
  #     length(scenarios$savedScenarios),
  #     length(hearts_scenarios$savedScenarios),
  #     length(hpp_scenarios$savedScenarios),
  #     length(hepC_scenarios$savedScenarios))
  #     
  #   
  #   intervenciones_con_escenarios_guardados = which(intervenciones_con_escenarios_guardados!=0)
  #   
  #   
  #   pickerInput(
  #     inputId = "filtro_intervencion",
  #     label = "Seleccionar intervención:", 
  #     choices = c("Vacuna contra el HPV","HEARTS","Hemorragia postparto","Hepatitis C")[intervenciones_con_escenarios_guardados],
  #     choicesOpt = list(
  #       content = c(
  #         paste(icon("syringe"),"Vacuna contra el HPV"),
  #         paste(icon("heart"),"HEARTS"),
  #         paste(icon("female"),"Hemorragia postparto"),
  #         paste(icon("virus"),"Hepatitis C"))[intervenciones_con_escenarios_guardados]
  #                   
  #       ),
  #     options = pickerOptions(
  #       noneSelectedText = "No hay escenarios guardados"
  #     ),
  #     selected=c("Vacuna contra el HPV","HEARTS","Hemorragia postparto","Hepatitis C")[intervenciones_con_escenarios_guardados],
  #     multiple = T
  #     )
  #     
  # 
  #   
  #  
  # })
  # 
  # 
  # output$select_escenarios_guardados = renderUI({
  #   
  #   if (length(input$filtro_intervencion)==1) {
  #     if (input$filtro_intervencion[1] == "Vacuna contra el HPV") {
  #       tagList(
  #         selectizeInput(
  #           "savedScenarios",
  #           "Seleccionar escenario guardado",
  #           names(scenarios$savedScenarios),
  #           multiple = T,
  #           selected = names(scenarios$savedScenarios)
  #         )
  #       )
  #     } else if (input$filtro_intervencion[1] == "HEARTS") {
  #       tagList(
  #         selectizeInput(
  #           "savedScenarios",
  #           "Seleccionar escenario guardado",
  #           names(hearts_scenarios$savedScenarios),
  #           multiple = T,
  #           selected = names(hearts_scenarios$savedScenarios)
  #         )
  #       )
  #     } else if (input$filtro_intervencion[1] == "Hemorragia postparto") {
  #       tagList(
  #         selectizeInput(
  #           "savedScenarios",
  #           "Seleccionar escenario guardado",
  #           names(hpp_scenarios$savedScenarios),
  #           multiple = T,
  #           selected = names(hpp_scenarios$savedScenarios)
  #         )
  #       )
  #     } else if (input$filtro_intervencion[1] == "Hepatitis C") {
  #       tagList(
  #         selectizeInput(
  #           "savedScenarios",
  #           "Seleccionar escenario guardado",
  #           names(hepC_scenarios$savedScenarios),
  #           multiple = T,
  #           selected = names(hepC_scenarios$savedScenarios)
  #         )
  #       )
  #     }
  #   } else {
  #     
  #     opciones = c(
  #       names(scenarios$savedScenarios),
  #       names(hearts_scenarios$savedScenarios),
  #       names(hpp_scenarios$savedScenarios),
  #       names(hepC_scenarios$savedScenarios)
  #     )
  #     
  #     sub_text = 
  #       c(
  #         rep("Vacuna contra el HPV", length(names(scenarios$savedScenarios))),
  #         rep("HEARTS", length(names(hearts_scenarios$savedScenarios))),
  #         rep("Hemorragia postparto", length(names(hpp_scenarios$savedScenarios))),
  #         rep("Hepatitis C", length(names(hepC_scenarios$savedScenarios)))
  #       )
  #     
  #     tagList(
  #       pickerInput(
  #         inputId = "savedScenariosMultiple",
  #         label = "Seleccionar escenario guardado",
  #         choices = opciones,
  #         choicesOpt = list(
  #           subtext = sub_text,
  #           style = rep("font-weight: bold;", length(opciones))
  #         ),
  #         multiple = T,
  #         selected = opciones
  #       )
  #     )
  #     
  #     
  #     
  #   }
  #   
  #   
  #   
  # })
  # 
  # 
  observeEvent(input$comparacion_intervencion, {
    
    if (length(input$comparacion_intervencion)==1) {
      
      output$escenarios_guardados = renderUI({
        # mira intervención seleccionada
        if (length(input$comparacion_intervencion)>0) {
          
          if (input$comparacion_intervencion[1] == "Vacuna contra el HPV") {
            output$grafico = renderHighchart({
              if (input$comparacion_intervencion[1] == "Vacuna contra el HPV") {
                if (length(scenarios$savedScenarios)>0) {
                  maxY = c()
                  for (i in names(scenarios$savedScenarios)) {
                    maxY=c(maxY,scenarios$savedScenarios[[i]]$dataPlot$y1)
                  }
                  
                  for (i in names(scenarios$savedScenarios)) {
                    maxY=c(maxY,scenarios$savedScenarios[[i]]$dataPlot$y2)
                  }
                  
                  maxY = roundUpNice(max(maxY[is.na(maxY)==F]))
                  
                  
                  plot = highchart()
                  if (!is.null(input$comparacion_escenario)) {
                    if (input$comparacion_escenario[1]!="") {
                      for (i in input$comparacion_escenario) {
                        plot = plot %>% hc_add_series(data = scenarios$savedScenarios[[i]]$dataPlot, name=names(scenarios$savedScenarios[i]), type = "line", hcaes(x = x, y = y2)) %>% hc_xAxis(min = 0, max = 80) %>% hc_yAxis(min = 0, max = maxY)
                      }
                    }
                  }
                  plot %>% hc_title(
                    text = "Efecto de la vacunación en la incidencia del cáncer de cuello de útero por edad",
                    margin = 20,
                    align = "left",
                    style = list(color = "black", useHTML = TRUE)
                  )
                  
                } else {NULL}
                
              }
              
            })
            
            output$summaryTableScenarios <- renderReactable({
              # paste(input$comparacion_intervencion)
              # paste(input$comparacion_escenario)
              if (length(scenarios$savedScenarios)>0 & input$comparacion_intervencion[1]=="Vacuna contra el HPV") {
                if (is.null(input$comparacion_escenario)) {
                  snSelected = colnames(scenarios$summaryTable)
                } else {
                  snSelected = c(colnames(scenarios$summaryTable)[1], input$comparacion_escenario)
                }
                table = scenarios$summaryTable[,snSelected]
                cat_input = c(1,2,3,14)
                cat_epi = c(6,7,8)
                cat_costos = c(4,5,9,10,11,12,13)
                
                table$cat=""
                table$cat[cat_input] = "Inputs"
                table$cat[cat_epi] = "Resultados epidemiológicos"
                table$cat[cat_costos] = "Resultados económicos"
                
                columns = list(
                  cat = colDef(name = "Categoría", align = "left"),
                  Outcomes = colDef(name = "Indicador", align = "left")
                )
                
                for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
                  columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
                }
                reactable(
                  table[table$cat!="Inputs",],
                  groupBy = "cat",
                  defaultExpanded = T,
                  pagination = F,
                  columnGroups = list(
                    colGroup("Escenarios", columns = colnames(table)[setdiff(1:ncol(table),c(1,ncol(table)))], sticky = "left",
                             headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
                  ),
                  defaultColDef = colDef(
                    align = "center",
                    minWidth = 70,
                    headerStyle = list(background = "#236292", color = "white")
                  ),
                  columns = columns,
                  bordered = TRUE,
                  highlight = TRUE
                )
                
                
                
              } else {NULL}
            })
            
            tagList(
              highchartOutput("grafico"),
              br(),
              reactableOutput("summaryTableScenarios")
            )
            
            
          } else if (input$comparacion_intervencion == "HEARTS") {
            output$hearts_table_saved = renderReactable({
              
              if (length(hearts_scenarios$savedScenarios)>0) {
                
                table = data.frame(Indicador=hearts_scenarios$savedScenarios[[1]]$Indicador)
                for (i in names(hearts_scenarios$savedScenarios)) {
                  scn_name = i
                  table[[i]] = hearts_scenarios$savedScenarios[[i]]$Valor
                }
                cat_epi = 1:12
                cat_costos = 13:15
                
                table$cat=""
                table$cat[cat_epi] = "Resultados epidemiológicos"
                table$cat[cat_costos] = "Resultados económicos"
                table[[i]][table$cat=="Resultados económicos"] = paste0("$",table[[2]][table$cat=="Resultados económicos"])
                columns = list(
                  cat = colDef(name = "Categoría", align = "left"),
                  Indicador = colDef(name = "Indicador", align = "left")
                )
                
                for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
                  table[i] = format(table[i], bigmark=",", decimalmark=".") 
                  columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
                }
                
                reactable(
                  table,
                  groupBy = "cat",
                  defaultExpanded = T,
                  pagination = F,
                  columnGroups = list(
                    colGroup("Escenarios", columns = colnames(table)[setdiff(1:ncol(table),c(1,ncol(table)))], sticky = "left",
                             headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
                  ),
                  defaultColDef = colDef(
                    align = "center",
                    minWidth = 70,
                    headerStyle = list(background = "#236292", color = "white")
                  ),
                  columns = columns,
                  bordered = TRUE,
                  highlight = TRUE
                )
                
                
                
              } else {NULL}
              
            })
            
            tagList(
              reactableOutput("hearts_table_saved")
            )
          } else if (input$comparacion_intervencion == "Hemorragia postparto") {
            output$hpp_table_saved = renderReactable({
              if (length(input$comparacion_escenario)>0) {
                enable("hpp_savedScenarios")
                table = data.frame(Indicador=hpp_run()$Indicador)
                
                for (i in input$comparacion_escenario) {
                  scn_name = i
                  table[[i]] = hpp_scenarios$savedScenarios[[i]]$Valor
                }
                
                cat_epi = c(2,4:8)
                cat_costos = c(1,3)
                table$cat=""
                table$cat[cat_epi] = "Resultados epidemiológicos"
                table$cat[cat_costos] = "Resultados económicos"
                table[[i]][table$cat=="Resultados económicos"] = paste0("$",table[[2]][table$cat=="Resultados económicos"])
                
                columns = list(
                  cat = colDef(name = "Categoría", align = "left"),
                  Indicador = colDef(name = "Indicador", align = "left")
                )
                
                for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
                  table[i] = format(table[i], bigmark=",", decimalmark=".") 
                  columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
                }
                reactable(
                  table,
                  groupBy = "cat",
                  defaultExpanded = T,
                  pagination = F,
                  columnGroups = list(
                    colGroup("Escenarios", columns = colnames(table)[setdiff(1:ncol(table),c(1,ncol(table)))], sticky = "left",
                             headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
                  ),
                  defaultColDef = colDef(
                    align = "center",
                    minWidth = 70,
                    headerStyle = list(background = "#236292", color = "white")
                  ),
                  columns = columns,
                  bordered = TRUE,
                  highlight = TRUE
                )
                
                
              } else {NULL}
              
            })
            
            tagList(
              reactableOutput("hpp_table_saved")
            )
            
          } else {
            
            output$hepC_table_saved = renderReactable({
              
              if (length(input$comparacion_escenario)>0) {
                table = data.frame(Indicador=hepC_run()$Indicador)
                
                for (i in input$comparacion_escenario) {
                  scn_name = i
                  table[[i]] = hepC_scenarios$savedScenarios[[i]]$Valor
                }
                
                cat_epi = 1:5
                cat_costos = 6:nrow(table)
                
                table$cat=""
                table$cat[cat_epi] = "Resultados epidemiológicos"
                table$cat[cat_costos] = "Resultados económicos"
                
                columns = list(
                  cat = colDef(name = "Categoría", align = "left"),
                  Indicador = colDef(name = "Indicador", align = "left")
                )
                
                for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
                  table[i] = format(table[i], bigmark=",", decimalmark=".") 
                  columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
                }
                reactable(
                  table,
                  groupBy = "cat",
                  defaultExpanded = T,
                  pagination = F,
                  columnGroups = list(
                    colGroup("Escenarios", columns = colnames(table)[setdiff(1:ncol(table),c(1,ncol(table)))], sticky = "left",
                             headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
                  ),
                  defaultColDef = colDef(
                    align = "center",
                    minWidth = 70,
                    headerStyle = list(background = "#236292", color = "white")
                  ),
                  columns = columns,
                  bordered = TRUE,
                  highlight = TRUE
                )
                
                
              } else {NULL}
              
              
            })
            
            renderUI(
              reactableOutput("hepC_table_saved")
            )
            
          }
          
        } 
      })
      
    } else {
      output$escenarios_guardados = renderUI({
        tagList(
          h1("Acá comparacion de escenarios entre intervenciones")
        )
        
      })
    }
  })
  
  
  #observeEvent(input$go_comp, {
    

  #})
  
}

