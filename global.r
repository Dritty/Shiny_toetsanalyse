
## Laad benodigde packages
library(shiny)
library(tidyverse)
library(shinyWidgets)
library(ggplot2)
library(ggrepel)


# Load all R functions in the resources folder
for (file in list.files('r_resources')){
    source(file.path('r_resources', file))
}
