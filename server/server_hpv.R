server_hpv = function (input, output, session, parameterReactive, scenarios, resultados, run_hearts, hearts_scenarios, hpp_run, hpp_scenarios, hepC_run, hepC_scenarios, summary_scenarios, inputs_scenarios, inputs_table, inputs_columns, inputs_table_multiple, tbc_run, tbc_scenarios,prep_run,prep_scenarios) {
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
    } else if (input$intervencion == "Profilaxis Pre Exposición VIH") {
      tagList(
        ui_resultados_prep(input, output, prep_run),
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
                  
                  table = tbc_run()
                  table$SAT[c(1:10,12)] = format(round(as.numeric(table$SAT[c(1:10,12)]),1),big.mark = ".",decimal.mark = ",")
                  table$VOT = format(round(table$VOT,1),big.mark = ".",decimal.mark = ",")
                  table$DOT = format(round(table$DOT,1),big.mark = ".",decimal.mark = ",")
                  
                  table = data.frame(
                    Parametro = rep(table$Parametro,3),
                    Clasif = c(rep("SAT",17),rep("DOT",17),rep("VOT",17)),
                    Valor = c(table$SAT,table$DOT,table$VOT)
                  )
                  
                  cat_epi = 1:9
                  cat_costos = 10:17
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  table$cat = rep(table$cat[1:17],3)
                  
                  columns = list()
                  
                  for (i in sel_escenario) {
                    scn_name = i
                    col = c(tbc_scenarios$savedScenarios[[i]]$SAT,tbc_scenarios$savedScenarios[[i]]$DOT,tbc_scenarios$savedScenarios[[i]]$VOT)
                    col[setdiff(1:length(col),c(11,13:17))] = format(round(as.numeric(col[setdiff(1:length(col),c(11,13:17))]),1),big.mark = ".",decimal.mark = ",")
                    table[[i]] = col  
                    columns[[i]] = colDef(name = i, align = "right")
                    
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
              
              
              ################################################
              
              output$tbc_table_saved = renderReactable({
                
                if (length(sel_escenario)>0) {
                  table = prep_run()
                  table$Parametro = prep_outcomes_labels()
                  
                  table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
                  
                  cat_epi = 1:14
                  cat_costos = 15:28
                  
                  table$cat=""
                  table$cat[cat_epi] = "Resultados epidemiológicos"
                  table$cat[cat_costos] = "Resultados económicos"
                  
                  columns = list()
                  for (i in sel_escenario) {
                    scn_name = i
                    table[[i]] = prep_scenarios$savedScenarios[[i]]$Valor
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
                hide("header_tabla_inputs")}
              
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
          if (length(input$comparacion_intervencion)>1) {
            intervenciones_seleccionadas = input$comparacion_intervencion
            escenarios_seleccionados = input$comparacion_escenario
            
            ROI= list()
            RCEI_AVAD = list()
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Vacuna contra el HPV"]]) {
              ROI[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Retorno de inversión"]
              RCEI_AVAD[[j]] = scenarios$savedScenarios[[j]]$outcomes$undisc[scenarios$savedScenarios[[j]]$outcomes$outcomes=="Razón de costo-efectividad incremental por Años de Vida Ajustados por Discapacidad evitados (USD)"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="HEARTS"]]) {
              ROI[[j]] = hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Retorno de inversión"]
              RCEI_AVAD[[j]] = hearts_scenarios$savedScenarios[[j]]$Valor[hearts_scenarios$savedScenarios[[j]]$Indicador=="Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Hemorragia postparto"]]) {
              ROI[[j]] = hpp_scenarios$savedScenarios[[j]]$Valor[hpp_scenarios$savedScenarios[[j]]$Indicador=="Retorno de Inversión (%)"]
              RCEI_AVAD[[j]] = hpp_scenarios$savedScenarios[[j]]$Valor[hpp_scenarios$savedScenarios[[j]]$Indicador=="Diferencia de costos respecto al escenario basal (USD)"] / hpp_scenarios$savedScenarios[[j]]$Valor[hpp_scenarios$savedScenarios[[j]]$Indicador=="Años de vida ajustados por discapacidad evitados"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Hepatitis C"]]) {
              ROI[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Retorno de Inversión (%)"]
              RCEI_AVAD[[j]] = hepC_scenarios$savedScenarios[[j]]$Valor[hepC_scenarios$savedScenarios[[j]]$Indicador=="Retorno de Inversión (%)"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="VDOT Tuberculosis"]]) {
              
              ROI[[j]] = tbc_scenarios$savedScenarios[[j]]$VOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Retorno de Inversión (%)"]
              RCEI_AVAD[[j]] = tbc_scenarios$savedScenarios[[j]]$VOT[tbc_scenarios$savedScenarios[[j]]$Parametro=="Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD)"]
            }
            
            for (j in escenarios_seleccionados[escenarios_seleccionados %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion=="Profilaxis Pre Exposición VIH"]]) {
              ROI[[j]] = prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Retorno de Inversión"]
              RCEI_AVAD[[j]] = prep_scenarios$savedScenarios[[j]]$Valor[prep_scenarios$savedScenarios[[j]]$Parametro=="Razón de costo-efectividad incremental (RCEI) por Años de Vida Ajustados por Discapacidad (AVAD) Evitados (descontado)"]
            }
            
            escenarios = names(unlist(ROI))
            roi_table = 
              data.frame(scenarioName = escenarios,
                         value = unlist(ROI)) %>% left_join(summary_scenarios$table)
            
            roi_table$scenarioName = paste0("Escenario: ","<b>",roi_table$scenarioName,"</b> <br>",roi_table$country,"<br>",roi_table$intervencion)
            
            roi_table <- roi_table %>% arrange(desc(value))
            roi_table$value = round(roi_table$value,2)
            
            iceravad_table = 
              data.frame(scenarioName = escenarios,
                         value = unlist(RCEI_AVAD)) %>% left_join(summary_scenarios$table)
            
            iceravad_table$scenarioName = paste0("Escenario: ","<b>",iceravad_table$scenarioName,"</b> <br>",iceravad_table$country,"<br>",iceravad_table$intervencion)
            
            iceravad_table <- iceravad_table %>% arrange(desc(value))
            iceravad_table$value = round(iceravad_table$value,2)
            
            output$grafico_multiple1 = renderHighchart({
              show("escenarios_guardados")
              
                grafico <- highchart() %>%
                  hc_chart(type = "column") %>%
                  hc_title(text = "Comparación del retorno de la inversión entre escenarios guardados") %>%
                  hc_xAxis(categories = roi_table$scenarioName) %>%
                  hc_plotOptions(column = list(
                    colorByPoint = TRUE,
                    dataLabels = list(enabled = TRUE)
                  )) %>%
                  hc_add_series(
                    data = roi_table,
                    type = "column",
                    hcaes(y = value, color = intervencion),
                    name = "ROI"
                  ) 
                
                grafico %>% hc_legend(list(
                  enabled = F
                )) %>%
                  hc_add_theme(hc_theme_elementary())
                
              
            })
            
            output$grafico_multiple2 = renderHighchart({
              show("escenarios_guardados")
              
              grafico <- highchart() %>%
                hc_chart(type = "column") %>%
                hc_title(text = "Comparación de la RCEI por AVADS evitados") %>%
                hc_xAxis(categories = iceravad_table$scenarioName) %>%
                hc_plotOptions(column = list(
                  colorByPoint = TRUE,
                  dataLabels = list(enabled = TRUE)
                )) %>%
                hc_add_series(
                  data = iceravad_table,
                  type = "column",
                  hcaes(y = value, color = intervencion),
                  name = "ROI"
                ) 
              
              grafico %>% hc_legend(list(
                enabled = F
              )) %>%
                hc_add_theme(hc_theme_elementary())
              
              
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
            br(),
            highchartOutput("grafico_multiple1"),
            br(),
            highchartOutput("grafico_multiple2"),
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

