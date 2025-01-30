#Usuniecie kolumny Loan_ID - nie jst potrzebna
if ("Loan_ID" %in% colnames(data)) {
  data <- subset(data, select = -Loan_ID)
}
#standaryzacja danych (zmiana na numeryczne)
map_to_numeric <- function(column, mapping) {
  factor_column <- factor(column, levels = names(mapping), labels = mapping)
  as.numeric(as.character(factor_column))
}


data$Gender <- map_to_numeric(data$Gender, c("Female" = 0, "Male" = 1))


data$Married <- map_to_numeric(data$Married, c("No" = 0, "Yes" = 1))


data$Dependents <- gsub("\\+", "", data$Dependents) # Usunięcie "+"
data$Dependents <- map_to_numeric(data$Dependents, c("0" = 0, "1" = 1, "2" = 2, "3" = 3))


data$Education <- map_to_numeric(data$Education, c("Not Graduate" = 0, "Graduate" = 1))


data$Self_Employed <- map_to_numeric(data$Self_Employed, c("No" = 0, "Yes" = 1))


data$CoapplicantIncome <- as.numeric(data$CoapplicantIncome)


data$Property_Area <- map_to_numeric(data$Property_Area, c("Rural" = 1, "Semiurban" = 2, "Urban" = 3))


data$Loan_Status <- map_to_numeric(data$Loan_Status, c("N" = 0, "Y" = 1))


#instalacja pakietów
if (!require("mice")) install.packages("mice")
if (!require("dplyr")) install.packages("dplyr")

library(mice)
library(dplyr)

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





