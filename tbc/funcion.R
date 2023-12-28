input = list()
input$country = "Argentina"




modelo_tbc <- function(pExitoso, 
                       pMuerte,
                       pFalla, 
                       DOTrrMuerte,
                       DOTrrFalla,
                       DOTadherencia,
                       DOTrrExito,
                       VOTrrExito,
                       VOTadherencia,
                       VOTrrFalla,
                       VOTrrMuerte,
                       pais_seleccionado,
                       cantidad_vot_semana,
                       cantidad_dot_semana,
                       datos_paises,
                       asunciones){
  
  pais_seleccionado = str_to_title(pais_seleccionado)
  datos_paises <- readxl::read_excel("tbc/data/datos_paises.xlsx")
  colnames(datos_paises)[2:ncol(datos_paises)] = str_to_title(colnames(datos_paises)[2:ncol(datos_paises)]) 
  colnames(datos_paises)[colnames(datos_paises)=="México"] = "Mexico"
  colnames(datos_paises)[colnames(datos_paises)=="Brasil"] = "Brazil"
  colnames(datos_paises)[colnames(datos_paises)=="Perú"] = "Peru"
  asunciones <- readxl::read_excel("tbc/data/asunciones.xlsx")
  
  #Cantidad de meses que dura la inducción
  Induccion_duracion <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Induccion duracion:") %>% 
    select(valor) %>% 
    as.numeric()
  
  #Cantidad de meses que dura el esquema básico (Inducción + Consolidación)
  ttoExitoso_Duracion <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Duración tratamiento:") %>% 
    select(valor) %>% 
    as.numeric()
  
  prob_internacion_con_falla <- 0.25#Porcentaje de pacientes que se internan dada la falla terapeutica
  
  
  disutilidad_tbc_activa <- 0.219 #Disutilidad de la tuberculosis activa
  
  #Costo tratamiento de inducción
  costo_trat_induccion <- datos_paises %>%
    filter(PARAMETRO=="Costo mensual del tratamiento inducción:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo tratamiento de consolidación
  costo_trat_consolidacion <- datos_paises %>%
    filter(PARAMETRO=="Costo mensual del tratamiento consolidación:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo de seguimiento
  costo_seguimiento <- datos_paises %>%
    filter(PARAMETRO=="Costo mensual de seguimiento:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo de examenes complementarios
  costo_examenes_complemen <- datos_paises %>%
    filter(PARAMETRO=="Costo mensual de examenes complementarios:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo internación por tuberculosis
  costo_internacion_falla_terapeu_a<- datos_paises %>%
    filter(PARAMETRO=="Costo de 1 día de internación:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo de un evento DOT
  costo_evento_DOT<- datos_paises %>%
    filter(PARAMETRO=="Costo de un evento de DOT:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo de un evento vDOT
  costo_evento_VOT<- datos_paises %>%
    filter(PARAMETRO=="Costo de un evento de VOT:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo programático DOT
  costo_intervencion_DOT<- datos_paises %>%
    filter(PARAMETRO=="Costo de la intervención:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  #Costo programático de vDOT
  costo_intervencion_VOT <- 0
  
  #Costo de consulta a emergencias
  costoConsulta <- datos_paises %>%
    filter(PARAMETRO=="Costo consulta a emergencias:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  
  #Costo tratamiento inducción en MR
  costo_trat_multires_induccion <- datos_paises %>%
    filter(PARAMETRO=="Costo de tratamiento multiresistente induccion:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  
  #Costo tratamiento consolidacion en MR
  costo_trat_multires_consolidacion <- datos_paises %>%
    filter(PARAMETRO=="Costo de tratamiento multiresistente consolidacion:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  
  #Utilidad de la población general
  utilidad_pob_gral <- 0.919
  
  #Mediana de edad de Tuberculosis
  mediana_edad_paciente <- datos_paises %>%
    filter(PARAMETRO=="Mediana de edad de paciente con tuberculosis:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  
  #Esperanza de vida
  esperanza_vida <- datos_paises %>%
    filter(PARAMETRO=="Esperanza de vida:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  Horizonte_temporal_meses <- 12
  cohorte <- 1000
  cantidad_vot_semana <- 5
  cantidad_dot_semana <- 5
  
  costo_internacion_falla_terapeu_b<- datos_paises %>%
    filter(PARAMETRO=="Cantidad de dias promedio de una internación por TBC ante falla") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  costo_internacion_falla_terapeu <- costo_internacion_falla_terapeu_a*costo_internacion_falla_terapeu_b
  
  
  
  ## utilidades-----
  

  #configuracion-----
  
  tasa_descuento_anual <- 0.03
  
  # epi demo-----
    utilidad_restante <- datos_paises %>%
    filter(PARAMETRO=="Utilidad restante:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  utilidad_restante_descontada <- datos_paises %>%
    filter(PARAMETRO=="Utilidad restante descontada:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  anos_vida_restantes <- datos_paises %>%
    filter(PARAMETRO=="Años de vida restantes:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  
  anos_vida_restantes <- datos_paises %>%
    filter(PARAMETRO=="Años de vida restantes:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  anos_vida_restantes_descontados <- datos_paises %>%
    filter(PARAMETRO=="Años de vida restantes descontados:") %>% 
    select(!!sym(pais_seleccionado)) %>% 
    as.numeric()
  
  
  
  #asunciones#-----
  
  pFallaResistencia <-asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Porcentaje de pacientes con falla debido a multiresistencia") %>% 
    select(valor) %>% 
    as.numeric()
  
  
  

  
  fallaDuracion <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Meses que reciben tratamiento el grupo que falla:") %>% 
    select(valor) %>% 
    as.numeric()
  
  pFallaAdherencia <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Porcentaje de pacientes con falla debido a mala adherencia") %>% 
    select(valor) %>% 
    as.numeric()
  
  pFallaReinicia <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Porcentaje de pacientes que ante fallas reinician") %>% 
    select(valor) %>% 
    as.numeric()
  

  
  pReinicia <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Porcentaje que reinicia el tratamiento en el año:") %>% 
    select(valor) %>% 
    as.numeric()
  
  ttoPerdido_Duracion <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Duración del tratamiento de los que pierden seguimiento:") %>% 
    select(valor) %>% 
    as.numeric()
  
  
  pPerdidoConsulta <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Porcentaje de perdida de tratamiento consulta emergencias:") %>% 
    select(valor) %>% 
    as.numeric()
  
  
  PerdidoCantidadConsultas <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Cantidad de consultas por paciente con perdida de tratamiento:") %>% 
    select(valor) %>% 
    as.numeric()
  
  GrupoMuerte_Meses_Vividos <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Meses que sobreviven el grupo de pacientes que mueren:") %>% 
    select(valor) %>% 
    as.numeric()
  
  GrupoMuerte_Meses_Tratados <- asunciones %>%
    filter(`PARAMETROS GLOBALES`== "Meses que reciben tratamiento el grupo de pacientes que mueren:") %>% 
    select(valor) %>% 
    as.numeric()
  
  
  
  ###costos###----
  
  
  
  
  costo_ponderado_trat_falla <- (pFallaResistencia * ((Induccion_duracion * costo_trat_multires_induccion) + ((12 - fallaDuracion - Induccion_duracion) * costo_trat_multires_consolidacion)) +
                                   pFallaAdherencia * ((Induccion_duracion * costo_trat_induccion + (12 - fallaDuracion - Induccion_duracion) * costo_trat_consolidacion) * pFallaReinicia + 
                                                         (12 - fallaDuracion) * costo_trat_consolidacion * (1 - pFallaReinicia))) / (12 - fallaDuracion)
  
  
  costo_ponderado_trat_falla
  
  
  #comienzo el arbol------
  ##Sat------
  trat_exitoso <- cohorte*pExitoso
  trat_no_exitoso <- cohorte-trat_exitoso
  falla_terapeutica <- trat_no_exitoso*pFalla
  
  muerte <- trat_no_exitoso*pMuerte
  
  perdida_seguimiento <- trat_no_exitoso-(falla_terapeutica +muerte)
  
  ##
  
  costo_a <-trat_exitoso*((costo_trat_induccion*Induccion_duracion)+
                            (costo_trat_consolidacion*(ttoExitoso_Duracion-Induccion_duracion)) +
                            (costo_seguimiento * ttoExitoso_Duracion) +
                            (costo_examenes_complemen * ttoExitoso_Duracion))
  
  utilidad_a <- trat_exitoso*(((12-ttoExitoso_Duracion) * (utilidad_pob_gral/12))+
                                (ttoExitoso_Duracion*((utilidad_pob_gral-disutilidad_tbc_activa)/12)))
  
  ##
  costo_b <- falla_terapeutica * ((((Induccion_duracion * costo_trat_induccion) + ((fallaDuracion-Induccion_duracion) * costo_trat_consolidacion)) +
                                     ((12-fallaDuracion) *costo_ponderado_trat_falla))+
                                    (12 * (costo_examenes_complemen + costo_seguimiento)  ) + (prob_internacion_con_falla * costo_internacion_falla_terapeu ))
  
  
  utilidad_b <- falla_terapeutica*(utilidad_pob_gral-disutilidad_tbc_activa)
  
  
  ##
  costo_c <- perdida_seguimiento*  ( (Induccion_duracion*costo_trat_induccion) +
                                       ((ttoPerdido_Duracion-Induccion_duracion)*costo_trat_consolidacion) +
                                       ( (costo_seguimiento + costo_examenes_complemen)*ttoPerdido_Duracion)    +
                                       ( ((Induccion_duracion*costo_trat_induccion) + 
                                            ((ttoPerdido_Duracion-Induccion_duracion)*costo_trat_consolidacion) +
                                            ( (costo_seguimiento + costo_examenes_complemen)*ttoPerdido_Duracion) ) *pReinicia) +
                                       (pPerdidoConsulta * PerdidoCantidadConsultas * costoConsulta ) )
  
  
  
  utilidad_c <- perdida_seguimiento* (utilidad_pob_gral-disutilidad_tbc_activa)
  
  #
  costo_d <- muerte *((costo_trat_induccion*(Induccion_duracion))+
                        (costo_trat_consolidacion*(GrupoMuerte_Meses_Tratados-Induccion_duracion)) +
                        (costo_seguimiento * GrupoMuerte_Meses_Tratados) +
                        (costo_examenes_complemen * GrupoMuerte_Meses_Tratados))
  
  
  
  utilidad_d <- muerte*((utilidad_pob_gral-disutilidad_tbc_activa)/12)*GrupoMuerte_Meses_Vividos
  
  ##total SAT------------------
  
  costo <- costo_a+costo_b+costo_c+costo_d
  QALYS <- utilidad_a+utilidad_b+utilidad_c+utilidad_d
  AVP <- muerte* anos_vida_restantes
  AVP_ajustados_MP <- muerte*utilidad_restante
  AVP_descontado <- muerte*anos_vida_restantes_descontados
  AVP_ajustados_MP_descontado <- muerte*utilidad_restante_descontada
  AVP_ajustados_discapacidad <- ((utilidad_pob_gral*trat_exitoso)-utilidad_a)+
    ((utilidad_pob_gral*muerte* (6/12))-utilidad_d)+
    ((falla_terapeutica *utilidad_pob_gral)-utilidad_b)+
    ((perdida_seguimiento*utilidad_pob_gral)-utilidad_c)
  
  AVP_ajustados <- AVP_ajustados_discapacidad+AVP_ajustados_MP
  AVP_ajustados_descontado <- AVP_ajustados_MP_descontado+AVP_ajustados_discapacidad
  costo_VOT_DOT <- 0
  
  ## armo vector
  
  SAT <- c(trat_exitoso,
           trat_exitoso/cohorte,
           round(perdida_seguimiento,2),
           muerte,
           QALYS,
           AVP,
           round(AVP_ajustados,2) ,
           round(AVP_ajustados_descontado,2),
           round(AVP_descontado,2),
           round(costo_VOT_DOT,2),
           "referencia",
           round(costo,2),
           "referencia",
           "referencia",
           "referencia","referencia","referencia"
  )
  
  ##DOT--------
  
  
  ##
  trat_exitoso <- (cohorte*pExitoso*DOTadherencia*DOTrrExito) +
    (cohorte*pExitoso*(1-DOTadherencia))
  
  
  ##
  
  trat_no_exitoso <- cohorte-trat_exitoso
  
  falla_terapeutica <- (trat_no_exitoso*pFalla*DOTadherencia*DOTrrFalla)+
    (trat_no_exitoso*pFalla*(1-DOTadherencia))
  
  muerte <- (trat_no_exitoso*pMuerte*DOTadherencia*DOTrrMuerte)+
    (trat_no_exitoso*pMuerte*(1-DOTadherencia))
  
  perdida_seguimiento <- trat_no_exitoso-(falla_terapeutica+muerte)
  
  ##
  
  costo_a <-trat_exitoso*((costo_trat_induccion*Induccion_duracion)+
                            (costo_trat_consolidacion*(ttoExitoso_Duracion-Induccion_duracion)) +
                            (costo_evento_DOT*cantidad_dot_semana*4*ttoExitoso_Duracion) +
                            (costo_seguimiento * ttoExitoso_Duracion)+
                            (costo_examenes_complemen * ttoExitoso_Duracion))
  
  utilidad_a <- trat_exitoso*(((12-ttoExitoso_Duracion) * (utilidad_pob_gral/12))+
                                (ttoExitoso_Duracion*((utilidad_pob_gral-disutilidad_tbc_activa)/12)))
  
  
  ##
  costo_b <- falla_terapeutica * ((((Induccion_duracion * costo_trat_induccion) +
                                      ((fallaDuracion-Induccion_duracion) * costo_trat_consolidacion)) +
                                     ((12-fallaDuracion) *costo_ponderado_trat_falla))+
                                    (12 * (costo_examenes_complemen + costo_seguimiento+(cantidad_dot_semana * 4  *costo_evento_DOT))  ) +
                                    (prob_internacion_con_falla * costo_internacion_falla_terapeu ))
  
  
  utilidad_b <- falla_terapeutica*(utilidad_pob_gral-disutilidad_tbc_activa)
  
  ##
  
  costo_c <- perdida_seguimiento*  ( (Induccion_duracion*costo_trat_induccion) +
                                       ((ttoPerdido_Duracion-Induccion_duracion)*costo_trat_consolidacion) +
                                       ( (costo_seguimiento + costo_examenes_complemen + (4*cantidad_dot_semana*costo_evento_DOT))*ttoPerdido_Duracion)    +
                                       ( ((Induccion_duracion*costo_trat_induccion) + 
                                            ((ttoPerdido_Duracion-Induccion_duracion)*costo_trat_consolidacion) +
                                            ( (costo_seguimiento + costo_examenes_complemen+(4*cantidad_dot_semana*costo_evento_DOT))*ttoPerdido_Duracion) ) *pReinicia) +
                                       (pPerdidoConsulta * PerdidoCantidadConsultas * costoConsulta ) )
  
  
  
  utilidad_c <- perdida_seguimiento* (utilidad_pob_gral-disutilidad_tbc_activa)
  
  
  ##
  costo_d <- muerte *((costo_trat_induccion*(Induccion_duracion))+
                        (costo_trat_consolidacion*
                           (GrupoMuerte_Meses_Tratados-Induccion_duracion)) +
                        (costo_evento_DOT * cantidad_dot_semana*4*GrupoMuerte_Meses_Tratados) +
                        ((costo_examenes_complemen + costo_seguimiento)* GrupoMuerte_Meses_Tratados))
  
  #=($G$32*$G$20*4*GrupoMuerte_Meses_Tratados)+(($G$29+$G$30))
  
  utilidad_d <- muerte*((utilidad_pob_gral-disutilidad_tbc_activa)/12)*GrupoMuerte_Meses_Vividos
  
  ##DOT total
  
  costo <- costo_a+costo_b+costo_c+costo_d
  QALYS <- utilidad_a+utilidad_b+utilidad_c+utilidad_d
  AVP <- muerte* anos_vida_restantes
  AVP_ajustados_MP <- muerte*utilidad_restante
  AVP_descontado <- muerte*anos_vida_restantes_descontados
  AVP_ajustados_MP_descontado <- muerte*utilidad_restante_descontada
  AVP_ajustados_discapacidad <- ((utilidad_pob_gral*trat_exitoso)-utilidad_a)+
    ((utilidad_pob_gral*muerte* (6/12))-utilidad_d)+
    ((falla_terapeutica *utilidad_pob_gral)-utilidad_b)+
    ((perdida_seguimiento*utilidad_pob_gral)-utilidad_c)
  
  AVP_ajustados <- AVP_ajustados_discapacidad+AVP_ajustados_MP
  AVP_ajustados_descontado <- AVP_ajustados_MP_descontado+AVP_ajustados_discapacidad
  costo_VOT_DOT <- ((trat_exitoso*ttoExitoso_Duracion) +
                      (falla_terapeutica *12) +
                      (perdida_seguimiento * ttoPerdido_Duracion) +
                      (muerte* GrupoMuerte_Meses_Tratados)) * (4 * costo_evento_DOT * cantidad_dot_semana)
  
  ### creo vector
  costos_evitados <- (as.numeric(SAT[12])-(costo-costo_VOT_DOT))
  options(scipen = 99)
  DOT <- c(trat_exitoso,
           trat_exitoso/cohorte,
           perdida_seguimiento,
           muerte,
           QALYS,
           AVP,
           AVP_ajustados ,
           AVP_ajustados_descontado,
           AVP_descontado,
           costo_VOT_DOT,
           costos_evitados,
           costo,
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[7])-AVP_ajustados)),
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[6])-AVP)),
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[9])-AVP_descontado)),
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[8])-AVP_ajustados_descontado)),
           (costos_evitados-costo_VOT_DOT)/costo_VOT_DOT
  )
  DOT
  
  ##VOT--------
  
  ##
  trat_exitoso <- (cohorte*pExitoso*VOTadherencia*DOTrrExito*VOTrrExito) +
    (cohorte*pExitoso*(1-VOTadherencia))
  
  
  ##
  
  trat_no_exitoso <- cohorte-trat_exitoso
  
  falla_terapeutica <- (trat_no_exitoso*pFalla*VOTadherencia*DOTrrFalla*VOTrrFalla)+
    (trat_no_exitoso*pFalla*(1-VOTadherencia))
  
  muerte <- (trat_no_exitoso*pMuerte*VOTadherencia*DOTrrMuerte*VOTrrMuerte)+
    (trat_no_exitoso*pMuerte*(1-VOTadherencia))
  
  perdida_seguimiento <- trat_no_exitoso-(falla_terapeutica+muerte)
  
  
  ##
  
  costo_a <-trat_exitoso*((costo_trat_induccion*Induccion_duracion)+
                            (costo_trat_consolidacion*(ttoExitoso_Duracion-Induccion_duracion)) +
                            (costo_evento_VOT*cantidad_dot_semana*4*ttoExitoso_Duracion) +
                            (costo_seguimiento * ttoExitoso_Duracion)+
                            (costo_examenes_complemen * ttoExitoso_Duracion))
  
  utilidad_a <- trat_exitoso*(((12-ttoExitoso_Duracion) * (utilidad_pob_gral/12))+(ttoExitoso_Duracion*((utilidad_pob_gral-disutilidad_tbc_activa)/12)))
  
  
  ##
  costo_b <- falla_terapeutica * ((((Induccion_duracion * costo_trat_induccion) +
                                      ((fallaDuracion-Induccion_duracion) * costo_trat_consolidacion)) +
                                     ((12-fallaDuracion) *costo_ponderado_trat_falla))+
                                    (12 * (costo_examenes_complemen + costo_seguimiento+(cantidad_dot_semana * 4  *costo_evento_VOT))  ) +
                                    (prob_internacion_con_falla * costo_internacion_falla_terapeu ))
  
  
  utilidad_b <- falla_terapeutica*(utilidad_pob_gral-disutilidad_tbc_activa)
  
  ##
  
  costo_c <- perdida_seguimiento*  ( (Induccion_duracion*costo_trat_induccion) +
                                       ((ttoPerdido_Duracion-Induccion_duracion)*costo_trat_consolidacion) +
                                       ( (costo_seguimiento + costo_examenes_complemen + (4*cantidad_dot_semana*costo_evento_VOT))*ttoPerdido_Duracion)    +
                                       ( ((Induccion_duracion*costo_trat_induccion) + 
                                            ((ttoPerdido_Duracion-Induccion_duracion)*costo_trat_consolidacion) +
                                            ( (costo_seguimiento + costo_examenes_complemen+(4*cantidad_dot_semana*costo_evento_VOT))*ttoPerdido_Duracion) ) *pReinicia) +
                                       (pPerdidoConsulta * PerdidoCantidadConsultas * costoConsulta ) )
  
  
  
  utilidad_c <- perdida_seguimiento* (utilidad_pob_gral-disutilidad_tbc_activa)
  
  
  ##
  
  costo_d <- muerte *((costo_trat_induccion*Induccion_duracion)+
                        (costo_trat_consolidacion*(GrupoMuerte_Meses_Tratados-Induccion_duracion))+
                        (costo_evento_VOT*cantidad_vot_semana*4*GrupoMuerte_Meses_Tratados) + 
                        (costo_seguimiento * GrupoMuerte_Meses_Tratados) + 
                        (costo_examenes_complemen * GrupoMuerte_Meses_Tratados))
  
  
  
  utilidad_d <- muerte*((utilidad_pob_gral-disutilidad_tbc_activa)/12)*GrupoMuerte_Meses_Vividos
  
  ##VOT total ------
  
  costo <- costo_a+costo_b+costo_c+costo_d
  QALYS <- utilidad_a+utilidad_b+utilidad_c+utilidad_d
  AVP <- muerte* anos_vida_restantes
  AVP_ajustados_MP <- muerte*utilidad_restante
  AVP_descontado <- muerte*anos_vida_restantes_descontados
  AVP_ajustados_MP_descontado <- muerte*utilidad_restante_descontada
  AVP_ajustados_discapacidad <- ((utilidad_pob_gral*trat_exitoso)-utilidad_a)+
    ((utilidad_pob_gral*muerte* (6/12))-utilidad_d)+
    ((falla_terapeutica *utilidad_pob_gral)-utilidad_b)+
    ((perdida_seguimiento*utilidad_pob_gral)-utilidad_c)
  
  AVP_ajustados <- AVP_ajustados_discapacidad+AVP_ajustados_MP
  AVP_ajustados_descontado <- AVP_ajustados_MP_descontado+AVP_ajustados_discapacidad
  costo_VOT_DOT <- ((trat_exitoso*ttoExitoso_Duracion) +
                      (falla_terapeutica *12) +
                      (perdida_seguimiento * ttoPerdido_Duracion) +
                      (muerte* GrupoMuerte_Meses_Tratados)) * (4 * costo_evento_VOT * cantidad_vot_semana)
  
  
  ### creo vector
  costos_evitados <- (as.numeric(SAT[12])-(costo-costo_VOT_DOT))
  
  VOT <- c(trat_exitoso,
           trat_exitoso/cohorte,
           perdida_seguimiento,
           muerte,
           QALYS,
           AVP,
           AVP_ajustados ,
           AVP_ajustados_descontado,
           AVP_descontado,
           costo_VOT_DOT,#10
           costos_evitados, 
           costo,
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[7])-AVP_ajustados)),
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[6])-AVP)),
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[9])-AVP_descontado)),
           ((costo-as.numeric(SAT[12]))/(as.numeric(SAT[8])-AVP_ajustados_descontado)),
           (costos_evitados-costo_VOT_DOT)/costo_VOT_DOT
  )
  VOT
  
  ### resultados -----
  # Nombres de los parámetros, como se ven en tu tabla.
  parametros <- c("Tratamientos exitosos (n)", "Porcentaje de éxito (%)",
                  "Perdida de seguimiento", 
                  "Muertes evitadas (n)",
                  "Años de vida ajustados por calidad",
                  "Años de vida ajustados por discapacidad evitados", 
                  "Años de vida ajustados por calidad perdidos",
                  "Años de vida perdidos descontados",
                  "Años de vida ajustados por calidad perdidos descontados",
                  "Costos de intervención (USD)",
                  "Costos por eventos evitados (USD)", 
                  "Costos totales",
                  "ICER por año de vida ajustado por calidad perdido evitado",
                  "ICER por año de vida perdido evitado",
                  "ICER por año de vida ajustado por calidad perdido evitado descontado",
                  "ICER por año de vida perdido evitado descontado", 
                  "Retorno de Inversión (%)")
  
  # Crear el dataframe
  resultados <- data.frame(Parametro=parametros, SAT=SAT, DOT=DOT, VOT=VOT)
  
  resultados[-1] <- lapply(resultados[-1], function(x) if(is.numeric(x)) round(x, 2) else x)
  
  return(
    resultados
    )
    
  
  
} 

