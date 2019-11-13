## Plotjes

## Maak een plotje van p en rirwaarden geselecteerde vragen
rir_plot <- function(df, max_score){
    
    ## Maak een itemanalyse-rapport
    itemanalyse <- psych::alpha(df)$item.stats
    
    itemanalyse <- itemanalyse %>% tibble::rownames_to_column("Items") %>% 
        left_join(max_score) %>% 
        mutate(p_waarde = mean/max,
               n = round(n))

p <- ggplot2:: ggplot(itemanalyse, aes(r.drop, p_waarde)) +
    geom_point(alpha=0.5) + 
    labs(x = "Rir waarde", y = "P waarde") + 
    geom_text_repel(aes(r.drop, p_waarde, label = Items)) + ylim(0,1) +
    theme_classic(base_size = 16)

p

}

## Maak een histogram van de totaalscores
score_histogram <- function(df) {
    
    itemanalyse <- psych::alpha(df, cumulative=TRUE)
    totaalscores <- tibble::enframe(itemanalyse$scores, name = NULL, 
                                    value = "totaalscores")
    
    df_totaalscores <- mutate(totaalscores, maximalescore = max(totaalscores),
                           gemiddeldescore = mean(totaalscores))
    
p <- ggplot2::ggplot(df_totaalscores, aes(totaalscores))+
    geom_histogram()+xlim(0, as.numeric(df_totaalscores$maximalescore[1])) +
    geom_vline(xintercept = df_totaalscores$gemiddeldescore[1], color="blue", size = 2)+
    theme_classic(base_size = 16) +
    labs(x = "Totaalscore op toets", y = "Frequentie")
    
p

}
