server_hpv = function (input, output, parameterReactive, scenarios, resultados, run_hearts, hearts_scenarios, hpp_run, hpp_scenarios) {
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
    } else {
      tagList(
        ui_resultados_hpp(input, output, hpp_run),
      )
    }
    
  })
  
  output$select_escenarios_guardados = renderUI({
    if (input$intervencion == "Vacuna contra el HPV") {
      tagList(
        selectizeInput(
          "savedScenarios",
          "Seleccionar escenario guardado",
          names(scenarios$savedScenarios),
          multiple = T,
          selected = names(scenarios$savedScenarios)
        )
      )
    } else if (input$intervencion == "HEARTS") {
      tagList(
        selectizeInput(
          "savedScenarios",
          "Seleccionar escenario guardado",
          names(hearts_scenarios$savedScenarios),
          multiple = T,
          selected = names(hearts_scenarios$savedScenarios)
        )
      )
    } else if (input$intervencion == "Hemorragia postparto") {
      tagList(
        selectizeInput(
          "savedScenarios",
          "Seleccionar escenario guardado",
          names(hpp_scenarios$savedScenarios),
          multiple = T,
          selected = names(hpp_scenarios$savedScenarios)
        )
      )
    }
    
    
  })
  
  output$escenarios_guardados = renderUI({
    
    # mira intervención seleccionada
    
    if (input$intervencion == "Vacuna contra el HPV") {
      output$grafico = renderHighchart({
        if (input$intervencion == "Vacuna contra el HPV") {
          
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
            if (!is.null(input$savedScenarios)) {
              if (input$savedScenarios[1]!="") {
                for (i in input$savedScenarios) {
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
            
          } else {disable("savedScenarios")}
          
        }
        
      })
      
      output$summaryTableScenarios <- renderReactable({
        if (length(scenarios$savedScenarios)>0) {
          if (is.null(input$savedScenarios)) {
            snSelected = colnames(scenarios$summaryTable)
          } else {
            snSelected = c(colnames(scenarios$summaryTable)[1], input$savedScenarios)
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
          
          
          
        } else {disable("savedScenarios")}
      })
      
      tagList(
        
        highchartOutput("grafico"),
        reactableOutput("summaryTableScenarios")
      )
      
      
    } else if (input$intervencion == "HEARTS") {
      
      output$hearts_table_saved = renderReactable({
        
        if (length(input$savedScenarios)>0) {
          table = data.frame(Indicador=hearts_scenarios$savedScenarios[[1]]$Indicador)
          for (i in input$savedScenarios) {
            scn_name = i
            table[[i]] = savedScenarios[[i]]$Valor
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
    } else {
      output$hpp_table_saved = renderReactable({
        if (length(input$savedScenarios)>0) {
          enable("hpp_savedScenarios")
          table = data.frame(Indicador=hpp_run()$Indicador)
          
          for (i in input$savedScenarios) {
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
      
    }
      
    
  })
}

