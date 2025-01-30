data <- read.csv("dataset/types_of_clients_data.csv")

install.packages("ggstatsplot")
library(ggstatsplot)

#Sprawdzamy, od czego zależy decyzja pozytywna lub negatywna otrzymania kredytu

logit1 <- glm(Loan_Status ~ Married + ApplicantIncome + CoapplicantIncome + Dependents + Education + LoanAmount + Credit_History, 
              data = data, family = binomial)
summary(logit1)
#Tu zmiennymi istotnymi statystycznie jest zmienna Married oraz Credit_History

#Zostawiamy tylko Married i Credit_History
logit2 <- glm(Loan_Status ~ Married + Credit_History, 
              data = data, family = binomial)
summary(logit2)
#Liczymy ilorazy szans
OR <- exp(logit2$coefficients)
OR
#Bycie w zwiazku malzenskim zwieksza szanse na otrzymanie kredytu o 73%.
#Natomiast pozytywna historia kredytowa zwieksza szanse na otrzymanie kredytu az o 3248%


# istotne zmienne na podstawie wcześniej utworzonego modelu logistycznego

#historia kredytowa
ggbarstats(
  x = Credit_History,
  y = Loan_Status,
  data = data
)
ggbetweenstats(
  y = Credit_History,
  x = Loan_Status,
  data = data
)

#stan cywilny
ggbarstats(
  x = Married,
  y = Loan_Status,
  data = data
)
ggbetweenstats(
  y = Married,
  x = Loan_Status,
  data = data
)

#poziom edukacji
ggbarstats(
  x = Education,
  y = Loan_Status,
  data = data
)
ggbetweenstats(
  y = Education,
  x = Loan_Status,
  data = data
)