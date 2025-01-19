#istalacja i wczytanie bibliotek
if (!require("naniar")) install.packages("naniar")
if (!require("mice")) install.packages("mice")
if (!require("visdat")) install.packages("visdat")
if (!require("gridExtra")) install.packages("gridExtra")

library(naniar)
library(mice)
library(visdat)
library(gridExtra)

#wczytanie danych
data <- read.csv("dataset/raw_data.csv")

#podstawowe statystyki
summary(data)

#struktura danych
str(data)

#obliczanie liczby NA (brakujących wartości) uwzględniając "puste ciągi"
count_na <- function(x) {
  sum(is.na(x) | x == "" | x == " ")
}
na_count <- sapply(data, count_na)
na_count

#zamiana pustych ciagow na NA
data[data == ""] <- NA
data[data == " "] <- NA

#wizualizacja braków danych
vis_miss(data)
gg_miss_var(data)
gg_miss_case(data)

#wzorce braków danych
md.pattern(data, plot = TRUE, rotate.names = TRUE)
gg_miss_upset(data)

a1 <- gg_miss_fct(data, fct = Gender)
a2 <- gg_miss_fct(data, fct = Education)
a3 <- gg_miss_fct(data, fct = Self_Employed)
a4 <- gg_miss_fct(data, fct = Property_Area)
grid.arrange(a1, a2, a3, a4, nrow=2)

#unikatowe wartości
unique_counts <- data.frame(
  unikalne_wartosci = vapply(data, function(kolumna) {
    length(setdiff(unique(kolumna), NA)) 
  }, numeric(1))
)
unique_counts

#proporcje odpowiedzi dla wybranych kategorii
columns_to_analyze <- list(
  Gender = data$Gender,
  Married = data$Married,
  Dependents = data$Dependents,
  Education = data$Education,
  Self_Employed = data$Self_Employed,
  Credit_History = data$Credit_History,
  Property_Area = data$Property_Area,
  Loan_Status = data$Loan_Status,
  Loan_Amount_Term = data$Loan_Amount_Term
)


proportions <- do.call(rbind, lapply(names(columns_to_analyze), function(col_name) {
  kolumna <- columns_to_analyze[col_name]
  dane <- as.data.frame(table(kolumna))
  colnames(dane) <- c("odpowiedzi", "liczba_obserwacji") 
  dane$kategorie <- col_name 
  return(dane)
}))

proportions

#typy danych
data_class <- data.frame(class = sapply(data, class))
data_class

#wizualizacja typow danych
vis_dat(data)
