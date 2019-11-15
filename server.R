# Define server logic 
server <- function(input, output, session) {
    
    ## Maak een reactive score bestand op basis van de upload
    scores <- reactive({inFile <- input$resultaten
    
    if (is.null(inFile))
        return(NULL)
    
    scores <- data.table::fread(inFile$datapath)
    
    scores
    
    })
    
    
    ## Maak een reactive maximale score bestand op basis van de upload
    max_score_vraag <- reactive({inFile_max <- input$max_score_upload
    
    if (is.null(inFile_max)) {
        
        ## Selecteer de vragen op basis van de input gebruikers
        scores <- select(scores(), input$itemnamen2)
        
        max_scores <- scores %>% 
            psych::describe() %>% tibble::rownames_to_column("Items") %>% 
            select(Items,
                   max)
        
        max_scores
        
    }
        
    else {
        
        max_scores <- data.table::fread(inFile_max$datapath)
        
        max_scores
    }
        
    })
    
 ## Houdt bij of een score bestand is geupload en past dan vraagopties aan
    observeEvent(input$resultaten, {
       
        vars <- names(scores())
        
        vars2 <- c(vars, "nvt")
        
        # Update de dropdown gedefinieerd in de UI
        updatePickerInput(session, "itemnamen2",
                          choices = vars, selected = vars)
        
        # Update de dropdown gedefinieerd in de UI
        updatePickerInput(session, "studentnamen",
                          choices = vars2)
    })
    

    ## Maak een df met toetsanalyse gegevens op basis van de scores en geselecteerde
    ## items
    output$betrouwbaarheid <- renderTable({
        
        ## Selecteer de vragen op basis van de input gebruikers
        scores <- select(scores(), input$itemnamen2)
        betrouwbaarheid <- betrouwbaarheid(scores, max_score_vraag())
        
        
    }, striped = TRUE)
    
    ## Maak een plot van rir en P waarden op basis van geupload bestand en 
    ## geselecteerde items
    output$rpPlot <- renderPlot({
        
        ## Selecteer de vragen op basis van de input gebruikers
        scores <- select(scores(), input$itemnamen2)
        
        rir_plot(scores, max_score_vraag())
        
    })
    
    ## Maak een itemanalyse van alle items in geupload bestand
    output$itemanalyse_table <- renderTable({
        
        ## Selecteer de vragen op basis van de input gebruikers
        scores <- select(scores(), input$itemnamen2)
        
        itemanalyse(scores, max_score_vraag())
        
    })
    
    # Create a download handler met de totaalscores per student
    output$download_totaalscores <- downloadHandler(
        # The downloaded file krijgt de naam itemanalyse.csv
        filename = "totaalscores.csv",
        content = function(file) {
            
            ## Selecteer de vragen op basis van de input gebruikers
            scores1 <- select(scores(), input$itemnamen2)
            
            ## Selecteer de kolom met id's
            if (input$studentnamen == "nvt")
            {
                ID <- scores1 %>% 
                    mutate(nvt = NA)
            }
            
            else{ID <- select(scores(), input$studentnamen)}
            
            totaalscore <- totaalscores(scores1, ID)
            
            # Write the filtered data into a CSV file
            write.csv2(totaalscore, file, row.names = FALSE)
        }
    )
   
    # ## Maak een bestand met de totaalscores per student
    # output$totaalscore <- renderTable({
    #     
    #     ## Selecteer de vragen op basis van de input gebruikers
    #     scores1 <- select(scores(), input$itemnamen2)
    #     
    #     ## Selecteer de kolom met id's
    #     if (input$studentnamen == "nvt")
    #     {
    #         ID <- "nvt"
    #     }
    #     
    #     else{ID <- select(scores(), input$studentnamen)}
    #     
    #     totaalscores(scores1, ID)
    # })
    
    
## Maak een histogram van de studentscores
    ## Selecteer de vragen op basis van de input gebruikers
    output$histogram <- renderPlot({ 
        
        scores <- select(scores(), input$itemnamen2)
    
        score_histogram(scores)
        
    })
    
    # Create a download handler
    output$download_data <- downloadHandler(
        # The downloaded file krijgt de naam itemanalyse.csv
        filename = "itemanalyse.csv",
        content = function(file) {
        
            ## Selecteer de vragen op basis van de input gebruikers
            scores <- select(scores(), input$itemnamen2)
            
            itemanalyse <- itemanalyse(scores, max_score_vraag())
            
            # Write the filtered data into a CSV file
            write.csv2(itemanalyse, file, row.names = FALSE)
        }
    )
    
    output$download_max_score <- downloadHandler(
        # The downloaded file krijgt de naam max_score.csv
        filename = "max_score.csv",
        content = function(file) {

           ## Selecteer de vragen op basis van de input gebruikers
            scores <- select(scores(), input$itemnamen2)
            
            max_scores <- scores %>% 
                psych::describe() %>% tibble::rownames_to_column("Items") %>% 
                select(Items,
                       max)
            
            max_scores
            
            # Write the filtered data into a CSV file
            write.csv2(max_scores, file, row.names = FALSE)
        })
    
    # Create a download handler van voorbeelddata
    output$download_voorbeeld <- downloadHandler(
        # The downloaded file krijgt de naam itemanalyse.csv
        filename = "test_scores.csv",
        content = function(file) {

            voorbeelddata

            # Write the filtered data into a CSV file
            write.csv2(voorbeelddata, file, row.names = FALSE)
        }
    )
    
    # Genereer een tekst element voor de tweede tab
    output$Uitleg_max <- renderText({
        "Indien de maximale score per vraag gecorrigeerd moet worden, 
        download dan de data en upload het gecorrigeerde bestand"
    })
}
