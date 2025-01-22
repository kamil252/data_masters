install.packages("ggplot2")
library(ggplot2)
library(dplyr)

library(readr)
data <- read_csv("dataset/clean_data.csv")
View(clean_data)


#Wykresy pudelkowe dla ApplicantIncome, CoapplicantIncome oraz LoanAmount
ggplot(data, aes(y = ApplicantIncome)) +
  geom_boxplot(fill="ivory") +
  labs(title = "Wykres pudełkowy dla Applicant Income")

ggplot(data, aes(y = CoapplicantIncome)) +
  geom_boxplot(fill="ivory") +
  labs(title = "Wykres pudełkowy dla Coapplicant Income")

ggplot(data, aes(y = LoanAmount)) +
  geom_boxplot(fill="ivory") +
  labs(title = "Wykres pudełkowy dla Loan Amount")


