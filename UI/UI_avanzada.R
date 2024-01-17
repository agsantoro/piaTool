library("htmltools")
library("bsplus")

ui_avanzada <- 
  navbarPage(
  id="NVP", 
  
  title = HTML('Programme Impact Assessment Tool (PIA Tool)'),
  tabPanel(
    
    HTML('<div class = "text-white")>Definición de escenarios</div>'),
    
    # fluidRow(column(12,
    #                 tags$header(class="text-5xl flex justify-between items-center p-8", style="background-color: #1D9ADD; color: white; text-align: center",
    #                             tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("PAHO Programme Impact Assessment Tool (PIA Tool)")),
    #                             tags$a(id="prueba", class="py-2 px-4 text-3xl text-white focus:text-sky-700 cursor-pointer", href="#!/", icon("home"))
    #                 ))),
    fluidRow(
      tags$style(getStyle()),
    #   column(12,
    #          tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
    #                      tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Intervención")),
    #                      tags$div(class="py-2 px-4 text-3xl text-white focus:text-sky-700")
    #          )
    #   )
    ),
    fluidRow(class = "bg-slate-200 mb-10",
      column(2,
             br(),
             pickerInput(
               inputId = "intervencion",
               label = "Seleccionar intervención:", 
               choices = c("Vacuna contra el HPV","HEARTS","Hemorragia postparto","Hepatitis C","Profilaxis Pre Exposición VIH", "VDOT Tuberculosis"),
               choicesOpt = list(
                 content = c(paste(icon("syringe"),"Vacuna contra el HPV"),
                             paste(icon("heart"),"HEARTS"),
                             paste(icon("female"),"Hemorragia postparto"),
                             paste(icon("virus"),"Hepatitis C"),
                             paste(icon("pills"),"Profilaxis Pre Exposición VIH"),
                             paste(icon("tv"),"VDOT Tuberculosis")
                             
                 )
               ),
               
             )
             
      ),
      column(2,
             br(),
             pickerInput("country", 
                         "Seleccionar país:",
                         
                         choices = c("Argentina" ="ARGENTINA",
                                     "Brazil" = "BRAZIL",
                                     "Chile" = "CHILE",
                                     "Colombia"="COLOMBIA",
                                     "Costa Rica" = "COSTA RICA",
                                     "Ecuador" = "ECUADOR",
                                     "Mexico" = "MEXICO",
                                     "Peru" = "PERU"
                         ),
                         choicesOpt = list(content =
                                             c(
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/ar.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Argentina</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/br.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Brazil</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/cl.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Chile</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/co.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Colombia</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/cr.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Costa Rica</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/ec.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Ecuador</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/mx.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Mexico</p></div>'),
                                               HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/pe.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Peru</p></div>')
                                               
                                               
                                             )
                                           
                                           
                         ),
                         selected = NULL,
                         multiple = TRUE,
                         options = pickerOptions(
                           maxOptions = 1,
                           noneSelectedText = "Elegir país")),
             br()),
      
      column(2,
             br(),
             br()),
      column(2,
             br()),
      column(2,
             br(),
             br())
      
      
      
      # fluidRow(
      #   column(12,
      #          tags$div(
      #            class = "bg-gray-200 p-4  w-full opacity-80", style = "z-index: 1;",
      #            tags$div(
      #              class = "flex justify-center",
      #              tags$div(
      #                class = "inline-block bg-blue-500 text-white px-4 py-2 mx-2 hover:bg-blue-700 cursor-pointer",
      #                actionLink(inputId = "saveScenario",label="Guardar escenario", class = "text-white hover:text-white")
      #              ),
      #              hidden(
      #                tags$div(
      #                  id = "guardar_hpv",
      #                  class = "inline-block bg-slate-500 text-white px-4 py-2 mx-2",
      #                  textInput("scenarioName",""),
      #                  actionButton("saveScenario2","Guardar") 
      #                )
      #              ),
      #              tags$div(
      #                class = "inline-block bg-green-500 text-white px-4 py-2 mx-2 hover:bg-green-700 cursor-pointer",
      #                tags$a(id="ver_escenarios_guardados","Ver escenarios guardados", href = "#!/escenarios_guardados")
      #              ),
      #              tags$div(
      #                class = "inline-block bg-red-500 text-white px-4 py-2 mx-2 hover:bg-red-700 cursor-pointer",
      #                "Ver resultados comparados"
      #              )
      #            )
      #          ))
      # ))
    ),
    fluidRow(id="comenzar_mensaje", tags$p(class="animate-pulse", "Seleccione un país para comenzar...")),
    fluidRow(id = "columna_borde",
      column(2, style='border-right: 1px solid grey; padding-right: 50px;',
             #theme = shinythemes::shinytheme("united"),
             #tags$style(getStyle()),
             
             hidden(
               tags$header(id = "header1", class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                           tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Configuración")),
                           tags$div(class="py-2 px-4 text-3xl text-white focus:text-sky-700")
               )
             ),
             br(),
             
             
             hidden(uiOutput("uiOutput_basica")),
             hidden(
               tags$header(id = "saveScenarioDiv", class="text-1xl flex justify-between items-center p-5 mt-4 bg-slate-400", style="color: white; text-align: center", 
                           tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Guardar escenario")),
                           actionLink(inputId = "saveScenario", label=icon("stream", style = "color: white;"))
               ) 
             ),
             br(),
             hidden(textInput("scenarioName",'Nombre del escenario')),
             column(12,
                    hidden(actionButton("saveScenario2",icon("save"))), align="right"),
             br(),
             br(),
             br()
             
             
             
             
      ),
      column(10,
             class = "px-20",
             
             hidden(
               br(),
               tags$header(id = "header2", class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                           tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Resultados"), )
               )
             ),
             br(),
             hidden(uiOutput("resultados_hpv")),
             hidden(actionButton("saveScenario2","Guardar")),
             br(),
             br())
    )
    
    
  ),
  tabPanel(
    id = "EG",
    HTML('<div class = "text-white")>Escenarios guardados</div>'),
    fluidRow(id = "row_comparacion",
             class = "bg-slate-200 mb-10",
             
             column(10,
                    br(),
                    h1(id = "no_esc", "Defina un escenario para ver los resultados"),
                    hidden(uiOutput("panel_comparacion"))),
             br(),
             column(1),
             column(1,
                    fluidRow(
                      column(6,
                             hidden(downloadButton("descarga_comp", ""))),
                      column(6,
                             hidden(actionButton("restart",icon("redo-alt"))))
                    )
            ),
             br(),
             br()
    ),
    
    fluidRow(style = "padding-top: 15px;",
      column(2),
      column(8,id="columna_resultados_borde",
             hidden(
               tags$header(id = "header_comparacion_resultados", class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                           tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Resultados")),
                           tags$div(class="py-2 px-4 text-3xl text-white focus:text-sky-700")
               ) 
             ),
             br(),
             br(),
             hidden(uiOutput("escenarios_guardados")),
             hidden(uiOutput("inputs_summary_table"))),
      column(2)
             
    )
    
  ),
  # tabPanel(
  #   HTML('<div class = "text-white")>Escenarios comparados</div>'),
  #   
  #   br(),
  #   tags$script(HTML("var header = $('.navbar > .container-fluid');
  #                     header.append('<div style=\"float:right\"><a href=\"#!//\"><img src=\"home-solid.svg\" style=\"float:right;width:27px;height:32px;padding-top:8px;\"> </a></div>');
  #                     console.log(header)")
  #   )
  # ),
  tabPanel(
    HTML('<div class = "text-white")>Documentación</div>'),
    useShinyjs(),
    tags$script(HTML("var header = $('.navbar > .container-fluid');
                      header.append('<div style=\"float:right\"><img src=\"PAHO_logos_bottom_spanish_white2.png\" style=\"float:left;width:7em;\"><a href=\"https://github.com/agsantoro/piaTool\" target=\"_blank\"><img src=\"github-mark-white.png\" style=\"float:right;width:27px;height:32px;padding-top:8px;padding-left:2px;\"> </a><a href=\"#!//\"><img src=\"home-solid.svg\" style=\"float:right;width:27px;height:32px;padding-top:8px;padding-right:2px;\"> </a></div>');
                      console.log(header)")
    ),
    br(),
    
    tabsetPanel(id = "TSP_Manuales",
                type = "pills",
                tabPanel("Vacuna contra el HPV",
                         br(),
                         tags$iframe(src='modelCards/model_card_vacuna_vph.html', 
                                     height=600, 
                                     width="100%",
                                     frameBorder="0")),
                tabPanel("HEARTS",
                         br(),
                         tags$iframe(src='modelCards/model_card_hearts.html', 
                                     height=600, 
                                     width="100%",
                                     frameBorder="0")),
                
                tabPanel("Hepatitis C",
                         br(),
                tags$iframe(src='modelCards/model_card_hepc.html', 
                            height=600, 
                            width="100%",
                            frameBorder="0")
                         ),
                tabPanel("Hemorragia postparto",
                         br(),
                         tags$iframe(src='modelCards/model_card_hpp.html', 
                                     height=600, 
                                     width="100%",
                                     frameBorder="0")),
                tabPanel("Profilaxis Pre Exposición VIH",
                         br(),
                         tags$iframe(src='modelCards/model_card_prep_vih.html', 
                                     height=600, 
                                     width="100%",
                                     frameBorder="0")
                          ),
                tabPanel("VDOT Tuberculosis",
                         br(),
                         tags$iframe(src='modelCards/model_card_vdot_tbc.html', 
                                     height=600, 
                                     width="100%",
                                     frameBorder="0")
                )
    )
  ),
  tags$footer(
    div(style = "display: flex;",
      div(style= "width: 50%;",
        p(
        style = "text-align: left;",
        "PIA Tool v0.4 - Desarrollado por IECS y el Departamento de Evidencia e Inteligencia para la Acción en Salud (PAHO)")
      ),
      div(
        style= "width: 50%;",
        p(
        style = "text-align: right;",
        tags$a("Descargar manual de usuario", href="Manual/manual-PIA_TOOL-v2.pdf", target ="_blank"), 
      ))
    ),
    
    
              align = "left",
              class = "bg-slate-100 opacity-95",
              style = "
                 position:fixed;
                 left: 0;
                 bottom:0;
                 width:100%;
                 height:30px; 
                 color: black;
                 padding: 4px;
                 z-index: 100;
                "),
  
    
    
  
  
  
  
  
)
