nombre_scn = "Escenario #1"
hito = "Mejor retorno de inversión"
valor = "10.9%"
intervencion = "HEARTS"

config = data.frame(
  input = c('Porcentaje de personas diagnosticadas que se encuentran en tratamiento (objetivo)',
            'Población total del país (n)',
            'Prevalencia de adultos con hipertensión, estandarizada por edad (%)'),
  valor = c(10,20,30)
)

info_box = function(
    nombre_scn,
    hito,
    valor,
    intervencion,
    config) {

  config_info = c()
  for (i in 1:nrow(config)) {
    add = paste0(config$input[i],": ",config$valor[i])
    config_info = c(config_info,add)
  }
  
  config_info = paste(config_info, collapse="<br>")
  
  HTML(
    glue(
      '<div class = "p-4 w-full">
      <dl class="mt-5 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-2">
        <div class="overflow-hidden rounded-lg bg-gray-500 px-4 pb-4 pt-5 shadow sm:px-6 sm:pt-6">
          <dt>
            <p class="ml-2 mb-2 truncate text-4xl font-medium text-gray-300">{nombre_scn}</p>
          </dt>
          
            <dd class="ml-2 items-baseline pb-6 sm:pb-7">
              <p class="text-2xl text-gray-100">{hito}: <b>{valor}</b></p>
              <p class="text-2xl text-gray-100">Intervención involucrada: <b>{intervencion}</b></p>
            </dd>
        <hr></hr>
        <dd class="ml-2 items-baseline pb-4 sm:pb-7">
              
              <p class="text-xl text-gray-100 mt-4">Configuración del escenario:</p>
              <p class="text-xl text-gray-100 mt-2">{config_info}</p>
            </dd>
        </div>
      </dl>
    </div>'
    ))
  
  
}

info_box(
  nombre_scn = nombre_scn,
  hito = hito,
  valor = valor,
  intervencion = intervencion,
  config = config)
