install.packages("gtsummary")
library(gtsummary)
library(tidyverse)
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

#Rozkład w tabeli

data %>%
  select(IncomePerDependent, Loan_Status) %>%
  tbl_summary(
    by=Loan_Status,
    type = all_continuous() ~ "continuous2",
    statistic = all_continuous() ~ c(
      "{N_nonmiss}","{mean}","{sd}",
      "{median} ({p25}, {p75})",
      "{min}, {max}"),
    missing = "no",
    label = IncomePerDependent ~ "Przychód na jedną osobę w gospodarstwie domowym") %>%
  modify_header(label ~ "**Zmienna**") %>%
  modify_caption("**Rozkład IncomePerDependent wg Loan_Status**") %>%
  bold_labels() %>% 
  add_p(pvalue_fun = ~ style_pvalue(.x, digits = 2))






