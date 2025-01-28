

# Zamiana wartości  kategorie
types_of_clients_data$Property_Area <- factor(types_of_clients_data$Property_Area, 
                                              levels = c(1, 2, 3), 
                                              labels = c("Urban", "Semiurban", "Rural"))
types_of_clients_data$type_of_client <- factor(types_of_clients_data$type_of_client, 
                                               levels = c(0, 1), 
                                               labels = c("Basic", "Premium"))

# Wykres 1: Rozkład dochodów dla wszystkich klientów według Property_Area
library(ggplot2)
ggplot(types_of_clients_data, aes(x = Property_Area, y = HouseholdIncome, fill = Property_Area)) +
  geom_boxplot() +
  labs(
    title = "Analiza dochodów według Property_Area",
    x = "Property Area",
    y = "Household Income"
  ) +
  theme_minimal()

# Wykres 2: Rozkład dochodów klientów Basic według Property_Area
ggplot(subset(types_of_clients_data, type_of_client == "Basic"), 
       aes(x = Property_Area, y = HouseholdIncome, fill = Property_Area)) +
  geom_boxplot() +
  labs(
    title = "Analiza dochodów klientów Basic według Property_Area",
    x = "Property Area",
    y = "Household Income"
  ) +
  theme_minimal()

# Wykres 3: Rozkład dochodów klientów Premium według Property_Area
ggplot(subset(types_of_clients_data, type_of_client == "Premium"), 
       aes(x = Property_Area, y = HouseholdIncome, fill = Property_Area)) +
  geom_boxplot() +
  labs(
    title = "Analiza dochodów klientów Premium według Property_Area",
    x = "Property Area",
    y = "Household Income"
  ) +
  theme_minimal()
