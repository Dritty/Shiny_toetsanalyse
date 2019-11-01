## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Voorbeeld tab ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##
## Auteur; DD
##
## Doel: Download voorbeelddata om te testen voor eigen upload in input tab
##
## Afhankelijkheden: Geen
##
## Datasets: Geen
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Wordt gebruikt in de ui.R definitie
ui_component_tab_vier <- tabItem(
    "tab_voorbeeld",
    fluidRow(
        column(
            width = 12,
            box(## Download de itemanalyse
                h4("Download voorbeelddata"),
                downloadButton(outputId = "download_voorbeeld", 
                               label = "Download voorbeeldsscores"))
        )
        
    )
)


