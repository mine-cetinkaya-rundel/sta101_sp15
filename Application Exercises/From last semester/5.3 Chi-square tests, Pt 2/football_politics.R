vote = c(rep("Barack Obama", "351"),
         rep("Mitt Romney", "382"),
         rep("Other / Don't remember", "47"))
vote = factor(vote, levels = c("Barack Obama", "Mitt Romney", "Other / Don't remember"))

team = c(rep("Duke", 53), rep("UNC", 95), rep("NC State", 35), rep("Other / no favourite", 168),
         rep("Duke", 69), rep("UNC", 76), rep("NC State", 54), rep("Other / no favourite", 183),
         rep("Duke", 7), rep("UNC", 8), rep("NC State", 8), rep("Other / no favourite", 24))
team = factor(team, levels = c("Duke", "UNC", "NC State", "Other / no favourite"))

fb_pol = data.frame(vote = vote, team = team)

write.csv(fb_pol, "fb_pol.csv", row.names = FALSE)
