## Bereken betrouwbaarheid

betrouwbaarheid <- function(df, vragen){
    
    df <- subset(df, select = vragen)
    
    itemanalyse_rapport <- psych::alpha(df, cumulative=TRUE)$total
    
    itemanalyse_rapport$Aantal_vragen <- ncol(df)
    itemanalyse_rapport$Aantal_studenten <- nrow(df)
    
    itemanalyse_rapport <- select(itemanalyse_rapport,
                                  'Cronbachs alpha' = raw_alpha,
                                  'Gemiddelde score' = mean,
                                  'Aantal vragen' = Aantal_vragen,
                                  'Aantal studenten' = Aantal_studenten)
    
    itemanalyse_rapport
}
