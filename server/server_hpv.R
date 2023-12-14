server_hpv = function (input, output, session, parameterReactive, scenarios, resultados, run_hearts, hearts_scenarios, hpp_run, hpp_scenarios, hepC_run, hepC_scenarios, summary_scenarios, inputs_table, inputs_columns, tbc_run) {
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
    } else if (input$intervencion == "VDOT Tuberculosis") {
      tagList(
        ui_resultados_tbc(input, output, tbc_run),
      )
    }
    
  })
  
  output$panel_comparacion = renderUI({
    table = summary_scenarios$table
    
    tagList(
      # column(3,
      #   pickerInput(
      #     inputId = "comparacion_country",
      #     label = "Seleccionar país",
      #     choices = unique(table$country),
      #     multiple = F,
      #     selected = unique(table$country)
      #   )
      column(2,
      awesomeCheckboxGroup(
        inputId = "comparacion_country",
        label = "Seleccionar país", 
        choices = unique(table$country),
        selected = unique(table$country)),
      br(),
      actionButton("go_country",
                   icon("arrow-right")),
      br(),
      br(),
      br()),
      column(2,
             hidden(
               awesomeCheckboxGroup(
                 "comparacion_intervencion",
                 "Seleccionar intervención",
                 unique(table$intervencion),
               )),
               br(),
               hidden(
                 actionButton("go_intervencion",
                              icon("arrow-right"))  
               ),
               br(),
               br(),
               br()
             
             
      ),
      column(3,
             hidden(
               pickerInput(
                 "comparacion_escenario",
                 "Seleccionar escenario",
                 unique(table$scenarioName),
                 multiple = T
               ) 
             ),
             hidden(
               actionButton("go_comp",
                            "Ver comparación"))
             
      )
             
  )
    
  })
  
  observeEvent(input$restart, {
    table = summary_scenarios$table
    updateAwesomeCheckboxGroup(session,"comparacion_country", choices = unique(table$country), selected = unique(table$country))
    updateAwesomeCheckboxGroup(session,"comparacion_intervencion", choices = unique(table$intervencion), selected = unique(table$intervencion))
    updateAwesomeCheckboxGroup(session,"comparacion_escenario", choices = unique(table$escenario), selected = unique(table$escenario))
    enable("comparacion_country")
    enable("go_country")
    enable("comparacion_intervencion")
    enable("go_intervencion")
    hide("comparacion_intervencion", anim = T, animType = "fade")
    hide("go_intervencion", anim = T, animType = "fade")
    hide("comparacion_escenario", anim = T, animType = "fade")
    hide("go_comp", anim = T, animType = "fade")
    hide("descargar_comp", anim = T, animType = "fade")
    hide("escenarios_guardados", anim = T, animType = "fade")
    hide("tabla_inputs", anim = T, animType = "fade")
    hide("header_comparacion_resultados", anim = T, animType = "fade")
    hide("header_tabla_inputs", anim = T, animType = "fade")
    hide(500,show("inputs_summary_table", anim = T, animType = "fade"))
  })
  
  observeEvent(input$go_country,{
    if (length(input$comparacion_country)==0) {
      shinyalert("Advertencia", "Debe seleccionar al menos un país", type = "error")
    } else {
      show("comparacion_intervencion")
      show("go_intervencion")
      disable("comparacion_country")
      disable("go_country")
    }
    
  })
  
  observeEvent(input$go_intervencion, {
    if (length(input$comparacion_intervencion)==0) {
      shinyalert("Advertencia", "Debe seleccionar al menos una intervención", type = "error")
    } else {
      show("comparacion_escenario")
      show("go_comp")
      disable("comparacion_intervencion")
      disable("go_intervencion")
      
    }
    
  })
  
  observeEvent(input$comparacion_country, {
    hide("columna_resultados_borde")
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country,]
    updateAwesomeCheckboxGroup(session,"comparacion_intervencion", choices = unique(table$intervencion), selected = unique(table$intervencion))
    updatePickerInput(session,"comparacion_escenario", choices = table$scenarioName[table$intervencion %in% input$comparacion_intervencion], selected = table$scenarioName[table$intervencion %in% input$comparacion_intervencion])
    
  })
  
  observeEvent(input$go_country, {
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country,]
    updateAwesomeCheckboxGroup(session,"comparacion_intervencion", choices = unique(table$intervencion), selected = unique(table$intervencion))
  })
  
  observeEvent(input$go_intervencion, {
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country &
                  table$intervencion %in% input$comparacion_intervencion,]
    
    opciones = table$scenarioName
    content = paste0(table$intervencion," - ",table$country)
    
    updatePickerInput(session,"comparacion_escenario", choices = opciones, selected = opciones, choicesOpt = list(subtext = content))
    
  })
  
  observeEvent(input$comparacion_intervencion, {
    table = summary_scenarios$table
    table = table[table$country %in% input$comparacion_country &
                  table$intervencion %in% input$comparacion_intervencion,]
    updatePickerInput(session,"comparacion_escenario", choices = table$scenarioName, selected = table$scenarioName)
  })
  
  
  observeEvent(input$go_comp, {
    show(500,show("inputs_summary_table", anim = T, animType = "fade"))
    show("escenarios_guardados")
    show("tabla_inputs")
    show("restart")
    show("header_tabla_inputs")
    hide("go_comp")
    hide("comparacion_escenario")
    
    
    if (length(input$comparacion_escenario)==0) {
      shinyalert("Advertencia", "Debe seleccionar al menos una intervención", type = "error")
      hide("header_comparacion_resultados")
      hide("columna_resultados_borde")
    } else {
      show("header_comparacion_resultados")
      show("columna_resultados_borde")
      disable("go_intervencion")
      show("descarga_comp")
      
      
      
      
      
      seleccion = summary_scenarios$table
      seleccion = seleccion[seleccion$country %in% input$comparacion_country &
                            seleccion$intervencion %in% input$comparacion_intervencion &
                            seleccion$scenarioName %in% input$comparacion_escenario,]
      
      sel_intervencion = unique(seleccion$intervencion)
      sel_country = input$comparacion_country
      sel_escenario = input$comparacion_escenario
      
      if (length(sel_intervencion)==1) {
        
        output$escenarios_guardados = renderUI({
          # mira intervención seleccionada
          if (length(sel_intervencion)>0) {
            
            if (sel_intervencion[1] == "Vacuna contra el HPV") {
              output$grafico = renderHighchart({
                if (sel_intervencion[1] == "Vacuna contra el HPV") {
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
                    if (!is.null(sel_escenario)) {
                      if (sel_escenario[1]!="") {
                        scenarios_hpv = summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion == "Vacuna contra el HPV"]
                        scenarios_hpv = scenarios_hpv[scenarios_hpv %in% sel_escenario]
                        
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
                # paste(sel_intervencion)
                # paste(sel_escenario)
                if (length(scenarios$savedScenarios)>0 & sel_intervencion[1]=="Vacuna contra el HPV" & length(sel_intervencion)==1) {
                  if (is.null(sel_escenario)) {
                    snSelected = colnames(scenarios$summaryTable)
                  } else {
                    snSelected = c(colnames(scenarios$summaryTable)[1], sel_escenario)
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
              
              
            } else if (sel_intervencion == "HEARTS") {
              output$hearts_table_saved = renderReactable({
                if (length(hearts_scenarios$savedScenarios)>0) {
                  
                  table = data.frame(Indicador=hearts_scenarios$savedScenarios[[1]]$Indicador)
                  for (i in summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion == sel_intervencion &
                                                                 summary_scenarios$table$country %in% sel_country &
                                                                 summary_scenarios$table$scenarioName %in% sel_escenario]) {
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
            } else if (sel_intervencion == "Hemorragia postparto") {
              output$hpp_table_saved = renderReactable({
                if (length(sel_escenario)>0) {
                  enable("hpp_savedScenarios")
                  table = data.frame(Indicador=hpp_run()$Indicador)
                  
                  for (i in sel_escenario) {
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
              
            } else if (sel_intervencion == "Hepatitis C") {
              
              output$hepC_table_saved = renderReactable({
                
                if (length(sel_escenario)>0) {
                  table = data.frame(Indicador=hepC_run()$Indicador)
                  
                  for (i in sel_escenario) {
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
              
            } else {
              
              output$tbc_table_saved = renderReactable({
                
                
              })
              
              renderUI(
                h1("Aca compara tbc")
              )
            }
            
          } 
        })
        
        output$inputs_summary_table = renderUI({
          
          output$tabla_inputs = renderReactable({
            if (is.null(sel_escenario)==F) {
              
              table_data = inputs_table
              columnas = inputs_columns
              
              reactable(
                table_data,
                groupBy = "Categoría",
                defaultExpanded = T,
                pagination = F,
                columnGroups = list(
                  colGroup("Escenarios", columns = colnames(table_data)[setdiff(1:ncol(table_data),c(1,ncol(table_data)))], sticky = "left",
                           headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
                ),
                defaultColDef = colDef(
                  minWidth = 70,
                  headerStyle = list(background = "#236292", color = "white")
                ),
                columns = columnas,
                bordered = TRUE,
                highlight = TRUE
              )
            }
          })
          
          
          
          tagList(
            br(),
            br(),
            hr(),
            br(),
            
              tags$header(id = "header_tabla_inputs", class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                          tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Descripción de escenarios guardados")),
                          actionLink(inputId = "toggle_tabla_inputs", label=icon("stream", style = "color: white;"))
              )
            ,
            br(),
            hidden(reactableOutput("tabla_inputs"))
          )  
          
          
        })  
        
      } else {
        output$escenarios_guardados = renderUI({
          tagList(
            h1("Acá comparacion de escenarios entre intervenciones")
          )
          
        })
      }
      
      
    }
    
    
    
    
   
    
  })
  
  
  #observeEvent(input$go_comp, {
    

  #})
  
}

