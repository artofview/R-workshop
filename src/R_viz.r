library(magrittr)

# dr3 for R and is replace "d3heatmap"
library(d3r)
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

d3heatmap(
    # calculate distance matrix
    gmdistmat,
    # name the rows (top to bottom)
    labRow = gmun$country, 
    # name the columns (left to right)
    labCol = gmun$country, 
    # turn off dendrogram
    dendrogram = 'none')

