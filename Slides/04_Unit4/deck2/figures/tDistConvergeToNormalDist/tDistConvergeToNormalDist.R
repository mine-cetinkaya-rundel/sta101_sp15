setwd("/Users/mine/Desktop/Teaching/Sta 101 - F11/Lectures/Lecture 16/6-1smallMean/figures/tDistConvergeToNormalDist")


pdf('tDistConvergeToNormalDist.pdf', 5, 2.3)

par(mar=c(2, 1, 1, 1), mgp=c(5, 0.6, 0))
plot(c(-3.5, 7), c(0, dnorm(0)), type='n', axes=FALSE)
axis(1, cex.axis = 0.75)
abline(h=0)

COL <- c('#000000FF', '#00000091', '#0000006F', '#0000004B', '#00000022')
DF <- c('normal', 10, 5, 2, 1)

X <- seq(-5, 8, 0.01)
Y <- dnorm(X)
lines(X, Y, col=COL[1])

for(i in 2:5){
	Y <- dt(X, as.numeric(DF[i]))
	lines(X, Y, col=COL[i])
}

legend('topright', legend=c(DF[1], paste('t, df=', DF[2:5], sep='')), col=COL, lty=rep(1, 5), bty = "n", cex = 0.85)

dev.off()
