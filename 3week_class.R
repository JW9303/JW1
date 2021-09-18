install.packages("dplyr")
library(dplyr)

install.packages("nycflights13")
library(nycflights13)

flight_lolo<-data.frame(flights)

## group by는 특성변수로 grouping하는 것 두개 이상의 집단으로 grouping하는 것  (ex. 성별(남/여)에 따라 데이터를 split하는 것)

mutate_flight_lolo %>%
  group_by(arr_delay_group) %>%
  summarise(max=max(arr_delay),min=min(arr_delay), mean=mean(arr_delay), med=median(arr_delay), per20=quantile(arr_delay, 0,25))

table(mutate_flight_lolo$arr_delay_group)

flight_lolo %>%
  filter(!is.na(arr_delay)) %>% ##!is.na NA가 아닌 것 
  mutate(arr_delay_group=ifelse(arr_delay>0, "delay", "no delay"))%>%
  group_by(arr_delay_group) %>%
  summarise(max=max(arr_delay),min=min(arr_delay), mean=mean(arr_delay), med=median(arr_delay), per20=quantile(arr_delay, 0,25))->final
final

install.packages('ggplot2')
library(ggplot2)

flight_lolo %>%
  filter(!is.na(arr_delay))

install.packages(c("ggplot2","plyr","reshape"))

library(ggplot2)
library(reshape)
library(plyr)
library(dplyr)

install.packages("readxl")
install.packages("foreign")
library(readxl)
library(foreign)

getwd()
setwd("C:\\Users\\jw9303\\Documents\\StarWithR\\2021_graduate-main\\2021_graduate-main")

examData<-read.delim("Exam Anxiety.dat", header=TRUE)

#Simple scatter
a <- ggplot(examData, aes(Anxiety, Exam)) ## aes는 변수를 의미함 x축, y축 순서로 써야 함 

a+geom_point()

##이걸 연결하면?
a<-ggplot(examData, aes(Anxiety,Exam))+geom_point()

##Simple scatter
B<-ggplot(examData, aes(Anxiety, Exam, colour=Gender))+geom_point() ## x축과 y축은 그대로 두되, 성별에는 다른 색을 들인다

a+geom_point(shape=5, size=1, colour="black")

a+geom_point()+labs(x="Exam Anxiety", y="Exam Performance %")+ggtitle("Exam anxiety")

a<-ggplot(examData, aes(Anxiety, Exam, colour=Gender))
a
B

festivalData <-read.delim("DownloadFestival.dat", header=TRUE)
##Histogram with Outlier ## 당연히 Histogram이니까 변수가 하나
festivalHistogram<-ggplot(festivalData, aes(day1))+labs(legend.position="none")+geom_histogram(binwidth = 0.4)+labs(x="Hygiene(Day 1 of Festival)", y="Frequency")
## 돌려보면 outlier가 하나 있어서 그래프가 짜부되어서 나옴 이걸 없애볼까?

festivalData2=read.delim("DownloadFestival(No Outlier).dat", header=TRUE)

ggplot(festivalData2, aes(day1))+geom_histogram(binwidth=0.4)+labs(x="Hygiene of Day 1", y="Frequency")

## 밀도함수
festivaldensity<-ggplot(festivalData2, aes(day1))+geom_density(aes(fill=gender), alpha=0.3)
##alpha는 투명도 

##Boxplots

festivalBoxplot <- ggplot(festivalData2, aes(gender, day1))+geom_boxplot()
## Boxplot의 점들은 outlier

##stat_summary


                                              