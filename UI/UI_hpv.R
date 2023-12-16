ui_hpv_basica = function (parametersReactive,input,inputs_hpv, run_hearts) {
  
  inputs_names = c(
    "Tamaño de la cohorte de nacimientos (mujeres)",
    "Tamaño de la cohorte a la edad de vacunación (mujeres)",
    "Cobertura (todas las dosis)",
    "Eficacia de la vacuna contra HPV 16/18",
    "Grupo de edad destinatario",
    "Precio de la vacunas por FIG",
    "Costo de distribución de vacunas por FIG",
    "Costo total de la vacuna por FIG",
    "Costo del tratamiento del cáncer (por episodio, a lo largo de la vida)",
    "DALYs por diagnóstico de cancer",
    "DALYs por secuelas no terminales del cáncer (por año)",
    "DALYs por cáncer terminal",
    "Tasa de descuento",
    "Proporción de casos de cáncer de cuello de útero debidos al VPH 16/18",
    "PIB per capita"
  )
  
  inputs_hover = c(
    "El número de recién nacidas mujeres en el país en el año base",
    "El número de mujeres en el país a la edad en que se administra la vacunación de rutina (basado en la edad en 'Grupo de edad objetivo')",
    "La proporción esperada de niñas en el grupo de edad relevante que recibirán el curso completo de la vacuna (ya sea 2 o 3 dosis)",
    "La reducción proporcional en el riesgo de cáncer cervical debido al HPV 16/18 en las personas vacunadas. Esto normalmente debería ser del 100%",
    "La edad a la que normalmente se administran las vacunas contra el HPV. Tenga en cuenta que PRIME solo es adecuado para evaluar las vacunas contra el HPV administradas a niñas en las edades recomendadas por la OMS, de 9 a 13 años",
    "El costo de adquisición para comprar suficientes vacunas (ya sea 2 o 3 dosis) para vacunar completamente a una niña",
    "El costo de entrega y administración de suficientes vacunas (ya sea 2 o 3 dosis) para vacunar completamente a una niña",
    "El costo total de adquisición para comprar suficientes vacunas (ya sea 2 o 3 dosis) para vacunar completamente a una niña. Esto se calcula automáticamente como la suma del costo de adquisición y entrega",
    "El costo promedio de tratar a una mujer con cáncer cervical, desde el diagnóstico hasta la muerte",
    "DALYs incurridos por un año de vida en el que se diagnostica cáncer cervical. Se recomienda consultar a un economista de la salud antes de modificar este parámetro",
    "DALYs incurridos por un año de vida después del año en que se diagnostica el cáncer cervical, asumiendo que el cáncer no es terminal. Esto puede variar según el país. Se recomienda consultar a un economista de la salud antes de modificar este parámetro",
    "DALYs incurridos por un año de vida inmediatamente antes de morir a causa de cáncer cervical terminal. Se recomienda consultar a un economista de la salud antes de modificar este parámetro",
    "La tasa que representa la preferencia de la sociedad por el consumo y las ganancias en salud en el presente en lugar del futuro. La OMS recomienda una tasa del 3% anual",
    "La proporción de casos de cáncer cervical diagnosticados en el año base que son causados por la infección de HPV 16 o 18",
    "El valor de todos los bienes y servicios producidos en el país dividido por la población total"
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
    hpv_map_inputs$avanzado[1:3] = F
    
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
        if (!i %in% c(3,4)) {
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


  
