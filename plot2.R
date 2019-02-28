library(readr)
library(magrittr)
library(dplyr)
library(ggplot2)
library(lubridate)

dataset <-
  read_delim('household_power_consumption.txt', ';', na="?", col_types=cols(Date=col_date(format="%d/%m/%Y"))) %>%
  filter(Date == as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

ggplot(dataset, aes(as_datetime(Date) + Time, Global_active_power)) +
  geom_line() +
  xlab('') +
  ylab('Global Active Power (kilowatts)') +
  scale_x_datetime(date_breaks='1 day', date_labels='%a')

ggsave('plot2.png')