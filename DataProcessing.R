install.packages(c('RMySQL','data.table','lubridate','shiny','leaflet','shinydashboard'))

library(RMySQL)
library(data.table)
library(lubridate)

mydb = dbConnect(MySQL(), user='root', password='pass123', dbname='cityopendata', host='localhost')

rs = dbSendQuery(mydb, "select * from 311data")
data = data.table(fetch(rs, n=-1))
data=unique(data)

data$expected_datetime=ymd_hms(data$expected_datetime)
data$requested_datetime=ymd_hms(data$requested_datetime)
data$updated_datetime=ymd_hms(data$updated_datetime)