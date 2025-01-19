#istalacja i wczytanie bibliotek
if (!require("naniar")) install.packages("naniar")
if (!require("mice")) install.packages("mice")

library(naniar)
library(mice)

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

#wizualizacja braków danych
vis_miss(data)

#wzorce braków danych
md.pattern(data, plot = TRUE, rotate.names = TRUE)
gg_miss_upset(data)

#Unikatowe wartości
unique_counts <- data.frame(
  unikalne_wartosci = vapply(data, function(kolumna) {
    length(setdiff(unique(kolumna), NA)) 
  }, numeric(1))
)
unique_counts

#Proporcje odpowiedzi dla wybranych kategorii
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
  kolumna <- columns_to_analyze[[col_name]]
  dane <- as.data.frame(table(kolumna)) # Liczenie liczby wystąpień
  colnames(dane) <- c("odpowiedzi", "liczba_obserwacji") # Nadanie nazw kolumn
  dane$kategorie <- col_name # Dodanie kategorii
  return(dane)
}))


proportions <- proportions[, c("kategorie", "odpowiedzi", "liczba_obserwacji")]


print(proportions)
