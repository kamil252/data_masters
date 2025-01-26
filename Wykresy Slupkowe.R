
library(ggplot2)
library(gridExtra)




full_data$Gender <- factor(full_data$Gender, levels = c(0, 1), labels = c("Female", "Male"))
full_data$Married <- factor(full_data$Married, levels = c(0, 1), labels = c("No", "Yes"))
full_data$Dependents <- factor(full_data$Dependents, levels = c(0, 1, 2, 3), labels = c("0", "1", "2", "3+"))
full_data$Education <- factor(full_data$Education, levels = c(0, 1), labels = c("Not Graduate", "Graduate"))
full_data$Self_Employed <- factor(full_data$Self_Employed, levels = c(0, 1), labels = c("No", "Yes"))
full_data$Credit_History <- factor(full_data$Credit_History, levels = c(0, 1), labels = c("No", "Yes"))
full_data$Property_Area <- factor(full_data$Property_Area, levels = c(1, 2, 3), labels = c("Urban", "Semiurban", "Rural"))
full_data$Loan_Status <- factor(full_data$Loan_Status, levels = c(0, 1), labels = c("Rejected", "Approved"))


plot1 <- ggplot(full_data, aes(x = Gender, fill = Gender)) +
  geom_bar() +
  labs(x = "Gender", y = "Liczba obserwacji", fill = "Gender") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")

plot2 <- ggplot(full_data, aes(x = Married, fill = Married)) +
  geom_bar() +
  labs(x = "Married", y = "Liczba obserwacji", fill = "Married") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

plot3 <- ggplot(full_data, aes(x = Dependents, fill = Dependents)) +
  geom_bar() +
  labs(x = "Dependents", y = "Liczba obserwacji", fill = "Dependents") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")

plot4 <- ggplot(full_data, aes(x = Education, fill = Education)) +
  geom_bar() +
  labs(x = "Education", y = "Liczba obserwacji", fill = "Education") +
  theme_minimal() +
  scale_fill_brewer(palette = "Pastel1")

plot5 <- ggplot(full_data, aes(x = Self_Employed, fill = Self_Employed)) +
  geom_bar() +
  labs(x = "Self Employed", y = "Liczba obserwacji", fill = "Self Employed") +
  theme_minimal() +
  scale_fill_brewer(palette = "Pastel2")

plot6 <- ggplot(full_data, aes(x = Credit_History, fill = Credit_History)) +
  geom_bar() +
  labs(x = "Credit History", y = "Liczba obserwacji", fill = "Credit History") +
  theme_minimal() +
  scale_fill_brewer(palette = "Dark2")

plot7 <- ggplot(full_data, aes(x = Property_Area, fill = Property_Area)) +
  geom_bar() +
  labs(x = "Property Area", y = "Liczba obserwacji", fill = "Property Area") +
  theme_minimal() +
  scale_fill_brewer(palette = "Accent")

plot8 <- ggplot(full_data, aes(x = Loan_Status, fill = Loan_Status)) +
  geom_bar() +
  labs(x = "Loan Status", y = "Liczba obserwacji", fill = "Loan Status") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")


grid.arrange(plot1, plot2, plot3, plot4, nrow = 2)


grid.arrange(plot5, plot6, plot7, plot8, nrow = 2)

plot1
plot2
plot3
plot4
plot5
plot6
plot7
plot8
