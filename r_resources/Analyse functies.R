## Bereken betrouwbaarheid

betrouwbaarheid <- function(df, max_score){
    
    itemanalyse_rapport <- psych::alpha(df, cumulative=TRUE)$total
    
    itemanalyse_rapport$Aantal_vragen <- ncol(df)
    itemanalyse_rapport$Aantal_studenten <- nrow(df)
    
        ## Maak een itemanalyse-rapport om gemiddelde p-waarde toe te voegen
    itemanalyse <- psych::alpha(df)$item.stats
    
    itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
        left_join(max_score) %>% 
        mutate(p_waarde = mean/max,
               n = round(n))
    
    itemanalyse_rapport$p_waarde <- round(mean(itemanalyse$p_waarde), digits = 2)
    
    itemanalyse_rapport <- itemanalyse_rapport %>% 
        mutate(Aantal_vragen = as.character(Aantal_vragen),
               Aantal_studenten = as.character(Aantal_studenten),
               mean = round(mean, digits = 2),
               raw_alpha = round(raw_alpha, digits = 2),
               sd = round(sd, digits = 2)) %>% 
        dplyr:: select('Cronbach\'s Alpha' = raw_alpha,
               'Gemiddelde score' = mean,
               'Standaarddeviatie' = sd,
               'Gemiddelde p waarde' = p_waarde,
               'Aantal vragen' = Aantal_vragen,
               'Aantal studenten' = Aantal_studenten)
    
    itemanalyse_rapport <- as.data.frame(t(itemanalyse_rapport)) %>% 
        tibble::rownames_to_column() %>% 
        dplyr:: select("Toetswaarden" = rowname,
               " " = V1)
    
    itemanalyse_rapport
    
    
}

itemanalyse <- function(df, max_score){
    
    itemanalyse <- psych::alpha(df)$item.stats
    
    itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
        left_join(max_score) %>% 
        mutate(p_waarde = mean/max,
               n = as.character(n))
    
    ## Selecreer gewenste kolommen en hernoem ze waar nodig
    itemanalyse <- dplyr:: select(itemanalyse,
                          Items,
                          n,
                          P = p_waarde,
                          rir = r.drop,
                          max)
    itemanalyse
}

totaalscores <- function(df, ID){
    
    if ("nvt" %in% names(ID)){
        totaalscore <- df %>% 
            mutate(Totaalscore = rowSums(.))
    }
    
    else{
        totaalscore <- df %>% 
            mutate(Totaalscore = rowSums(.)) %>% 
            bind_cols(ID)
            }
    
    totaalscore
}


