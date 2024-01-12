### Nenana Project

### Calculate daily avg, max, and min for Stage and Flow. 

require(lubridate)
require(dplyr)
require(writexl)
require(readxl)

Nenana_Data$Date <- as.Date(Nenana_Data$`Date (UTC)`) #format date

#aggregate data:
nenana_dailymean <- aggregate(Nenana_Data, by = list(Group.date = Nenana_Data$Date), FUN = mean) 

nenana_dailymin <- aggregate(Nenana_Data, by = list(Group.date = Nenana_Data$Date), FUN = min)

nenana_dailymax <- aggregate(Nenana_Data, by = list(Group.date = Nenana_Data$Date), FUN = max)

#calculate daily mean, min, and max:
nenana_dailymean <- nenana_dailymean %>% 
  rename("Daily Mean Stage" = "Stage",
         "Daily Mean Flow" = "Flow")

nenana_dailymin <- nenana_dailymin %>% 
  rename("Daily Min Stage" = "Stage",
         "Daily Min Flow" = "Flow")

nenana_dailymax <- nenana_dailymax %>% 
  rename("Daily Max Stage" = "Stage",
         "Daily Max Flow" = "Flow")

Nenana_Daily_Data <- cbind(nenana_dailymean, nenana_dailymax[,4:5], nenana_dailymin[,4:5]) #combine dataframes

Nenana_Daily_Data <- select(Nenana_Daily_Data,1,4,5,7,8,9,10) #reorder columns 

write_xlsx(Nenana_Daily_Data, path = "Nenana_Daily_Data.xlsx") #write xlsx to wd. 

