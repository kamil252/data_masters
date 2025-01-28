data <- read.csv("dataset/full_data.csv")

# Dochód gospodarstwa
data$HouseholdIncome <- data$ApplicantIncome + data$CoapplicantIncome  

# Dochód na osobę zależną 
data$IncomePerDependent <- ifelse(data$Dependents == 0, data$HouseholdIncome, data$HouseholdIncome / data$Dependents)


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

odstajace <- identyfikacja(data$IncomePerDependent)

data$type_of_client <- ifelse(data$IncomePerDependent >= min(odstajace$outliers),1,0)
table(data$type_of_client)


write.csv(data, "dataset/types_of_clients_data.csv")
