server_hpv = function (input, output, session, parameterReactive, scenarios, resultados, run_hearts, hearts_scenarios, hpp_run, hpp_scenarios, hepC_run, hepC_scenarios, summary_scenarios, inputs_scenarios, inputs_table, inputs_columns, inputs_table_multiple, tbc_run, tbc_scenarios,prep_run,prep_scenarios) {
  output$resultados_hpv = renderUI({
    if (input$intervencion == "Vacuna contra el HPV") {
      if (is.null(input$birthCohortSizeFemale)) {NULL} else {paste(resultados())}
      tagList(
        fluidRow(class="shadow-xl ring-1 ring-gray-900/5 my-6 py-8",
          column(12,
                 ui_grafico_nuevo_hpv(resultados(),input, output)
                 )
        ),
        br(),
        # fluidRow(
        #   column(12,
        #          ui_grafico_hpv(resultados(),input)
        #   )
        # ),
        fluidRow(class="shadow-xl ring-1 ring-gray-900/5 my-6 py-8",
          column(
            12,
            ui_tabla_hpv(resultados(),input)
          )
        )
        
        
        
        
        
      )  
    } else if (input$intervencion == "HEARTS") {
      tagList(
        ui_resultados_hearts(input, output, run_hearts)
        )
      
    } else if (input$intervencion == "Hemorragia postparto") {
      tagList(
        ui_resultados_hpp(input, output, hpp_run),
      )
    } else if (input$intervencion == "Hepatitis C") {
      tagList(
        fluidRow(class="shadow-xl ring-1 ring-gray-900/5 my-6 py-8",
          column(12,
                 ui_grafico_nuevo_hepC(input, output, hepC_run))
        ),
        fluidRow(class="shadow-xl ring-1 ring-gray-900/5 my-6 py-8",
          column(12,
                 ui_resultados_hepC(input, output, hepC_run))
        )
        
      )
    } else if (input$intervencion == "VDOT Tuberculosis") {
      tagList(
        ui_resultados_tbc(input, output, tbc_run),
      )
    } else if (input$intervencion == "Profilaxis Pre Exposición VIH") {
      tagList(
        fluidRow(class="shadow-xl ring-1 ring-gray-900/5 my-6 py-8",
          column(12,
                ui_grafico_nuevo_prep(input, output, prep_run))
          ),
        fluidRow(class="shadow-xl ring-1 ring-gray-900/5 my-6 py-8",
          column(12,
                 ui_resultados_prep(input, output, prep_run))
          )
          
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
    shinyjs::hide("comparacion_intervencion", anim = T, animType = "fade")
    shinyjs::hide("go_intervencion", anim = T, animType = "fade")
    shinyjs::hide("comparacion_escenario", anim = T, animType = "fade")
    shinyjs::hide("go_comp", anim = T, animType = "fade")
    shinyjs::hide("descargar_comp", anim = T, animType = "fade")
    shinyjs::hide("escenarios_guardados", anim = T, animType = "fade")
    shinyjs::hide("tabla_inputs", anim = T, animType = "fade")
    shinyjs::hide("tabla_inputs_multiple", anim = T, animType = "fade")
    shinyjs::hide("header_comparacion_resultados", anim = T, animType = "fade")
    shinyjs::hide("header_tabla_inputs", anim = T, animType = "fade")
    shinyjs::hide("header_tabla_inputs_multiple", anim = T, animType = "fade")
    shinyjs::hide(500,shinyjs::show("inputs_summary_table", anim = T, animType = "fade"))
  })
  
  observeEvent(input$go_country,{
    if (length(input$comparacion_country)==0) {
      shinyalert("Advertencia", "Debe seleccionar al menos un país", type = "error")
    } else {
      shinyjs::show("comparacion_intervencion")
      shinyjs::show("go_intervencion")
      shinyjs::disable("comparacion_country")
      shinyjs::disable("go_country")
    }
    
  })
  
  observeEvent(input$go_intervencion, {
    if (length(input$comparacion_intervencion)==0) {
      shinyalert("Advertencia", "Debe seleccionar al menos una intervención", type = "error")
    } else {
      shinyjs::show("comparacion_escenario")
      shinyjs::show("go_comp")
      shinyjs::disable("comparacion_intervencion")
      shinyjs::disable("go_intervencion")
      
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
    shinyjs::show(500,shinyjs::show("inputs_summary_table", anim = T, animType = "fade"))
    shinyjs::show("escenarios_guardados")
    shinyjs::show("tabla_inputs")
    shinyjs::show("tabla_inputs_multiple")
    shinyjs::show("restart")
    shinyjs::show("header_tabla_inputs")
    shinyjs::show("header_tabla_inputs_multiple")
    shinyjs::hide("go_comp")
    shinyjs::hide("comparacion_escenario")
    
    
    if (length(input$comparacion_escenario)==0) {
      shinyalert("Advertencia", "Debe seleccionar al menos una intervención", type = "error")
      shinyjs::hide("header_comparacion_resultados")
      shinyjs::hide("columna_resultados_borde")
    } else {
      shinyjs::show("header_comparacion_resultados")
      shinyjs::show("columna_resultados_borde")
      shinyjs::disable("go_intervencion")
      shinyjs::show("descarga_comp")
      
      
      
      
      
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
                  
                  # cat_input = c(1,2,3,14)
                  # cat_epi = c(6,7,8,9)
                  # cat_costos = c(4,5,10,11,12,13,15)
                  # 
                  cat_epi = c(5:8)
                  cat_costos = c(2,3,4,9,10,11,12,14)
                  
                  # table$cat=""
                  # table$cat[cat_input] = "Inputs"
                  # table$cat[cat_epi] = "Resultados epidemiológicos"
                  # table$cat[cat_costos] = "Resultados económicos"
                  # 
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  
                  table = table[table$cat!="",]
                  table = rbind(
                    table[table$cat=="Resultados epidemiológicos",],
                    table[table$cat=="Resultados económicos",]
                  )
                  
                  
                  columns = list(
                    cat = colDef(name = "Categoría", align = "left"),
                    Outcomes = colDef(name = "Indicador", align = "left")
                  )
                  
                  for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
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
                  
                  cat_epi = 1:13
                  cat_costos = 14:20
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  table[[i]][table$cat=="Resultados económicos"] = paste0("$",table[[2]][table$cat=="Resultados económicos"])
                  columns = list(
                    cat = colDef(name = "Categoría", align = "left"),
                    Indicador = colDef(name = "Indicador", align = "left")
                  )
                  
                  for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
                    table[i] = format(table[i], big.mark=",", small.mark=".") 
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
                  table=hpp_run()
                  table = table %>% dplyr::select(indicador)
                  
                  for (i in sel_escenario) {
                    scn_name = i
                    table[[i]] = hpp_scenarios$savedScenarios[[i]]$valor
                  }
                  
                  cat_epi = 1:4
                  cat_costos = 4:nrow(table)
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  
                  columns = list(
                    cat = colDef(name = "Categoría", align = "left"),
                    indicador = colDef(name = "Indicador", align = "left")
                  )
                  
                  for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
                    table[i] = format(round(table[i],1), bigmark=",", decimalmark=".") 
                    columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
                  }
                  
                  rownames(table)=c(1:nrow(table))
                  
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
              
            } else if (sel_intervencion == "VDOT Tuberculosis") {
              
              output$tbc_table_saved = renderReactable({
                
                if (length(sel_escenario)>0) {
                  enable("tbc_savedScenarios")
                  tbc_run = data.frame(indicador = tbc_run()[,c(1)])
                  table = tbc_run
                  
                  cat_epi = 1:4
                  cat_costos = 5:nrow(table)
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  
        
                  columns = list()
                  
                  for (i in sel_escenario) {
                    scn_name = i
                    col = tbc_scenarios$savedScenarios[[i]]$vDOT
                    table[[i]] = col  
                    columns[[i]] = colDef(name = i, align = "right")
                    
                  }
                
                  columns[["cat"]] = colDef(name = "Categoría", align = "left")
                  columns[["indicador"]] = colDef(name = "Parámetro", align = "left")
                
                
                  reactable(
                    table,
                    groupBy = "cat",
                    defaultExpanded = T,
                    pagination = F,
                    columnGroups = list(
                      colGroup("Escenarios", columns = sel_escenario, sticky = "left",
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
                reactableOutput("tbc_table_saved")
              )
            } else if (sel_intervencion == "Profilaxis Pre Exposición VIH") {
              
              
              output$tbc_table_saved = renderReactable({
                
                if (length(sel_escenario)>0) {
                  table = prep_run()
                  table$Parametro = prep_outcomes_labels()
                  
                  table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
                  
                  cat_epi = 1:6
                  cat_costos = 7:nrow(table)
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  
                  # ocultamos descontados
                  table = table[c(1,2,3,5,7,9,11,13,15,17,19),]
                  
                  columns = list()
                  for (i in sel_escenario) {
                    scn_name = i
                    table[[i]] = prep_scenarios$savedScenarios[[i]]$Valor[c(1,2,3,5,7,9,11,13,15,17,19)]
                    table[[i]] = format(round(table[[i]],2),big.mark = ".", decimal.mark = ",")
                  }
                  
                  
                  
                  columns[["cat"]] = colDef(name = "Categoría", align = "left")
                  columns[["Parametro"]] = colDef(name = "Parámetro", align = "left")
                  
                  table$Valor = NULL
                  
                  reactable(
                    table,
                    groupBy = "cat",
                    defaultExpanded = T,
                    pagination = F,
                    columnGroups = list(
                      colGroup("Escenarios", columns = sel_escenario, sticky = "left",
                               headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
                    ),
                    defaultColDef = colDef(
                      align = "right",
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
                reactableOutput("tbc_table_saved")
              )
              
              ####################################
              
              
              
            }
            
          } 
        })
        
        output$inputs_summary_table = renderUI({
          output$tabla_inputs = renderReactable({
            if (is.null(sel_escenario)==F & is.null(input$comparacion_intervencion)==F & is.null(input$comparacion_escenario)==F) {
              
              if (length(input$comparacion_intervencion)==1) {
                table_data = inputs_table_generator(input,output, inputs_scenarios, summary_scenarios)[[1]]
                columnas = inputs_table_generator(input,output, inputs_scenarios, summary_scenarios)[[2]]
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
              } else {
                hide("header_tabla_inputs_multiple")}
              
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
            hidden(reactableOutput("tabla_inputs")),
            br(),
            br()
          )  
          
          
        })  
        
      } else {
        
        output$escenarios_guardados = renderUI({
          shinyjs::hide("header_comparacion_resultados")
          shinyjs::hide("header_tabla_inputs")
          shinyjs::hide("inputs_summary_table")
          if (length(input$comparacion_intervencion)>1) {
            intervenciones_seleccionadas = input$comparacion_intervencion
            escenarios_seleccionados = input$comparacion_escenario
            
            AVAD = list()
            COSTO_TOTAL = list()
            DIF_COSTO = list()
            RCEI_AVAD = list()
            ROI = list()
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Vacuna contra el HPV"]]) {
              AVAD[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Años de Vida Ajustados por Discapacidad evitados (AVAD)"]
              COSTO_TOTAL[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Costo total de la intervención (USD)"]
              DIF_COSTO[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Diferencia de Costos respecto al escenario basal (USD)"]
              ROI[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Retorno de Inversión (%)"]
              RCEI_AVAD[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Razón de costo-efectividad incremental por Años de Vida Ajustados por Discapacidad evitados (USD)"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="HEARTS"]]) {
              AVAD[[j]] = as.numeric(hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Años de vida ajustados por discapacidad evitados"])
              COSTO_TOTAL[[j]] = as.numeric(hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Costos totales de la intervención (USD)"])
              DIF_COSTO[[j]] = as.numeric(hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Diferencia de costos respecto al escenario basal (USD)"])
              ROI[[j]] = as.numeric(hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Retorno de inversión (%)"])
              RCEI_AVAD[[j]] = as.numeric(hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD)"])
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Hemorragia postparto"]]) {
              AVAD[[j]] = hpp_scenarios$savedScenarios[[j]]$valor[hpp_scenarios$savedScenarios[[j]]$indicador=="Años de vida ajustados por discapacidad evitados"]
              COSTO_TOTAL[[j]] = hpp_scenarios$savedScenarios[[j]]$valor[hpp_scenarios$savedScenarios[[j]]$indicador=="Costo total de la intervención (USD)"]
              DIF_COSTO[[j]] = hpp_scenarios$savedScenarios[[j]]$valor[hpp_scenarios$savedScenarios[[j]]$indicador=="Diferencia de costos respecto al escenario basal (USD)"]
              ROI[[j]] = hpp_scenarios$savedScenarios[[j]]$valor[hpp_scenarios$savedScenarios[[j]]$indicador=="Retorno de Inversión (%)"]
              RCEI_AVAD[[j]] = hpp_scenarios$savedScenarios[[j]]$valor[hpp_scenarios$savedScenarios[[j]]$indicador=="Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD)"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Hepatitis C"]]) {
              AVAD[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Años de Vida Ajustados por Discapacidad evitados"]
              COSTO_TOTAL[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Costo total de la intervención (USD)"]
              DIF_COSTO[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Diferencia de costos respecto al escenario basal (USD)"]
              ROI[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Retorno de Inversión (%)"]
              RCEI_AVAD[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Razón de costo-efectividad incremental por Años de Vida Ajustados por Discapacidad evitada (USD)"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="VDOT Tuberculosis"]]) {
              AVAD[[j]] = round(tbc_scenarios$savedScenarios[[j]]$vDOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Años de vida ajustados por discapacidad evitados"],1)
              COSTO_TOTAL[[j]] = round(tbc_scenarios$savedScenarios[[j]]$vDOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Costo total de la intervención (USD)"],1)
              DIF_COSTO[[j]] = round(tbc_scenarios$savedScenarios[[j]]$vDOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Diferencia de costos respecto al escenario basal (USD)"],1)
              ROI[[j]] = round(tbc_scenarios$savedScenarios[[j]]$vDOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Retorno de Inversión (%)"],1)
              RCEI_AVAD[[j]] = round(tbc_scenarios$savedScenarios[[j]]$vDOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Razon de costo-efectividad incremental por año de vida ajustado por discapacidad prevenido"],1)
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Profilaxis Pre Exposición VIH"]]) {
              AVAD[[j]] = round(prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Años de vida ajustados por discapacidad evitados"],1)
              COSTO_TOTAL[[j]] = round(prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Costo total de la intervención (USD)"],1)
              DIF_COSTO[[j]] = round(prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Diferencia de costos respecto al escenario basal (USD)"],1)
              ROI[[j]] = round(prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Retorno de Inversión (ROI) (%)"],1)
              RCEI_AVAD[[j]] = round(prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Razón de costo-efectividad incremental (RCEI) por Años de Vida Ajustados por Discapacidad (AVAD) Evitados (descontado)"],1)
            }
            
            escenarios = names(unlist(ROI))
            
            indicadores = c(
              "AVAD",
              "COSTO_TOTAL",
              "DIF_COSTO",
              "ROI",
              "RCEI_AVAD")
            
            table = data.frame()
            
            for (i in indicadores) {
              append = data.frame(
                indicador = i,
                scenarioName = escenarios,
                value = unlist(eval(parse(text=i)))) %>% left_join(summary_scenarios$table)
              table = rbind(table,append)
            }
            
            table = table %>% dplyr::select(scenarioName,country,intervencion, indicador, value)
            
            
            
            ########## ACÁ METÉ LOS GRÁFICOS ##########
          
          
            compa <- table
         
            compa<- compa %>%
              mutate(Intervencion_escenario = paste0(intervencion,'<br>',"(",scenarioName,")" ),
                     value = round(value, 1))
            
            compa$indicador[compa$indicador=="AVAD"] = "Años de vida ajustados por discapacidad evitados"
            compa$indicador[compa$indicador=="COSTO_TOTAL"] = "Costo total de la intervención (USD)"
            compa$indicador[compa$indicador=="DIF_COSTO"] = "Diferencia de costos respecto al escenario basal (USD)"
            compa$indicador[compa$indicador=="ROI"] = "Retorno de Inversión (%)"
            compa$indicador[compa$indicador=="RCEI_AVAD"] = "Razon de costo-efectividad incremental por año de vida ajustado por discapacidad prevenido"
          
            
            
            # Colores de fondo para cada gráfico
            background_colors <- c("#FEDCB4", "#FCE3CB", "#c6efef", "#b2ceea", "#A8B7CC")
            
            unique_indicators <- unique(compa$indicador)
            
            #  gráficos
            list_of_plots <- lapply(seq_along( unique(compa$indicador)), function(idx) {
              indicador <- unique_indicators[idx]
              data_subset <-filter(compa, indicador == !!indicador)
              chart <- hchart(data_subset, "bar", hcaes(x = Intervencion_escenario, y = value, name = intervencion)) %>%
                hc_chart(backgroundColor = background_colors[idx %% length(background_colors) + 1]) %>% # Establecer color de fondo
                hc_title(text = paste("Indicador:", indicador),
                         style = list(fontSize = "14px")) %>%
                hc_plotOptions(series = list(
                  color = '#596775' # Configurar el color de las barras a negro
                  # dataLabels = list(
                  #   enabled = TRUE, 
                  #   format = '{point.y}',  # Usar el nombre de la opción de punto para la etiqueta
                  #   color = 'black', # Cambiar el color del texto a negro
                  #   align = 'right', # Alinear a la derecha (fuera de la barra)
                  #   inside = FALSE, # Asegurar que la etiqueta esté fuera de la barra
                  #   verticalAlign = 'middle', # Alinear verticalmente en el medio
                  #   y = 0, # Ajustar posición vertical
                  #   x = 5  # Ajustar posición horizontal (un poco a la derecha de la barra)
                  # )
                )) %>%
                hc_xAxis(title = list(text = "Escenario selecionado"),
                         categories=data_subset$Intervencion_escenario) %>%
                hc_yAxis(title = list(text = ""),
                         opposite = TRUE,
                         plotLines = list(list(
                           value = 0, 
                           color = 'white',
                           width = 2 # Puedes ajustar el grosor de la línea aquí
                         )) )%>%
                hc_tooltip(pointFormat = paste('Valor de',indicador,': <b>{point.y:,.0f}</b><br/>'))
              chart
            })
            
            # cuadrícula
            
            
              # hw_grid(list_of_plots, rowheight = 240, ncol=5, add_htmlgrid_css = F) %>%
              #   htmltools::browsable()
              # 
            
            
            output$grafico_multiple1 = renderHighchart({list_of_plots[[1]]})
            output$grafico_multiple2 = renderHighchart({list_of_plots[[2]]})
            output$grafico_multiple3 = renderHighchart({list_of_plots[[3]]})
            output$grafico_multiple4 = renderHighchart({list_of_plots[[4]]})
            output$grafico_multiple5 = renderHighchart({list_of_plots[[5]]})
            
            output$tabla_escenarios_guardados = renderReactable({
              
              table_data = data.frame(
                scenarioName = paste0(table$scenarioName," (",table$country," / ",table$intervencion),
                table$indicador,
                table$value
              ) %>% dplyr::mutate(
                table.indicador = case_when(table$indicador == "AVAD" ~ "Años de vida ajustados por discapacidad evitados",
                                            table$indicador == "COSTO_TOTAL" ~ "Costos totales de la intervención (USD)",
                                            table$indicador == "DIF_COSTO"  ~ "Diferencia de costos respecto al escenario basal (USD)",
                                            table$indicador == "ROI"  ~ "Retorno de inversión (%)",
                                            table$indicador == "RCEI_AVAD" ~  "Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD)"),
                table.value = format(round(table.value,1), big.mark=".", decimal.mark=",")
              )
              
              reactable(
                table_data,
                defaultExpanded = T,
                groupBy = "scenarioName",
                pagination = F,
                columns = list(
                  scenarioName = colDef(name = "Escenario guardado", align = "left"),
                  table.indicador = colDef(name = "Indicador", align = "left"),
                  table.value = colDef(name = "Valor", align = "right")
                ),
                defaultColDef = colDef(
                  headerStyle = list(background = "#236292", color = "white", borderWidth = "0")
                )
                
              )
              
              
              
            })
            
            output$infoBoxAVAD = renderUI({
              best = max(table$value[table$indicador=="AVAD"])
              nombre_scn = table$scenarioName[table$indicador == "AVAD" & table$value == best]
              hito = "Mayor cantidad de AVAD salvados"
              valor = format(round(best,1),big.mark=".",small.mark=",")
              intervencion = table$intervencion[table$indicador == "AVAD" & table$value == best]
              
              info_box(
                nombre_scn = nombre_scn,
                hito = hito,
                valor = valor,
                intervencion = intervencion)

            })
            
            output$infoBoxCostoTotal = renderUI({
              best = min(table$value[table$indicador=="COSTO_TOTAL"])
              nombre_scn = table$scenarioName[table$indicador == "COSTO_TOTAL" & table$value == best]
              hito = "Menor costo total de la intervención (%)"
              valor = format(round(best,1),big.mark=".",small.mark=",")
              intervencion = table$intervencion[table$indicador == "COSTO_TOTAL" & table$value == best]
              
              info_box(
                nombre_scn = nombre_scn,
                hito = hito,
                valor = valor,
                intervencion = intervencion)
              
            })
            
            output$infoBoxDiferenciaCosto = renderUI({
              best = min(table$value[table$indicador=="DIF_COSTO"])
              nombre_scn = table$scenarioName[table$indicador == "DIF_COSTO" & table$value == best]
              hito = "Menor diferencia de costo respecto del escenario basal (%)"
              valor = format(round(best,1),big.mark=".",small.mark=",")
              intervencion = table$intervencion[table$indicador == "DIF_COSTO" & table$value == best]
              
              info_box(
                nombre_scn = nombre_scn,
                hito = hito,
                valor = valor,
                intervencion = intervencion)
              
            })
            
            output$infoBoxROI = renderUI({
              best = max(table$value[table$indicador=="ROI"])
              nombre_scn = table$scenarioName[table$indicador == "ROI" & table$value == best]
              hito = "Mayor retorno de inversión (%)"
              valor = format(round(best,1),big.mark=".",small.mark=",")
              intervencion = table$intervencion[table$indicador == "ROI" & table$value == best]
              
              info_box(
                nombre_scn = nombre_scn,
                hito = hito,
                valor = valor,
                intervencion = intervencion)
              
            })
            
            output$infoBoxRCEIAVAD = renderUI({
              best = min(table$value[table$indicador=="RCEI_AVAD"])
              nombre_scn = table$scenarioName[table$indicador == "RCEI_AVAD" & table$value == best]
              hito = "Menor razón de costo incremental por AVAD evitado (%)"
              valor = format(round(best,1),big.mark=".",small.mark=",")
              intervencion = table$intervencion[table$indicador == "RCEI_AVAD" & table$value == best]
              
              info_box(
                nombre_scn = nombre_scn,
                hito = hito,
                valor = valor,
                intervencion = intervencion)
              
            })
            
          }
          
          
          output$prueba = renderReactable({
            if (is.null(sel_escenario)==F & is.null(input$comparacion_intervencion)==F & is.null(input$comparacion_escenario)==F) {
              tabla = inputs_table_generator_multiple(input,output, inputs_scenarios, summary_scenarios)
              #tabla = inputs_table_multiple
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
              
              tabla$Categoría = NULL
              
              tabla$escenario_full = paste0(tabla$int,": ",tabla$escenario)
              
              tabla = tabla[,c("Input","valor","escenario_full")]
              
              reactable(
                tabla,
                groupBy = "escenario_full",
                pagination = F,
                columns = list(
                  escenario_full = colDef(name = "Escenario guardado", align = "left"),
                  Input = colDef(name = "Input", align = "left"),
                  valor = colDef(name = "Valor", align = "right")
                ),
                defaultColDef = colDef(
                  headerStyle = list(background = "#236292", color = "white", borderWidth = "0")
                )
                
              ) 
            }
                     
            
            
          })
          
          shiny::tagList(
            fluidRow(
              column(9,
                     tags$header(class="text-1xl flex justify-between items-center p-5 mt-4",style="background-color: #FF671B; color: white; text-align: center", 
                                 tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Generales")),
                     ),
                     br(),
                     reactableOutput("tabla_escenarios_guardados"), align="center"),
              column(3,
                     tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                                 tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Destacados")),
                     ),
                     br(),
                     htmlOutput("infoBoxAVAD"),
                     htmlOutput("infoBoxCostoTotal"),
                     htmlOutput("infoBoxDiferenciaCosto"),
                     htmlOutput("infoBoxROI"),
                     htmlOutput("infoBoxRCEIAVAD"), align = "center")
                     
            ),
            
            fluidRow(
              
              column(
                12,
                br(),
                tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                            tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Gráficos")),
                            
                ),
                br()
              ), align="center"),
            fluidRow(
              column(4,highchartOutput("grafico_multiple1")),
              column(4,highchartOutput("grafico_multiple2")),
              column(4,highchartOutput("grafico_multiple3"))
            ),
            fluidRow(
              column(4,highchartOutput("grafico_multiple4")),
              column(4,highchartOutput("grafico_multiple5"))
            ),
            fluidRow(
              br(),
              column(12,
                     br(),
                     tags$header(id = "header_tabla_inputs_multiple", class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                                 tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Descripción de escenarios guardados")),
                                 actionLink(inputId = "toggle_tabla_inputs_multiple", label=icon("stream", style = "color: white;"))
                     ),
                     br(),
                     hidden(reactableOutput("prueba")),
                     br(),
                     br()
                     )
            )
            
          )
          
          # tagList(
          #   br(),
          #   br(),
          #   hr(),
          #   highchartOutput("grafico_multiple"),
          #   br(),
          #   tags$header(id = "header_tabla_inputs_multiple", class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
          #               tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Descripción de escenarios guardados")),
          #               actionLink(inputId = "toggle_tabla_inputs_multiple", label=icon("stream", style = "color: white;"))
          #   ),
          #   br(),
          #   reactableOutput("inputs_summary_table")
          #   
          # )
          
          
        })
      }
      
      
    }
    
    
    
    
   
    
  })
  
  
  #observeEvent(input$go_comp, {
    

  #})
  
}

