library(shiny)
library(shiny.router)

root_page <- fluidPage(
  fluidRow(
    column(4,
           h2("UI Intro con selección de UI"),
           tags$a(href="#!/other", "UI Básica"),
           tags$br(),
           tags$a(href="#!/other2", "UI Avanzada")
           )
  )
  
)

other_page1 <- div(h3("UI Básica"))

other_page2 <- div(h3("UI Avanzada"))

ui <- fluidPage(
  title = "Router demo",
  router_ui(
    route("/", root_page),
    route("other", other_page1),
    route("other2", other_page2)
  )
)

server <- function(input, output, session) {
  router_server()
}

shinyApp(ui, server)
