ui_home <- fluidPage(
  shiny.tailwind::use_tailwind(),
  tags$style(getStyle()),
  theme = shinythemes::shinytheme("united"),
  fluidRow(
    column(12,
           getCards(),
           
    )
    
  ),
  fixedPanel(
    bottom = 8,
    right = 8,
    actionButton("boton_ingresar","Ingresar a la aplicación", icon = icon("arrow-right"))
  )
  
)
