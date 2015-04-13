setwd("/Users/mine/Desktop/Teaching/Sta 101 - S12/Lectures/Lecture 19/transformations/figures/pickup")

pu_allyrs = read.csv("pickup.csv")

# all: scatterplot, no line

pdf("pu_price_year_scat_allyrs.pdf", height = 4, width = 7)
par(mar=c(4,4.5,1,1), las=1, mgp=c(3,0.7,0), cex.lab = 1.5, cex.axis = 1)
plot(pu_allyrs$price ~ pu_allyrs$year, ylab = "price", xlab = "year", pch=19, col=COL[2])
dev.off()


pu = subset(pu_allyrs, pu_allyrs$year >= 1992)

COL <- c('#55000088','#225588')



# 1992 and newer: scatterplot, no line

pdf("pu_price_year_scat_noline.pdf", height = 4, width = 7)
par(mar=c(4,4.5,1,1), las=1, mgp=c(3,0.7,0), cex.lab = 1.5, cex.axis = 1)
plot(pu$price ~ pu$year, ylab = "price", xlab = "year", pch=19, col=COL[2])
dev.off()


# no log: scatterplot, with line

pdf("pu_price_year_scat.pdf", height = 4, width = 6)
par(mar=c(4,4.5,1,1), las=1, mgp=c(3,0.7,0), cex.lab = 1.5, cex.axis = 1)
plot(pu$price ~ pu$year, ylab = "price", xlab = "year", pch=19, col=COL[2])
m1 = lm(pu$price ~ pu$year)
abline(m1, col = COL[1], lwd = 3)
dev.off()

# no log: residuals

pdf("pu_price_year_res.pdf", height = 2.25, width = 6)
par(mar=c(2,4.5,1,1), las=1, mgp=c(3,0.7,0), cex.lab = 1.5, cex.axis = 1)
plot(m1$residuals ~ pu$year, ylab = "residuals", pch=19, col=COL[2], ylim = c(-10000,10000))
abline(h = 0, lty = 3)
dev.off()


# log: scatterplot, with line

pdf("pu_price_year_scat_log.pdf", height = 4, width = 6)
par(mar=c(4,4.5,1,1), las=1, mgp=c(3,0.7,0), cex.lab = 1.5, cex.axis = 1)
plot(log(pu$price) ~ pu$year, ylab = "log(price)", xlab = "year", pch=19, col=COL[2])
m2 = lm(log(pu$price) ~ pu$year)
abline(m2, col = COL[1], lwd = 3)
dev.off()

# log: residuals

pdf("pu_price_year_res_log.pdf", height = 2.25, width = 6)
par(mar=c(2,4.5,1,1), las=1, mgp=c(3,0.7,0), cex.lab = 1.5, cex.axis = 1)
plot(m2$residuals ~ pu$year, ylab = "residuals", pch=19, col=COL[2], ylim = c(-1.5,1.5))
abline(h = 0, lty = 3)
dev.off()

# summary
xtable(summary(m2), digits = 2)