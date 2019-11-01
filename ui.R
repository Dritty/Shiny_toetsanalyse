## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## UI ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Shiny App voor Toetsanalyse met eigen upload
##
## Auteur; DD
##
## Doel: UI toetsanalyse
##
## Afhankelijkheden: Geen
##
## Datasets: Geen
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Het dashboard moet een header hebben
header <- dashboardHeader(
    title = "Toetsanalyse"
   
)

# Definieer de tabs in het dashboardbody.
# De inhoud van de tabs is in ui_components/* gedefinieerd voor leesbaarheid
body <- dashboardBody(
    # Dit laad de CSS uit www/custom.css in
    tags$head(tags$link(rel = "stylesheet",
                        type = "text/css", href = "custom.css")),
    tags$head(tags$script(src="example.js")),
    tabItems(
        ui_component_tab_main,
        ui_component_tab_twee,
        ui_component_tab_drie,
        ui_component_tab_vier
    )
)

# Shiny gaat op zoek naar dit, de UI component
# De dashboardpage moet een header, dashboardSidebar en dasboardBody hebben
ui <- dashboardPage(
    header,
    dashboardSidebar(
        # Link tabNames met ids aan de tabs in ui_components/*
        sidebarMenu(
            menuItem("Input", tabName = "tab_main"),
            menuItem("Analyse", tabName = "tab_output"),
            menuItem("Download", tabName = "tab_download"),
            menuItem("Voorbeeld score data", tabName = "tab_voorbeeld")
        )
    ),
    body
)
