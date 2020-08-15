import.pop.df = function(filename){
  
  library(xlsx)
  
  library(xts)
  
  df1 = read.xlsx(file = paste0(filename),
                  sheetIndex = 1,rowIndex = 8:58,colIndex = 5:9,
                  header = FALSE, colClasses = c(rep("numeric",4),"character"))
  
  df2 =  read.xlsx(file = paste0(filename),
                   sheetIndex = 2,rowIndex = 8:31,colIndex = 5:9,
                   header = FALSE, colClasses = c(rep("numeric",4),"character"))
  
  df = rbind.data.frame(df1,df2)
  
  names(df) = c("Others","Arabs","Jews","Total","Year")
  
  levels(df$Year) = trimws(levels(df$Year))
  
  ind = sapply(levels(df$Year), function(Z){grepl(pattern = "\\(",x = Z)})
  
  levels(df$Year)[ind] = gsub(pattern = "\\((\\d+)\\)",replacement = "",
                              x = levels(df$Year)[ind])
  
  levels(df$Year)[levels(df$Year) == "8.11.1948"] = "1948"
  
  df = aggregate(df,list(df$Year), mean, na.rm = TRUE)
  
  df$Year = NULL
  
  names(df)[names(df) == "Group.1"] = "Year"
  
  df = xts(df[,names(df) != "Year"],
           order.by = as.Date(df$Year, format = "%Y"))

  return(df)
  
  
}
