ui <- div(
  router_ui(
    route("/", ui_home),
    route("avanzada", ui_avanzada),
    route("main", ui_main)
  )
)