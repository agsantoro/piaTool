ui_avanzada <- navbarPage(title = "Evaluación de programas e intervenciones priorizadas",
                          id="NVP",
                          
                          theme = shinythemes::shinytheme("united"),
                          
                          
                          
                          tabPanel(
                            id="vhpv",
                            "Vacuna contra el HPV",
                            fluidRow(
                              tags$style(HTML("
                 @import url('https://fonts.googleapis.com/css2?family=Istok+Web&display=swap');

body {
  font-family: 'Istok Web', sans-serif;
}                 
                 
                 .panel-default>.panel-heading {
    color: white;
    background-color: #1D9ADD;
    border-color: white
                 }

.custom-div {
    position: absolute;
    top: 0;
    right: 0;
    width: 100px; /* Adjust the width as needed */
    height: 100px; /* Adjust the height as needed */
    background-color: red;
}
  
#fullpage_popup {
  overflow-y: auto;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  z-index: 9999;
  display: none;
}

.popup-content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 80%; /* Adjust the width as needed */
  max-width: 400px; /* Optionally set a max-width for larger screens */
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}
                 
                 .navbar {background-color:#1D9ADD !important;
                 border-color: #1D9ADD !important;
                 }
                 
                 
                 
                 
                 .navbar-default .navbar-nav>li>a:hover,.navbar-default .navbar-nav>li>a:focus {
    color: blackfff !important;
    background-color: #E95420 !important
                 }

.navbar-default .navbar-nav>.active>a,.navbar-default .navbar-nav>.active>a:hover,.navbar-default .navbar-nav>.active>a:focus {
    color: #ffffff;
    background-color: #E95420 !important
}

.btn-default {
    color: black;
    background-color: white;
    border-color: #aea79f
}

.dropdown-menu>.active>a,.dropdown-menu>.active>a:hover,.dropdown-menu>.active>a:focus {
    
    text-decoration: none;
    outline: 0;
    background-color: #1D9ADD
}


.btn-default:focus,.btn-default.focus {
    color: #ffffff;
    background-color:#f0f0f0;
    border-color: #6f675e
}
.bootstrap-select .dropdown-toggle .filter-option {
    position: static;
    top: 0;
    left: 0;
    float: left;
    height: 100%;
    width: 100%;
    text-align: left;
    overflow: hidden;
    -webkit-box-flex: 0;
    -webkit-flex: 0 1 auto;
    -ms-flex: 0 1 auto;
    flex: 0 1 auto;
    color: black;
}

.btn-default:active,.btn-default.active,.open>.dropdown-toggle.btn-default {
    color: #ffffff;
    background-color: #f0f0f0;
    border-color: #92897e
}

.btn-default:active:hover,.btn-default.active:hover,.open>.dropdown-toggle.btn-default:hover,.btn-default:active:focus,.btn-default.active:focus,.open>.dropdown-toggle.btn-default:focus,.btn-default:active.focus,.btn-default.active.focus,.open>.dropdown-toggle.btn-default.focus {
    color: black;
    background-color: #f0f0f0;
    border-color: #6f675e
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus {
    color: #777777;
    background-color: #ffffff;
    border: 1px solid #dddddd;
    border-bottom-color: transparent;
    cursor: default;
    font-weight: bolder;
}

a, h1, h2, h3, h4, h5 {font-family: 'Istok Web', sans-serif;}

a:hover {
    color: black;
    text-decoration: none;
}

a {color: black}


.dropdown-menu>li>a:hover,.dropdown-menu>li>a:focus {
    text-decoration: none;
    color:black;
    background-color: #f0f0f0
}

.btn-default:hover {
    color: black;
    background-color: #f0f0f0;
    border-color: #92897e;
}



")),
                              useShinyjs(),
                              
                              shiny.i18n::usei18n(i18n),
                              
                              column(11, 
                                     div(
                                       id = "fullpage_popup",
                                       style = "display: none;",
                                       div(
                                         class = "popup-content",
                                         getTextoIntro(),
                                         br(),
                                         
                                         actionButton("volver", "Continuar")
                                       )
                                     ),
                                     h3(tags$b("Evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el VPH")),
                                     div(HTML("<p>Modelo de evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el virus del papiloma humano (VPH) en niñas para la prevención del cáncer de cuello uterino por país. 
                                  <br>Permite evaluar el impacto del aumento de cobertura de vacunación contra el VPH para las niñas en la carga de enfermedad por cáncer de cuello uterino.
                                  <br>Modelo basado en la herramienta Papillomavirus Rapid Interface for Modelling and Economics "),
                                         a(href="https://pubmed.ncbi.nlm.nih.gov/25103394/", "(PRIME)", target = "_blank", style = "text-decoration: underline;"))),
                              
                              column(1,
                                     
                                     
                                     pickerInput("selectedLanguage", "",
                                                 multiple = F,
                                                 choices = c( "en","sp"),
                                                 choicesOpt = list(content =
                                                                     mapply(c("en","sp"), flags, FUN = function(country, flagUrl) {
                                                                       HTML(paste(
                                                                         tags$img(src=flagUrl, width=20, height=15),
                                                                         country
                                                                       ))
                                                                     }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                   
                                                 ),
                                                 selected = "sp"),
                                     align="center")
                            ),
                            
                            br(),
                            tabsetPanel(id="TSP",
                                        tabPanel(
                                          "Parámetros del modelo",
                                          br(),
                                          fluidRow(
                                            column(2, style = "padding-left: 2%;",
                                                   pickerInput("country", 
                                                               "País", 
                                                               multiple = F,
                                                               choices = c("Argentina" ="ARGENTINA",
                                                                           "Brazil" = "BRAZIL",
                                                                           "Chile" = "CHILE", 
                                                                           "Colombia"="COLOMBIA",
                                                                           "Costa Rica" = "COSTA RICA",
                                                                           "Ecuador" = "ECUADOR", 
                                                                           "Mexico" = "MEXICO",
                                                                           "Peru" = "PERU"),
                                                               choicesOpt = list(content =  
                                                                                   mapply(c("Argentina" ="ARGENTINA",
                                                                                            "Brazil" = "BRAZIL",
                                                                                            "Chile" = "CHILE", 
                                                                                            "Colombia"="COLOMBIA",
                                                                                            "Costa Rica" = "COSTA RICA",
                                                                                            "Ecuador" = "ECUADOR", 
                                                                                            "Mexico" = "MEXICO",
                                                                                            "Peru" = "PERU"), flagsDropdown, FUN = function(country, flagUrl) {
                                                                                              HTML(paste(
                                                                                                tags$img(src=flagUrl, width=20, height=15),
                                                                                                str_to_title(country)
                                                                                              ))
                                                                                            }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                                 
                                                               ),
                                                               selected = "Argentina"),
                                                   
                                                   uiOutput("uiOutput")),
                                            column(1),
                                            column(8,
                                                   h3(tags$b("Resultados generales")),
                                                   br(),
                                                   reactableOutput("summaryTable"),
                                                   br(),
                                                   br(),
                                                   br(),
                                                   highchartOutput("grafico"),
                                                   br(),
                                                   hr(),
                                                   br(),
                                                   fluidRow(
                                                     column(4,
                                                            textAreaInput("scenarioName","Nombre:"),
                                                            fluidRow(
                                                              column(12,
                                                                     actionButton("saveScenario2","Guardar"),
                                                                     br(),
                                                                     br(),
                                                                     align = "left")
                                                            ),
                                                            align = "left"),
                                                     column(8, 
                                                            actionButton("saveScenario","Guardar escenario"),
                                                            br(),
                                                            br(),
                                                            align = "Right")
                                                   ), align="center"),
                                            column(1)
                                            
                                          )
                                          
                                        ),
                                        tabPanel(
                                          "Escenarios guardados",
                                          br(),
                                          fluidRow(
                                            column(2,
                                                   selectizeInput("savedScenarios", "Escenarios guardados",choices=c(), multiple = T)),
                                            column(5,
                                                   highchartOutput("scenariosPlotPreVac")),
                                            column(5,
                                                   highchartOutput("scenariosPlotPostVac"))
                                          ),
                                          br(),
                                          fluidRow(
                                            column(2),
                                            column(10,reactableOutput("summaryTableScenarios"))),
                                          br(),
                                          fluidRow(
                                            column(12,
                                                   actionButton("downloadReport", "Descargar .pdf"),
                                                   align = "right"
                                            )
                                          ),
                                          br(),
                                          br()
                                          
                                        ),
                                        tabPanel("Documentación",
                                                 br(),
                                                 fluidRow(
                                                   column(2),
                                                   column(8,htmlOutput("manual")),
                                                   column(2, downloadButton("descargaManual","Descargar manual de usuario"))
                                                   
                                                 ))
                            )
                          ),
                          tabPanel("HEARTS",
                            fluidRow(
                              column(11,
                                     h3(tags$b("Evaluación del impacto epidemiológico y de costo-efectividad del tratamiento farmacológico de la hipertensión arterial en el marco de la iniciativa Global HEARTS")),
                                     HTML('<p>Modelo de evaluación del impacto epidemiológico y de costo-efectividad del control de la presión arterial con tratamiento farmacológico en personas con hipertensión arterial ya diagnosticadas en el marco de la iniciativa HEARTS para la reducción de la mortalidad relacionada con enfermedades cardíacas isquémicas (ECI) y accidentes cerebrovasculares (ACV) por país.<br>Permite evaluar el impacto del aumento de cobertura del tratamiento farmacológico de personas con hipertensión ya diagnosticadas en la carga de enfermedad cardio y cerebrovascular.<br>Modelo basado en las herramientas <a href="https://www.paho.org/es/enlace/herramienta-para-estimar-impacto-control-poblacional-hipertension-mortalidad-por-ecv" target="_blank" style="text-decoration: underline;">"Hypertension: cardiovascular disease EstimaTool (HTN: CVD EstimaTool)"</a> y <a href="https://www.tephinet.org/tephinet-learning-center/tephinet-library/hearts-costing-tool?" target="_blank" style="text-decoration: underline;">"Global HEARTS Costing Tool Version 5.4"</a></p>')
                              ),
                              column(1,
                                     pickerInput("selectedLanguage", "",
                                                 multiple = F,
                                                 choices = c( "en","sp"),
                                                 choicesOpt = list(content =
                                                                     mapply(c("en","sp"), flags, FUN = function(country, flagUrl) {
                                                                       HTML(paste(
                                                                         tags$img(src=flagUrl, width=20, height=15),
                                                                         country
                                                                       ))
                                                                     }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                   
                                                 ),
                                                 selected = "sp"))
                            ),
                            br(),
                            br(),
                            tabsetPanel(id="TSP_HEARTS",
                                        tabPanel(
                                          "Parámetros del modelo", 
                                          br(),
                                          fluidRow(
                                            column(2,style = "padding-left: 2%;",
                                                   pickerInput("hearts_country", 
                                                               "País", 
                                                               multiple = F,
                                                               choices = c("Argentina",
                                                                           "Brazil",
                                                                           "Chile", 
                                                                           "Colombia",
                                                                           "Costa Rica",
                                                                           "Ecuador", 
                                                                           "Mexico",
                                                                           "Peru"),
                                                               choicesOpt = list(content =  
                                                                                   mapply(c("Argentina" ="ARGENTINA",
                                                                                            "Brazil" = "BRAZIL",
                                                                                            "Chile" = "CHILE", 
                                                                                            "Colombia"="COLOMBIA",
                                                                                            "Costa Rica" = "COSTA RICA",
                                                                                            "Ecuador" = "ECUADOR", 
                                                                                            "Mexico" = "MEXICO",
                                                                                            "Peru" = "PERU"), flagsDropdown, FUN = function(country, flagUrl) {
                                                                                              HTML(paste(
                                                                                                tags$img(src=flagUrl, width=20, height=15),
                                                                                                str_to_title(country)
                                                                                              ))
                                                                                            }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                                 
                                                               ),
                                                               selected = "Argentina"),
                                                   uiOutput("hearts_inputs")),
                                            column(1),
                                            column(8,
                                                   h3(tags$b("Resultados generales")),
                                                   br(),
                                                   reactableOutput("hearts_resultados"),
                                                   br(),
                                                   br(),
                                                   br(),
                                                   br(),
                                                   br(),
                                                   plotlyOutput("hearts_grafico_1"),
                                                   br(),
                                                   hr(),
                                                   br(),
                                                   plotlyOutput("hearts_grafico_2"),
                                                   
                                                   br(),
                                                   
                                                   br(),
                                                   fluidRow(
                                                     column(4,
                                                            br(),
                                                            textAreaInput("hearts_scenarioName","Nombre:"),
                                                            fluidRow(
                                                              column(12,
                                                                     actionButton("hearts_saveScenario2","Guardar"),
                                                                     br(),
                                                                     br(),
                                                                     br(),
                                                                     align = "right")
                                                            ),
                                                            align = "left"),
                                                     column(8,
                                                            br(),
                                                            actionButton("hearts_saveScenario","Guardar escenario"),
                                                            br(),
                                                            align = "Right")
                                                   ), align = "center"),
                                            column(1)
                                            
                                            
                                          )
                                          
                                          
                                        ),
                                        tabPanel("Escenarios guardados",
                                                 br(),
                                                 fluidRow(
                                                   column(2,
                                                          selectizeInput("hearts_savedScenarios", "Escenarios guardados",choices=c(), multiple = T)),
                                                   column(10,
                                                          reactableOutput("hearts_table_saved"))),
                                                 br(),
                                                 fluidRow(
                                                   column(12,
                                                          actionButton("hearts_downloadReport", "Descargar .pdf"),
                                                          br(),
                                                          br(),
                                                          align = "right"
                                                   )
                                                 ),
                                                 
                                                 
                                                 
                                        ),
                                        tabPanel("Documentación",
                                                 br(),
                                                 fluidRow(
                                                   column(2),
                                                   column(8,htmlOutput("hearts_manual")),
                                                   column(2, downloadButton("descargaManual_hearts","Descargar manual de usuario"))
                                                   
                                                 )
                                        )
                                        
                            )
                          ),
                          tabPanel(
                            "Hemorragia postparto",
                            fluidRow(
                              shiny.i18n::usei18n(i18n),
                              column(11, 
                                     h3(tags$b("Evaluación del impacto epidemiológico del tratamiento con oxitocina durante el parto")),
                                     HTML('<p>Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna por país. 
                                 <br>Permite evaluar el impacto del aumento de cobertura del uso de oxitocina durante el parto en la carga de enfermedad por hemorragia postparto.</p>')
                              ),
                              
                              column(1,
                                     pickerInput("selectedLanguage", "",
                                                 multiple = F,
                                                 choices = c( "en","sp"),
                                                 choicesOpt = list(content =
                                                                     mapply(c("en","sp"), flags, FUN = function(country, flagUrl) {
                                                                       HTML(paste(
                                                                         tags$img(src=flagUrl, width=20, height=15),
                                                                         country
                                                                       ))
                                                                     }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                   
                                                 ),
                                                 selected="sp"),
                                     align="center"),
                            ),
                            
                            br(),
                            
                            tabsetPanel(id="TSP_HPP",
                                        tabPanel(
                                          "Parámetros del modelo", 
                                          br(),
                                          fluidRow(
                                            column(2,style = "padding-left: 2%;",
                                                   pickerInput("hpp_country", 
                                                               "País", 
                                                               multiple = F,
                                                               choices = c("Argentina",
                                                                           "Brazil",
                                                                           "Chile", 
                                                                           "Colombia",
                                                                           "Costa Rica",
                                                                           "Ecuador", 
                                                                           "Mexico",
                                                                           "Peru"),
                                                               choicesOpt = list(content =  
                                                                                   mapply(c("Argentina" ="ARGENTINA",
                                                                                            "Brazil" = "BRAZIL",
                                                                                            "Chile" = "CHILE", 
                                                                                            "Colombia"="COLOMBIA",
                                                                                            "Costa Rica" = "COSTA RICA",
                                                                                            "Ecuador" = "ECUADOR", 
                                                                                            "Mexico" = "MEXICO",
                                                                                            "Peru" = "PERU"), flagsDropdown, FUN = function(country, flagUrl) {
                                                                                              HTML(paste(
                                                                                                tags$img(src=flagUrl, width=20, height=15),
                                                                                                str_to_title(country)
                                                                                              ))
                                                                                            }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                                 
                                                               )),
                                                   uiOutput("hpp_inputs")),
                                            column(1),
                                            column(8,
                                                   h3(tags$b("Resultados generales")),
                                                   br(),
                                                   reactableOutput("hpp_summaryTable"),
                                                   fluidRow(
                                                     column(12,
                                                            br(),
                                                            br(),
                                                            fluidRow(
                                                              column(6,
                                                                     br(),
                                                                     textAreaInput("hpp_scenarioName","Nombre:"),
                                                                     fluidRow(
                                                                       column(12,
                                                                              actionButton("hpp_saveScenario2","Guardar"),
                                                                              br(),
                                                                              br(),
                                                                              br(),
                                                                              align = "left")
                                                                     ),
                                                                     align = "left"),
                                                              column(6,
                                                                     br(),
                                                                     actionButton("hpp_saveScenario","Guardar escenario"),
                                                                     br(),
                                                                     align = "Right")
                                                            ))
                                                   )
                                            ), align="center",
                                            column(2)
                                            
                                            
                                          ),
                                          
                                          
                                          
                                        ),
                                        tabPanel("Escenarios guardados",
                                                 br(),
                                                 fluidRow(
                                                   column(2,
                                                          selectizeInput("hpp_savedScenarios", "Escenarios guardados",choices=c(), multiple = T)),
                                                   column(10,
                                                          reactableOutput("hpp_table_saved"))),
                                                 br(),
                                                 fluidRow(
                                                   column(12,
                                                          actionButton("hpp_downloadReport", "Descargar .pdf"),
                                                          br(),
                                                          br(),
                                                          align = "right"
                                                   )
                                                 )),
                                        tabPanel("Documentación",
                                                 br(),
                                                 fluidRow(
                                                   column(2),
                                                   column(8,htmlOutput("hpp_manual")),
                                                   column(2, downloadButton("descargaManual_hpp","Descargar manual de usuario"))
                                                   
                                                 )
                                        )
                            )
                            
                          ),
                          
                          
                          
                          tabPanel(
                            "Hepatitis C",
                            fluidRow(
                              shiny.i18n::usei18n(i18n),
                              column(11, 
                                     h3(tags$b("Evaluación del impacto epidemiológico y de costo efectividad del tratamiento de Hepatitis C crónica")),
                                     HTML('<p style="text-align:justify">
  Modelo de evaluación del impacto epidemiológico y de costo-efectividad del tratamiento de Hepatitis C crónica para la reducción de la morbimortalidad por Hepatitis C por país. <br>Permite evaluar el impacto del aumento de la cobertura de tratamiento de Hepatitis C crónica para personas ya diagnosticadas, con distintos estadíos de fibrosis hepática y que nunca han realizado tratamiento, en la carga de enfermedad por Hepatitis C Crónica.
  <br>Basado en el modelo <a href="https://www.hepccalculator.org/about-the-calculators/calculator" target="_blank" style="text-decoration: underline;">“Hep C Calculator”</a>.
</p>')),
                              
                              column(1,
                                     pickerInput("selectedLanguage", "",
                                                 multiple = F,
                                                 choices = c( "en","sp"),
                                                 choicesOpt = list(content =
                                                                     mapply(c("en","sp"), flags, FUN = function(country, flagUrl) {
                                                                       HTML(paste(
                                                                         tags$img(src=flagUrl, width=20, height=15),
                                                                         country
                                                                       ))
                                                                     }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                   
                                                 ),
                                                 selected="sp"),
                                     align="center")
                            ),
                            
                            br(),
                            
                            tabsetPanel(id="TSP_HEPC",
                                        tabPanel(
                                          "Parámetros del modelo", 
                                          br(),
                                          fluidRow(
                                            column(2, tags$style("padding: 2%;)"),
                                                   pickerInput("hepC_country", 
                                                               "País", 
                                                               multiple = F,
                                                               choices = c(#"Argentina",
                                                                 "Brazil",
                                                                 #"Chile", 
                                                                 "Colombia"#,
                                                                 #"Costa Rica",
                                                                 #"Ecuador", 
                                                                 #"Mexico",
                                                                 #"Peru"
                                                               ),
                                                               choicesOpt = list(content =  
                                                                                   mapply(c(#"Argentina" ="ARGENTINA",
                                                                                     "Brazil" = "BRAZIL",
                                                                                     #"Chile" = "CHILE", 
                                                                                     "Colombia"="COLOMBIA"#,
                                                                                     #"Costa Rica" = "COSTA RICA",
                                                                                     #"Ecuador" = "ECUADOR", 
                                                                                     #"Mexico" = "MEXICO",
                                                                                     #"Peru" = "PERU"
                                                                                   ), flagsDropdown[c(2,4)], FUN = function(country, flagUrl) {
                                                                                     HTML(paste(
                                                                                       tags$img(src=flagUrl, width=20, height=15),
                                                                                       str_to_title(country)
                                                                                     ))
                                                                                   }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                                                                 
                                                               )),
                                                   uiOutput("hepC_inputs")),
                                            column(1),        
                                            column(8,
                                                   h3(tags$b("Resultados generales")),
                                                   br(),
                                                   reactableOutput("hepC_summaryTable"),
                                                   
                                                   column(12,
                                                          br(),
                                                          actionButton("hepC_saveScenario","Guardar escenario"),
                                                          br(),
                                                          align = "Right"),
                                                   fluidRow(
                                                     column(6,
                                                            br(),
                                                            textAreaInput("hepC_scenarioName","Nombre:"),
                                                            actionButton("hepC_saveScenario2","Guardar"),
                                                            align = "left")
                                                   )
                                            ),
                                            column(1)
                                          ),
                                          fluidRow(
                                            column(4),
                                            column(6,
                                                   br(),
                                                   br(),
                                                   
                                                   
                                            )
                                          )
                                          
                                          
                                        ),
                                        tabPanel("Escenarios guardados",
                                                 br(),
                                                 fluidRow(
                                                   column(2,
                                                          selectizeInput("hepC_savedScenarios", "Escenarios guardados",choices=c(), multiple = T)),
                                                   column(10,
                                                          reactableOutput("hepC_table_saved"))),
                                                 br(),
                                                 fluidRow(
                                                   column(12,
                                                          actionButton("hepC_downloadReport", "Descargar .pdf"),
                                                          br(),
                                                          br(),
                                                          align = "right"
                                                   )
                                                 )),
                                        tabPanel("Documentación",
                                                 br(),
                                                 fluidRow(
                                                   column(2),
                                                   column(8,htmlOutput("hepC_manual")),
                                                   column(2, downloadButton("descargaManual_hepC","Descargar manual de usuario"))
                                                   
                                                 )
                                        )
                            )
                          )
                          
                          
                          
                          
                          
                          
)
