# UI landing

ui_home <- fluidPage(
  shiny.tailwind::use_tailwind(), # implementa tailwind css
  theme = shinythemes::shinytheme("united"),
  tags$style(getStyle()),
  getCards() # intro y tarjetas de las intervenciones
)


