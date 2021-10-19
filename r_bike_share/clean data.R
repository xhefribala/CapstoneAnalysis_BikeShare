install.packages("magrittr") 
install.packages("dplyr")
library(magrittr)
library(dplyr)
remove.packages("ggplot2") # Unisntall ggplot
install.packages("ggplot2") # Install it again
library(ggplot2)
library(scales)

## convert 12 df into 1 df, checkn for empty columns/rows
bike_share <- rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12)
bike_share <- janitor:::remove_empty(bike_share,which = c("cols"))
bike_share <- janitor:::remove_empty(bike_share,which = c("rows"))

## convert Data time stamp into data.frame
bike_share$started_at <- lubridate:::ymd_hms(bike_share$started_at)
bike_share$ended_at <- lubridate:::ymd_hms(bike_share$ended_at)

## create hour field
bike_share$start_hour <- lubridate:::hour(bike_share$started_at)
bike_share$end_hour <- lubridate:::hour(bike_share$ended_at)

## parse the time
bike_share$start_time <- as.Date(bike_share$started_at)
bike_share$end_time <- as.Date(bike_share$ended_at)

## number of rides they had in each time slot
bike_share %>% count(start_hour, sort = T) %>% 
  ggplot() + geom_line(aes(x=start_hour, y=n)) +
  scale_y_continuous(labels = comma) +
  labs(title="Count of bike rides by hour : Previous 12 months", x="Start hour of rides", y="Number of bike rides")




