library(readr)
maxscores <- read_delim("C:/Users/Drittij/Downloads/max_score (4).csv", 
                           ";", escape_double = FALSE, trim_ws = TRUE)

nrq <- 13
scores <- as.data.frame(voorbeelddata)

#Bereken totaalscore per student
scores$sum <- rowSums(scores[1:nrq])

#Plaats student in een rank-groep (5 gelijke groepen)
scores$RANK <- ntile(scores$sum, 5)

## Bereken gemiddelde score vraag per rank-groep
rankgroup <- by(scores[, 1:nrq], scores$RANK, colMeans)

## Creer dataframe met gem. score per rankgroep per vraag en hernoem kopjes.
x <- c(1:nrq)

RankV <- matrix(c(rankgroup$`1`[x], rankgroup$`2`[x], rankgroup$`3`[x], rankgroup$`4`[x], rankgroup$`5`[x]), ncol=nrq,byrow=TRUE)
RankVdf <- as.data.frame(RankV, row.names=(c("rankgroup1", "rankgroup2", "rankgroup3", "rankgroup4", "rankgroup5")))

##Kolomnamen hernoemen naar juiste vraagnummer
names = c(colnames(scores[1:nrq]))
colnames(RankVdf) = names

##Bereken p-waarde per vraag per rankgroep
nmaxscore <- maxscores$max
for (i in 1:5) RankVdf[i,] = RankVdf[i,]/nmaxscore

RankVdf <- rownames_to_column(RankVdf, var = "Rankgroep")

library(reshape2)
library(ggplot2)

melted_RankVdf <- melt(RankVdf, id.vars='Rankgroep') %>% 
    mutate(label = as.character(variable),
           label = if_else(Rankgroep == "rankgroup2", "", label),
           label = if_else(Rankgroep == "rankgroup3", "", label),
           label = if_else(Rankgroep == "rankgroup4", "", label))

ggplot(melted_RankVdf, aes(Rankgroep, value, col=variable)) + 
    geom_line(aes(Rankgroep, value, group=variable))+
    geom_text_repel(aes(Rankgroep, value, label = label))

