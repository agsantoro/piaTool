library(shiny)

ui <- fluidPage(
  use_tailwind(),
  uiOutput("header"),
  uiOutput("pagina")
  
)

server <- function(input, output, session) {
  
  output$header = renderUI({
    
    tags$nav(
      class = "sticky top-0",
      style = "z-index: 1;",
      div(
        style = "background-color: #0099D9;",
        div(
          class = "flex p-3",
          div(
            class = "w-2/4",
            div(
              id = "this1",
              class = "p-2 text-4xl text-white",
              style = "background-color: #0099D9;",
              tags$b("PAHO Programme Impact Assessment Tool")
            )
          ),
          div(
            class = "w-2/4",
            div(
              id = "class",
              class = "p-2",
              div(
                class = "text-right text-base text-white",
                tags$a(href = "https://www.paho.org/es/hearts-americas", "Español"),
                tags$span("|"),
                tags$a(href = "www.infobae.com", "Inglés")
              )
            )
          )
        ),
        div(
          class = "text-white text-right text-lg pb-3",
          style = "background-color: #0099D9;",
          actionLink(
            inputId =  "link1",
            class = "selected:text-red font-bold px-10 cursor-pointer hover:no-underline hover:text-slate-700 transition ease-in-out delay-150",
            label="Definición de escenarios"
          ),
          actionLink(
            inputId =  "link2",
            class = "selected:text-red font-bold px-10 cursor-pointer hover:no-underline hover:text-slate-700 transition ease-in-out delay-150",
            label="Escenarios guardados"
          ),
          actionLink(
            inputId =  "link3",
            class = "selected:text-red font-bold px-10 cursor-pointer hover:no-underline hover:text-slate-700 transition ease-in-out delay-150",
            label="Escenarios comparados"
          )
        )
      )
    )
    
  })
  
  observeEvent(input$link1, {
    input_names = c("Definición de escenarios",
                    "Escenarios guardados",
                    "Comparación de escenarios")
        
    if (length(input$link1)!=0 &
        length(input$link2)!=0 &
        length(input$link3)!=0) {
      
      updateActionLink(session = session, label=HTML(glue('<p style = "color: orange; display: inline-block">{input_names[1]}</p>')), inputId = paste0("link",1))
      
      for (i in 2:3) {
        updateActionLink(session = session, label=input_names[i], inputId =paste0("link",i))
      }
    }
  })
  
  observeEvent(input$link2, {
    input_names = c("Definición de escenarios",
                    "Escenarios guardados",
                    "Comparación de escenarios")
    
    if (length(input$link1)!=0 &
        length(input$link2)!=0 &
        length(input$link3)!=0) {
      
      updateActionLink(session = session, label=HTML(glue('<p style = "color: orange; display: inline-block">{input_names[2]}</p>')), inputId = paste0("link",2))
      
      for (i in c(1,3)) {
        updateActionLink(session = session, label=input_names[i], inputId =paste0("link",i))
      }
    }
  })
  
  observeEvent(input$link3, {
    input_names = c("Definición de escenarios",
                    "Escenarios guardados",
                    "Comparación de escenarios")
    
    if (length(input$link1)!=0 &
        length(input$link2)!=0 &
        length(input$link3)!=0) {
      
      updateActionLink(session = session, label=HTML(glue('<p style = "color: orange; display: inline-block">{input_names[3]}</p>')), inputId = paste0("link",3))
      
      for (i in c(1,2)) {
        updateActionLink(session = session, label=input_names[i], inputId =paste0("link",i))
      }
    }
  })
}

shinyApp(ui = ui, server = server)
