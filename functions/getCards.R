getCards = function () {
  
  
  HTML('
    <div class= "text-5xl" style = "background-color: #1D9ADD; padding: 10px; color: white; text-align: center">
      <h1 class = "mt-8 mb-8"><b>PAHO Programme Impact Assessment Tool (PIA Tool)</b></h1>
    </div>
  
    <br></br>
  
    <div>
      <h2 class = "text-4xl"> Bienvenido a PiaTool  </h2>
      <p class = "m-6 text-3xl">Esta herramienta permite al usuario evaluar el impacto epidemiológico y económico de intervenciones priorizadas por la OMS, tendientes a reducir la carga de enfermedad a largo plazo. Ofrece una visión de la inversión necesaria y los ahorros potenciales derivados de las intervenciones consideradas, en países seleccionados, a partir de metodologías validadas.</p>
    </div>
  
    <div>
      <div class="flex flex-wrap ml-4 my-4">
  
      <!-- Tarjeta 1 -->
      <div class="max-w-lg px-2 mb-4">
        <div class="bg-white p-4 shadow-md h-full m-8">
          <img class="w-full" src="https://www.masseycancercenter.org/-/media/massey-media/news/hpv-vaccine-1.ashx" alt="Sunset in the mountains">
          <div class="font-bold text-4xl mb-2 mt-3">Vacuna contra el HPV</div>
          <p class="text-gray-700 text-xl">
            Modelo de evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el virus del papiloma humano (VPH) en niñas para la prevención del cáncer de cuello uterino por país.
          </p>
        </div>
      </div>
  
    <!-- Tarjeta 2 -->
      <div class="max-w-lg px-2 mb-4">
        <div class="bg-white p-4 shadow-md h-full m-8">
          <img class="w-full" src="https://www.paho.org/sites/default/files/2020-02/HEARTS-logo-en-illustrator-WEB_3.gif" alt="Sunset in the mountains">
          <div class="font-bold text-4xl mb-2 mt-3">Iniciativa Global HEARTS</div>
          <p class="text-gray-700 text-xl">
            Modelo de evaluación del impacto epidemiológico y de costo-efectividad del control de la presión arterial con tratamiento farmacológico en personas con hipertensión arterial ya diagnosticadas en el marco de la iniciativa HEARTS para la reducción de la mortalidad relacionada con enfermedades cardíacas isquémicas (ECI) y accidentes cerebrovasculares (ACV) por país.
          </p>
        </div>
      </div>
  
      <!-- Tarjeta 3 -->
      <div class="max-w-lg px-2 mb-4">
        <div class="bg-white p-4 shadow-md h-full m-8">
          <img class="w-full" src="https://www.pmfarma.com/articulos/contenido/3696/image/hemorragia%20postparto.jpg" alt="Sunset in the mountains">
          <div class="font-bold text-4xl mb-2 mt-3">Hemorragia postparto</div>
          <p class="text-gray-700 text-xl">
            Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna por país.
          </p>
        </div>
      </div>
  
      <!-- Tarjeta 4 -->
      <div class="max-w-lg px-2 mb-4">
        <div class="bg-white p-4 shadow-md h-full m-8">
          <img class="w-full" src="https://www.infobae.com/new-resizer/96tw_XDa_aW1TGjxmziJP9DRi4w=/992x558/filters:format(webp):quality(85)/s3.amazonaws.com/arc-wordpress-client-uploads/infobae-wp/wp-content/uploads/2018/05/23144521/Hepatitis-C-3.jpg" alt="Sunset in the mountains">
          <div class="font-bold text-4xl mb-2 mt-3">Hepatitis C</div>
          <p class="text-gray-700 text-xl">
            Modelo de evaluación del impacto epidemiológico y de costo-efectividad del tratamiento de Hepatitis C crónica para la reducción de la morbimortalidad por Hepatitis C por país.
          </p>
        </div>
      </div>
      
    </div>

       ')
}

