library(readr)
library(magrittr)
library(dplyr)
library(ggplot2)
library(grid)
library(gridExtra)
library(lubridate)

dataset <-
  read_delim('household_power_consumption.txt', ';', na="?", col_types=cols(Date=col_date(format="%d/%m/%Y"))) %>%
  filter(Date == as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

p1 <- ggplot(dataset, aes(as_datetime(Date) + Time, Global_active_power)) +
  geom_line() +
  xlab('') +
  ylab('Global Active Power') +
  scale_x_datetime(date_breaks='1 day', date_labels='%a')

p2 <- ggplot(dataset, aes(as_datetime(Date) + Time, Voltage)) +
  geom_line() +
  xlab('') +
  scale_x_datetime(date_breaks='1 day', date_labels='%a')

p3 <- ggplot(dataset, aes(x=as_datetime(Date) + Time)) +
  geom_line(aes(y=Sub_metering_1, color='Sub_metering_1')) +
  geom_line(aes(y=Sub_metering_2, color='Sub_metering_2')) +
  geom_line(aes(y=Sub_metering_3, color='Sub_metering_3')) +
  scale_color_manual(values=c("black", "red", 'blue')) +
  xlab('') +
  ylab('Energy Sub Metering') +
  scale_x_datetime(date_breaks='1 day', date_labels='%a') +
  guides(color=guide_legend(title=NULL)) +
  theme(legend.position = c(0.90, 0.90))

p4 <- ggplot(dataset, aes(as_datetime(Date) + Time, Global_reactive_power)) +
  geom_line() +
  xlab('') +
  ylab('Global Reactive Power') +
  scale_x_datetime(date_breaks='1 day', date_labels='%a')

g <- arrangeGrob(grobs=list(p1, p2, p3, p4), nrow=2)
ggsave('plot4.png', g)