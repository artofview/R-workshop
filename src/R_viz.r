# install.packages("C:\\Program Files\\R\\R-4.3.2\\library\\d3heatmap_0.6.1.tar.gz",repos=NULL,type="source")

library(magrittr)

# d3.js for R
library(d3r)
# https://www.rdocumentation.org/packages/heatmap3/versions/1.1.9/topics/heatmap3
library(heatmap3)
library(dplyr)
library(readr)

# read data from github repository using readr read_csv() function
gapminder <- read_csv("C:\\privat\\Repos\\R-workshop\\data\\gapminder.csv")

# create a list of countries to filter *in*
countrylist <- c("China","France","United Kingdom", "United States", "Egypt", "Japan", "Senegal", "Ukraine", "Uruguay", "Venezuela", "Spain", "Malaysia", "New Zealand", "Angola")

# subset the original data and calculate summary statistics of interest
gmun <- gapminder %>%
    filter(country %in% countrylist) %>%
    group_by(country) %>%
    summarise(
        meanlifexp = mean(lifeExp),
        sdlifeexp = sd(lifeExp),
        meangdppercap = mean(gdpPercap),
        sdgdppercap = sd(gdpPercap))

print(gmun)

gmdistmat <- dist(select(gmun, -country))

print(gmdistmat)

z_matrix <- matrix(gmdistmat, nrow = 13, ncol = 13)
print(z_matrix)

print(gmun$country)

heatmap3(
    # calculate distance matrix
    z_matrix,
    # name the rows (top to bottom)
    labRow = gmun$country,
    # name the columns (left to right)
    labCol = gmun$country,
    # turn off dendrogram
    dendrogram = 'none')




