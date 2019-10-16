# Define UI 
ui <- fluidPage(
    
    # Application title
    titlePanel("Toetsanalyse eigen upload"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput("resultaten",
                      "Upload de file met studentresultaten",
                      accept = c(
                          "text/csv",
                          "text/comma-separated-values,text/plain",
                          ".csv")
            ),
            ## Maak een knop om mogelijke vragen in selectieveld te activieren
            actionButton("choice", "Toon beschikbare vragen"),
            
            ## Selecteer gewenste vragen voor analyse
            selectInput("itemnamen", "Selecteer vragen voor analyse",
                        choices = NULL, multiple = TRUE),
            
            ## Download nde itemanalyse
            downloadButton(outputId = "download_data", label = "Download item analyse")

        ),
        
        # Resultaten van geuploade scores met overall toetsgegevens
        mainPanel(h3("Toetsgegevens"),
                  tableOutput("betrouwbaarheid"),
                      
                  ## Een plot van de studentscores
                  h4("Histogram van studentscores (blauw = gemiddelde score)"),
                  plotOutput("histogram", width = "600px", height = "400px",),
                  
                  ## Een plot van de p en rir waarden van de geselecteerde vragen
                  h4("Plot van p en rir waarden"),
                  plotOutput("rpPlot", width = "600px", height = "400px",),
                  
                  ## een tabel/overzicht van de itemanalyse van alle aanwezige vragen
                  h4("Item analyse:"),
                  tableOutput("itemanalyse_table")
        )
    )
)