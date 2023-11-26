ui_escenarios = fluidPage(
  column(12,
         uiOutput("select_escenarios_guardados"),
         uiOutput("escenarios_guardados"),
         uiOutput("go_comparacion"))
)