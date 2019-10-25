# Define UI 
ui <- fluidPage(
    
    # Application title
    titlePanel("Toetsanalyse eigen upload"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput("resultaten",
                      "Upload de csv file met studentresultaten",
                      accept = c(
                          "text/csv",
                          "text/comma-separated-values,text/plain",
                          ".csv")
            ),

            pickerInput("itemnamen2", "Selecteer gewenste vragen voor analyse",
                        choices = NULL, multiple = TRUE),
            
            ## Download de maximale score per vraag (van de geselecteerde vragen)
            downloadButton(outputId = "download_max_score", 
                           label = "Download csv met maximale score per vraag"),
            
            ## Biedt mogelijkheid om maximale score per vraag te uploaden
            fileInput("max_score_upload",
                      "Upload de file met correcte maximale score",
                      accept = c(
                          "text/csv",
                          "text/comma-separated-values,text/plain",
                          ".csv")
            ),
            
            ## Download de itemanalyse
            downloadButton(outputId = "download_data", label = "Download item analyse")

        ),
        
        # Resultaten van geuploade scores met overall toetsgegevens
        mainPanel(h3("Toetsgegevens"),
                  tableOutput("betrouwbaarheid"),

                  ## Een plot van de studentscores
                  h4("Histogram van studentscores (blauw = gemiddelde score)"),
                  plotOutput("histogram", width = "600px", height = "400px"),
                  
                  ## Een plot van de p en rir waarden van de geselecteerde vragen
                  h4("Plot van p en rir waarden"),
                  plotOutput("rpPlot", width = "600px", height = "400px",),
                  
                  ## een tabel/overzicht van de itemanalyse van alle aanwezige vragen
                  h4("Item analyse:"),
                  tableOutput("itemanalyse_table")
        )
    )
)
