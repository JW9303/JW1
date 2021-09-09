## 글씨가 한글로 깨질 때 Repoen with encoding > CP949를 누르면 다시 열림 

print("hello world!")
1*2

## 변수(variable)만들기
a<-2
a
a<-3
a
a<-c(3,5)
a

#scalar-Charater들은 ""로 표시해야 함  
scalar<-1
scalar
scalar<-"bts"
scalar

#Vector: 여러개의 원소들이나 하나의 row만 갖고 있는 것것
vector <-c(1,2,3)
vector
vector<-c("v","rm","suga")
vector

## matrix: vector를 여러개의 row로 쌓은, 즉 행렬
matrix<-matrix(c(1,2,3,4,5,6), nrow=3)
matrix
matrix<-matrix(c(1,2,3,4,5,6),nrow=2)
matrix

## 아래 console에 나오는 쉼표는 무엇인가? 행렬의 위치를 말해주는 것 [1,]:1번째 raw, 전체 column을 의미하는 것
## 3*2 는 3 row * 2 column 
matrix<-matrix(c(1,2,3,4,5,6), nrow=2,byrow=TRUE)
matrix
mat1<-c(1:3)
mat2<-c(4:6)
matrix<-c(mat1, mat2)
matrix
matrix<-cbind(mat1, mat2) #cbind: column을 기준으로 횡으로 붙이기기
matrix
matrix<-rbind(mat1,mat2) #rbind: row를 기준으로 종으로 붙이ㅣ
matrix

matrix[1,2] #첫번째 row, 두번째 col의 원소
matrix[1,]
matrix[1:2]
matrix[,1]
matrix[c(1,2),] #1,2번 row의 모든 원소를 추출

#array: matrix를 여러층으로 쌓은 것
matrix1<- matrix(c(1:9), nrow=3)
matrix1
matrix2<-matrix(c(10:18), nrow=3)
matrix3<-matrix(c(19:27), nrow=3)
array<-array(c(matrix1, matrix2, matrix3), dim=c(3,3,3))
array


#vector, matrix, array는 모두 같은 특성의 데이터로만 구성되어 있음. 즉 charater, logic, numberic의 한 종류로만 가능함
vector<-c(1,"1")
vector

#일반적으로 쓰는 데이터는 문자변수, 숫자변수 등이 하나의 데이터셋에 담겨 있어서 이 경우 쓰는 것이 dataframe. 앞으로 우리가 쓰는 대부분의 데이터는 dataframe일 것임

JTJname<-c("JW","TH","MJ")
JTJyear<-c(1993,1993,1994)
JTJposition<-c("talk","travel","talk")
JTJ<-data.frame(JTJname,JTJyear,JTJposition)
JTJ
str(JTJ) #structure을 보여주는 함수, obs: 관찰대상, variable: 변수
JTJ<-data.frame(JTJname,JTJyear,JTJposition, stringsAsFactors = TRUE)
JTJ
str(JTJ)
# factor란 주로 categorical한 변수로서 "값"(일반벡터)에 "level"이라는 장치를 추가한 것
str(JTJ)

gender=factor(c("male", "female", "female", "male"))
gender
str(gender)

#level의 순서를 따로 지정하지 않으면 factor의 numbering은 a-z 순서대로
gender=factor(gender, levels=c("male","female"))
gender
str(gender)

#변수 선택시 $표시 활용
JTJ$JTJname
JTJ$JTJname=factor(JTJname, levels=c("MJ", "JW", "TH"))
JTJ$JTJname

JTJ$age<-2021-JTJ$JTJyear+1
JTJ

#NULL=존재하지 않는 값
#NA=결측치

JTJ$null<-NULL
JTJ
JTJ$na<-NA
JTJ
dim(JTJ) #dimension 확인하는 함수 

JTJ[3,5]<-3 #3행 5열에 3을 넣어줘
mean(JTJ$age)
mean(JTJ$na) #na가 있기 때문에 값이 안나옴
mean(JTJ$na, na.rm=TRUE) #na중에 값이 있는 것의 평균을 구해줘 -> na 중 값이 있는 것의 평균이 나옴

getwd()

## dplyr 소개
## 데이터 전처리 과정에서 자주 사용하며, 데이터 전처리는 연구의 분석 목적에 따라 데이터를 재구조화
##필터링(특정 변수 값을 가진 데이터만 선택), 특정변수만 선택하거나(select), 정렬(ordering), 새로운 변수를 만들어(mutate, transformate)내는 등의 작업임

