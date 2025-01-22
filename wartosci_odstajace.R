install.packages("ggplot2")
library(ggplot2)
library(dplyr)

library(readr)
data <- read_csv("dataset/clean_data.csv")
View(clean_data)


#Wykresy pudelkowe dla ApplicantIncome, CoapplicantIncome oraz LoanAmount
pudelkowyApplicantIncome <- ggplot(data, aes(y = ApplicantIncome)) +
  geom_boxplot(fill="ivory") +
  labs(title = "Wykres pudełkowy dla Applicant Income")

pudelkowyCoapplicantIncome <- ggplot(data, aes(y = CoapplicantIncome)) +
  geom_boxplot(fill="ivory") +
  labs(title = "Wykres pudełkowy dla Coapplicant Income")

pudelkowyLoanAmount <- ggplot(data, aes(y = LoanAmount)) +
  geom_boxplot(fill="ivory") +
  labs(title = "Wykres pudełkowy dla Loan Amount")

#Histogramy dla powyzszych zmiennych
histogramApplicantIncome <- ggplot(data) +
  aes(x = ApplicantIncome) +
  geom_histogram(bins = 30, fill = "maroon3") +
  labs(title = "Histogram dla Applicant Income")+
  theme_minimal()

histogramCoapplicantIncome <- ggplot(data) +
  aes(x = CoapplicantIncome) +
  geom_histogram(bins = 30, fill = "maroon3") +
  labs(title = "Histogram dla Copplicant Income") +
  theme_minimal()

histogramLoanAmount <- ggplot(data) +
  aes(x = LoanAmount) +
  geom_histogram(bins = 30, fill = "maroon3") +
  labs(title = "Histogram dla Loan Amount") +
  theme_minimal()

gridExtra::grid.arrange(pudelkowyApplicantIncome, pudelkowyCoapplicantIncome, pudelkowyLoanAmount, histogramApplicantIncome, histogramCoapplicantIncome, histogramLoanAmount, nrow=2)
