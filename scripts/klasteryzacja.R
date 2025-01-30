library(factoextra)
library(dplyr)


data <- read.csv("dataset/full_data.csv")

# Normalizacja danych
s_data <- scale(data)

# Wybór optymalnej liczby klastrów
fviz_nbclust(s_data, kmeans, method = "silhouette")

# Klasteryzacja
clusters <- kmeans(s_data, centers = 2, nstart = 25)

fviz_cluster(clusters, data = s_data,
             palette = "Accent", 
             ellipse.type = "euclid", 
             star.plot = TRUE, 
             repel = TRUE, 
             ggtheme = theme_minimal())

# Dodaj kolumnę z etykietą klastra do danych
data$Cluster <- as.factor(clusters$cluster)
data
# Statystyki opisowe dla każdego klastra
summary_stat <- data %>%
  group_by(Cluster) %>%
  summarise(across(everything(), list(mean = ~mean(.), sd = ~sd(.), median = ~median(.), 
                                      min = ~min(.), max = ~max(.), n = ~length(.)), 
                   .names = "{col}_{fn}"))

summary_statistics <- summary_stat[,14:ncol(summary_stat)]
