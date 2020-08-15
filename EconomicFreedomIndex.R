library(tidyverse)


efw_df = read.csv(paste0("C:\\Users\\Misha\\Documents\\Data\\",
                      "Economic Freedom of the World\\EFW_Index_2019.csv"),
                  col.names = c("Year","ISO_Code","Country","EFW",
                                "Gov_size","Property_Rights",
                                "Money","FreeTrade","Regulation"))

ggplot(efw_df %>% 
         filter(Country == "Israel"), aes(x = Year, y = EFW)) + 
  geom_line() + 
  theme_bw()

ggplot(efw_df %>% 
         filter(Year == 2017) %>% 
         filter(EFW > 7.2),
       aes(x = reorder(Country, Gov_size), y = Gov_size,
           fill = (Country == "Israel"))) + 
  geom_bar(stat = "identity") + 
  coord_flip() + 
  theme_bw() + 
  theme(axis.text.y = element_text(size = 5), legend.position = "none")
