ui_hpv_basica = function (input,inputs_hpv, run_hearts) {
  inputs_names = c(
    'Porcentaje de cobertura basal (esquema completo)',
    #'Tamaño de la cohorte de nacimientos (mujeres)',
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
    
  )
  
  inputs_hover = c(
    'Se refiere al porcentaje de mujeres que actualmente reciben vacuna contra el VPH.',
    #'Tamaño de la cohorte de nacimientos (mujeres)',
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
    
  )
  
  if (is.null(input$country) == F) {
    parametersReactive <- function () {
      paramsList = list(
        coverageBase = as.numeric(parameters[parameters$Country==input$country,11]),
        #birthCohortSizeFemale = as.numeric(parameters[parameters$Country==input$country,8]),
        cohortSizeAtVaccinationAgeFemale = as.numeric(cohortSizeAcVac$value[cohortSizeAcVac$country==input$country & 
                                                                              cohortSizeAcVac$age==as.numeric(parameters[parameters$Country==input$country,13])
        ]
        ),
        coverageAllDosis = as.numeric(parameters[parameters$Country==input$country,23]),
        vaccineEfficacyVsHPV16_18 = as.numeric(parameters[parameters$Country==input$country,12]),
        targetAgeGroup = as.numeric(parameters[parameters$Country==input$country,13]),
        vaccinePricePerFIG = as.numeric(parameters[parameters$Country==input$country,14]),
        vaccineDeliveryCostPerFIG = as.numeric(parameters[parameters$Country==input$country,15]),
        totalVaccineCostPerFIG = as.numeric(parameters[parameters$Country==input$country,14])+as.numeric(parameters[parameters$Country==input$country,15]),
        cancerTreatmentCostPerEpisodeOverLifetime = as.numeric(parameters[parameters$Country==input$country,16]),
        DALYsForCancerDiagnosis = 0.08,
        DALYsForNonTerminalCancerSequelaePperYear = as.numeric(parameters[parameters$Country==input$country,22]),
        DALYsForTerminalCancer = 0.78,
        discountRate = as.numeric(parameters[parameters$Country==input$country,18]),
        proportionOfCervicalCancerCasesThatAreDueToHPV16_18 = as.numeric(parameters[parameters$Country==input$country,19]),
        GDPPerCapita = as.numeric(parameters[parameters$Country==input$country,20])
        
      )
      return(paramsList)
    }
    
    i_names = c()
    for (i in 1:15) {
      i_names = c(i_names,names(parametersReactive()[i]))
    }
    
    i_labels = c()
    
    for (i in 1:15) {
      i_labels = c(i_labels,inputs_names[i])
    }
    
    browser()
    
    hpv_map_inputs = data.frame(
      intervencion = "Vacuna contra el HPV",
      i_names,
      i_labels
    )
    
    bsc = c(1,3,6)
    avz = setdiff(seq(1,nrow(hpv_map_inputs)),bsc)
    prc = c(1,3,4,13,14)
    
    hpv_map_inputs$avanzado = NA
    hpv_map_inputs$avanzado[avz] = T
    hpv_map_inputs$avanzado[bsc] = F
    
    save(
      hpv_map_inputs,
      file = "hpv_map_inputs.Rdata"
    )
    
  }
  
  renderUI({
    tagList(
      br(),
      #tags$style(getStyle()),
      lapply(bsc, function (i) {
        if (!i %in% prc) {
          numericInput(input=names(parametersReactive())[i],
                       tags$div(
                         inputs_names[i],
                         icon("circle-info",
                              "fa-1x",
                              title = inputs_hover[i])
                       ),
                       value = parametersReactive()[[i]])
        } else {
          sliderInput(input=names(parametersReactive())[i],
                      label=tags$div(
                        inputs_names[i],
                        icon("circle-info",
                             "fa-1x",
                             title = inputs_hover[i])
                      ),
                      min = 0,
                      max= 100,
                      value=parametersReactive()[[i]]*100)}
        
      }),
      br(),
      tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                  tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                  actionLink(inputId = "toggle_avanzado_hpv", label=icon("stream", style = "color: white;"))
      ),
      br(),
      lapply(avz, function (i) {
        if (!i %in% prc) {
          hidden(
            numericInput(input=names(parametersReactive())[i],
                         tags$div(
                           inputs_names[i],
                           icon("circle-info", 
                                "fa-1x",
                                title = inputs_hover[i])
                         )
                         ,
                         value = parametersReactive()[[i]])
            
          )
        } else {
          hidden(
            sliderInput(input=names(parametersReactive())[i],
                        label=tags$div(
                          inputs_names[i],
                          icon("circle-info", 
                               "fa-1x",
                               title = inputs_hover[i])
                        ),
                        min = 0,
                        max= 100,
                        value=parametersReactive()[[i]]*100)
            
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
  if (length(input$coverageBase)>0) {
    browser()
    table = resultados$outcomes
    table$disc = format(round(table$disc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
    table$undisc = format(round(table$undisc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
    
    colnames(table) = c("Outcomes", "Undiscounted", "Discounted")
    
    browser()
    
    cat_epi = c(5:8)
    cat_costos = c(2,3,4,9,10,11,12,14)
    
    table$cat=""
    table$cat[cat_epi] = "Resultados epidemiológicos"
    table$cat[cat_costos] = "Resultados económicos"
    
    table = table[table$cat!="",]
    table = rbind(
      table[table$cat=="Resultados epidemiológicos",],
      table[table$cat=="Resultados económicos",]
    )
    
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
        Outcomes = colDef(name = "Resultados", align = "left"),
        Undiscounted = colDef(name = "Sin descontar", align = "right"),
        Discounted = colDef(name = "Descontados", align = "right")
      ),
      bordered = TRUE,
      highlight = TRUE
    )
    
    
  } else {NULL}
  
}


