library(shiny)
library(shinyjs)

# Define UI
ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  
  # Add a button to trigger the modal
  actionButton("showModalBtn", "Show Centered Modal"),
  
  # Main page content
  h1("Main Page Content")
)

# Define Server
server <- function(input, output, session) {
  
  # Function to show the centered modal
  observeEvent(input$showModalBtn, {
    showModal(
      modalDialog(
        title = HTML("<div style='background-color: red;'>hola</div>"),
        div("Modal Content"),
        easyClose = TRUE  # Close modal by clicking outside
      )
    )
    
    # Center the modal
    #shinyjs::runjs('$(".modal").css("margin-top", Math.max(0, ($(window).height() - $(".modal-dialog").height()) / 2));')
    
    # Disable interaction with the main page
    shinyjs::disable("showModalBtn")
  })
}

# Run the application
shinyApp(ui, server)