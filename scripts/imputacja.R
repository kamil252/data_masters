#instalacja pakietów
if (!require("mice")) install.packages("mice")
if (!require("dplyr")) install.packages("dplyr")
if (!require("dplyr")) install.packages("dplyr")
if (!require("gridExtra")) install.packages("gridExtra")

library(gridExtra)
library(dplyr)
library(mice)
library(dplyr)
library(mice)

#wczytanie danych
data <- read.csv("dataset/clean_data.csv")
pre_imp <- vis_miss(data)
# imputacja danych - mediana dla "Married"
if ("Married" %in% colnames(data)) {
  # Obliczenie mediany dla zmiennej "Married" (bez NA)
  mediana_married <- median(data$Married, na.rm = TRUE)
  
  #Zastąpienie braków danych w "Married" medianą
  data$Married[is.na(data$Married)] <- mediana_married
}

#imputacja pozostalych - metoda mice

variables_with_na <- c("Gender", "Dependents", "Self_Employed", 
                       "LoanAmount", "Loan_Amount_Term", "Credit_History")

data_mice <- data[variables_with_na]

print("Braki przed imputacją:")
print(colSums(is.na(data_mice)))

imputacja <- mice(data_mice, m = 5, maxit = 50, method = 'pmm', seed = 123)

print("Podsumowanie imputacji:")
summary(imputacja)

data_imputed <- complete(imputacja)

data[variables_with_na] <- data_imputed

print("Braki po imputacji:")
print(colSums(is.na(data)))

print("Podsumowanie danych po imputacji:")
summary(data)


post_imp <- vis_miss(data)

grid.arrange(pre_imp, post_imp)

#zapisanie uzupełnionych danych
write.csv(data, "dataset/full_data.csv")
