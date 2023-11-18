library("htmltools")
library("bsplus")

ui_avanzada <- fluidPage(
  useShinyjs(),
  
  fluidRow(column(12,
                  tags$header(class="text-5xl flex justify-between items-center p-8", style="background-color: #1D9ADD; color: white; text-align: center",
                              tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("PAHO Programme Impact Assessment Tool (PIA Tool)")),
                              tags$a(id="prueba", class="py-2 px-4 text-3xl text-white focus:text-sky-700 cursor-pointer", href="#!/", icon("home"))
                  ))),
  fluidRow(
    column(2,
           tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                       tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Intervención")),
                       tags$div(class="py-2 px-4 text-3xl text-white focus:text-sky-700")
           ),
           br(),
           pickerInput("country", 
                       "Seleccionar país:",
                       multiple = F,
                       choices = c("Argentina" ="ARGENTINA",
                                   "Brazil" = "BRAZIL"
                                   # "Chile" = "CHILE",
                                   # "Colombia"="COLOMBIA",
                                   # "Costa Rica" = "COSTA RICA",
                                   # "Ecuador" = "ECUADOR",
                                   # "Mexico" = "MEXICO",
                                   # "Peru" = "PERU"
                       ),
                       choicesOpt = list(content =
                                           c(
                                             HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/ar.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Argentina</p></div>'),
                                             HTML('<div style="display: flex; align-items: center;"><img src="https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/br.svg" alt="Flag" width="20" height="15" style="margin-right: 5px;"><p>Brazil</p></div>')
                                           )
                                         
                                         
                       ),
                       selected = "Argentina"),
           pickerInput(
             inputId = "intervencion",
             label = "Seleccionar intervención:", 
             choices = c("Vacuna contra el HPV","HEARTS","Hemorragia postparto","Hepatitis C"),
             choicesOpt = list(
               content = c(paste(icon("syringe"),"Vacuna contra el HPV"),
                           paste(icon("heart"),"HEARTS"),
                           paste(icon("female"),"Hemorragia postparto"),
                           paste(icon("virus"),"Hepatitis C")
                           
               )
             )
           )
    ),
    column(2,
           theme = shinythemes::shinytheme("united"),
           tags$style(getStyle()),
           tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                       tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Configuración")),
                       tags$div(class="py-2 px-4 text-3xl text-white focus:text-sky-700")
           ),
           br(),
           
           
           uiOutput("uiOutput_basica")
    ),
    column(8,
           class = "px-20",
           tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center",
                       tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Resultados"))
           ),
           br(),
           uiOutput("resultados_hpv"))
  ),
  fluidRow(
    column(12,
           tags$div(
             class = "bg-gray-200 p-4 fixed bottom-0 left-0 w-full opacity-80", style = "z-index: 1;",
             tags$div(
               class = "flex justify-center",
               tags$div(
                 class = "inline-block bg-blue-500 text-white px-4 py-2 mx-2 hover:bg-blue-700 cursor-pointer",
                 actionLink(inputId = "saveScenario",label="Guardar escenario", class = "text-white hover:text-white")
               ),
               hidden(
                 tags$div(
                   id = "guardar_hpv",
                   class = "inline-block bg-slate-500 text-white px-4 py-2 mx-2",
                   textInput("scenarioName",""),
                   actionButton("saveScenario2","Guardar") 
                 )
               ),
               tags$div(
                 id = "ver_escenarios_guardados",
                 class = "inline-block bg-green-500 text-white px-4 py-2 mx-2 hover:bg-green-700 cursor-pointer",
                 tags$a(id="ver_escenarios_guardados","Ver escenarios guardados", href = "#!/escenarios_guardados")
               ),
               tags$div(
                 class = "inline-block bg-red-500 text-white px-4 py-2 mx-2 hover:bg-red-700 cursor-pointer",
                 "Ver resultados comparados"
               )
             )
           ))
  )
)
