install.packages("ggplot2")
if (!require(mfx)) install.packages("mfx")
if (!require(margins)) install.packages("margins")
if (!require(dplyr)) install.packages("dplyr")
if (!require(lmtest)) install.packages("lmtest")
if (!require(sandwich)) install.packages("sandwich")
if (!require(car)) install.packages("car")
if (!require(pscl)) install.packages("pscl")
if (!require(ROCR)) install.packages("ROCR")
if (!require(AER)) install.packages("AER")
if (!require(MASS)) install.packages("MASS")
if (!require(effects)) install.packages("effects")
if (!require(reshape2)) install.packages("reshape2")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require("nnet")) install.packages("nnet", dependencies = TRUE)
if (!require(mlogit)) install.packages("mlogit")
if (!require(tidyr)) install.packages("tidyr")
if (!require(readxl)) install.packages("readxl")
if (!require(censReg)) install.packages("censReg")
if (!require(haven)) install.packages("haven")

library(mfx)
library(margins)
library(dplyr)
library(lmtest)
library(sandwich)
library(car)
library(pscl)
library(ROCR)
library(AER)
library(MASS)
library(effects)
library(reshape2) 
library(ggplot2)
library(nnet)
library(mlogit)
library(tidyr)
library(readxl)
library(haven)
library(censReg)
library(ggplot2)
library(dplyr)

library(readr)
data <- read_csv("dataset/full_data.csv")
View(data)


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


#Identyfikacja wartosci odstajacych

#Definiujemy funkcję "identyfikacja",ktora pomoze nam w identyfikacji wartosci odstajacych za pomoca IQR - 
identyfikacja <- function(column) {
  Q1 <- quantile(column, 0.25, na.rm = TRUE)
  Q3 <- quantile(column, 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  
outliers <- column[column < lower_bound | column > upper_bound]
  return(list(
    lower_bound = lower_bound,
    upper_bound = upper_bound,
    outliers = outliers
  ))
}

#Analiza wartosci dla zmiennych ApplicantIncome, CoapplicantIncome i LoanAmount
ApplicantIncomeOutliers <- identyfikacja(data$ApplicantIncome)
CoapplicantIncomeOutliers <- identyfikacja(data$CoapplicantIncome)
LoanAmountOutliers <- identyfikacja(data$LoanAmount)


#Wyswietlenie wynikow
print("Wartosci odstajace dla ApplicantIncome")
print(ApplicantIncomeOutliers$outliers)
print("Wartosci odstajace dla CoapplicantIncome")
print(CoapplicantIncomeOutliers$outliers)
print("Wartosci odstajace dla LoanAmount")
print(LoanAmountOutliers$outliers)

