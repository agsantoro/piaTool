ui_hearts = function (input,base_line) {
  
  
  country_sel = str_to_title(input$country)
  renderUI({
    input_names = c(
      "Prevalencia de adultos con hipertensión, estandarizada por edad",
      "Porcentaje de adultos con hipertensión diagnosticados",
      "Porcentaje de personas diagnosticadas que se encuentran en tratamiento (basal)",
      "Porcentaje de adultos con hipertensión controla entre los tratados",
      "Costo farmacológico anual promedio por paciente", 
      "Costo de evento de enfermedad isquémica",
      "Costo de seguimiento anual promedio por paciente",
      "Porcentaje de personas diagnosticadas que se encuentran en tratamiento (objetivo)"
    )
    
    names(input_names) = colnames(base_line)[-c(1,6)]
    names(input_names)[8] = names(input_names)[3] 
    
    if (is.null(input$country) == F) {
      i_names = c()
      for (i in 1:8) {
        i_names = c(i_names,paste0("hearts_input_",i))
      }
      
      i_labels = c()
      
      for (i in 1:8) {
        i_labels = c(i_labels,input_names[i])
      }
      
      # i_labels[3] = paste(i_labels[3],"(basal)")
      # i_labels[7] = paste(i_labels[7],"(objetivo)")
      # 
      
      
      hearts_map_inputs = data.frame(
        intervencion = "HEARTS",
        i_names,
        i_labels
      )
      
      hearts_map_inputs$avanzado = NA
      hearts_map_inputs$avanzado[c(1,2,3,4,5,6,7)] = T
      hearts_map_inputs$avanzado[c(8)] = F
      
      rownames(hearts_map_inputs) = 1:nrow(hearts_map_inputs)
      
      save(
        hearts_map_inputs,
        file = "hearts_map_inputs.Rdata"
      )
      
    }
    
    tagList(
          
          lapply(c(8), function (i) {
            sliderInput(paste0("hearts_input_",i),
                        tags$div(input_names[i],icon("circle-info","fa-1x",title = model_card_hearts$Descripción[model_card_hearts$inputID==paste0("hearts_input_",i)])),
                        value = 100*targets_default$treatment[targets_default$country==country_sel],
                        min=0,
                        max=100,
                        step=.1)
          }),
        
          tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                      tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                      actionLink(inputId = "toggle_avanzado_hearts", label=icon("stream", style = "color: white;"))
          ),
          hidden(
            lapply(c(3), function (i) {
              sliderInput(paste0("hearts_input_",i),
                          tags$div(input_names[i],icon("circle-info","fa-1x",title = model_card_hearts$Descripción[model_card_hearts$inputID==paste0("hearts_input_",i)])),
                          value = 100*base_line[base_line$country==country_sel,names(input_names[i])],
                          min=0,
                          max=100,
                          step=.1)
            }),
            lapply(c(1,2,4), function (i) {
              sliderInput(paste0("hearts_input_",i),
                          tags$div(input_names[i],icon("circle-info","fa-1x",title = model_card_hearts$Descripción[model_card_hearts$inputID==paste0("hearts_input_",i)])),
                          value = 100*base_line[base_line$country==country_sel,names(input_names[i])],
                          min=0,
                          max=100,
                          step=.1)
            }),
            lapply(c(5,6,7), function (i) {
              numericInput(paste0("hearts_input_",i),
                           tags$div(input_names[i],icon("circle-info","fa-1x",title = model_card_hearts$Descripción[model_card_hearts$inputID==paste0("hearts_input_",i)])),
                          value = base_line[base_line$country==country_sel,names(input_names[i])],
                          step=.1)
            })
          ),
          # hidden(tags$div(id = "titulo2", h4("Objetivo"))),
          # hidden(
          #   lapply(input_names[c(1,2,4)], function (i) {
          #     sliderInput(paste0("hearts_input_target_",which(input_names==i)),
          #                 input_names[input_names==i],
          #                 value = targets_default[targets_default$country==country_sel,names(input_names[input_names==i])],
          #                 min=0,
          #                 max=1,
          #                 step=.001)
          #   })
          # )
        )
      
    
    
    
  })
}

