

data %>%
  filter(Week < as.Date("2020-01-01 UTC")) %>%
  select(Week,State) %>%
  group_by(Week,State) %>% 
  summarise(Cases = n()) %>% 
  as_tsibble(key = State, index = Week, regular = FALSE) %>% 
  index_by(t = floor_date(Week, unit = "1 week")) %>%
  summarise(Cases = sum(Cases)) %>%
  as_tibble() %>%
  select(t,Cases) %>%
  transmute(t = as.Date(t),Cases=Cases) %>%
  as_tsibble(index = t) %>%
  model(feasts::STL(Cases)) %>% 
  components() %>%
  autoplot()


data %>%
  filter(Week < as.Date("2020-01-01 UTC")) %>%
  group_by(Week) %>% 
  summarise(Cases = n()) %>%
  transmute(t = as.Date(floor_date(Week, unit = "1 week")), Cases) %>% 
  as_tsibble(index = t) %>%
  model(feasts::STL(Cases)) %>% 
  components() %>%
  autoplot()

# model(stl = STL(Cases))
