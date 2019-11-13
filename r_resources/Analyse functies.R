## Bereken betrouwbaarheid

betrouwbaarheid <- function(df, max_score){
    
    itemanalyse_rapport <- psych::alpha(df, cumulative=TRUE)$total
    
    itemanalyse_rapport$Aantal_vragen <- ncol(df)
    itemanalyse_rapport$Aantal_studenten <- nrow(df)
    
    itemanalyse_rapport <- select(itemanalyse_rapport,
                                  'Cronbachs alpha' = raw_alpha,
                                  'Gemiddelde score' = mean,
                                  'Aantal vragen' = Aantal_vragen,
                                  'Aantal studenten' = Aantal_studenten)
    
    ## Maak een itemanalyse-rapport om gemiddelde p-waarde toe te voegen
    itemanalyse <- psych::alpha(df)$item.stats
    
    itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
        left_join(max_score) %>% 
        mutate(p_waarde = mean/max,
               n = round(n))
    
    itemanalyse_rapport$p_waarde <- mean(itemanalyse$p_waarde)
    
    itemanalyse_rapport <- itemanalyse_rapport %>% 
        rename(`Gemiddelde p waarde` = p_waarde)
    
    itemanalyse_rapport
}

itemanalyse <- function(df, max_score){
    
    itemanalyse <- psych::alpha(df)$item.stats
    
    itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
        left_join(max_score) %>% 
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
}