ui_resultados_hearts = function(input,output,resultados) {
  paste(input$hearts_input_1)
  country_sel = str_to_title(input$country)
  
  if (is.null(input$hearts_input_1)==F) {
    run_hearts = resultados()
    
    output$hearts_grafico_1 = renderPlotly({
      if (length(run_hearts)>0) {
        x = 0:100
        y = c()
        
        for (i in x) {
          y=c(y,exp((-0.0294 * i) +5.5305))
        }
        
        y1 = round(run_hearts$epi_model_outcomes$Modelo1_x1,1)
        y2 = round(run_hearts$epi_model_outcomes$Modelo1_x2,1)
        x1 = round(run_hearts$run[[country_sel]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
        x2 = round(run_hearts$run[[country_sel]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
        
        data <- data.frame(x,y,y1,y2,x1,x2)
        fig <-
          plot_ly(
            data)%>%
          add_trace(
            y = ~ y1,
            name = 'trace 1',
            mode = "line",
            type = 'scatter',
            line = list(
              color = '#FF691D',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'none'
          ) %>%
          add_trace(
            y = ~ y2,
            type = 'scatter',
            mode = "line",
            line = list(
              color = '#0a94d6',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'skip'
          ) %>%
          add_trace(
            x = ~ x1,
            y=~ y,
            type = 'scatter',
            mode = "line",
            line = list(
              color = '#FF691D',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'skip'
          ) %>%
          add_trace(
            x = ~ x2,
            y=~ y,
            type = 'scatter',
            mode = "line",
            line = list(
              color = '#0a94d6',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'skip'
          )  %>% 
          add_trace(
            
            x = ~ x,
            y = ~ y,
            name = 'trace 0',
            type = 'scatter',
            mode = "line",
            line = list(color = 'black', width = 2),
            hovertemplate = paste("Para una prevalencia estandarizada por edad del control de la HTA en la población de %{x:,}%<br>",
                                  " se espera una mortalidad por enfermedad isquémica del corazón de %{y:.1f} por 100 000 habitantes<extra></extra> ")
          ) %>%
          add_annotations(
            x = 3,
            y = data$y1[1] + 3,
            text = data$y1[1],
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            showarrow = F
          ) %>% add_annotations(
            x = 3,
            y = data$y2[1] + 3,
            text = data$y2[1],
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            showarrow = F
          ) %>% add_annotations(
            y = 15,
            x = data$x1[1] + 0.5,
            text = data$x1[1],
            textangle=90,
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            showarrow = F
          ) %>% add_annotations(
            y = 15,
            x = data$x2[1] + 0.5,
            text = data$x2[1],
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            textangle=90,
            showarrow = F
          ) %>% config(displayModeBar = FALSE) %>% layout(
            showlegend = FALSE,
            title = list(text='<b>Modelo predictivo para la mortalidad por enfermedad isquémica del corazón<b>',
                         font=
                           list(color = '#265787',
                                family = "Istok Web",
                                size=15)),
            xaxis = list(title =list(text="Prevalencia de control de HTA en la población (%)",
                                     font=list(
                                       family = "Istok Web",
                                       size = 14,
                                       color = '#265787')) ,
                         zeroline = FALSE,           
                         zerolinecolor = "gray",
                         showline= F),
            yaxis = list(title =list(text="Tasa por 100.000 habitantes", font=list(
              family = "Istok Web",
              size = 14,
              color = '#265787')) ,
              tickfont = list(color = "gray"),
              linecolor = "gray",
              showline= F),
            zeroline = FALSE,           
            zerolinecolor = "gray"
          )
        fig %>% layout(font = list(family ="Istok Web"))
        
        
      }
      
      
    })
    
    output$hearts_grafico_2 = renderPlotly({
      if (length(run_hearts)>0) {
        x = 0:100
        y = c()
        
        for (i in x) {
          y=c(y,exp((-0.0240177 * i) + 4.57206))
        }
        
        y1 = round(run_hearts$epi_model_outcomes$Modelo2_x1,1)
        y2 = round(run_hearts$epi_model_outcomes$Modelo2_x2,1)
        
        x1 = round(run_hearts$run[[country_sel]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
        x2 = round(run_hearts$run[[country_sel]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
        data <- data.frame(x,y,y1,y2,x1,x2)
        
        fig <-
          plot_ly(
            data)%>%
          add_trace(
            y = ~ y1,
            name = 'trace 1',
            mode = "line",
            type = 'scatter',
            line = list(
              color = '#FF691D',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'none'
          ) %>%
          add_trace(
            y = ~ y2,
            type = 'scatter',
            mode = "line",
            line = list(
              color = '#0a94d6',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'skip'
          ) %>%
          add_trace(
            x = ~ x1,
            y=~ y,
            type = 'scatter',
            mode = "line",
            line = list(
              color = '#FF691D',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'skip'
          ) %>%
          add_trace(
            x = ~ x2,
            y=~ y,
            type = 'scatter',
            mode = "line",
            line = list(
              color = '#0a94d6',
              width = 1,
              dash = 'dash'
            ),
            hoverinfo = 'skip'
          )  %>% 
          add_trace(
            
            x = ~ x,
            y = ~ y,
            name = 'trace 0',
            type = 'scatter',
            mode = "line",
            line = list(color = 'black', width = 2),
            hovertemplate = paste("Para una prevalencia estandarizada por edad del control de la HTA en la población de %{x:,}%<br>",
                                  " se espera una mortalidad por accidente cerebrovascular de %{y:.1f} por 100 000 habitantes<extra></extra>")
          ) %>%
          add_annotations(
            x = 3,
            y = data$y1[1]+ 1 ,
            text = data$y1[1],
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            showarrow = F
          ) %>% add_annotations(
            x = 3,
            y = data$y2[1]+ 1,
            text = data$y2[1],
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            showarrow = F
          ) %>% add_annotations(
            y = 15,
            x = data$x1[1] + 0.5,
            text = data$x1[1],
            textangle=90,
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            showarrow = F
          ) %>% add_annotations(
            y = 15,
            x = data$x2[1] + 0.5,
            text = data$x2[1],
            font =list(
              color = '#265787',
              family = "Istok Web",
              size = 10
            ),
            textangle=90,
            showarrow = F
          )%>% config(displayModeBar = FALSE) %>%
          layout(
            showlegend = FALSE,
            title = list(text='<b>Modelo predictivo para la mortalidad por accidente cerebrovascular',
                         font=
                           list(color = '#265787',
                                family = "Istok Web",
                                size = 15)
            ),
            xaxis = list(title = list(text="Prevalencia de control de HTA en la población (%)",font=list(
              family = "Istok Web",
              size = 14,
              color = '#265787')),
              zeroline = FALSE,           
              zerolinecolor = "gray",
              showline= F),
            yaxis = list(title = list( text="Tasa por 100.000 habitantes",font=list(
              family = "Istok Web",
              size = 14,
              color = '#265787')),
              tickfont = list(color = "gray"),
              linecolor = "gray",
              showline= F),
            zeroline = FALSE,           
            zerolinecolor = "gray"
          )
        fig
        
      }
      
      
    })
    
    output$hearts_resultados = renderReactable({
      if(length(run_hearts)>0) {
        metrica_baseline = names(run_hearts$run[[country_sel]]$baseline)
        valores_baseline = unname(unlist(run_hearts$run[[country_sel]]$baseline))
        metrica_target = names(run_hearts$run[[country_sel]]$target)
        valores_target = unname(unlist(run_hearts$run[[country_sel]]$target))
        
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
        
        epi = run_hearts$epi_outcomes
        colnames(epi) = colnames(table)
        
        
        costos = data.frame(
          Indicador=names(run_hearts$costs_outcomes),
          Valor=unname(unlist(run_hearts$costs_outcomes))
          
        ) 
        table = rbind(
          table,
          epi,
          costos
        ) %>% as.data.frame()
        
        table$Valor = round(table$Valor,1)
        table$Valor = format(table$Valor, big.mark = ".", decimal.mark = ",")
        
        cat_epi = 1:12
        cat_costos = 13:22
        table$cat=""
        table$cat[cat_epi] = "Resultados epidemiológicos"
        table$cat[cat_costos] = "Resultados económicos"
        rownames(table) = NULL
        
        table$Valor[table$cat=="Resultados económicos"] = paste0("$",table$Valor[table$cat=="Resultados económicos"])
        clipr::write_clip(table)
        reactable(
          table,
          groupBy = "cat",
          defaultExpanded = T,
          pagination = F,
          defaultColDef = colDef(
            minWidth = 70,
            headerStyle = list(background = "#236292", color = "white")
          ),
          columns = list(
            cat = colDef(name = "Categoría", align = "left"),
            Indicador = colDef(name = "Indicador", align = "left"),
            Valor = colDef(name = "Valor", align = "right")
          ),
          bordered = TRUE,
          highlight = TRUE
        )
        
        
      }
    
    })
    
    tagList(
      fluidRow(
        column(6,
               plotlyOutput("hearts_grafico_1")),
        column(6,
               plotlyOutput("hearts_grafico_2"))
      ),
      br(),
      br(),
      fluidRow(
        column(12,
               reactableOutput("hearts_resultados"))
        
      )
      
      
      
    )
    
    
  } else {NULL}
  
  
}
