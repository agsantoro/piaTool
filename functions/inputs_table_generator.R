inputs_table_generator = function (input, output, inputs_scenarios, summary_scenarios) {
  seleccion = summary_scenarios$table
  seleccion = seleccion[seleccion$country %in% input$comparacion_country &
                        seleccion$intervencion %in% input$comparacion_intervencion &
                        seleccion$scenarioName %in% input$comparacion_escenario,]
  
  sel_intervencion = unique(seleccion$intervencion)
  sel_country = input$comparacion_country
  sel_escenario = input$comparacion_escenario
  
  
  
  table_inputs = inputs_scenarios$table
  table_inputs = table_inputs[table_inputs$country %in% sel_country &
                              table_inputs$intervencion == sel_intervencion &
                              table_inputs$scenarioName %in% sel_escenario,]
  
  
  if (sel_intervencion[1] == "Vacuna contra el HPV") {
    load("hpv_map_inputs.Rdata")
    labels_inputs = hpv_map_inputs
  } else if (sel_intervencion[1] == "HEARTS") {
    load("hearts_map_inputs.Rdata")
    labels_inputs = hearts_map_inputs
  } else if (sel_intervencion[1] == "Hemorragia postparto") {
    load("hpp_map_inputs.Rdata")
    labels_inputs = hpp_map_inputs
  } else if (sel_intervencion[1] == "Hepatitis C") {
    load("hepC_map_inputs.Rdata")
    labels_inputs = hepC_map_inputs
  } else if (sel_intervencion[1] == "VDOT Tuberculosis") {
    load("tbc_map_inputs.Rdata")
    labels_inputs = tbc_map_inputs
  }
  
  table_inputs = labels_inputs %>% left_join(table_inputs, by = c("i_names" = "inputName"))
  
  table_inputs$scenarioName = paste0(table_inputs$scenarioName, " (",table_inputs$country,")")
  
  if (sel_intervencion[1] == "HEARTS") {
    table_data = data.frame(
      Input = rep(unique(table_inputs$i_labels),2)
    )
  } else {
    table_data = data.frame(
      Input = unique(table_inputs$i_labels)
    )
  }
  
  for (i in unique(table_inputs$scenarioName)) {
    table_data[[i]] = format(round(as.numeric(table_inputs$inputValue[table_inputs$scenarioName==i]),2), big.mark = ".", decimal.mark = ",")
  }
  
  if (sel_intervencion[1] == "HEARTS") {
    table_data$Input[1:4] = paste0(table_data$Input[1:4]," (base)")
    table_data$Input[5:8] = paste0(table_data$Input[5:8]," (target)")
  }
  
  table_data = cbind(table_data, labels_inputs$avanzado)
  
  table_data$`labels_inputs$avanzado`[table_data$`labels_inputs$avanzado`==T] = "Inputs avazados"
  table_data$`labels_inputs$avanzado`[table_data$`labels_inputs$avanzado`==F] = "Inputs básicos"
  colnames(table_data)[colnames(table_data)=="labels_inputs$avanzado"] ="Categoría"
  columnas = list()
  
  for (i in colnames(table_data)) {
    if (i == "Input") {
      
      columnas[[i]] = colDef(name = "Input", align = "left")
    } else if (i == "Categoría") {
      NULL
    } else {
      columnas[[i]] = colDef(name = i, align = "right")
    }
    
  }
  
  return(
    list(
      table_data,
      columnas)
  )
  
}


inputs_table_generator_multiple = function (input, output, inputs_scenarios, summary_scenarios) {
  seleccion = summary_scenarios$table
  seleccion = seleccion[seleccion$country %in% input$comparacion_country &
                          seleccion$intervencion %in% input$comparacion_intervencion &
                          seleccion$scenarioName %in% input$comparacion_escenario,]
  
  sel_intervencion = unique(seleccion$intervencion)
  sel_country = input$comparacion_country
  sel_escenario = input$comparacion_escenario
  
  
  
  
  tablas = list()
  
  for (int in sel_intervencion) {
    for (esc in sel_escenario[sel_escenario %in% summary_scenarios$table$scenarioName[summary_scenarios$table$intervencion==int]]) {
      print(paste(int,esc))
      table_inputs = inputs_scenarios$table
      table_inputs = table_inputs[table_inputs$country %in% sel_country &
                                  table_inputs$intervencion == int &
                                  table_inputs$scenarioName %in% esc,]
      
      
      if (int == "Vacuna contra el HPV") {
        load("hpv_map_inputs.Rdata")
        labels_inputs = hpv_map_inputs
      } else if (int == "HEARTS") {
        load("hearts_map_inputs.Rdata")
        labels_inputs = hearts_map_inputs
      } else if (int == "Hemorragia postparto") {
        load("hpp_map_inputs.Rdata")
        labels_inputs = hpp_map_inputs
      } else if (int == "Hepatitis C") {
        load("hepC_map_inputs.Rdata")
        labels_inputs = hepC_map_inputs
      } else if (int == "VDOT Tuberculosis") {
        load("tbc_map_inputs.Rdata")
        labels_inputs = tbc_map_inputs
      }
      table_inputs = labels_inputs %>% left_join(table_inputs, by = c("i_names" = "inputName"))
      
      table_inputs$scenarioName = paste0(table_inputs$scenarioName, " (",table_inputs$country,")")
      
      if (int == "HEARTS") {
        table_data = data.frame(
          Input = rep(unique(table_inputs$i_labels),2)
        )
      } else {
        table_data = data.frame(
          Input = unique(table_inputs$i_labels)
        )
      }
      
      
      
      for (i in unique(table_inputs$scenarioName)) {
        table_data[[i]] = format(round(as.numeric(table_inputs$inputValue[table_inputs$scenarioName==i]),2), big.mark = ".", decimal.mark = ",")
      }
      
      if (int == "HEARTS") {
        table_data$Input[1:4] = paste0(table_data$Input[1:4]," (base)")
        table_data$Input[5:8] = paste0(table_data$Input[5:8]," (target)")
      }
      
      table_data = cbind(table_data, labels_inputs$avanzado)
      
      table_data$`labels_inputs$avanzado`[table_data$`labels_inputs$avanzado`==T] = "Inputs avazados"
      table_data$`labels_inputs$avanzado`[table_data$`labels_inputs$avanzado`==F] = "Inputs básicos"
      colnames(table_data)[colnames(table_data)=="labels_inputs$avanzado"] ="Categoría"
      columnas = list()
      
      for (i in colnames(table_data)) {
        if (i == "Input") {
          columnas[[i]] = colDef(name = "Input", align = "left")
        } else if (i == "Categoría") {
          NULL
        } else {
          columnas[[i]] = colDef(name = i, align = "right")
        }
        
      }
      tablas[[int]][[esc]] = table_data
    }
  }
  
  
  
  return(
    tablas
  )
  
}
