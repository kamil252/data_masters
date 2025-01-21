data <- read.csv("dataset/clean_data.csv")
install.packages("validate")
library(validate)

#Definiowanie regul walidacyjnych
reguly_walidacyjne <- validator(
  
  #dochod wnioskodawcy musi byc wiekszy niz 0
  data$ApplicantIncome > 0 | is.na(data$ApplicantIncome),
  
  #kwota pozyczki musi byc wieksza od 0
  data$LoanAmount > 0 | is.na(data$LoanAmount),
  
  #historia kredytowa powinna byc deklarowana jako 0, 1 lub NA
  data$Credit_History %in% c(0,1,NA),
  
  #plec powinna byc jako 0 lub 1
  data$Gender %in% c(0,1,NA),
  
  #liczba osob na utrzymaniu musi byc liczba calkowita
  is.numeric(data$Dependents) & data$Dependents >= 0 | is.na(data$Dependents)
  
)
