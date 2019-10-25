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
    
    # Houdt bij of het faculteit filter verandert en past opleiding filter aan
    observeEvent(input$resultaten, {
       
        vars <- names(scores())
        
        # Update de dropdown gedefinieerd in de UI
        updatePickerInput(session, "itemnamen2",
                          choices = vars, selected = vars)
    })
    

    ## Maak een df met toetsanalyse gegevens op basis van de scores en geselecteerde
    ## items
    output$betrouwbaarheid <- renderTable({
        
        ## selecteer items op basis van inputselectie
        scores <- scores()
        scores <- subset(scores, select = input$itemnamen2)
        
        itemanalyse_rapport <- psych::alpha(scores, cumulative=TRUE)$total
        
        itemanalyse_rapport$Aantal_vragen <- ncol(scores)
        itemanalyse_rapport$Aantal_studenten <- nrow(scores)
        
        itemanalyse_rapport <- select(itemanalyse_rapport,
                                     'Cronbachs alpha' = raw_alpha,
                                     'Gemiddelde score' = mean,
                                     'Aantal vragen' = Aantal_vragen,
                                     'Aantal studenten' = Aantal_studenten)
        
        itemanalyse_rapport
    })
    
    ## Maak een plot van rir en P waarden op basis van geupload bestand en 
    ## geselecteerde items
    output$rpPlot <- renderPlot({
        
        ## Selecteer de vragen op basis van de input gebruikers
        scores <- select(scores(), input$itemnamen2)
        
        ## Maak een itemanalyse-rapport
        itemanalyse <- psych::alpha(scores)$item.stats

            itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
                left_join(max_score_vraag()) %>% 
                mutate(p_waarde = mean/max,
                       n = round(n))
        
        ## Maak een plotje van p en rirwaarden geselecteerde vragen
        p <- ggplot(itemanalyse, aes(r.drop, p_waarde)) +
            geom_point(alpha=0.5) + 
            labs(x = "Rir waarde", y = "P waarde") + 
            geom_text_repel(aes(r.drop, p_waarde, label = Items)) + ylim(0,1) +
            theme_classic(base_size = 16)
        p
        
    })
    
    ## Maak een itemanalyse van alle items in geupload bestand
    output$itemanalyse_table <- renderTable({
        
        ## Selecteer de vragen op basis van de input gebruikers
        scores <- select(scores(), input$itemnamen2)
        
        itemanalyse <- psych::alpha(scores)$item.stats

        itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
            left_join(max_score_vraag()) %>% 
            mutate(p_waarde = mean/max,
                   n = as.character(n))
        
        ## Selecreer gewenste kolommen en hernoem ze waar nodig
        itemanalyse <- select(itemanalyse,
                              Items,
                              n,
                              P = p_waarde,
                              rir = r.drop,
                              max)
        itemanalyse
        
    })
    
    
    ## Maak een histogram van de studentscores
    
    ## Selecteer de vragen op basis van de input gebruikers
    output$histogram <- renderPlot({ 
        
        scores <- select(scores(), input$itemnamen2)
    
        itemanalyse <- psych::alpha(scores, cumulative=TRUE)
        totaalscores <- tibble::enframe(itemanalyse$scores, name = NULL, 
                                        value = "totaalscores")
        
        totaalscores <- mutate(totaalscores, maximalescore = max(totaalscores),
                   gemiddeldescore = mean(totaalscores))
        
        ggplot2::ggplot(totaalscores, aes(totaalscores))+
            geom_histogram()+xlim(0, as.numeric(totaalscores$maximalescore[1])) +
            geom_vline(xintercept = totaalscores$gemiddeldescore[1], color="blue", size = 2)+
            theme_classic(base_size = 16) +
            labs(x = "Totaalscore op toets", y = "Frequentie")
    
    })
    
    # Create a download handler
    output$download_data <- downloadHandler(
        # The downloaded file krijgt de naam itemanalyse.csv
        filename = "itemanalyse.csv",
        content = function(file) {
        
            ## Selecteer de vragen op basis van de input gebruikers
            scores <- select(scores(), input$itemnamen2)
            
            itemanalyse <- psych::alpha(scores)$item.stats
            
            itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
                left_join(max_score_vraag()) %>% 
                mutate(p_waarde = mean/max,
                       n = as.character(n))
            
            ## Selecreer gewenste kolommen en hernoem ze waar nodig
            itemanalyse <- select(itemanalyse,
                                  Items,
                                  n,
                                  P = p_waarde,
                                  rir = r.drop,
                                  max)
            itemanalyse
            
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
}
