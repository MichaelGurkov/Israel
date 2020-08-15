library(Quandl)

library(xts)

Quandl.api_key("Vd7t2TFEjCvipyX7zPmh")

recession = Quandl("FRED/ISRRECDM", type = "xts")
