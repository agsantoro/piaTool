ui_home <- fluidPage(
  shiny.tailwind::use_tailwind(),
  tags$style(getStyle()),
  theme = shinythemes::shinytheme("united"),
  
  fluidRow(
    column(12,
           getTextoIntro()),
    ),
  fluidRow(
    column(12,
           hr(),
           h3("Acá tarjetas con descripción de los modelos disponibles"),
           hr(),
           h3("Ingresar a la aplicación:"),
           actionButton("link_entrar","Ingresar a la app", onclick ="window.open('#!/main')"),
           actionButton("link_avanzada","Ingresar a la app (avanzada)", onclick ="window.open('#!/avanzada')"),
           br(),
           br()),
  )
           
)

