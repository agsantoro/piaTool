ui_prep = function (input) {
  renderUI({
    if (is.null(input$country) == F) {
      prep_map_inputs = data.frame(
        intervencion = "Profilaxis Pre Exposición VIH",
        i_names = names(get_prep_params(input$country)),
        i_labels = get_prep_params_labels()
      )

      bsc = 1:4
      avz = 5:nrow(prep_map_inputs)
      
      prep_map_inputs$avanzado = NA
      prep_map_inputs$avanzado[avz] = T
      prep_map_inputs$avanzado[bsc] = F

      rownames(prep_map_inputs) = 1:nrow(prep_map_inputs)

      save(
        prep_map_inputs,
        file = "prep_map_inputs.Rdata"
      )

    }

    tagList(
      
      lapply(bsc, function(i) {
        numericInput(prep_map_inputs$i_names[i],prep_map_inputs$i_labels[i],get_prep_params(input$country)[[i]])
      }),
      tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                  tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                  actionLink(inputId = "toggle_avanzado_prep", label=icon("stream", style = "color: white;"))
      ),

      lapply(avz, function(i) {
        hidden(numericInput(prep_map_inputs$i_names[i],prep_map_inputs$i_labels[i],get_prep_params(input$country)[[i]]))
      })
    )
    
    
    
    
  })
}


ui_resultados_prep = function(input,output,resultados) {
  
  prep_run = resultados()
  
  output$prep_summaryTable = renderReactable({
    
    if (length(prep_run)>1) {
      table = prep_run
      table$Parametro = prep_outcomes_labels()
      
      table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
      
      cat_epi = 1:6
      cat_costos = 7:nrow(table)
      
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
          Parametro = colDef(name = "Indicador", align = "left"),
          Valor = colDef(name = "Valor", align = "right")
        ),
        bordered = TRUE,
        highlight = TRUE
      )
    }
    
  })
  
  tagList(
    reactableOutput("prep_summaryTable")
  )
}





