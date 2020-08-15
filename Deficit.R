library(tidyverse)

library(scales)

library(Quandl)

Quandl.api_key("Vd7t2TFEjCvipyX7zPmh")

isr_def = Quandl("ODA/ISR_GGSB_NPGDP")

ggplot(isr_def, aes(x = Date, y = Value)) + 
  geom_bar(stat = "identity", width = 150) + 
  theme_bw()
