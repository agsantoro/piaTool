ui_tbc = function (input) {
  renderUI({
    if (is.null(input$country) == F) {
      tbc_map_inputs = data.frame(
        intervencion = "VDOT Tuberculosis",
        i_names = names(get_tbc_params(input=input)),
        i_labels = get_tbc_params_labels()
      )
      
      bsc = 1:3
      avz = 4:nrow(tbc_map_inputs)
    
      tbc_map_inputs$avanzado = NA
      tbc_map_inputs$avanzado[bsc] = F
      tbc_map_inputs$avanzado[avz] = T

      rownames(tbc_map_inputs) = 1:nrow(tbc_map_inputs)

      save(
        tbc_map_inputs,
        file = "tbc_map_inputs.Rdata"
      )

    }
    
    porcentajes = c(2,6,7,8,14,20,31)
    
    inputs_hover = get_tbc_hover()
    
    tagList(
      
      lapply(bsc, function(i) {
        if (i %in% porcentajes) {
          sliderInput(tbc_map_inputs$i_names[i],
                      tags$div(
                        tbc_map_inputs$i_labels[i],
                        icon("circle-info",
                             "fa-1x",
                             title = inputs_hover[i])
                      ),
                      
                      min=0, 
                      max=100,
                      step = 0.01,
                      value = get_tbc_params(input)[[i]]*100)
        } else {
          numericInput(tbc_map_inputs$i_names[i],tags$div(
            tbc_map_inputs$i_labels[i],
            icon("circle-info",
                 "fa-1x",
                 title = inputs_hover[i])
          ),get_tbc_params(input)[[i]])
        }
        
      }),
      tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                  tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                  actionLink(inputId = "toggle_avanzado_tbc", label=icon("stream", style = "color: white;"))
      ),

      lapply(avz, function(i) {
        if (i %in% porcentajes) {
          hidden(sliderInput(tbc_map_inputs$i_names[i],tags$div(
            tbc_map_inputs$i_labels[i],
            icon("circle-info",
                 "fa-1x",
                 title = inputs_hover[i])
          ),min=0, 
          max=100,
          step = 0.01,
          value = get_tbc_params(input)[[i]]*100))
        } else {
          hidden(numericInput(tbc_map_inputs$i_names[i],tags$div(
            tbc_map_inputs$i_labels[i],
            icon("circle-info",
                 "fa-1x",
                 title = inputs_hover[i])
          ),get_tbc_params(input)[[i]]))
        }
        
      })
    )
    
    
    
    
  })
  
  
  
  
}


ui_resultados_tbc = function(input,output,resultados) {
  
  tbc_run = resultados()[,c(1,4)]
  
  output$tbc_summaryTable = renderReactable({
    
    if (length(tbc_run)>1) {
      table = tbc_run
      table$vDOT = format(round(table$vDOT,1),big.mark = ".",decimal.mark = ",")
      
      cat_epi = 1:4
      cat_costos = 5:nrow(table)
      
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
          vDOT = colDef(name = "Valor", align = "right")
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


