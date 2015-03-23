n_obama = round(849 * 0.45)
n_romney = round(849 * 0.48)
n_other = round(849 * 0.07)

n_obama + n_romney + n_other #check

vote = c(rep("Barack Obama", n_obama),
         rep("Mitt Romney", n_romney),
         rep("Other / Don't remember", n_other))
vote = factor(vote, levels = c("Barack Obama", "Mitt Romney", "Other / Don't remember"))

obama_perc_dist = c(0.23, 0.46, 0.31) 
obama_count_dist = round(n_obama * obama_perc_dist)
sum(obama_count_dist) #check

romney_perc_dist = c(0.31, 0.38, 0.31) 
romney_count_dist = round(n_romney * romney_perc_dist)
sum(romney_count_dist) #nope
romney_count_dist[3] = romney_count_dist[3] + 1
sum(romney_count_dist) #check

other_perc_dist = c(0.27, 0.23, 0.50) 
other_count_dist = round(n_other * other_perc_dist)
sum(other_count_dist) #nope
other_count_dist[3] = other_count_dist[3] - 1
sum(other_count_dist) #check

team = c(rep("Duke", obama_count_dist[1]),
         rep("UNC", obama_count_dist[2]),
         rep("Not sure", obama_count_dist[3]),
         rep("Duke", romney_count_dist[1]),
         rep("UNC", romney_count_dist[2]),
         rep("Not sure", romney_count_dist[3]),
         rep("Duke", other_count_dist[1]),
         rep("UNC", other_count_dist[2]),
         rep("Not sure", other_count_dist[3])
         )

team = factor(team, levels = c("Duke", "UNC", "Not sure"))

basket_pres = data.frame(vote = vote, team = team)

# check
tab = table(basket_pres$team, basket_pres$vote)
round(prop.table(tab, 2), 2)

write.csv(basket_pres, "basket_pres.csv", row.names = FALSE)
