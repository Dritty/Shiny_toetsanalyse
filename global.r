
## Laad benodigde packages
library(shiny)
# library(CTT)
library(tidyverse)
library(shinyWidgets)
library(shinydashboard)
library(ggplot2)
library(ggrepel)
library(data.table)


# Load all R functions in the resources folder
for (file in list.files('r_resources')){
    source(file.path('r_resources', file))
}

# Laad de UI components nadat de data is geladen (filters gebruiken de data)
for (file in list.files('ui_components')){
    source(file.path('ui_components', file))
}

## Lees testbestanden in
voorbeelddata <- data.table::fread("data/test_scores.csv")

maxscores <- data.table::fread("data/max_score.csv")




