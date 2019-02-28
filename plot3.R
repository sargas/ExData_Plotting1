library(readr)
library(magrittr)
library(dplyr)
library(ggplot2)
library(lubridate)

dataset <-
  read_delim('household_power_consumption.txt', ';', na="?", col_types=cols(Date=col_date(format="%d/%m/%Y"))) %>%
  filter(Date == as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

ggplot(dataset, aes(x=as_datetime(Date) + Time)) +
  geom_line(aes(y=Sub_metering_1, color='Sub_metering_1')) +
  geom_line(aes(y=Sub_metering_2, color='Sub_metering_2')) +
  geom_line(aes(y=Sub_metering_3, color='Sub_metering_3')) +
  scale_color_manual(values=c("black", "red", 'blue')) +
  xlab('') +
  ylab('Energy Sub Metering') +
  scale_x_datetime(date_breaks='1 day', date_labels='%a') +
  guides(color=guide_legend(title=NULL))

ggsave('plot3.png')