# 
# modelo_tbc(params$pExitoso,
#            params$pMuerte,
#            params$pFalla, 
#            params$DOTrrMuerte,
#            params$DOTrrFalla,
#            params$DOTadherencia,
#            params$DOTrrExito,
#            params$VOTrrExito,
#            params$VOTadherencia,
#            params$VOTrrFalla,
#            params$VOTrrMuerte,
#            input$country,
#            params$cantidad_vot_semana,
#            params$cantidad_dot_semana,
#            datos_paises,
#            asunciones)

get_tbc_params = function () {
  params = list()
  params$DOTrrExito = 1.14
  params$VOTrrExito = 1.36
  params$VOTadherencia = 0.78
  params$pExitoso <- 0.661
  params$pMuerte <- 0.23
  params$pFalla <- 0.11
  params$DOTrrMuerte  <- 0.45
  params$DOTrrFalla <- 0.49
  params$DOTadherencia <- 0.31
  params$VOTrrMuerte <- 1
  params$VOTrrFalla <- 1
  params$cantidad_vot_semana <- 5
  params$cantidad_dot_semana <- 5
  
  params
}

get_tbc_params_labels = function () {
  c(
    'Riesgo Relativo (RR) del tratamiento exitoso con con tratamiento de observación directa vs tratamiento autoadministrado',
    'Riesgo relativo tratamiento exitoso tratamiento de observación directa por video vs tratamiento de observación directa',
    'Porcentaje de adherencia a tratamiento de observación directa por video (%)',
    'Porcentaje de tratamiento exitoso mediante tratamiento autosupervisado',
    'Porcentaje de muerte dado tratamiento no exitoso mediante tratamiento autosupervisado',
    'Porcentaje de falla terapéutica dado tratamiento no exitoso mediante tratamiento autosupervisado',
    'Riesgo relativo de muerte tratamiento directamente observado vs tratamiento autosupervisado',
    'Riesgo relativo de falla terapéutica del tratamiento directamente observado vs tratamiento autosupervisado',
    'Porcentaje de adherencia al tratamiento directamente observado (%)',
    'Riesgo relativo de muerte mediante tratamiento directamente observado por video vs tratamiento directamente observado',
    'Riesgo relativo de falla terapéutica con tratamiento directamente observado por video vs tratamiento directamente observado',
    'Cantidad de dosis supervisadas mediante tratamiento directamente observado por video por semana',
    'Cantidad de dosis supervisadas mediante tratamiento directamente observado por semana'
  )
}