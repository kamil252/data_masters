data <- read.csv("dataset/clean_data.csv")
install.packages("validate")
library(validate)

#Definiowanie regul walidacyjnych
reguly_walidacyjne <- validator(
  
  #dochod wnioskodawcy musi byc wiekszy niz 0
  data$ApplicantIncome > 0,
  
  #kwota pozyczki musi byc wieksza od 0
  data$LoanAmount > 0,
  
  #historia kredytowa powinna byc deklarowana jako 0, 1 lub NA
  data$Credit_History %in% c(0,1,NA),
  
  #plec powinna byc jako 0 lub 1
  data$Gender %in% c(0,1),
  
  #liczba osob na utrzymaniu musi byc liczba calkowita
  is.numeric(data$Dependents) & data$Dependents >= 0,
  
  #jesli ktos jest w zwiazku malzenskim, to ilosc osob na utrzymaniu nie moze byc 0
  if(data$Married == 1) data$Dependents > 0
  
)