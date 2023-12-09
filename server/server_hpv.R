server_hpv = function (input, output, session, parameterReactive, scenarios, resultados, run_hearts, hearts_scenarios, hpp_run, hpp_scenarios, hepC_run, hepC_scenarios, summary_scenarios, inputs_scenarios) {
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
    updateSelectizeInput(session,"comparacion_escenario", choices = table$scenarioName[table$intervencion %in% input$comparacion_intervencion], selected = table$scenarioName[table$intervencion %in% input$comparacion_intervencion])
    
  })
  
  observeEvent(input$comparacion_intervencion, {
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country &
                  table$intervencion %in% input$comparacion_intervencion,]
    updateSelectizeInput(session,"comparacion_escenario", choices = table$scenarioName, selected = table$scenarioName)
  })
  
  
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
                      scenarios_hpv = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion == "Vacuna contra el HPV"]
                      scenarios_hpv = scenarios_hpv[scenarios_hpv %in% input$comparacion_escenario]
                      
                      for (i in scenarios_hpv) {
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
              if (length(scenarios$savedScenarios)>0 & input$comparacion_intervencion[1]=="Vacuna contra el HPV" & length(input$comparacion_intervencion)==1) {
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
                for (i in summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion == input$comparacion_intervencion &
                                                               summary_scenarios$table$country %in% input$comparacion_country &
                                                               summary_scenarios$table$scenarioName %in% input$comparacion_escenario]) {
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
      
      output$inputs_summary_table = renderUI({
        
        output$tabla_inputs = renderDataTable({
          if (is.null(input$comparacion_escenario)==F) {
            table_inputs = inputs_scenarios$table
            table_inputs = table_inputs[table_inputs$country %in% input$comparacion_country &
                                          table_inputs$intervencion == input$comparacion_intervencion &
                                          table_inputs$scenarioName %in% input$comparacion_escenario,]
            
            
            if (input$comparacion_intervencion == "Vacuna contra el HPV") {
              load("hpv_map_inputs.RData")
              labels_inputs = hpv_map_inputs
            }
            
            table_inputs = labels_inputs %>% left_join(table_inputs, by = c("i_labels" = "inputName"))
            
            table_inputs$scenarioName = paste0(table_inputs$scenarioName, " (",table_inputs$country,")")
            
            table_data = data.frame(
              Input = unique(table_inputs$i_names)
            )
            
            for (i in unique(table_inputs$scenarioName)) {
              table_data[[i]] = table_inputs$inputValue[table_inputs$scenarioName==i]
            }
            datatable(table_data)
            }
        })
        
          
          browser()
          
          tagList(
            br(),
            br(),
            dataTableOutput("tabla_inputs")
          )  
        
        
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

