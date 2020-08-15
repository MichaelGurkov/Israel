library(readxl)

library(tidyverse)

wage = read_xlsx(paste0("C:\\Users\\Misha\\Documents\\Data\\BOI\\",
                       "Real_wage_business_sector.xlsx"),skip = 15,
                 col_names = c("Date","Wage")) %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

ggplot(wage %>% 
         filter(Date > as.Date("1990-01-01")), aes(x = Date, y = Wage)) + 
  geom_line() + 
  # geom_smooth(method = "loess") + 
  theme_bw()
