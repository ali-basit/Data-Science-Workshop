#title: "R Notebook"
#output: html_notebook

#Set up connection to database 
```{r}
library(RMySQL)
library(data.table)
library(lubridate)

mydb = dbConnect(MySQL(), user='root', password='pass123', dbname='cityopendata', host='localhost')

```

#Fetch all data
```{r}
rs = dbSendQuery(mydb, "select * from 311data")
data = data.table(fetch(rs, n=-1))
data=unique(data)
```

#Convert Data
```{r}
data$expected_datetime=ymd_hms(data$expected_datetime)
data$requested_datetime=ymd_hms(data$requested_datetime)
data$updated_datetime=ymd_hms(data$updated_datetime)
```

#Convert Data
```{r}
data$request_to_finish=as.numeric(difftime(time1 = data$updated_datetime,time2 = data$requested_datetime,units = "days"))
```

#Days To Complete
```{r}
data[status=="closed",.(`Days To Complete`=mean(request_to_finish,na.rm = T)),.(service_name)]
```