#instalacja i wczytanie bibliotek
if (!require("gridExtra")) install.packages("gridExtra")

library(gridExtra)

#wczytanie danych
data <- read.csv("dataset/raw_data.csv")

#zapisanie wizualizacji typow danych przed standaryzacja
data_pre_stand <- vis_dat(data)

#zmiana pustych ciagow na NA
data[data == ""] <- NA
data[data == " "] <- NA

#usuniecie kolumny Loan_ID
if ("Loan_ID" %in% colnames(data)) {
  data <- subset(data, select = -Loan_ID)
}

#funkcja zmiany typu
map_to_numeric <- function(column, mapping) {
  factor_column <- factor(column, levels = names(mapping), labels = mapping)
  as.numeric(as.character(factor_column))
}

#standaryzacja danych (zmiana na numeryczne)
data$Gender <- map_to_numeric(data$Gender, c("Female" = 0, "Male" = 1))
data$Married <- map_to_numeric(data$Married, c("No" = 0, "Yes" = 1))
data$Dependents <- gsub("\\+", "", data$Dependents) # Usunięcie "+"
data$Dependents <- map_to_numeric(data$Dependents, c("0" = 0, "1" = 1, "2" = 2, "3" = 3))
data$Education <- map_to_numeric(data$Education, c("Not Graduate" = 0, "Graduate" = 1))
data$Self_Employed <- map_to_numeric(data$Self_Employed, c("No" = 0, "Yes" = 1))
data$CoapplicantIncome <- as.numeric(data$CoapplicantIncome)
data$Property_Area <- map_to_numeric(data$Property_Area, c("Rural" = 1, "Semiurban" = 2, "Urban" = 3))
data$Loan_Status <- map_to_numeric(data$Loan_Status, c("N" = 0, "Y" = 1))


#wizualizacja typow danych przed i po czyszczeniu
grid.arrange(data_pre_stand, vis_dat(data))

#zapisanie wyczyszczonych danych
write.csv(data, "dataset/clean_data.csv")
