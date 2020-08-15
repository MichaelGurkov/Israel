source("C:\\Users\\Misha\\Documents\\Israel\\Auxilary-Functions.R")

library(PerformanceAnalytics)

pop.df = import.pop.df(paste0("C:\\Users\\Misha\\Documents",
                              "\\Data\\Israel\\st02_01.xlsx"))


x.cord = barplot(t(pop.df[,c("Arabs","Jews")]),
        col = c("green","blue"), las = 2, beside = TRUE,
        xaxt = "n", space = c(0,1.5),
        main = paste0("Population of Israel ",
                     format(index(pop.df)[1], "%Y"),"-",
                     format(index(pop.df)[nrow(pop.df)], "%Y")),
        ylab = "Thousands")

axis(side = 1,at = apply(x.cord,2,mean),
     labels = format(index(pop.df), "%Y"))

par(xpd = TRUE)

legend("bottom", c("Arabs","Jews"), pch = 15,
       col = c("green","blue"), bty = "n", inset = -0.3,
       horiz = TRUE)


plot.zoo(CalculateReturns(pop.df$Jews)[-1] * 100, type = "h",
         ylab = "Percent", xaxt = "n",las = 2, xlab = "",lwd =2,
         col = "blue",
         main = "Annual growth rate of Jewish population in Israel")

axis(side = 1,at = index(pop.df),
     labels = format(index(pop.df), "%Y"))

