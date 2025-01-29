library(readr)
data <- read_csv("dataset/types_of_clients_data.csv")


#Statystyki opisowe

statystyki <-
  list("IncomePerDependent" =
         list("Średnia"= ~(mean(IncomePerDependent)),
              "Mediana"= ~(median(IncomePerDependent)),
              "Odchylenie standardowe"= ~(sd(IncomePerDependent)),
              "Pierwszy kwartyl"= ~quantile(IncomePerDependent,0.25),
              "Trzeci kwartyl"= ~quantile(IncomePerDependent,0.75),
              "IQR"= ~(IQR(IncomePerDependent)),
              "Odchylenie ćwiartkowe"= ~(IQR(IncomePerDependent)/2),
              "Skośność"= ~(skew(IncomePerDependent)),
              "Kurtoza"= ~(kurtosi(IncomePerDependent)),
              "Min"= ~min(IncomePerDependent),
              "Max"= ~max(IncomePerDependent)
         ))

