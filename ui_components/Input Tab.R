## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Input tab ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Auteur; DD
##
## Doel: Upload en selecteer data voor analyse
##
## Afhankelijkheden: Geen
##
## Datasets: Geen
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Wordt gebruikt in de ui.R definitie
ui_component_tab_main <- tabItem(
  "tab_main",
  fluidRow(
    column(
      width = 12,
      box(fileInput("resultaten",
                    "Upload de csv file met studentresultaten",
                    accept = c(
                      "text/csv",
                      "text/comma-separated-values,text/plain",
                      ".csv")
      )),
      box(p("Als het bestand met de scores per vraag ook een kolom met studentnamen of studentnummers bevat
            , kan deze kolom hier geselecteerd worden."),
        pickerInput("studentnamen",
                    "Welke kolom bevat de studentnamen?",
                    choices = NULL, multiple = FALSE)),
      box(
        p("Deselecteer kolommen die geen scores bevatten, of vragen die verwijderd moeten worden
          uit de analyse"),
        pickerInput("itemnamen2", 
                    "Selecteer gewenste vragen/kolommen voor analyse",
                    choices = NULL, multiple = TRUE)
      )
    )
  ),
  fluidRow(
    column(
      width = 12,
      box(textOutput("Uitleg_max"))
      
      )),
  
  fluidRow(
    column(
      width = 12,
      box(## Download de maximale score per vraag (van de geselecteerde vragen)
        downloadButton(outputId = "download_max_score", 
                       label = "Download csv met maximale score per vraag"))
      
    )),

fluidRow(
  column(
    width = 12,
    box(fileInput("max_score_upload",
                  "Upload de file met correcte maximale score",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv"))
        )))

)



