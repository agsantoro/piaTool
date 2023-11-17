ui <- div(
  router_ui(
    route("/", ui),
    route("avanzada", ui_avanzada)
  )
)