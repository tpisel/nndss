


fit_model <- combined_data %>% 
  fabletools::model(
    lm = TSLM(cases ~ avg_temp)
  )


fit_model %>% summarise

