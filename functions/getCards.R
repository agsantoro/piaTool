getCards = function () {
  div(
    tags$header(class="text-5xl flex justify-between items-center p-8", style="background-color: #1D9ADD; color: white; text-align: center",
                tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("PAHO Programme Impact Assessment Tool (PIA Tool)")),
                tags$a(class="py-2 px-4 text-3xl text-white focus:text-sky-700 cursor-pointer", href="#!/avanzada", icon("arrow-right"))
                ),
    tags$div(class="flex flex-wrap ml-4 my-4",
             tags$div(class="max-w-lg px-2 mb-4",
                      tags$div(class="bg-white p-4 shadow-md h-full m-8",
                               tags$img(class="w-full", src="https://www.masseycancercenter.org/-/media/massey-media/news/hpv-vaccine-1.ashx", alt="Vacuna contra el HPV"),
                               tags$div(class="font-bold text-4xl mb-4 mt-5","Vacuna contra el HPV"),
                               tags$p(class="text-gray-700 text-xl","Modelo de evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el virus del papiloma humano (VPH) en niñas para la prevención del cáncer de cuello uterino por país.")
                      )
             ),
             tags$div(class="max-w-lg px-2 mb-4",
                      tags$div(class="bg-white p-4 shadow-md h-full m-8",
                               tags$img(class="w-full", src="https://www.paho.org/sites/default/files/styles/max_1300x1300/public/card/2019-07/HEARTS-header-en_0.png?itok=yeumwogQ", alt="HEARTS"),
                               tags$div(class="font-bold text-4xl mb-4 mt-5","Iniciativa global HEARTS"),
                               tags$p(class="text-gray-700 text-xl","Modelo de evaluación del impacto epidemiológico y de costo-efectividad del control de la presión arterial con tratamiento farmacológico en personas con hipertensión arterial ya diagnosticadas en el marco de la iniciativa HEARTS para la reducción de la mortalidad relacionada con enfermedades cardíacas isquémicas (ECI) y accidentes cerebrovasculares (ACV) por país.")
                      )
             ),
             tags$div(class="max-w-lg px-2 mb-4",
                      tags$div(class="bg-white p-4 shadow-md h-full m-8",
                               tags$img(class="w-full", src="https://www.pmfarma.com/articulos/contenido/3696/image/hemorragia%20postparto.jpg", alt="Hemorragia postparto"),
                               tags$div(class="font-bold text-4xl mb-4 mt-5","Hemorragia postparto"),
                               tags$p(class="text-gray-700 text-xl","Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna por país.")
                      )
             ),
             tags$div(class="max-w-lg px-2 mb-4",
                      tags$div(class="bg-white p-4 shadow-md h-full m-8",
                               tags$img(class="w-full", src="https://www.healthychildren.org/SiteCollectionImagesArticleImages/hepatitis-c-positive.jpg?RenditionID=3", alt="Hepatitis C"),
                               tags$div(class="font-bold text-4xl mb-4 mt-5","Hepatitis C"),
                               tags$p(class="text-gray-700 text-xl","Modelo de evaluación del impacto epidemiológico y de costo-efectividad del tratamiento de Hepatitis C crónica para la reducción de la morbimortalidad por Hepatitis C por país.")
                      )
             ),
             
             tags$div(class="max-w-lg px-2 mb-4",
                      tags$div(class="bg-white p-4 shadow-md h-full m-8",
                               tags$img(class="w-full", src="https://s1.eestatic.com/2021/11/18/actualidad/628199152_215371181_864x486.jpg", alt="Hepatitis C"),
                               tags$div(class="font-bold text-4xl mb-4 mt-5","Intervención #5"),
                               tags$p(class="text-gray-700 text-xl","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel egestas dolor, nec dignissim metus. Donec augue elit, rhoncus ac sodales id, porttitor vitae est. Donec laoreet rutrum libero sed pharetra.")
                      )
             ),
             
             tags$div(class="max-w-lg px-2 mb-4",
                      tags$div(class="bg-white p-4 shadow-md h-full m-8",
                               tags$img(class="w-full", src="https://estaticos-cdn.prensaiberica.es/clip/4191e0ff-ac20-4123-8c6b-3baf24292bc0_16-9-aspect-ratio_default_0.jpg", alt="Hepatitis C"),
                               tags$div(class="font-bold text-4xl mb-4 mt-5","Intervención #6"),
                               tags$p(class="text-gray-700 text-xl","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel egestas dolor, nec dignissim metus. Donec augue elit, rhoncus ac sodales id, porttitor vitae est. Donec laoreet rutrum libero sed pharetra.")
                      )
             )
             
             
    )
     
  )
  
  
  # HTML('
  # 
  #   <header class="text-5xl flex justify-between items-center p-8" style="background-color: #1D9ADD; color: white; text-align: center">
  #     <h1 style="display: inline-block; margin: 0 auto;" class="flex-grow mt-8 mb-8"><b>PAHO Programme Impact Assessment Tool (PIA Tool)</b></h1>
  #     <a class="animate-pulse py-2 px-4 text-3xl text-white focus:text-sky-700 cursor-pointer" href="#!/prueba">Ingresar <i class="fa-solid fa-arrow-right"></i> </a>
  #   </header>
  #   
  #   <br></br>
  #   
  #   <div>
  #     <h2 class = "text-4xl"> Bienvenido a PiaTool  </h2>
  #     <p class = "m-6 text-3xl">Esta herramienta permite al usuario evaluar el impacto epidemiológico y económico de intervenciones priorizadas por la OMS, tendientes a reducir la carga de enfermedad a largo plazo. Ofrece una visión de la inversión necesaria y los ahorros potenciales derivados de las intervenciones consideradas, en países seleccionados, a partir de metodologías validadas.</p>
  #   </div>
  #   
  #   <div>
  #     <div class="flex flex-wrap ml-4 my-4">
  #       
  #       <div class="max-w-lg px-2 mb-4">
  #         <div class="bg-white p-4 shadow-md h-full m-8">
  #           <img class="w-full" src="https://www.masseycancercenter.org/-/media/massey-media/news/hpv-vaccine-1.ashx" alt="Vacuna contra el HPV">
  #           <div class="font-bold text-4xl mb-2 mt-3">Vacuna contra el HPV</div>
  #           <p class="text-gray-700 text-xl">
  #             Modelo de evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el virus del papiloma humano (VPH) en niñas para la prevención del cáncer de cuello uterino por país.
  #           </p>
  #         </div>
  #       </div>
  #       
  #       <div class="max-w-lg px-2 mb-4">
  #         <div class="bg-white p-4 shadow-md h-full m-8">
  #           <img class="w-full" src="https://www.paho.org/sites/default/files/2020-02/HEARTS-logo-en-illustrator-WEB_3.gif" alt="HEARTS">
  #           <div class="font-bold text-4xl mb-2 mt-3">Iniciativa Global HEARTS</div>
  #           <p class="text-gray-700 text-xl">
  #             Modelo de evaluación del impacto epidemiológico y de costo-efectividad del control de la presión arterial con tratamiento farmacológico en personas con hipertensión arterial ya diagnosticadas en el marco de la iniciativa HEARTS para la reducción de la mortalidad relacionada con enfermedades cardíacas isquémicas (ECI) y accidentes cerebrovasculares (ACV) por país.
  #           </p>
  #         </div>
  #       </div>
  #       
  #       <div class="max-w-lg px-2 mb-4">
  #         <div class="bg-white p-4 shadow-md h-full m-8">
  #           <img class="w-full" src="https://www.pmfarma.com/articulos/contenido/3696/image/hemorragia%20postparto.jpg" alt="Hemorragia postparto">
  #           <div class="font-bold text-4xl mb-2 mt-3">Hemorragia postparto</div>
  #           <p class="text-gray-700 text-xl">
  #             Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna por país.
  #           </p>
  #         </div>
  #       </div>
  #       
  #       <div class="max-w-lg px-2 mb-4">
  #         <div class="bg-white p-4 shadow-md h-full m-8">
  #           <img class="w-full" src="https://www.infobae.com/new-resizer/96tw_XDa_aW1TGjxmziJP9DRi4w=/992x558/filters:format(webp):quality(85)/s3.amazonaws.com/arc-wordpress-client-uploads/infobae-wp/wp-content/uploads/2018/05/23144521/Hepatitis-C-3.jpg" alt="Hepatitis C">
  #           <div class="font-bold text-4xl mb-2 mt-3">Hepatitis C</div>
  #           <p class="text-gray-700 text-xl">
  #             Modelo de evaluación del impacto epidemiológico y de costo-efectividad del tratamiento de Hepatitis C crónica para la reducción de la morbimortalidad por Hepatitis C por país.
  #           </p>
  #         </div>
  #       </div>
  #     </div>
  #   
  #      '))
}

