install.packages("summarytools")
library(summarytools)
view(dfSummary(iris))

install.packages("GGally")
require(GGally)
ggpairs(iris) #simple pairs plot
ggpairs(iris, aes(color = Species)) #colour by Species
plot = ggpairs(iris, aes(color = Species, alpha = 0.5)) #add some transparency
plot[x,y] #show only selected plots
ggsave("iris.png", plot) #save

data1 = mtcars #load up another dataset
ggpairs(data1)  #simple pairs plot
ggpairs(data1, aes(color = gear)) #error
class(data1$gear)                 #let's check if it's a factor
data1$gear = as.factor(data1$gear)#convert to factor

ggpairs(data1, aes(color = gear)) #bingo
setNames(seq_along(data1), colnames(data1)) #get index numbers
ggpairs(data1[,c(x:y,z)], aes(color = gear)) #select custom numbers

ggcorr(iris) #correlation matrix
ggcorr(iris, label = TRUE) #show the labels


install.packages("tudyplots")
require(tidyplots)
iris |>
  tidyplot(x=Species, y=Sepal.Width, colour = Species) #|>
#  add_data_points() |>
#  add_boxplot() |>
#  add_mean_bar(alpha = 0.4) |>
#  add_sem_errorbar() |>
#  adjust_x_axis_title("Title") |>
#  adjust_legend_title("Legend")

#set.seed(123)
#iris$category <- factor(sample(c(1, 2), nrow(iris), replace = TRUE))
#split_plot(by = category)


# filter(Species == "setosa") |>
# filter(Species %in% c("setosa", "versicolor")) |>
# filter(Species %in% c("setosa", "versicolor"), Sepal.Width < 3) |>


#more: https://jbengler.github.io/tidyplots/articles/tidyplots.html

install.packages("ggstatsplot")
require(ggstatsplot)
ggscatterstats(data = iris, x = Sepal.Width, y = Sepal.Length) #type = "non-parametric"
ggscatterstats(data = iris, x = Sepal.Width, y = Sepal.Length, bf.message = FALSE)

grouped_ggscatterstats(data = iris, x = Sepal.Width, y = Sepal.Length, grouping.var = Species, bf.message = FALSE)

ggbetweenstats(iris, Species, Sepal.Width)
ggbetweenstats(iris, Species, Sepal.Width, digits = 10, bf.message = FALSE)

grouped_ggbetweenstats(iris, Species, Sepal.Width, digits = 10, grouping.var = category, bf.message = FALSE, )

# xlab = "Species of Iris",               # custom x-axis label
# ylab = "Sepal Width (cm)",              # custom y-axis label
# title = "Sepal Width by Species",       # main title
# subtitle = "Comparison using ANOVA",    # subtitle below the title
# caption = "Source: UTAS (2025" )      # caption in bottom right

gghistostats(iris, Sepal.Width)
grouped_gghistostats(iris, Sepal.Width, Species, bf.message = F)

#more: https://indrajeetpatil.github.io/ggstatsplot/

options(scipen=999)
