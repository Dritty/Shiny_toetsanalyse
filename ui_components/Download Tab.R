## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Download tab ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Auteur; DD
##
## Doel: Download resultaten voor de UI. Los voor leesbaarheid
##
## Afhankelijkheden: Geen
##
## Datasets: Geen
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Wordt gebruikt in de ui.R definitie
ui_component_tab_drie <- tabItem(
    "tab_download",
    fluidRow(
        column(
            width = 12,
            box(## Download de itemanalyse
                h4("Download de itemanalyse"),
                downloadButton(outputId = "download_data", label = "Download item analyse"))
            )

        ),
    fluidRow(
        column(
            width = 12,
            box(## Download de itemanalyse
                h4("Download de totaalscores"),
                downloadButton(outputId = "download_totaalscores", label = "Download de totaalscores"))
        )
        
    )
    )


