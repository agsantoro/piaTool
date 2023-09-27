library(readxl)
library(dplyr)
library(tidyr)
library(plotly)
library(highcharter)
library(shiny)
library(DT)
library(readxl)
library(shinyjs)
library(shinyWidgets)
library(uuid)
library(shiny.i18n)
library(kableExtra)
library(prime)
library(bsplus)
library(shinyBS)
library(bslib)
library(shinythemes)
library(gfonts)
library(fresh)
library(reactable)
library(stringr)

flagsDropdown <- c(
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/ar.svg",#argentina
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/br.svg",#brasil
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/cl.svg",#chile
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/co.svg",#colombia
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/cr.svg",#costa rica
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/ec.svg",#ecuador
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/mx.svg",#mexico
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/pe.svg"#peru
)

flags <- c(
  "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/gb.svg",
  "https://cdn.jsdelivr.net/gh/lipis/flag-icon-css@master/flags/4x3/es.svg"
)

# load functions
source("functions/getPrime.R")
source("functions/roundUpNice.R")
source("functions/generateRMD.R")
source("estimaTool/estimaTool.R")
source("hpp/funciones/funciones.R")
source("hepC/funcion_hepC.R", .GlobalEnv)

charts_theme <- hc_theme(
  chart = list(
    style = list(
      fontFamily = "Istok Web"
    )
  )
)


i18n <- Translator$new(translation_json_path='translation.json')
i18n$set_translation_language('sp')



##### APP #####

ui <- navbarPage(title = "Evaluación de programas e intervenciones priorizadas",
                 
                 
                 theme = shinythemes::shinytheme("united"),
                 
                 
                 
                 tabPanel(
                   
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
    border-color: #92897e
}



")),
                     useShinyjs(),
                     
                     shiny.i18n::usei18n(i18n),
                     
                     column(11, 
                            h3(tags$b(i18n$t("HPV Vaccination cost-effective assessment from the World Health Organisation"))),
                            HTML("<h5>Modelo de evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el virus del papiloma humano (VPH) en niñas para la prevención del cáncer de cuello uterino por país. 
                               <br>Permite evaluar el impacto del aumento de cobertura de la vacunación contra el VPH para las niñas en la carga del cáncer cervicouterino y sus costos.<h5/>")),
                     
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
                                 "Escenario principal",
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
                                          downloadButton("downloadReport", "Descargar .pdf"),
                                          align = "right"
                                   )
                                 ),
                                 br(),
                                 br()
                                 
                               ),
                               tabPanel("Metodología",
                                        br(),
                                        fluidRow(
                                          htmlOutput("manual")
                                        ))
                   )
                 ),
                 tabPanel(
                   "Iniciativa Global HEARTS",
                   fluidRow(
                     column(11,h3(tags$b(i18n$t("Iniciativa Global HEARTS"))),
                            HTML("<h5>Modelo de evaluación del impacto epidemiológico y de costo-efectividad del control de la presión arterial con tratamiento farmacológico en personas con hipertensión arterial ya diagnosticadas en el marco de la iniciativa HEARTS para la reducción de la mortalidad relacionada con enfermedades cardíacas isquémicas (ECI) y accidentes cerebrovasculares (ACV) por país. 
                               <br>Permite evaluar el impacto del aumento de cobertura del tratamiento farmacológico de personas con hipertensión ya diagnosticadas en la carga de enfermedad cerebro y cardiovascular y sus costos.<h5/>"))
                   ),
                   br(),
                   br(),
                   tabsetPanel(id="TSP_HEARTS",
                               tabPanel(
                                 "Escenario principal", 
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
                                          highchartOutput("hearts_grafico_1"),
                                          hr(),
                                          br(),
                                          highchartOutput("hearts_grafico_2"),
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
                                                 reactableOutput("hearts_table_saved")))),
                               tabPanel("Metodología",
                                        br(),
                                        fluidRow(
                                          htmlOutput("hearts_manual")
                                        ))
                   )
                 ),
                 tabPanel(
                   "Hemorragia postparto",
                   fluidRow(
                     shiny.i18n::usei18n(i18n),
                     column(11, 
                            h3(tags$b(i18n$t("Hemorragia posparto"))),
                            HTML("<h5>Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna por país.
                               <br>Permite evaluar el impacto del aumento de cobertura del uso de oxitocina durante el parto en la carga de enfermedad por hemorragia posparto.<h5/>")
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
                                                          
                                        )),
                            align="center"),
                   ),
                   
                   br(),
                   
                   tabsetPanel(id="TSP_HPP",
                               tabPanel(
                                 "Escenario principal", 
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
                                                 htmlOutput("hpp_table_saved")))),
                               tabPanel("Metodología",
                                        br(),
                                        fluidRow(
                                          htmlOutput("hpp_manual")
                                        ))
                   )
                   
                 ),
                 
                 
                 
                 tabPanel(
                   "Hepatitis C",
                   fluidRow(
                     shiny.i18n::usei18n(i18n),
                     column(11, h3(("Hepatitis C"))),
                     
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
                                                          
                                        )),
                            align="center")
                   ),
                   
                   br(),
                   
                   tabsetPanel(id="TSP_HEPC",
                               tabPanel(
                                 "Escenario principal", 
                                 br(),
                                 fluidRow(
                                   column(4,
                                          selectInput(
                                            "hepC_country",
                                            "Seleccionar país",
                                            c("Brazil","Colombia"),
                                            selected = "Brazil"
                                          ),
                                          uiOutput("hepC_inputs")),
                                   column(6,
                                          DT::dataTableOutput("hepC_summaryTable"),
                                          
                                          column(12,
                                                 br(),
                                                 actionButton("hepC_saveScenario","Guardar escenario"),
                                                 br(),
                                                 align = "Right"),
                                          fluidRow(
                                            column(6,
                                                   br(),
                                                   textAreaInput("hepC_scenarioName","Nombre:"),
                                                   
                                                   align = "left"),
                                            fluidRow(
                                              column(12,
                                                     actionButton("hepC_saveScenario2","Guardar"),
                                                     br(),
                                                     br(),
                                                     br(),
                                                     align = "right")
                                            )
                                          )
                                   )
                                 ),
                                 fluidRow(
                                   column(4),
                                   column(6,
                                          br(),
                                          br(),
                                          
                                          
                                   )
                                 ),
                                 
                                 
                               ),
                               tabPanel("Escenarios guardados",
                                        br(),
                                        fluidRow(
                                          column(2,
                                                 selectizeInput("hepC_savedScenarios", "Escenarios guardados",choices=c(), multiple = T)),
                                          column(10,
                                                 htmlOutput("hepC_table_saved")))),
                               tabPanel("Metodología",
                                        br(),
                                        fluidRow(
                                          htmlOutput("hepC_manual")
                                        ))
                   )
                   
                 )
                 
                 
                 
)

