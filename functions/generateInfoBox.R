# nombre_scn = "Escenario #1"
# hito = "Mejor retorno de inversión"
# valor = "10.9%"
# intervencion = "HEARTS"
# 
# config = data.frame(
#   input = c('Porcentaje de personas diagnosticadas que se encuentran en tratamiento (objetivo)',
#             'Población total del país (n)',
#             'Prevalencia de adultos con hipertensión, estandarizada por edad (%)'),
#   valor = c(10,20,30)
# )

info_box = function(
    nombre_scn,
    hito,
    valor,
    intervencion) {

  HTML(
    glue(
      "<div class='shadow-lg m-3 rounded-lg text-slate-50 bg-slate-400 p-3' style = 'background-color: '>
<div class='flex'> 
  <div class = 'flex-1 text-4xl text-left px-4 pt-3 pb-3 border-slate-800'>{nombre_scn}</div>
  <div class='ml-auto mr-4 mt-3'>
    <svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='currentColor' class='w-10 h-10'>
  <path fill-rule='evenodd' d='M18.97 3.659a2.25 2.25 0 0 0-3.182 0l-10.94 10.94a3.75 3.75 0 1 0 5.304 5.303l7.693-7.693a.75.75 0 0 1 1.06 1.06l-7.693 7.693a5.25 5.25 0 1 1-7.424-7.424l10.939-10.94a3.75 3.75 0 1 1 5.303 5.304L9.097 18.835l-.008.008-.007.007-.002.002-.003.002A2.25 2.25 0 0 1 5.91 15.66l7.81-7.81a.75.75 0 0 1 1.061 1.06l-7.81 7.81a.75.75 0 0 0 1.054 1.068L18.97 6.84a2.25 2.25 0 0 0 0-3.182Z' clip-rule='evenodd' />
</svg>


  </div>
</div>
  
  <hr>
  <div class = 'text-xl text-left p-4 border-slate-800'>
    {hito} <b>{valor}</b></div>
    <div class = 'text-xl text-left p-4 pt-0 border-slate-800'>
    Intervención involucrada: <b>{intervencion}</b></div>
</div>"
    ))
  
  
}
# 
# info_box(
#   nombre_scn = nombre_scn,
#   hito = hito,
#   valor = valor,
#   intervencion = intervencion,
#   config = config)
