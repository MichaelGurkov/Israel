library(Quandl)

library(tidyverse)

Quandl.api_key("Vd7t2TFEjCvipyX7zPmh")

raw_us = Quandl("FRED/GDPC1") %>% 
  arrange(Date)

us = raw_us %>% 
  mutate(Year = format(Date, "%Y")) %>% 
  group_by(Year) %>% 
  summarise(GDP = sum(Value)) %>% 
  select(Year, GDP) %>% 
  mutate(Change = c(NA, diff(GDP))) %>% 
  mutate(Ret = Change / lag(GDP)) %>% 
  filter(complete.cases(.)) %>% 
  filter(!Year == 2019)

ggplot(us,
       aes(x = Year , y = GDP, fill = Change > 0)) + 
  geom_bar(stat = "identity") + 
  theme_bw() + 
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90))

ggplot(us,
       aes(x = Year , y = Change, fill = Change > 0)) + 
  geom_bar(stat = "identity") + 
  theme_bw() + 
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90))

df = read.csv("C:\\Users\\Misha\\Documents\\Data\\OECD\\GDP.csv")
