ui_tbc = function (input) {
  renderUI({
    
    if (is.null(input$country) == F) {
      tbc_map_inputs = data.frame(
        intervencion = "VDOT Tuberculosis",
        i_names = names(get_tbc_params()),
        i_labels = get_tbc_params_labels()
      )

      tbc_map_inputs$avanzado = NA
      tbc_map_inputs$avanzado[1:3] = T
      tbc_map_inputs$avanzado[4:13] = F

      rownames(tbc_map_inputs) = 1:nrow(tbc_map_inputs)

      save(
        tbc_map_inputs,
        file = "tbc_map_inputs.Rdata"
      )

    }

    tagList(
      
      lapply(1:3, function(i) {
        numericInput(tbc_map_inputs$i_names[i],tbc_map_inputs$i_labels[i],get_tbc_params()[[i]])
      }),
      tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                  tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                  actionLink(inputId = "toggle_avanzado_tbc", label=icon("stream", style = "color: white;"))
      ),

      lapply(4:13, function(i) {
        hidden(numericInput(tbc_map_inputs$i_names[i],tbc_map_inputs$i_labels[i],get_tbc_params()[[i]]))
      })
    )
    
    
    
    
  })
  
  
  
  
}


ui_resultados_tbc = function(input,output,resultados) {
  
  tbc_run = resultados()
  
  output$tbc_summaryTable = renderReactable({
    
    if (length(tbc_run)>1) {
      table = tbc_run
      table$SAT[c(1:10,12)] = format(round(as.numeric(table$SAT[c(1:10,12)]),1),big.mark = ".",decimal.mark = ",")
      table$VOT = format(round(table$VOT,1),big.mark = ".",decimal.mark = ",")
      table$DOT = format(round(table$DOT,1),big.mark = ".",decimal.mark = ",")
      
      cat_epi = 1:9
      cat_costos = 10:17
      
      table$cat=""
      table$cat[cat_epi] = "Resultados epidemiológicos"
      table$cat[cat_costos] = "Resultados económicos"
      reactable(
        table,
        groupBy = "cat",
        defaultExpanded = T,
        pagination = F,
        defaultColDef = colDef(
          align = "center",
          minWidth = 70,
          headerStyle = list(background = "#236292", color = "white")
        ),
        columns = list(
          cat = colDef(name = "Categoría", align = "left"),
          Parametro = colDef(name = "Parámetro", align = "left"),
          SAT = colDef(name = "SAT", align = "right"),
          DOT = colDef(name = "DOT", align = "right"),
          VOT = colDef(name = "VOT", align = "right")
        ),
        bordered = TRUE,
        highlight = TRUE
      )
    }
    
  })
  
  tagList(
    reactableOutput("tbc_summaryTable")
  )
  # hpp_run = resultados()
  # 
  # output$hpp_summaryTable = renderReactable({
  #   
  #   if (length(hpp_run)>1) {
  #     browser()
  #     table = hpp_run
  #     table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
  #     
  #     cat_epi = c(2,4:8)
  #     cat_costos = c(1,3, 9:12)
  #     
  #     table$cat=""
  #     table$cat[cat_epi] = "Resultados epidemiológicos"
  #     table$cat[cat_costos] = "Resultados económicos"
  #     reactable(
  #       table,
  #       groupBy = "cat",
  #       defaultExpanded = T,
  #       pagination = F,
  #       defaultColDef = colDef(
  #         align = "center",
  #         minWidth = 70,
  #         headerStyle = list(background = "#236292", color = "white")
  #       ),
  #       columns = list(
  #         cat = colDef(name = "Categoría", align = "left"),
  #         Indicador = colDef(name = "Indicador", align = "left"),
  #         Valor = colDef(name = "Valor", align = "right")
  #       ),
  #       bordered = TRUE,
  #       highlight = TRUE
  #     )
  #   }
  #   
  # })
  # 
  # tagList(
  #   reactableOutput("hpp_summaryTable")
  # )
  
}


