data <- read.csv("dataset/full_data.csv")

# Dochód gospodarstwa
data$HouseholdIncome <- data$ApplicantIncome + data$CoapplicantIncome  

# Dochód na osobę zależną 
data$IncomePerDependent <- ifelse(data$Dependents == 0, data$HouseholdIncome, data$HouseholdIncome / data$Dependents)

# Dochód na osobę zależną w kontekście pożyczki
data$IncomePerDependentToLoan <- data$IncomePerDependent / data$LoanAmount


print(data)
