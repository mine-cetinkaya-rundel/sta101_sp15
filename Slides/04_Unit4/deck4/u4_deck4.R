
rxntime.example <- function(write.out=FALSE, width=400, height=300)
{

    rxntime = read.csv("data/rxntime.csv")

    
    rxnt    = rxntime[,c("Subject", "PictureTarget.RT", "Littered", "FarAway")]

    if (write.out) png("figures/rxntime-boxplots.png", width=width, height=height)
    
    boxplot(PictureTarget.RT ~ Subject, data=rxntime, main="Reaction time of subjects",
            ylab="Reaction Times", xlab="Subject ID")

    if (write.out) dev.off()

    lm1 = lm(PictureTarget.RT ~ as.factor(Subject), data=rxntime)
    anova(lm1)

    
    
}
