library(readr)
library(magrittr)
library(dplyr)

dataset <-
  read_delim('household_power_consumption.txt', ';', na="?", col_types=cols(Date=col_date(format="%d/%m/%Y"))) %>%
  filter(Date == as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

png('plot1.png')
with(dataset, hist(Global_active_power, main='Global Active Power',
                   col='red', xlab='Global Active Power (kilowatts)', ylab='Frequency'))
dev.off()