install.packages("dplyr")
library(dplyr)


## chain operator, %>%
##deplyr의 강점은 chain operator를 사용하여 코드를 심플하게 짤 수 있다는 점
##chain operator는 "and then"의 문법과 같이 의미로 사용. 원래는 괄호()가 이 기능 수행
##직관적인 코딩을 가능하게 하며, 소괄호 갯수 실수를 줄일 수 있음
##단축어:ctrl+shift+M

#chain operator 미사용시
x<-c(30,20,10,0)
sqrt(mean(abs(x)))
#chain operator 사용시
x %>% 
  abs() %>% 
  mean() %>% 
  sqrt()

#특정함수에 대한 도움말 참조
help(abs)


## 숫자형 벡터 처리 함수
#abs(x): 절대값
#sqrt(x): 제곱근
#ceiling(x): x보다 크거나 같은 정수
#floort(x): x보다 작거나 같은 정수
#truc(x): 소숫점 이하 절삭
#round(x, digits=3): 소수점 n자리로 반올림
#log(x, base=n): 밑이 n인 로그

##dplyr의 주요 기능 - filter는 특정 변수가 특정 값을 가지는 (예=성별: 여자) 행(row)을 선택하는 기능, 즉 data set을 횡으로 전달하는 기능

##분석에 앞서서 R 내장 데이터를 불러오자
install.packages("nycflights13")
library(nycflights13)
head(flights) #head 자료 개수를 보여줌 tibble
flight_lolo<-data.frame(flights)
str(flight_lolo)

##month=2인 자료만 subset
table(flight_lolo$month)
flight_lolo %>% 
  filter(month==2) %>% ## =를 두번써야 함 ==
  count(month) ## month 자료만 봄으로써 filtering 여부를 확인 (filter가 잘 먹혔는지 이런 식으로 확인하는 습관이 필요함)

##month=2 or day=1 자료만 subset
flight_lolo %>% 
  filter(month==2 | day==1) %>% #OR는 | 로 표기함
  head(5)

##month =2 and day=1 
flight_lolo %>% 
  filter(month==2,day==1)

##month=2가 아닌 자료만 subset
flight_lolo %>% 
  filter(month!=2)## ! + = 를 누르면 됨 (!가 R에서는 not의 의미를 가지고 있음 )

##month가 5이상인 자료만 subset
flight_lolo %>% 
  filter(month>=5)## >+=

##month가 5,7,10인 자료만 subset
flight_lolo %>% 
  filter(month %in% c(5,7,10))

##na 값 표시 또는 제거 해서 subset
flight_lolo %>% 
  filter(is.na(month)) #month가 na인 row만 표시

flight_lolo %>% 
  filter(!is.na(month)) #month가 na가 아닌 row만 표시

#필터링 한 데이터를 저장하고 싶은 경우는?
flight_lolo %>% 
  filter(month %in% c(5,7,10))->flight_df_filter

###### select####
## select는 특정 변수를 선택하는 기능(열(column)선택)


##month, day 변수만 선택해서 저장
flight_lolo %>% 
  select(month, day) ->select_flight_lolo 
str(select_flight_lolo)

##year부터 day까지
flight_lolo %>% 
  select(year:day)

#year부터 day까지의 변수만 제외해서 선택
flight_lolo %>% 
  select(!year:day)

#year, month 변수 제외하고 선택 이 때에는 c를 선택
flight_lolo %>% 
  select(-c(year, month))-> NOTYEARMONTH_flight_lolo

#### arrange
## month는 오름차순, day는 내림차순
flight_lolo %>% 
  arrange(month,-day)->arragne_flight_lolo

##mutate -> 새로운 변수(파생변수)생성

flight_lolo %>% 
  mutate(mean_distance=distance/hour, ratio_delay=arr_delay/(hour*60*minute)) ## 따로 저장을 안했기 때문에 표에 저장이 안됨 

##ifelse를 활용하여 category 변수 생성
flight_lolo %>% 
  mutate(arr_delay_group=ifelse(arr_delay>0, "delay","no delay"))->mutate_flight_lolo
## ifelse 구문(arr_delay가 0보다 크면 delay, 아니면 no delay로 넣는 arr_delay_group 변수를 생성해줘)