server <- function(input, output, session) {
  
  output$hepC_inputs = renderUI({
    input_names = c("aCostoDC", "aCostoF0F2", "aCostoF3", "aCostoF4", "aCostoHCC", "AtasaDescuento", 
                    "cohorte", "Costo_Evaluacion", "Costo_Tratamiento", "F0", "F1", "F2", "F3", "F4", 
                    "pAbandono", "pais", "pSVR", "tDuracion_Meses")
    default = list()
    default$cohorte = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="Cohorte"]
    default$AtasaDescuento = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="Descuento"]
    default$F0 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="F0"]
    default$F1 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="F1"]
    default$F2 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="F2"]
    default$F3 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="F3"]
    default$F4 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="epi" & datosPais$indicador=="CC"]
    default$aCostoF0F2 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="F0-F2"]
    default$aCostoF3 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="F3"]
    default$aCostoF4 = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="F4"]
    default$aCostoDC = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="DC"]
    default$aCostoHCC = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="HCC"]
    default$pSVR = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="tratamiento" & datosPais$indicador=="SVR"]
    default$tDuracion_Meses = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="tratamiento" & datosPais$indicador=="Duracion Meses"]
    default$pAbandono = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="tratamiento" & datosPais$indicador=="%Abandono"]
    default$Costo_Tratamiento = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="Costo Mensual"]
    default$Costo_Evaluacion = datosPais$valor[datosPais$pais==input$hepC_country & datosPais$dimension=="costos" & datosPais$indicador=="Assesment"]
    
    tagList({
      lapply(input_names, function(i) {
        numericInput(
          i,
          i,
          default[[i]]
          
        )
      })
    })
  })
  
  hepC_run = reactive({
    if (length(input$cohorte) > 0) {
      hepC = hepC_full(
        input,
        output,
        input_pais = input$hepC_country,
        input_cohorte = input$cohorte,
        input_AtasaDescuento = input$AtasaDescuento,
        input_F0 = input$F0,
        input_F1 = input$F1,
        input_F2 = input$F2,
        input_F3 = input$F3,
        input_F4 = input$F4,
        input_aCostoF0F2 = input$aCostoF0F2,
        input_aCostoF3 = input$aCostoF3,
        input_aCostoF4 = input$aCostoF4,
        input_aCostoDC = input$aCostoDC,
        input_aCostoHCC = input$aCostoHCC,
        input_pSVR = input$pSVR,
        input_tDuracion_Meses = input$tDuracion_Meses,
        input_pAbandono = input$pAbandono,
        input_Costo_Tratamiento = input$Costo_Tratamiento,
        input_Costo_Evaluacion = input$Costo_Evaluacion
      )
      
      hepC_indicators = names(hepC$Comparacion)
      hepC_values = unlist(hepC$Comparacion)
      
      hepCTable = data.frame(
        hepC_indicators,
        hepC_values
      )
      
      rownames(hepCTable) = NULL
      colnames(hepCTable) = c("Indicador", "Valor")
      hepCTable
    }
    
    
  })
  
  output$hepC_summaryTable = DT::renderDataTable({
    
    DT::datatable(hepC_run())
  })
  
  hpp_run = reactive({
    
    paste(input$hpp_costoIntervencion,
          input$hpp_country,
          input$hpp_descuento,
          input$hpp_uso_oxitocina_base,
          input$hpp_uso_oxitocina_taget)
    
    
    if (length(input$hpp_costoIntervencion)>0) {
      resultados = resultados_comparados(input$hpp_country,
                                         input$hpp_uso_oxitocina_base,
                                         input$hpp_uso_oxitocina_taget,
                                         input$hpp_descuento,
                                         input$hpp_costoIntervencion)
      
      data.frame(
        Indicador = c("Costo promedio de un evento de Hemorragia Post Parto",
                      "Perdida de Qaly por un evento de Hemorragia Post Parto",
                      "Diferencia de costo",
                      "Hemorragias Post Parto Evitadas",
                      "Muertes por Hemorragias Post Parto Evitadas",
                      "Histerectomias por Hemorragias Post Parto Evitadas",
                      "Años de vida por muerte prematura salvados",
                      "Años de vida por discapacidad salvados"),
        Valor = c(resultados$base$"Costo_HPP",
                  resultados$base$"Dalys_Total",
                  resultados[["comparacion"]][["Diferencia de costo"]],
                  resultados[["comparacion"]][["Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Muertes por Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Histerectomias por Hemorragias Post Parto Evitadas"]],
                  resultados[["comparacion"]][["Años de vida por muerte prematura salvados"]],
                  resultados[["comparacion"]][["Años de vida por discapacidad salvados"]])
      )
    }
    
  })
  
  
  output$hpp_inputs = renderUI({
    load("hpp/data/datosPais.RData")
    datosPais = datosPais %>% dplyr::filter(pais==input$hpp_country)
    
    nombres_input = c(
      "hpp_descuento",
      "hpp_costoIntervencion",
      "hpp_uso_oxitocina_base",
      "hpp_uso_oxitocina_taget" 
      
    )
    
    label_inputs = c(
      "Descuento",
      "Costo de la intervención",
      "Cobertura actual del uso de oxitocina (%)",
      "Cobertura esperada del uso de oxitocina (%)"
    )
    
    defaults = c(
      0.05,
      0,
      datosPais$value[4],
      .80339
    )
    
    tagList(
      bsCollapse(
        id="hpp_collapse",
        open="Parámetros básicos",
        bsCollapsePanel(
          title = "Parámetros básicos",
          lapply(3:4, function(i) {
            numericInput(nombres_input[i],label_inputs[i],defaults[i])
          })    
        ),
        bsCollapsePanel(
          title = "Parámetros avanzados",
          lapply(1:2, function(i) {
            numericInput(nombres_input[i],label_inputs[i],defaults[i])
          })    
        )
      )
      
    )
    
    
  })
  
  output$hpp_summaryTable = renderReactable({
    if (length(hpp_run())>1) {
      table = hpp_run()
      table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
      
      cat_epi = c(2,4:8)
      cat_costos = c(1,3)
      
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
          Indicador = colDef(name = "Indicador", align = "left"),
          Valor = colDef(name = "Valor", align = "right")
        ),
        bordered = TRUE,
        highlight = TRUE
      )
    }
    
  })
  
  
  
  observeEvent(list(input$vaccinePricePerFIG,input$vaccineDeliveryCostPerFIG),{
    shinyjs::enable("totalVaccineCostPerFIG")
    updateNumericInput(session,"totalVaccineCostPerFIG",value=input$vaccinePricePerFIG+input$vaccineDeliveryCostPerFIG)
    shinyjs::disable("totalVaccineCostPerFIG")
  })
  
  observeEvent(input$selectedLanguage, {
    update_lang(
      language = input$selectedLanguage,
      session)
  })
  
  observeEvent(input$TSP, {
    updateSelectInput(session,"savedScenarios",choices = names(scenarios$savedScenarios), selected = names(scenarios$savedScenarios))
    
  })
  
  observeEvent(input$TSP_HEARTS, {
    updateSelectInput(session,"hearts_savedScenarios",choices = names(hearts_scenarios$savedScenarios), selected = names(hearts_scenarios$savedScenarios))
    enable("hearts_savedScenarios")
  })
  
  observeEvent(input$TSP_HPP, {
    updateSelectInput(session,"hpp_savedScenarios",choices = names(hpp_scenarios$savedScenarios), selected = names(hpp_scenarios$savedScenarios))
    if (length(hpp_scenarios$savedScenarios)>0) {enable("hpp_savedScenarios")}
  })
  
  observeEvent(input$TSP_HEPC, {
    updateSelectInput(session,"hepC_savedScenarios",choices = names(hepC_scenarios$savedScenarios), selected = names(hepC_scenarios$savedScenarios))
    if (length(hepC_scenarios$savedScenarios)>0) {enable("hepC_savedScenarios")}
  })
  
  resultados  <-  reactive({
    getPrime(
      input,
      input$country,
      input$birthCohortSizeFemale,
      input$cohortSizeAtVaccinationAgeFemale,
      input$coverageAllDosis,
      input$vaccineEfficacyVsHPV16_18,
      input$targetAgeGroup,
      input$vaccinePricePerFIG,
      input$vaccineDeliveryCostPerFIG,
      input$totalVaccineCostPerFIG,
      input$cancerTreatmentCostPerEpisodeOverLifetime,
      input$DALYsForCancerDiagnosis,
      input$DALYsForNonTerminalCancerSequelaePperYear,
      input$DALYsForTerminalCancer,
      input$discountRate,
      input$proportionOfCervicalCancerCasesThatAreDueToHPV16_18,
      input$GDPPerCapita,
      mortall,
      mortcecx,
      incidence,
      dalys,
      parameters
    )
  })
  
  hide("scenarioName")
  hide("saveScenario2")
  hide("hearts_scenarioName")
  hide("hearts_saveScenario2")
  hide("hpp_scenarioName")
  hide("hpp_saveScenario2")
  hide("hepC_scenarioName")
  hide("hepC_saveScenario2")
  
  observeEvent(input$saveScenario, {
    show("scenarioName", anim = T, animType = "fade")
    show("saveScenario2", anim = T, animType = "fade")
    hide("saveScenario", anim = T, animType = "fade")
  })
  
  observeEvent(input$hearts_saveScenario, {
    show("hearts_scenarioName", anim = T, animType = "fade")
    show("hearts_saveScenario2", anim = T, animType = "fade")
    hide("hearts_saveScenario", anim = T, animType = "fade")
  })
  
  observeEvent(input$hpp_saveScenario, {
    show("hpp_scenarioName", anim = T, animType = "fade")
    show("hpp_saveScenario2", anim = T, animType = "fade")
    hide("hpp_saveScenario", anim = T, animType = "fade")
  })
  
  observeEvent(input$hepC_saveScenario, {
    show("hepC_scenarioName", anim = T, animType = "fade")
    show("hepC_saveScenario2", anim = T, animType = "fade")
    hide("hepC_saveScenario", anim = T, animType = "fade")
  })
  
  scenarios = reactiveValues()
  hearts_scenarios = reactiveValues()
  hpp_scenarios = reactiveValues()
  hepC_scenarios = reactiveValues()
  
  scenarios$savedScenarios = list()
  scenarios$summaryTable = data.frame()
  
  hearts_scenarios$savedScenarios = list()
  
  hpp_scenarios$savedScenarios = list()
  hepC_scenarios$savedScenarios = list()
  
  observeEvent(input$saveScenario2, {
    if (input$scenarioName !="") {
      scnID = UUIDgenerate()
      scnName = input$scenarioName
      scenarios$savedScenarios[[scnName]] <- resultados()
      summaryScenarios = data.frame(outcomes=scenarios$savedScenarios[[1]]$outcomes[[1]])
      
      for (i in names(scenarios$savedScenarios)){
        summaryScenarios = cbind(summaryScenarios,data.frame(scenarios$savedScenarios[[i]]$outcomes[,"undisc"]))
      }
      
      colnames(summaryScenarios)[2:ncol(summaryScenarios)] = names(scenarios$savedScenarios)
      colnames(summaryScenarios)[1] = "Outcomes"
      summaryScenarios = summaryScenarios %>% mutate(across(c(2:ncol(summaryScenarios)), function(x) format(round(x,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)))
      
      if (is.null(input$savedScenarios)) {
        scenarios$summaryTable = summaryScenarios   
      } else {
        scenarios$summaryTable = summaryScenarios[,c("Outcomes",names(scenarios$savedScenarios))]   
      }
      
      
      sendSweetAlert(
        session = session,
        title = "Escenario guardado",
        text = paste0("Nombre: ",scnName),
        type = "success",
        btn_labels = "Continuar",
        btn_colors = "#E95420"
        
      )
      
      hide("scenarioName", anim = T, animType = "fade")
      hide("saveScenario2", anim = T, animType = "fade")
      show("saveScenario", anim = T, animType = "fade")
      updateTextAreaInput(session,"scenarioName",value="")  
    } else {
      sendSweetAlert(
        session = session,
        title = "",
        text = "Debe definir un nombre para guardar el escenario.",
        type = "error"
      )
      hide("scenarioName", anim = T, animType = "fade")
      hide("saveScenario2", anim = T, animType = "fade")
      show("saveScenario", anim = T, animType = "fade")
    }
    
  })
  
  
  
  
  
  
  parametersReactive <- reactive({
    paramsList = list(
      birthCohortSizeFemale = as.numeric(parameters[parameters$Country==input$country,8]),
      cohortSizeAtVaccinationAgeFemale = as.numeric(parameters[parameters$Country==input$country,10]),
      coverageAllDosis = as.numeric(parameters[parameters$Country==input$country,11]),
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
  })
  
  output$uiOutput <- renderUI({
    
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
      "The number of female newborns in the country in the base year",
      "The number of females in the country at the age at which routine vaccination is given (based on the age in 'Target age group')",
      "The expected proportion of girls in the relevant age group who will receive the full course of the vaccine (either 2 or 3 doses)",
      "The proportionate reduction in risk of cervical cancers due to HPV 16/18 in vaccinees. This should normally be 100%",
      "The age at which HPV vaccines are normally given. Note that PRIME is only suitable to be used to look at HPV vaccines delivered to girls in the WHO recommended ages of 9-13 years old",
      "The procurement cost to purchase enough vaccines (either 2 or 3 doses) to fully vaccinate one girl",
      "The cost of delivering and administering enough vaccines (either 2 or 3 doses) to fully vaccinate one girl",
      "The total cost to purchase enough vaccines (either 2 or 3 doses) to fully vaccinate on girl. This is automatically calculated as the sum of the procurement and delivery cost",
      "The cost on average to treat a woman with cervical cancer, from diagnosis to death",
      "DALYS incurred for a year of life in which cervical cancer is diagnosed. Advice from a health economist is recommended before altering this parameter",
      "DALYS incurred for a year of life following the year in which cervical cancer is diagnosed, assuming the cancer is non-terminal. This may vary depending on the country. Advice from a health economist is recommended before altering this parameter",
      "DALYS incurred for a year of life immediately prior to dying from terminal cervical cancer. Advice from a health economist is recommended before altering this parameter",
      "The rate representing society’s preference for consumption and health gains in the present rather than in the future. WHO recommends a rate of 3% per annum",
      "The proportion of cervical cancer cases diagnosed in the base year that are caused by HPV 16 or 18 infection",
      "The value of all the goods and services produced in the country divided by the total population"
    )
    
    tagList(
      bsCollapse(
        id="prueba",
        open="Parámetros básicos",
        bsCollapsePanel(
          
          title = "Parámetros básicos",
          lapply(1:3, function (i) {
            if (!i %in% c(3,4)) {
              numericInput(input=names(parametersReactive())[i],
                           tags$div(
                             inputs_names[i],
                             tags$i(
                               class = "fas fa-circle-info",
                               style = "color:#0072B2;",
                               title = inputs_hover[i]
                             )
                           )
                           ,
                           value = parametersReactive()[[i]])
            } else {
              sliderInput(input=names(parametersReactive())[i],
                          label=tags$div(
                            inputs_names[i],
                            tags$i(
                              class = "fas fa-circle-info",
                              style = "color:#0072B2;",
                              title = inputs_hover[i]
                            )
                          ),
                          min = 0,
                          max= 1,
                          value=parametersReactive()[[i]])}
          })
        )
        
      ),
      bsCollapse(
        id="prueba",
        bsCollapsePanel(
          title = "Parámetros avanzados",
          lapply(4:15, function (i) {
            if (!i %in% c(3,4)) {
              numericInput(input=names(parametersReactive())[i],
                           tags$div(
                             inputs_names[i],
                             tags$i(
                               class = "fas fa-circle-info",
                               style = "color:#0072B2;",
                               title = inputs_hover[i]
                             )
                           )
                           ,
                           value = parametersReactive()[[i]])
            } else {
              sliderInput(input=names(parametersReactive())[i],
                          label=tags$div(
                            inputs_names[i],
                            tags$i(
                              class = "fas fa-circle-info",
                              style = "color:#0072B2;",
                              title = inputs_hover[i]
                            )
                          ),
                          min = 0,
                          max= 1,
                          value=parametersReactive()[[i]])}
          })
        )
        
      )

    )
    
  })
  
  output$grafico <- renderHighchart({
    if (length(input$proportionOfCervicalCancerCasesThatAreDueToHPV16_18)>0) {
      resultados()$plot
    } else {
      NULL
    }
  })
  
  output$summaryTable <- renderReactable ({
    if (length(input$birthCohortSizeFemale)>0) {
      table = resultados()$outcomes
      table$disc = format(round(table$disc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
      table$undisc = format(round(table$undisc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
      
      colnames(table) = c("Outcomes", "Undiscounted", "Discounted")
      
      cat_input = c(1,2,3,14)
      cat_epi = c(6,7,8)
      cat_costos = c(4,5,9,10,11,12,13)
      
      table$cat=""
      table$cat[cat_input] = "Inputs"
      table$cat[cat_epi] = "Resultados epidemiológicos"
      table$cat[cat_costos] = "Resultados económicos"
      table$Discounted[cat_input] = "-"
      
      
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
  })
  
  observeEvent(input$TSP, {
    enable("savedScenarios")
    
    output$scenariosPlotPreVac <- renderHighchart({
      if (length(scenarios$savedScenarios)>0) {
        maxY = c()
        for (i in names(scenarios$savedScenarios)) {
          maxY=c(maxY,scenarios$savedScenarios[[i]]$dataPlot$y1)
        }
        
        for (i in names(scenarios$savedScenarios)) {
          maxY=c(maxY,scenarios$savedScenarios[[i]]$dataPlot$y2)
        }
        
        maxY = roundUpNice(max(maxY[is.na(maxY)==F]))
        
        plot = highchart()
        for (i in input$savedScenarios) {
          plot = plot %>% hc_add_series(data = scenarios$savedScenarios[[i]]$dataPlot, name=names(scenarios$savedScenarios[i]), type = "line", hcaes(x = x, y = y1)) %>% hc_xAxis(min = 0, max = 80) %>% hc_yAxis(min = 0, max = maxY)
        }
        
        plot %>% hc_title(
          text = "Efecto de la vacunación en la incidencia del cáncer de cuello de útero por edad",
          margin = 20,
          align = "left",
          style = list(color = "black", useHTML = TRUE)
        ) %>% hc_add_theme(charts_theme)
      }
      
    })
    
    output$scenariosPlotPostVac <- renderHighchart({
      if (length(scenarios$savedScenarios)>0) {
        
        maxY = c()
        for (i in names(scenarios$savedScenarios)) {
          maxY=c(maxY,scenarios$savedScenarios[[i]]$dataPlot$y1)
        }
        
        for (i in names(scenarios$savedScenarios)) {
          maxY=c(maxY,scenarios$savedScenarios[[i]]$dataPlot$y2)
        }
        
        maxY = roundUpNice(max(maxY[is.na(maxY)==F]))
        
        
        plot = highchart()
        for (i in input$savedScenarios) {
          plot = plot %>% hc_add_series(data = scenarios$savedScenarios[[i]]$dataPlot, name=names(scenarios$savedScenarios[i]), type = "line", hcaes(x = x, y = y2)) %>% hc_xAxis(min = 0, max = 80) %>% hc_yAxis(min = 0, max = maxY)
        }
        
        plot %>% hc_title(
          text = "Efecto de la vacunación en la incidencia del cáncer de cuello de útero por edad",
          margin = 20,
          align = "left",
          style = list(color = "black", useHTML = TRUE)
        )
      } else {disable("savedScenarios")}
    })
    
    output$summaryTableScenarios <- renderReactable({
      if (length(scenarios$savedScenarios)>0) {
        if (is.null(input$savedScenarios)) {
          snSelected = colnames(scenarios$summaryTable)
        } else {
          snSelected = c(colnames(scenarios$summaryTable)[1], input$savedScenarios)
        }
        
        table = scenarios$summaryTable[,snSelected]
        cat_input = c(1,2,3,14)
        cat_epi = c(6,7,8)
        cat_costos = c(4,5,9,10,11,12,13)
        
        table$cat=""
        table$cat[cat_input] = "Inputs"
        table$cat[cat_epi] = "Resultados epidemiológicos"
        table$cat[cat_costos] = "Resultados económicos"
        
        columns = list(
          cat = colDef(name = "Categoría", align = "left"),
          Outcomes = colDef(name = "Indicador", align = "left")
        )
        
        for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
          columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
        }
        reactable(
          table,
          groupBy = "cat",
          defaultExpanded = T,
          pagination = F,
          columnGroups = list(
            colGroup("Escenarios", columns = colnames(table)[setdiff(1:ncol(table),c(1,ncol(table)))], sticky = "left",
                     headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
          ),
          defaultColDef = colDef(
            align = "center",
            minWidth = 70,
            headerStyle = list(background = "#236292", color = "white")
          ),
          columns = columns,
          bordered = TRUE,
          highlight = TRUE
        )
        
       
        
      } else {disable("savedScenarios")}
    })
    
    output$downloadReport <- downloadHandler(
      filename = function() {
        "report.pdf"
      },
      content = function(file) {
        
        tableScn <- scenarios$summaryTable
        tableScn <<- tableScn
        
        dataPlot = data.frame(Scenario = NA,
                              Age = NA,
                              Undiscounted = NA)
        
        dataInputs = data.frame(
          Scenario = NA,
          Input = NA,
          Value = NA
        )
        for (i in input$savedScenarios) {
          dataPlot = union_all(
            data.frame(Scenario = i,
                       Age = scenarios$savedScenarios[[i]][["dataPlot"]]$x,
                       Undiscounted = scenarios$savedScenarios[[i]][["dataPlot"]]$y1),
            dataPlot)
          
          dataInputs = union_all(
            data.frame(Scenario = i,
                       Input = scenarios$savedScenarios[[i]][["inputsTable"]]$Input,
                       Value = scenarios$savedScenarios[[i]][["inputsTable"]]$Value),
            dataInputs)
        }
        
        dataInputs <<- pivot_wider(
          dataInputs %>% dplyr::filter(is.na(Scenario)==F),
          names_from = "Scenario",
          values_from = Value) 
        
        plotUndisc <<- ggplot(
          dataPlot[is.na(dataPlot$Scenario)==F,],
          aes(
            x=Age,
            y=Undiscounted,
            color = factor(Scenario)
          )) + geom_line() + theme_minimal() + theme(legend.title=element_blank()) +
          labs(x = "Age", y = "Scenario") 
        
        title <- "Scenario report"
        intro <- "Description: Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede."
        author <- "Prime tool"
        outputFormat <- "pdf_document"
        plotChunk <- 'plotUndisc'
        tableChunk1 <- "knitr::kable(dataInputs, format = 'latex')"
        tableChunk2 <- "knitr::kable(tableScn,format = 'latex')"
        rendered_file <- generateRMD(title, author, intro, outputFormat, plotChunk, tableChunk1, tableChunk2)
        
        filePath <- "scenarioReport.pdf"
        file.copy(filePath, file)
      }
    )
    
    
  })
  
  output$manual <- renderUI({
    manual <- tags$iframe(src='manual.html', 
                          height=600, 
                          width="100%",
                          frameBorder="0")
    manual
  })
  
  output$hpp_manual <- renderUI({
    manual <- tags$iframe(src='manual.html', 
                          height=600, 
                          width="100%",
                          frameBorder="0")
    manual
  })
  
  output$hepC_manual <- renderUI({
    manual <- tags$iframe(src='manual.html', 
                          height=600, 
                          width="100%",
                          frameBorder="0")
    manual
  })
  
  output$hearts_manual <- renderUI({
    manual <- tags$iframe(src='manual.html', 
                          height=600, 
                          width="100%",
                          frameBorder="0")
    manual
  })
  
  ##### HEARTS #####
  
  output$hearts_inputs = renderUI({
    
    input_names = c(
      "Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad",
      "Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad.",
      "Tratamiento entre diagnosticados (%)",
      "Control de la hipertensión entre los tratados (%)"
    )
    
    names(input_names) = colnames(base_line)[-1]
    
    tagList(
      bsCollapse(
        id="hearts_collapse",
        open="Parámetros básicos",
        bsCollapsePanel(
          
          title = "Parámetros básicos",
          h4("Línea de base"),
          lapply(input_names[3], function (i) {
        
            sliderInput(paste0("hearts_input_base_",which(input_names==i)),
                        input_names[input_names==i],
                        value = base_line[base_line$country==input$hearts_country,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          }),
          h4("Objetivo"),
          lapply(input_names[3], function (i) {
            sliderInput(paste0("hearts_input_target_",which(input_names==i)),
                        input_names[input_names==i],
                        value = targets_default[targets_default$country==input$hearts_country,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          })),
        bsCollapsePanel(
          title = "Parámetros Secundarios",
          h4("Línea de base"),
          lapply(input_names[c(1,2,4)], function (i) {
            
            sliderInput(paste0("hearts_input_base_",which(input_names==i)),
                        input_names[input_names==i],
                        value = base_line[base_line$country==input$hearts_country,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          }),
          h4("Objetivo"),
          lapply(input_names[c(1,2,4)], function (i) {
            sliderInput(paste0("hearts_input_target_",which(input_names==i)),
                        input_names[input_names==i],
                        value = targets_default[targets_default$country==input$hearts_country,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          })
        ))
      
    )
    
    
  })
  
  run_hearts = reactive({
    paste(input$hearts_input_base_1)
    paste(input$hearts_input_base_2)
    paste(input$hearts_input_base_3)
    paste(input$hearts_input_base_4)
    paste(input$hearts_input_target_1)
    paste(input$hearts_input_target_2)
    paste(input$hearts_input_target_3)
    paste(input$hearts_input_target_4)
    
    if (is.null(input$hearts_input_target_4)==F) {
      estimaToolCosts(
        input$hearts_country,
        population$population[population$country==input$hearts_country],
        input$hearts_input_base_1,
        input$hearts_input_target_1,
        input$hearts_input_base_2,
        input$hearts_input_target_2,
        input$hearts_input_base_3,
        input$hearts_input_target_3,
        input$hearts_input_base_4,
        input$hearts_input_target_4
      )
    }
    
    
    
  })
  
  output$hearts_grafico_1 = renderHighchart({
    if (length(run_hearts())>0) {
      x = 0:100
      y = c()
      
      for (i in x) {
        y=c(y,exp((-0.0294 * i) +5.5305))
      }
      
      y1 = round(run_hearts()$epi_model_outcomes$Modelo1_x1,1)
      y2 = round(run_hearts()$epi_model_outcomes$Modelo1_x2,1)
      
      x1 = round(run_hearts()$run[[input$hearts_country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
      x2 = round(run_hearts()$run[[input$hearts_country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
      
      highchart() %>% hc_chart(type = "line") %>%
        hc_add_series(y, name = "Predictive model") %>% 
        hc_add_series(rep(y1,100), yAxis = 0, name = "Inicial") %>%
        hc_add_series(rep(y2,100), yAxis = 0, name = "Resultado") %>%
        hc_yAxis(
          title = list(text="Tasa por 100.000 habitantes")
        ) %>%
        hc_xAxis(
          title = list(text="Prevalencia de control de HTA en la población (%)"),
          plotLines = list(
            list(color = "#25252550",
                 width = 1,
                 value = x1,
                 dashStyle = "longdash"),
            list(color = "red",
                 width = 1,
                 value = x2,
                 dashStyle = "longdash")
          )) %>% hc_title(text = "Modelo predictivo para la mortalidad por enfermedad isquémica del corazón")
      
      
      
    }
    
    
  })
  
  
  output$hearts_grafico_2 = renderHighchart({
    if (length(run_hearts())>0) {
      x = 0:100
      y = c()
      
      for (i in x) {
        y=c(y,exp((-0.0240177 * i) + 4.57206))
      }
      
      y1 = round(run_hearts()$epi_model_outcomes$Modelo2_x1,1)
      y2 = round(run_hearts()$epi_model_outcomes$Modelo2_x2,1)
      
      x1 = round(run_hearts()$run[[input$hearts_country]]$baseline$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
      x2 = round(run_hearts()$run[[input$hearts_country]]$target$`Prevalence of controlled hypertension among adults aged 30-79 years with hypertension, age- standardized`*100,1)
      
      highchart() %>% hc_chart(type = "line") %>%
        hc_add_series(y, name = "Predictive model") %>% 
        hc_add_series(rep(y1,100), yAxis = 0, name = "Inicial") %>%
        hc_add_series(rep(y2,100), yAxis = 0, name = "Resultado") %>%
        hc_yAxis(
          title = list(text="Tasa por 100.000 habitantes")
        ) %>%
        hc_xAxis(
          title = list(text="Prevalencia de control de HTA en la población (%)"),
          plotLines = list(
            list(color = "#25252550",
                 width = 1,
                 value = x1,
                 dashStyle = "longdash"),
            list(color = "red",
                 width = 1,
                 value = x2,
                 dashStyle = "longdash")
          )) %>% hc_title(text = "Modelo predictivo para la mortalidad por accidente cerebrovascular")
      
      
      
    }
    
    
  })
  
  output$hearts_resultados = renderReactable({
    if(length(run_hearts())>0) {
      metrica_baseline = names(run_hearts()$run[[input$hearts_country]]$baseline)
      valores_baseline = unname(unlist(run_hearts()$run[[input$hearts_country]]$baseline))
      metrica_target = names(run_hearts()$run[[input$hearts_country]]$target)
      valores_target = unname(unlist(run_hearts()$run[[input$hearts_country]]$target))
      
      
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
      
      epi = run_hearts()$epi_outcomes
      colnames(epi) = colnames(table)
      
      costos = data.frame(
        Indicador=names(run_hearts()$costs_outcomes),
        Valor=unname(unlist(run_hearts()$costs_outcomes))
        
      ) 
      table = rbind(
        table,
        epi,
        costos
      ) %>% as.data.frame()
      
      table$Valor = round(table$Valor,1)
      table$Valor = format(table$Valor, big.mark = ".", decimal.mark = ",")
      
      cat_epi = 1:12
      cat_costos = 13:15
      
      table$cat=""
      table$cat[cat_epi] = "Resultados epidemiológicos"
      table$cat[cat_costos] = "Resultados económicos"
      
      rownames(table) = NULL
      
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
    
    # table$disc = format(round(table$disc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
    # table$undisc = format(round(table$undisc,1), nsmall = 1,big.mark = ".", decimal.mark = ",", scientific = FALSE)
    # 
    # colnames(table) = c("Outcomes", "Undiscounted", "Discounted")
    # 
    # kableExtra::kable(table,
    #                   align = c("l","r","r")) %>%
    #   kable_styling(
    #     font_size = 15,
    #     bootstrap_options = c("striped", "hover", "condensed")
    #   ) 
  })
  
  observeEvent(input$hearts_saveScenario2, {
    
    if (input$hearts_scenarioName !="") {
      scnID = UUIDgenerate()
      scnName = input$hearts_scenarioName
      
      metrica_baseline = names(run_hearts()$run[[input$hearts_country]]$baseline)
      valores_baseline = unname(unlist(run_hearts()$run[[input$hearts_country]]$baseline))
      metrica_target = names(run_hearts()$run[[input$hearts_country]]$target)
      valores_target = unname(unlist(run_hearts()$run[[input$hearts_country]]$target))
      
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
      
      epi = run_hearts()$epi_outcomes
      colnames(epi) = colnames(table)
      
      costos = data.frame(
        Indicador=names(run_hearts()$costs_outcomes),
        Valor=unname(unlist(run_hearts()$costs_outcomes))
        
      ) 
      
      table = rbind(
        table,
        epi,
        costos
      )
      
      table$Valor = round(table$Valor,1)
      
      hearts_scenarios$savedScenarios[[scnName]] <- table
      
      sendSweetAlert(
        session = session,
        title = "Escenario guardado",
        text = paste0("Nombre: ",scnName),
        type = "success"
      )
      
      hide("hearts_scenarioName", anim = T, animType = "fade")
      hide("hearts_saveScenario2", anim = T, animType = "fade")
      show("hearts_saveScenario", anim = T, animType = "fade")
      updateTextAreaInput(session,"hearts_scenarioName",value="")  
    } else {
      sendSweetAlert(
        session = session,
        title = "Error",
        text = "Debe definir un nombre para guardar el escenario.",
        type = "error"
      )
      hide("scenarioName", anim = T, animType = "fade")
      hide("saveScenario2", anim = T, animType = "fade")
      show("saveScenario", anim = T, animType = "fade")
    }
    
  })
  
  
  observeEvent(input$hpp_saveScenario2, {
    
    if (input$hpp_scenarioName !="") {
      scnID = UUIDgenerate()
      scnName = input$hpp_scenarioName
      
      table = hpp_run()
      
      hpp_scenarios$savedScenarios[[scnName]] <- table
      
      sendSweetAlert(
        session = session,
        title = "Escenario guardado",
        text = paste0("Nombre: ",scnName),
        type = "success"
      )
      
      hide("hpp_scenarioName", anim = T, animType = "fade")
      hide("hpp_saveScenario2", anim = T, animType = "fade")
      show("hpp_saveScenario", anim = T, animType = "fade")
      updateTextAreaInput(session,"hpp_scenarioName",value="")  
    } else {
      sendSweetAlert(
        session = session,
        title = "Error",
        text = "Debe definir un nombre para guardar el escenario.",
        type = "error"
      )
      hide("hpp_scenarioName", anim = T, animType = "fade")
      hide("hpp_saveScenario2", anim = T, animType = "fade")
      show("hpp_saveScenario", anim = T, animType = "fade")
    }
    
  })
  
  
  observeEvent(input$hepC_saveScenario2, {
    if (input$hepC_scenarioName !="") {
      scnID = UUIDgenerate()
      scnName = input$hepC_scenarioName
      
      table = hepC_run()
      
      hepC_scenarios$savedScenarios[[scnName]] <- table
      
      sendSweetAlert(
        session = session,
        title = "Escenario guardado",
        text = paste0("Nombre: ",scnName),
        type = "success"
      )
      
      hide("hepC_scenarioName", anim = T, animType = "fade")
      hide("hepC_saveScenario2", anim = T, animType = "fade")
      show("hepC_saveScenario", anim = T, animType = "fade")
      updateTextAreaInput(session,"hepC_scenarioName",value="")  
    } else {
      sendSweetAlert(
        session = session,
        title = "Error",
        text = "Debe definir un nombre para guardar el escenario.",
        type = "error"
      )
      hide("hepC_scenarioName", anim = T, animType = "fade")
      hide("hepC_saveScenario2", anim = T, animType = "fade")
      show("hepC_saveScenario", anim = T, animType = "fade")
    }
    
  })
  
  output$hearts_table_saved = renderReactable({
    
    if (length(input$hearts_savedScenarios)>0) {
      table = data.frame(Indicador=hearts_scenarios$savedScenarios[[1]]$Indicador)
      for (i in input$hearts_savedScenarios) {
        scn_name = i
        table[[i]] = hearts_scenarios$savedScenarios[[i]]$Valor
      }
      
      cat_epi = 1:12
      cat_costos = 13:15
      
      table$cat=""
      table$cat[cat_epi] = "Resultados epidemiológicos"
      table$cat[cat_costos] = "Resultados económicos"
      
      columns = list(
        cat = colDef(name = "Categoría", align = "left"),
        Indicador = colDef(name = "Indicador", align = "left")
      )
      
      for (i in setdiff(1:ncol(table),c(1,ncol(table)))) {
        table[i] = format(table[i], bigmark=",", decimalmark=".") 
        columns[[colnames(table)[i]]] = colDef(name = colnames(table)[i], align = "right")
      }
      reactable(
        table,
        groupBy = "cat",
        defaultExpanded = T,
        pagination = F,
        columnGroups = list(
          colGroup("Escenarios", columns = colnames(table)[setdiff(1:ncol(table),c(1,ncol(table)))], sticky = "left",
                   headerStyle = list(background = "#236292", color = "white", borderWidth = "0"))
        ),
        defaultColDef = colDef(
          align = "center",
          minWidth = 70,
          headerStyle = list(background = "#236292", color = "white")
        ),
        columns = columns,
        bordered = TRUE,
        highlight = TRUE
      )
      
      
      
    } else {disable("hearts_savedScenarios")}
    
  })
  
  
  output$hpp_table_saved = renderText({
    
    if (length(input$hpp_savedScenarios)>0) {
      enable("hpp_savedScenarios")
      table = data.frame(Indicador=hpp_run()$Indicador)
      for (i in input$hpp_savedScenarios) {
        scn_name = i
        table[[i]] = hpp_scenarios$savedScenarios[[i]]$Valor
      }
      
      kableExtra::kable(table,
                        row.names = F
      ) %>%
        kable_styling(
          font_size = 15,
          bootstrap_options = c("striped", "hover", "condensed")
        )
      
    } else {disable("hpp_savedScenarios")}
    
  })
  
  
  output$hepC_table_saved = renderText({
    
    if (length(input$hepC_savedScenarios)>0) {
      enable("hepC_savedScenarios")
      table = data.frame(Indicador=hepC_run()$Indicador)
      for (i in input$hepC_savedScenarios) {
        scn_name = i
        table[[i]] = hepC_scenarios$savedScenarios[[i]]$Valor
      }
      
      kableExtra::kable(table,
                        row.names = F
      ) %>%
        kable_styling(
          font_size = 15,
          bootstrap_options = c("striped", "hover", "condensed")
        )
      
    } else {disable("hepC_savedScenarios")}
    
  })
  
}

shinyApp(ui, server)

