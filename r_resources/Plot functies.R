## Plotjes

## Maak een plotje van p en rirwaarden geselecteerde vragen
rir_plot <- function(df){

p <- ggplot2:: ggplot(df, aes(r.drop, p_waarde)) +
    geom_point(alpha=0.5) + 
    labs(x = "Rir waarde", y = "P waarde") + 
    geom_text_repel(aes(r.drop, p_waarde, label = Items)) + ylim(0,1) +
    theme_classic(base_size = 16)

p

}

## Maak een histogram van de totaalscores
score_histogram <- function(df) {
    
p <- ggplot2::ggplot(df, aes(totaalscores))+
    geom_histogram()+xlim(0, as.numeric(df$maximalescore[1])) +
    geom_vline(xintercept = df$gemiddeldescore[1], color="blue", size = 2)+
    theme_classic(base_size = 16) +
    labs(x = "Totaalscore op toets", y = "Frequentie")
    
p

}
