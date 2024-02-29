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
library(bsplus)
library(shinyBS)
library(bslib)
library(shinythemes)
library(gfonts)
library(fresh)
library(reactable)
library(stringr)
library(openxlsx)
library(shiny.router)
library(shinyalert)
library(RColorBrewer)

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
source("functions/graf_esc.R", encoding = "UTF-8")
source("functions/generateInfoBox.R", encoding = "UTF-8")
source("functions/textoIntro.R", encoding = "UTF-8")
source("hpv/getPrime.R", encoding = "UTF-8")
source("functions/roundUpNice.R", encoding = "UTF-8")
source("functions/generateRMD.R", encoding = "UTF-8")
source("estimaTool/estimaTool.R", encoding = "UTF-8")
source("tbc/funcion.R", encoding = "UTF-8")
source("prep/fn_prep4.R", encoding = "UTF-8")
source("hpp/funciones/funciones.R", encoding = "UTF-8")
source("hepC/funcion_hepC.R", .GlobalEnv, encoding = "UTF-8")

charts_theme <- hc_theme(
  chart = list(
    style = list(
      fontFamily = "Istok Web"
    )
  )
)


i18n <- Translator$new(translation_json_path='translation.json')
i18n$set_translation_language('sp')

model_card_hearts = read.xlsx("estimaTool/model_card_sheet/model_card_sheet.xlsx") %>% dplyr::filter(is.na(inputID)==F)
