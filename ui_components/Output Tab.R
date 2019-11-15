## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Ouput tab ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##
## Auteur; DD
##
## Doel: Analysegegevens tonen
##
## Afhankelijkheden: Input tab
##
## Datasets: Eigen upload
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Wordt gebruikt in de ui.R definitie
ui_component_tab_twee <- tabItem(
  "tab_output",
  fluidRow(
    column(
      width = 10,
      box(tableOutput("betrouwbaarheid"))
    )
  ),
  fluidRow(
    column(
      width = 10,
      box(h4("Histogram van studentscores (blauw = gemiddelde score)"),
          plotOutput("histogram"))
    )
  ),
  fluidRow(
    column(
      width = 10,
      box(h4("Plot van p en rir waarden"),
          plotOutput("rpPlot"))
    )
  ),
  fluidRow(
    column(
      width = 10,
      box(h4("Item analyse:"),
          tableOutput("itemanalyse_table"))
    )
  ),
  fluidRow(
    column(
      width = 10,
      box(h4("ICC:"),
          p("Onderstaande plot toont de Item characteristic curve van de geselecteerde vraag. 
            Deze curve is een weergave van de relatie tussen de gemiddelde totaalscore van een 
            groep studenten en de score op de vraag"),
          pickerInput("ICC_input",
                          "Kies de gewenste vraag",
                          choices = NULL, multiple = FALSE),
          plotOutput("ICC"))
    )
  )
)

