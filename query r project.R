library(readxl)
library(dplyr)
library(lubridate)
library(ggplot2)
rm(list = ls())
setwd("C:/query with r")


course <- read_excel("course.xlsx", .name_repair = "universal")
registration <- read_excel("registration.xlsx", .name_repair = "universal")
student <- read_excel("student.xlsx", .name_repair = "universal")
all_df <-student %>%
  left_join(registration, by = c("Student.ID")) %>%
  left_join(course, by = c("Instance.ID"))

compSciStudent <- all_df %>%
  dplyr::filter(Title == "Computer Science")

AllPaymentStudent <- all_df %>%
  dplyr::filter(Payment.Plan == "True")

FirstQuarterClassOption <- all_df %>%
  dplyr::filter(Start.Date> "2021-07-31" & End.Date <"2021-12-31")

TotalBalanceByPlan <- all_df %>%
  select(Payment.Plan, Balance.Due) %>%
  group_by(Payment.Plan) %>%
  summarise(Balance.Due = sum(Balance.Due))
TotalCostByMajor <- all_df %>%
  select(Title,Cost) %>%
  group_by(Title) %>%
  summarise(Cost = sum(Cost))

hist(TotalCostByMajor$Cost,
     col='green',
     main='Cost per major graph',
     xlab='Cost',
     ylab='Title')
     
