ui_hpv_basica = function (parametersReactive,input,inputs_hpv, run_hearts) {
  inputs_names = c(
    'Tamaño de la cohorte de nacimientos (mujeres)',
    'Tamaño de la cohorte en edad de vacunación (mujeres)',
    'Porcentaje de cobertura objetivo (esquema completo)',
    'Porcentaje de eficacia de la vacuna contra el VPH 16/18',
    'Grupo de edad objetivo',
    'Costo de vacunación (esquema completo)',
    'Costos administrativos de la vacuna (esquema completo)',
    'Costo total de vacunación (esquema completo)',
    'Costo del tratamiento del cáncer',
    'Años de vida ajustados por discapacidad por diagnóstico de cáncer de cuello uterino',
    'Años de vida ajustados por discapacidad por secuelas de cáncer de cuello uterino',
    'Años de vida ajustados por discapacidad por cáncer de cuello uterino terminal',
    'Tasa de descuento',
    'Porcentaje de casos de cáncer de cuello de útero debidos al VPH 16/18',
    'PIB per capita'
    #'Porcentaje de cobertura objetivo (esquema completo)'
  )
  
  inputs_hover = c(
    'Tamaño de la cohorte de nacimientos (mujeres)',
    'Número de mujeres en el país correspondientes a la edad de vacunación de rutina, definida por el "grupo de edad objetivo"',
    'Se refiere al porcentaje de mujeres que actualmente reciben vacuna contra el VPH',
    'Indica la reducción del riesgo de infecciones persistentes y lesiones precancerosas por los tipos 16 y 18 del VPH*',
    'Edad a la que normalmente se administran las vacunas contra el VPH. Tenga en cuenta que PRIME solo es adecuado para evaluar las vacunas contra el HPV administradas a niñas en las edades recomendadas por la OMS, de 9 a 13 años',
    'Costo de vacunación completa por niña para abril de 2023 (USD oficial a tasa de cambio nominal de cada país)',
    'Costo de administración, entrega y almacenamiento de la vacuna por niña completamente inmunizada para abril de 2023 (USD oficial a tasa de cambio nominal de cada país)',
    'Costo total (precio de la vacuna más el costo administrativo) por niña completamente inmunizada para abril de 2023 (USD oficial a tasa de cambio nominal de cada país)',
    'Costo promedio del tratamiento de un cáncer cervical a lo largo de la vida, expresado en dólares de abril de 2023 (USD oficial a tasa de cambio nominal de cada país)',
    'Miden la carga total del cáncer de cuello uterino combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro',
    'Miden la carga total de las secuelas de cáncer de cuello uterino combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro',
    'Miden la carga total del cáncer de cuello uterino terminal combinando años de vida perdidos por muerte prematura y años vividos con discapacidad. Se recomienda consultar a un economista de la salud antes de cambiar este parámetro',
    'Tasa de descuento',
    'Porcentaje de casos de cáncer de cuello uterino que son atribuibles a las cepas 16 y 18 del VPH',
    'PIB per capita'
    #'La proporción esperada de niñas en el grupo de edad relevante que recibirán el esquema completo de la vacuna luego de la intervención'
  )
  
  if (is.null(input$country) == F) {
    i_names = c()
    for (i in 1:15) {
      i_names = c(i_names,names(parametersReactive[i]))
    }
    
    i_labels = c()
    
    for (i in 1:15) {
      i_labels = c(i_labels,inputs_names[i])
    }
    
    hpv_map_inputs = data.frame(
      intervencion = "Vacuna contra el HPV",
      i_names,
      i_labels
    )
    
    hpv_map_inputs$avanzado = NA
    hpv_map_inputs$avanzado[4:15] = T
    hpv_map_inputs$avanzado[c(1:3)] = F
    
    save(
      hpv_map_inputs,
      file = "hpv_map_inputs.Rdata"
    )
    
  }
  
  renderUI({
    tagList(
      br(),
      #tags$style(getStyle()),
      lapply(1:3, function (i) {
        if (!i %in% c(3,4)) {
          numericInput(input=names(parametersReactive)[i],
                       tags$div(
                         inputs_names[i],
                         icon("circle-info",
                              "fa-1x",
                              title = inputs_hover[i])
                       ),
                       value = parametersReactive[[i]])
        } else {
          sliderInput(input=names(parametersReactive)[i],
                      label=tags$div(
                        inputs_names[i],
                        icon("circle-info",
                             "fa-1x",
                             title = inputs_hover[i])
                      ),
                      min = 0,
                      max= 1,
                      value=parametersReactive[[i]])}
        
      }),
      br(),
      tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                  tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                  actionLink(inputId = "toggle_avanzado_hpv", label=icon("stream", style = "color: white;"))
      ),
      br(),
      lapply(4:15, function (i) {
        if (!i %in% c(3,4,16)) {
          hidden(
            numericInput(input=names(parametersReactive)[i],
                         tags$div(
                           inputs_names[i],
                           icon("circle-info", 
                                "fa-1x",
                                title = inputs_hover[i])
                         )
                         ,
                         value = parametersReactive[[i]])
            
          )
        } else {
          hidden(
            sliderInput(input=names(parametersReactive)[i],
                        label=tags$div(
                          inputs_names[i],
                          icon("circle-info", 
                               "fa-1x",
                               title = inputs_hover[i])
                        ),
                        min = 0,
                        max= 1,
                        value=parametersReactive[[i]])
            
          )
        }
      })
      
      
      
    )
    
  }) 
}

ui_grafico_hpv = function (resultados, input) {
  renderHighchart({
    if (length(input$proportionOfCervicalCancerCasesThatAreDueToHPV16_18)>0) {
      resultados$plot
    } else {
      NULL
    }
  })
}

ui_tabla_hpv = function (resultados, input) {
  if (length(input$birthCohortSizeFemale)>0) {
    table = resultados$outcomes
    table$disc = format(round(table$disc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
    table$undisc = format(round(table$undisc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
    
    colnames(table) = c("Outcomes", "Undiscounted", "Discounted")
    
    cat_input = c(1,2,3,14)
    cat_epi = c(6,7,8,9)
    cat_costos = c(4,5,10,11,12,13,15)
    
    table$cat=""
    table$cat[cat_input] = "Inputs"
    table$cat[cat_epi] = "Resultados epidemiológicos"
    table$cat[cat_costos] = "Resultados económicos"
    table$Discounted[cat_input] = "-"
    
    
    reactable(
      table[table$cat!="Inputs",],
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
        Outcomes = colDef(name = "Resultados", align = "left"),
        Undiscounted = colDef(name = "Sin descontar", align = "right"),
        Discounted = colDef(name = "Descontados", align = "right")
      ),
      bordered = TRUE,
      highlight = TRUE
    )
    
    
  } else {NULL}
  
}


