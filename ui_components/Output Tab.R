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
          plotOutput("histogram", width = "600px", height = "400px"))
    )
  ),
  fluidRow(
    column(
      width = 10,
      box(h4("Plot van p en rir waarden"),
          plotOutput("rpPlot", width = "600px", height = "400px"))
    )
  ),
  fluidRow(
    column(
      width = 10,
      box(h4("Item analyse:"),
          tableOutput("itemanalyse_table"))
    )
  )
)

