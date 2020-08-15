library(Quandl)

library(xts)

countires_list = list(list(Country = "Israel", code = "ISR"),
                      list(Country = "Syria", code = "SYR"),
                      list(Country = "Egypt", code = "EGY"),
                      list(Country = "Jordan", code = "JOR"),
                      list(Country = "Lebanon", code = "LBN"),
                      list(Country = "SaudiArabia", code = "SAU"),
                      list(Country = "Iran", code = "IRN"))


Quandl.api_key("Vd7t2TFEjCvipyX7zPmh")

gdp_list = lapply(countires_list, function(Z){
  
    q_code = paste0("ODA/",Z$code,"_PPPPC")
    
    return(Quandl(code = q_code,type = "xts"))
  
})

gdp_list = do.call(merge.xts, gdp_list)

names(gdp_list) = sapply(countires_list,function(Z){Z$Country})

