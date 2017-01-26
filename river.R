data <- read.csv("~/Desktop/Project/River/Water_Quality_data/Data.csv")
summary(data)
head(data)
data <- data[-1,]
summary(data)
str(data)
library(funModeling)
df_status(data)
data[data==""] <- NA #getting all blanks and moving them to NAs
df_status(data)

#need to find if missing data is same as 0 reading?
#some rows have all blank data, might be good to remove this
#Will also need to remove data which is in the maintenance timesheet

#For preliminary analysis, removing True Color and then will remove any rows containing NAs
data1 <- data[,-13]
data2 <- na.omit(data1)
df_status(data2)
#currently not removing any 0s, but will need to check and action them accordingly

table(data2$s_Name)


#Breaking up data into each site
Site1 <- filter(data2, s_Name=="Site1 ")
Site2 <- filter(data2, s_Name=="Site2 ")
Site3 <- filter(data2, s_Name=="Site3 ")
Site4 <- filter(data2, s_Name=="Site4 ")
Site5 <- filter(data2, s_Name=="Site5 ")
Site6 <- filter(data2, s_Name=="Site6 ")
Site7 <- filter(data2, s_Name=="Site7 ")
Site8 <- filter(data2, s_Name=="Site8 ")
Site9 <- filter(data2, s_Name=="Site9 ")

#Making a timeseries
library(forecast)
library(lubridate)

df_status(Site1)
Site1$dt_TimeStamp <- parse_date_time(Site1$dt_TimeStamp, orders = "mdy HM")
Site1$dt_TimeStamp <- as.POSIXct(Site1$dt_TimeStamp)

range(Site1$dt_TimeStamp)
Site1ts <- msts(Site1,seasonal.periods = c(96,960,3840)) #considering 15 mins a hour, hence 96 seaonal period, along with 
plot(Site1ts[,12])
df_status(Site1)

