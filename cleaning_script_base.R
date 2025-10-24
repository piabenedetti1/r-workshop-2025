## ---------------------------
## PACKAGES
## ---------------------------
# Base R only – no packages required


## ---------------------------
## 1. IMPORT
## ---------------------------
iris_data <- read.csv("iris_messy.csv", na.strings = c("", "NA"))

## ---------------------------
## 2. INSPECT
## ---------------------------
head(iris_data)
colSums(is.na(iris_data))
names(iris_data)
str(iris_data)
summary(iris_data)


## ---------------------------
## 3. CLEAN NAMES
## ---------------------------
# Manually rename columns
names(iris_data)[names(iris_data) == "Sepal.length"]    <- "sepal_length"
names(iris_data)[names(iris_data) == "sepal_Width"]     <- "sepal_width"
names(iris_data)[names(iris_data) == "PetalLength"]     <- "petal_length"
names(iris_data)[names(iris_data) == "petal.width.cm."] <- "petal_width"
names(iris_data)[names(iris_data) == "Species"]         <- "species"
names(iris_data)[names(iris_data) == "Notes"]           <- "notes"


## ---------------------------
## 4. REMOVE UNWANTED COLUMNS
## ---------------------------
# Easiest version
iris_data$notes <- NULL
# Alternative:
# iris_data <- subset(iris_data, select = -notes)


## ---------------------------
## 5. RECODE MESSY VARIABLES
## ---------------------------

### 5a) Sepal length
unique(iris_data$sepal_length)
iris_data$sepal_length[is.na(as.numeric(iris_data$sepal_length))]

# Fix "five" and convert to numeric
iris_data$sepal_length[iris_data$sepal_length == "five"] <- "5"
iris_data$sepal_length <- as.numeric(iris_data$sepal_length)

### 5b) Species category
table(iris_data$species)

# Convert to lowercase and fix spelling
iris_data$species <- tolower(iris_data$species)
iris_data$species[iris_data$species == "versicolour"] <- "versicolor"
iris_data$species[iris_data$species == "setoosa"]     <- "setosa"

# Convert to factor and set order
iris_data$species <- factor(iris_data$species,
                            levels = c("setosa", "versicolor", "virginica"))

table(iris_data$species)


## ---------------------------
## 6. DUPLICATES
## ---------------------------
# Check for duplicates
sum(duplicated(iris_data))
iris_data[duplicated(iris_data), ]

# Remove duplicates
iris_data <- iris_data[!duplicated(iris_data), ]

# Check again
sum(duplicated(iris_data))


## ---------------------------
## 7. OUTLIERS
## ---------------------------

### 7a) Check
summary(iris_data)
hist(iris_data$sepal_length)
hist(iris_data$sepal_width)
hist(iris_data$petal_length)
hist(iris_data$petal_width)
boxplot(iris_data$sepal_length)
boxplot(iris_data$petal_width)

iris_data_original <- iris_data

### 7b) Remove rows with outliers entirely
iris_data <- iris_data[iris_data$sepal_length <= 45 &
                         iris_data$petal_width  <= 8, ]

### 7c) Set outliers to NA (alternative)
iris_data <- iris_data_original
iris_data$sepal_length[iris_data$sepal_length > 45] <- NA
iris_data$petal_width [iris_data$petal_width  > 8]  <- NA


## ---------------------------
## 8. FINAL CHECKS AND SAVE
## ---------------------------
str(iris_data)
summary(iris_data)

# Save cleaned file
# write.csv(iris_data, "iris_clean.csv", row.names = FALSE)
