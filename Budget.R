library(Quandl)

library(tidyverse)

Quandl.api_key("Vd7t2TFEjCvipyX7zPmh")

gov_df = list(Revenue_GDP = Quandl(code = "ODA/ISR_GGR_NGDP",type = "raw"),
              Expenditure_GDP = Quandl(code = "ODA/ISR_GGX_NGDP",
                                       type = "raw")) %>% 
  reduce(inner_join, by = "Date") %>% 
  setNames(c("Date","Revenue_GDP","Expenditure_GDP"))

gov_df = gov_df %>% 
  mutate(Deficit_GDP = Expenditure_GDP - Revenue_GDP) %>% 
  arrange(Date)


ggplot(gov_df, aes(x = format(Date,"%Y"), y = Deficit_GDP)) + 
  geom_bar(stat = "identity", width = 0.5)+
  theme_bw()
