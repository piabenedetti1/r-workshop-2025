## ---------------------------
## PACKAGES
## ---------------------------
# install.packages(c("tidyverse", "janitor", "skimr")) # run once if needed
library(tidyverse)
library(janitor)
library(skimr)


## ---------------------------
## 1. IMPORT
## ---------------------------
iris_data <- read_csv("iris_messy.csv")

## ---------------------------
## 2. INSPECT
## ---------------------------
head(iris_data)
colSums(is.na(iris_data))
names(iris_data)
glimpse(iris_data)
summary(iris_data)
skim(iris_data)


## ---------------------------
## 3. CLEAN NAMES
## ---------------------------

# Option 1: Use janitor to clean automatically
iris_data <- iris_data %>% clean_names()
iris_data <- iris_data %>% rename(petal_width = petal_width_cm)

# Option 2: Rename manually with dplyr
# iris_data <- iris_data %>%
#   rename(
#     sepal_length = `Sepal length`,
#     sepal_width  = sepal_Width,
#     petal_length = PetalLength,
#     petal_width  = `petal width(cm)`,
#     species      = Species,
#     notes        = Notes
#   )


## ---------------------------
## 4. REMOVE UNWANTED COLUMNS
## ---------------------------
iris_data <- iris_data %>% select(-notes)


## ---------------------------
## 5. RECODE MESSY VARIABLES
## ---------------------------

# 5a) Sepal length
unique(iris_data$sepal_length)
table(iris_data$sepal_length)

iris_data <- iris_data %>%
  mutate(
    sepal_length = recode(sepal_length, "five" = "5"),
    sepal_length = as.numeric(sepal_length)
  )

# 5b) Species category
table(iris_data$species)

iris_data <- iris_data %>%
  mutate(
    species = species %>%
      tolower() %>%
      recode("versicolour" = "versicolor",
             "setoosa"     = "setosa") %>%
      factor(levels = c("setosa", "versicolor", "virginica"))
  )

table(iris_data$species)


## ---------------------------
## 6. DUPLICATES
## ---------------------------
sum(duplicated(iris_data))
iris_data <- iris_data %>% distinct()
sum(duplicated(iris_data))


## ---------------------------
## 7. OUTLIERS
## ---------------------------
summary(iris_data)
hist(iris_data$sepal_length)
hist(iris_data$sepal_width)
hist(iris_data$petal_length)
hist(iris_data$petal_width)
boxplot(iris_data$sepal_length)
boxplot(iris_data$petal_width)

iris_data_original <- iris_data

# Remove rows with outliers entirely
iris_data <- iris_data_original %>%
  filter(sepal_length <= 45, petal_width <= 8)

# Set outliers to NA (alternative)
iris_data <- iris_data_original %>%
  mutate(
    sepal_length = ifelse(sepal_length > 45, NA, sepal_length),
    petal_width  = ifelse(petal_width  > 8,  NA, petal_width)
  )


## ---------------------------
## 8. FINAL CHECKS AND SAVE
## ---------------------------
glimpse(iris_data)
summary(iris_data)

# write_csv(iris_data, "iris_clean.csv")
