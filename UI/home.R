# UI landing

ui_home <- fluidPage(
  shiny.tailwind::use_tailwind(), # implementa tailwind css
  #theme = shinythemes::shinytheme("united"),
  #tags$style(getStyle()),
  #getCards() # intro y tarjetas de las intervenciones
  HTML(
    '
    <nav class="sticky top-0" style="z-index: 1;">
  <div class="flex bg-white p-3">
    <div class="w-1/4">
      <div id="this1" class="bg-white p-4">
        <img src="https://www.paho.org/themes/paho/images/logo-es.png" alt="" />
      </div>
    </div>
    <div class="w-2/4">
      <div class="p-6 text-center text-5xl">
        <div style="color: #1D9ADD;"><b>PAHO Programme Impact Assessment Tool</b></div>
      </div>
    </div>
    <div class="w-1/4">
      <div id="class" ="p-2 text-base">
        <div class="text-right">
          <a href="https://www.paho.org/es/hearts-americas">Español</a>
          |
          <a href="www.infobae.com">Inglés</a>
        </div>
        <a id="go" class="pt-0 text-right" href="#!/avanzada">
          <div><b>INGRESAR</b></div>
        </a>
      </div>
    </div>
  </div>
</nav>

<div class="flex h-screen">
  <div class="relative h-auto w-3/4">
    <div class="h-full bg-[url(https://www.paho.org/sites/default/files/styles/max_1500x1500/public/2023-11/boys-water.jpg?itok=ZfMrtN2G)] bg-cover bg-center"></div>
    <div class="absolute inset-0 flex items-center justify-center">
      <p class="px-4 text-center text-4xl text-white">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum quam in dictum aliquet. Vestibulum non ante a mi bibendum facilisis at vitae libero. Integer id aliquam sapien.</p>
    </div>
  </div>
  <div id="div_1" class="h-auto w-1/4 py-5" style="background-color: #FF671B">
    <div>
      <div class="flex w-full items-center justify-center py-3">
        <div class="pl-9 text-white">
          <svg class="fill-white" xmlns="http://www.w3.org/2000/svg" height="3em" viewBox="0 0 512 512">
            <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
            <path d="M201.5 174.8l55.7 55.8c3.1 3.1 3.1 8.2 0 11.3l-11.3 11.3c-3.1 3.1-8.2 3.1-11.3 0l-55.7-55.8-45.3 45.3 55.8 55.8c3.1 3.1 3.1 8.2 0 11.3l-11.3 11.3c-3.1 3.1-8.2 3.1-11.3 0L111 265.2l-26.4 26.4c-17.3 17.3-25.6 41.1-23 65.4l7.1 63.6L2.3 487c-3.1 3.1-3.1 8.2 0 11.3l11.3 11.3c3.1 3.1 8.2 3.1 11.3 0l66.3-66.3 63.6 7.1c23.9 2.6 47.9-5.4 65.4-23l181.9-181.9-135.7-135.7-64.9 65zm308.2-93.3L430.5 2.3c-3.1-3.1-8.2-3.1-11.3 0l-11.3 11.3c-3.1 3.1-3.1 8.2 0 11.3l28.3 28.3-45.3 45.3-56.6-56.6-17-17c-3.1-3.1-8.2-3.1-11.3 0l-33.9 33.9c-3.1 3.1-3.1 8.2 0 11.3l17 17L424.8 223l17 17c3.1 3.1 8.2 3.1 11.3 0l33.9-34c3.1-3.1 3.1-8.2 0-11.3l-73.5-73.5 45.3-45.3 28.3 28.3c3.1 3.1 8.2 3.1 11.3 0l11.3-11.3c3.1-3.2 3.1-8.2 0-11.4z" />
          </svg>
        </div>
        <div class="px-9 text-white">
          <div>
            <b>Vacuna contra el HPV</b>
          </div>
          <div>Modelo de evaluación del impacto epidemiológico y de costo-efectividad de la vacunación contra el virus del papiloma humano (VPH)</div>
        </div>
      </div>
    </div>
    <!-- Contenido del segundo div -->
    <div>
      <div class="flex w-full items-center justify-center py-3">
        <div class="pl-9 text-white">
          <svg class="fill-white" xmlns="http://www.w3.org/2000/svg" height="3em" viewBox="0 0 512 512">
            <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
            <path d="M458.4 64.3C400.6 15.7 311.3 23 256 79.3 200.7 23 111.4 15.6 53.6 64.3-21.6 127.6-10.6 230.8 43 285.5l175.4 178.7c10 10.2 23.4 15.9 37.6 15.9 14.3 0 27.6-5.6 37.6-15.8L469 285.6c53.5-54.7 64.7-157.9-10.6-221.3zm-23.6 187.5L259.4 430.5c-2.4 2.4-4.4 2.4-6.8 0L77.2 251.8c-36.5-37.2-43.9-107.6 7.3-150.7 38.9-32.7 98.9-27.8 136.5 10.5l35 35.7 35-35.7c37.8-38.5 97.8-43.2 136.5-10.6 51.1 43.1 43.5 113.9 7.3 150.8z" />
          </svg>
        </div>

        <div class="px-9 text-white">
          <div>
            <b>HEARTS</b>
          </div>
          <div>Modelo de evaluación del impacto epidemiológico y de costo-efectividad del control de la presión arterial con tratamiento farmacológico</div>
        </div>
      </div>
    </div>

    <div>
      <div class="flex w-full items-center justify-center py-3">
        <div class="pl-9 text-white">
          <svg fill="white" height="3em" width="3em" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-217 51 256 256" xml:space="preserve">
            <path
              d="M-87.3,117.5c-17,0-30.9-13.7-30.9-30.7c0-16.9,13.8-30.6,30.9-30.6c17.1,0,30.9,13.7,30.9,30.6
	            C-56.4,103.8-70.2,117.5-87.3,117.5z"
            />
            <path
              d="M5.3,244.5L-19,159.8c-9.7-33.9-38.1-32.8-38.1-32.8h-60.4c0,0-28.3-1.1-38.1,32.8l-24.3,84.7c-2.3,7.9,2,14,9,15.9
              c6.9,2,14-1.5,15.8-7.8l23.6-82.6l11.6,0l-37.8,131.8h140.9L-54.7,170l11.5,0l23.7,82.6c1.8,6.3,8.9,9.8,15.8,7.8
              C3.3,258.4,7.6,252.4,5.3,244.5z M-41.6,248.3c0,25.2-20.4,45.7-45.7,45.7c-25.2,0-45.7-20.5-45.7-45.7c0-25.2,20.4-45.7,45.7-45.7
              C-62.1,202.6-41.6,223-41.6,248.3z"
            />
            <path
              d="M-77.5,237.1c-5.5-2.6-7.8-9.1-5.2-14.6c2.6-5.5,9.1-7.8,14.6-5.2c5.5,2.6,7.8,9.1,5.2,14.6
	            C-65.5,237.4-72,239.7-77.5,237.1z"
            />
            <path
              d="M-67.2,252.4c-1.1,2.3-6.9,14.5-8,16.9c-3.2,6.8-11.4,9.8-18.3,6.5c-2.2-1.1-3.9-2.7-5.4-4.5c-2.2-2.7-3.6-10-3.6-10
              c-2.3,1.6-8.1,5.3-10.5,7c-2.2,1.5-5.2,1-6.8-1.2c-1.6-2.2-1-5.2,1.2-6.8c3.5-2.4,13.1-9,13.1-9c2.9-2.1,7-1.4,9,1.6l4.1,8.3
              l6.5-13.1l-5.7-1.7c-1.2-0.4-2.3-1.2-2.9-2.4l-5.6-10.7c-1.2-2.3-0.3-5.2,2-6.4c2.3-1.2,5.2-0.3,6.4,2c0,0,3.3,6.4,4.6,8.9
              c3.1,0.9,15.5,4.5,15.5,4.5c0.7,0.2,1.2,0.6,1.7,1C-66.9,245.4-65.7,249.2-67.2,252.4z"
            />
          </svg>
        </div>

        <div class="px-9 text-white">
          <div>
            <b>Hemorragia postparto</b>
          </div>
          <div>Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna</div>
        </div>
      </div>
    </div>

    <div>
      <div class="flex w-full items-center justify-center py-3">
        <div class="pl-9 text-white">
          <svg fill="white" height="3em" width="3em" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-217 51 256 256" xml:space="preserve">
            <path
              d="M-87.3,117.5c-17,0-30.9-13.7-30.9-30.7c0-16.9,13.8-30.6,30.9-30.6c17.1,0,30.9,13.7,30.9,30.6
	            C-56.4,103.8-70.2,117.5-87.3,117.5z"
            />
            <path
              d="M5.3,244.5L-19,159.8c-9.7-33.9-38.1-32.8-38.1-32.8h-60.4c0,0-28.3-1.1-38.1,32.8l-24.3,84.7c-2.3,7.9,2,14,9,15.9
              c6.9,2,14-1.5,15.8-7.8l23.6-82.6l11.6,0l-37.8,131.8h140.9L-54.7,170l11.5,0l23.7,82.6c1.8,6.3,8.9,9.8,15.8,7.8
              C3.3,258.4,7.6,252.4,5.3,244.5z M-41.6,248.3c0,25.2-20.4,45.7-45.7,45.7c-25.2,0-45.7-20.5-45.7-45.7c0-25.2,20.4-45.7,45.7-45.7
              C-62.1,202.6-41.6,223-41.6,248.3z"
            />
            <path
              d="M-77.5,237.1c-5.5-2.6-7.8-9.1-5.2-14.6c2.6-5.5,9.1-7.8,14.6-5.2c5.5,2.6,7.8,9.1,5.2,14.6
	            C-65.5,237.4-72,239.7-77.5,237.1z"
            />
            <path
              d="M-67.2,252.4c-1.1,2.3-6.9,14.5-8,16.9c-3.2,6.8-11.4,9.8-18.3,6.5c-2.2-1.1-3.9-2.7-5.4-4.5c-2.2-2.7-3.6-10-3.6-10
              c-2.3,1.6-8.1,5.3-10.5,7c-2.2,1.5-5.2,1-6.8-1.2c-1.6-2.2-1-5.2,1.2-6.8c3.5-2.4,13.1-9,13.1-9c2.9-2.1,7-1.4,9,1.6l4.1,8.3
              l6.5-13.1l-5.7-1.7c-1.2-0.4-2.3-1.2-2.9-2.4l-5.6-10.7c-1.2-2.3-0.3-5.2,2-6.4c2.3-1.2,5.2-0.3,6.4,2c0,0,3.3,6.4,4.6,8.9
              c3.1,0.9,15.5,4.5,15.5,4.5c0.7,0.2,1.2,0.6,1.7,1C-66.9,245.4-65.7,249.2-67.2,252.4z"
            />
          </svg>
        </div>

        <div class="px-9 text-white">
          <div>
            <b>Hemorragia postparto</b>
          </div>
          <div>Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna</div>
        </div>
      </div>
    </div>

    <div>
      <div class="flex w-full items-center justify-center py-3">
        <div class="pl-9 text-white">
          <svg fill="white" height="3em" width="3em" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-217 51 256 256" xml:space="preserve">
            <path
              d="M-87.3,117.5c-17,0-30.9-13.7-30.9-30.7c0-16.9,13.8-30.6,30.9-30.6c17.1,0,30.9,13.7,30.9,30.6
	            C-56.4,103.8-70.2,117.5-87.3,117.5z"
            />
            <path
              d="M5.3,244.5L-19,159.8c-9.7-33.9-38.1-32.8-38.1-32.8h-60.4c0,0-28.3-1.1-38.1,32.8l-24.3,84.7c-2.3,7.9,2,14,9,15.9
              c6.9,2,14-1.5,15.8-7.8l23.6-82.6l11.6,0l-37.8,131.8h140.9L-54.7,170l11.5,0l23.7,82.6c1.8,6.3,8.9,9.8,15.8,7.8
              C3.3,258.4,7.6,252.4,5.3,244.5z M-41.6,248.3c0,25.2-20.4,45.7-45.7,45.7c-25.2,0-45.7-20.5-45.7-45.7c0-25.2,20.4-45.7,45.7-45.7
              C-62.1,202.6-41.6,223-41.6,248.3z"
            />
            <path
              d="M-77.5,237.1c-5.5-2.6-7.8-9.1-5.2-14.6c2.6-5.5,9.1-7.8,14.6-5.2c5.5,2.6,7.8,9.1,5.2,14.6
	            C-65.5,237.4-72,239.7-77.5,237.1z"
            />
            <path
              d="M-67.2,252.4c-1.1,2.3-6.9,14.5-8,16.9c-3.2,6.8-11.4,9.8-18.3,6.5c-2.2-1.1-3.9-2.7-5.4-4.5c-2.2-2.7-3.6-10-3.6-10
              c-2.3,1.6-8.1,5.3-10.5,7c-2.2,1.5-5.2,1-6.8-1.2c-1.6-2.2-1-5.2,1.2-6.8c3.5-2.4,13.1-9,13.1-9c2.9-2.1,7-1.4,9,1.6l4.1,8.3
              l6.5-13.1l-5.7-1.7c-1.2-0.4-2.3-1.2-2.9-2.4l-5.6-10.7c-1.2-2.3-0.3-5.2,2-6.4c2.3-1.2,5.2-0.3,6.4,2c0,0,3.3,6.4,4.6,8.9
              c3.1,0.9,15.5,4.5,15.5,4.5c0.7,0.2,1.2,0.6,1.7,1C-66.9,245.4-65.7,249.2-67.2,252.4z"
            />
          </svg>
        </div>

        <div class="px-9 text-white">
          <div>
            <b>Hemorragia postparto</b>
          </div>
          <div>Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna</div>
        </div>
      </div>
    </div>

    <div>
      <div class="flex w-full items-center justify-center py-3">
        <div class="pl-9 text-white">
          <svg fill="white" height="3em" width="3em" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="-217 51 256 256" xml:space="preserve">
            <path
              d="M-87.3,117.5c-17,0-30.9-13.7-30.9-30.7c0-16.9,13.8-30.6,30.9-30.6c17.1,0,30.9,13.7,30.9,30.6
	            C-56.4,103.8-70.2,117.5-87.3,117.5z"
            />
            <path
              d="M5.3,244.5L-19,159.8c-9.7-33.9-38.1-32.8-38.1-32.8h-60.4c0,0-28.3-1.1-38.1,32.8l-24.3,84.7c-2.3,7.9,2,14,9,15.9
              c6.9,2,14-1.5,15.8-7.8l23.6-82.6l11.6,0l-37.8,131.8h140.9L-54.7,170l11.5,0l23.7,82.6c1.8,6.3,8.9,9.8,15.8,7.8
              C3.3,258.4,7.6,252.4,5.3,244.5z M-41.6,248.3c0,25.2-20.4,45.7-45.7,45.7c-25.2,0-45.7-20.5-45.7-45.7c0-25.2,20.4-45.7,45.7-45.7
              C-62.1,202.6-41.6,223-41.6,248.3z"
            />
            <path
              d="M-77.5,237.1c-5.5-2.6-7.8-9.1-5.2-14.6c2.6-5.5,9.1-7.8,14.6-5.2c5.5,2.6,7.8,9.1,5.2,14.6
	            C-65.5,237.4-72,239.7-77.5,237.1z"
            />
            <path
              d="M-67.2,252.4c-1.1,2.3-6.9,14.5-8,16.9c-3.2,6.8-11.4,9.8-18.3,6.5c-2.2-1.1-3.9-2.7-5.4-4.5c-2.2-2.7-3.6-10-3.6-10
              c-2.3,1.6-8.1,5.3-10.5,7c-2.2,1.5-5.2,1-6.8-1.2c-1.6-2.2-1-5.2,1.2-6.8c3.5-2.4,13.1-9,13.1-9c2.9-2.1,7-1.4,9,1.6l4.1,8.3
              l6.5-13.1l-5.7-1.7c-1.2-0.4-2.3-1.2-2.9-2.4l-5.6-10.7c-1.2-2.3-0.3-5.2,2-6.4c2.3-1.2,5.2-0.3,6.4,2c0,0,3.3,6.4,4.6,8.9
              c3.1,0.9,15.5,4.5,15.5,4.5c0.7,0.2,1.2,0.6,1.7,1C-66.9,245.4-65.7,249.2-67.2,252.4z"
            />
          </svg>
        </div>

        <div class="px-9 text-white">
          <div>
            <b>Hemorragia postparto</b>
          </div>
          <div>Modelo de evaluación del impacto epidemiológico del uso de oxitocina durante el parto para la prevención de hemorragia postparto y mortalidad materna</div>
        </div>
      </div>
    </div>

    
  </div>
</div>

    '
  )
)


