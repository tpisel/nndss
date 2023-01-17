


fit_model <- combined_data %>% 
  model(
    lm = TSLM(cases ~ avg_temp)
  )


fc_model <- forecast(fit_model)

fc_model %>%  autoplot(cases)



combined_data %>%
  filter(state == "NSW") %>% 
  autoplot(avg_temp)


combined_data %>%
  filter(state == "NSW") %>% 
  gg_tsdisplay(difference(avg_temp), plot_type = "partial")






ts <- combined_data %>% fill_gaps



ts %>% 
    model(arima = ARIMA(log(cases) ~ 0 + pdq(0, 1, 1) + PDQ(0, 1, 1))) %>%
      report()


ts %>% 
  filter(state == "Vic") %>% 
  pivot_longer(c(avg_temp,cases), names_to = "Series") %>%
  autoplot()

ts %>% 
  filter(state == "Vic") %>% 
  model(TSLM(cases ~ avg_temp)) %>% 
  report()



?auto.arima


library(modelr)



mod <- lm(log(cases) ~ factor(date), data = ts)


ts %>%  add_predictions(mod) %>% 
  ggplot(aes(date,pred))+geom_line()


ts %>%  add_residuals(mod) %>% 
  ggplot(aes(date,resid))+geom_line()






