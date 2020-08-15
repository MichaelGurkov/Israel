library(Quandl)

library(tidyverse)

library(gghighlight)

library(scales)

Quandl.api_key("Vd7t2TFEjCvipyX7zPmh")

codes = read.csv(paste0("C:\\Users\\Misha\\Documents\\Data\\OECD",
                        "\\Country_Codes.csv")) %>% 
  filter(OECD_member == 1) %>% 
  mutate(CODE = str_remove(CODE,"^[A-Z]{4}-")) %>% 
  mutate(CODE = str_replace(CODE,"KOREA-NS","KOR"))

cap_stock = lapply(codes$CODE, function(temp_code){
  
  temp_ind = paste0("WWDI/",temp_code,"_NE_GDI_TOTL_ZS")
  
  temp_df = Quandl(temp_ind)
  
  names(temp_df)[2] = temp_code
  
  return(temp_df)
  
  
})

capital_df = cap_stock %>% 
  reduce(inner_join, by = "Date") %>% 
  gather(key = "Country",value = "Capital_to_GDP",-Date)

ggplot(capital_df, aes(x = Date, y = Capital_to_GDP, color = Country)) + 
  geom_line() + 
  gghighlight(Country == "ISR",use_group_by = FALSE) + 
  scale_y_continuous(labels = percent_format(scale = 1)) + 
  labs(x = "", y = "", title = "Capital (gross) formation as % of GDP in OECD") + 
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))
