library(tidyverse)

library(scales)

m = read.csv("C:\\Users\\Misha\\Documents\\Data\\BOI\\M1-money.csv",
             stringsAsFactors = FALSE) %>% 
  rename(Date = 1) %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

b = read.csv("C:\\Users\\Misha\\Documents\\Data\\BOI\\b-money_base.csv",
             stringsAsFactors = FALSE) %>% 
  rename(Date = 1) %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

money_df = inner_join(b,m, by = "Date") %>% 
  gather(key = "Indicator",value = Val, -Date) %>% 
  group_by(Date = format(Date,"%Y"), Indicator) %>% 
  summarise(Val = mean(Val * 0.001))

ggplot(money_df, aes(x = Date, y = Val,
                     color = Indicator, group = Indicator)) + 
  geom_line() + 
  scale_color_manual(values = c("blue","black")) + 
  labs(x = "", y = "ILS (Billions)", title = "Israel money aggregates") + 
  theme_bw() + 
  theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5))


ggplot(b %>% 
         mutate(B = c(NA, diff(B))) %>% 
         filter(complete.cases(.)), aes(x = Date, y = B,
                                        fill = (B >= 0))) + 
  geom_bar(stat = "identity") + 
  labs(x = "", y = "", title = "Changes in money base in Israel") + 
  theme_bw() + 
  theme(legend.position = "none", plot.title = element_text(hjust = 0.5))
