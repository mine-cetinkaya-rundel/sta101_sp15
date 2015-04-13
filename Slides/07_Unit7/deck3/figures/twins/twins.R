setwd("~/Desktop/Teaching/Sta 101 - F13/Slides/(7) Unit 7/Lec 3/figures/twins")


blue = "#569BBD"
red = "#F05133"
green = "#4C721D"

install.packages("faraway")
library(faraway)
data(twins)

n = nrow(twins)
r = cor(y, x)

x = twins$Biological
y = twins$Foster

m = lm(Foster ~ Biological, data = twins)

pdf("twins_IQ.pdf", height = 4.8, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
dev.off()

pdf("twins_IQ_100pred.pdf", height = 4.8, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
newdata = data.frame(Biological=100)
int_ci100 = as.data.frame(predict(m, newdata, interval="confidence"))
lines(x = c(100,100), y = c(0,int_ci100$fit), lty = 2)
lines(x = c(0,100), y = c(int_ci100$fit,int_ci100$fit), lty = 2)
dev.off()

pdf("twins_IQ_100cint.pdf", height = 4.8, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
lines(x = c(100,100), y = c(0,int_ci100$fit), lty = 2)
lines(x = c(0,100), y = c(int_ci100$fit,int_ci100$fit), lty = 2)
lines(x = c(100,100), y = c(int_ci100$lwr, int_ci100$upr), col = green, lwd = 5)
dev.off()

pdf("twins_IQ_100cint_130pred.pdf", height = 4.8, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
lines(x = c(100,100), y = c(0,int_ci100$fit), lty = 2)
lines(x = c(0,100), y = c(int_ci100$fit,int_ci100$fit), lty = 2)
lines(x = c(100,100), y = c(int_ci100$lwr, int_ci100$upr), col = green, lwd = 5)
newdata = data.frame(Biological=130)
int_ci130 = as.data.frame(predict(m, newdata, interval="confidence"))
lines(x = c(130,130), y = c(0,int_ci130$fit), lty = 2)
lines(x = c(0,130), y = c(int_ci130$fit,int_ci130$fit), lty = 2)
dev.off()

pdf("twins_IQ_100cint_130cint.pdf", height = 4, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
lines(x = c(100,100), y = c(0,int_ci100$fit), lty = 2)
lines(x = c(0,100), y = c(int_ci100$fit,int_ci100$fit), lty = 2)
lines(x = c(100,100), y = c(int_ci100$lwr, int_ci100$upr), col = green, lwd = 5)
lines(x = c(130,130), y = c(0,int_ci130$fit), lty = 2)
lines(x = c(0,130), y = c(int_ci130$fit,int_ci130$fit), lty = 2)
lines(x = c(130,130), y = c(int_ci130$lwr, int_ci130$upr), col = green, lwd = 5)
dev.off()

pdf("twins_IQ_cint.pdf", height = 4, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
newdata = data.frame(Biological = seq(min(x)-5,max(x)+5,0.1))
int_ci = as.data.frame(predict(m, newdata, interval="confidence"))
lines(x = seq(min(x)-5,max(x)+5,0.1), y = int_ci$lwr, lwd = 2, col = green)
lines(x = seq(min(x)-5,max(x)+5,0.1), y = int_ci$upr, lwd = 2, col = green)
dev.off()

pdf("twins_IQ_100cintpint_130cintpint.pdf", height = 4, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)
lines(x = c(100,100), y = c(0,int_ci100$fit), lty = 2)
lines(x = c(0,100), y = c(int_ci100$fit,int_ci100$fit), lty = 2)

newdata = data.frame(Biological = 100)
int_pi100 = as.data.frame(predict(m, newdata, interval="prediction"))

lines(x = c(100,100), y = c(int_pi100$lwr, int_pi100$upr), col = "gray", lwd = 5)
lines(x = c(100,100), y = c(int_ci100$lwr, int_ci100$upr), col = green, lwd = 5)
lines(x = c(130,130), y = c(0,int_ci130$fit), lty = 2)
lines(x = c(0,130), y = c(int_ci130$fit,int_ci130$fit), lty = 2)

newdata = data.frame(Biological = 130)
int_pi130 = as.data.frame(predict(m, newdata, interval="prediction"))

lines(x = c(130,130), y = c(int_pi130$lwr, int_pi130$upr), col = "gray", lwd = 5)
lines(x = c(130,130), y = c(int_ci130$lwr, int_ci130$upr), col = green, lwd = 5)
legend("bottomright", col=c(green,"gray"), lwd = 5, c("confidence","prediction"), bg = "white")
dev.off()

pdf("twins_IQ_cint_pint.pdf", height = 4, width = 6)
par(mar=c(4.5,4.5,0.5,0.5))
plot(y ~ x, xlab = "biological IQ", ylab = "foster IQ", col = blue, pch = 20, cex = 1.25, las = 1, cex.axis = 1.5, cex.lab = 1.5, ylim = c(55,145))
abline(m, col = red, lwd = 2)

newdata = data.frame(Biological = seq(min(x)-5,max(x)+5,0.1))

int_ci = as.data.frame(predict(m, newdata, interval="confidence"))
lines(x = seq(min(x)-5,max(x)+5,0.1), y = int_ci$lwr, lwd = 2, col = green)
lines(x = seq(min(x)-5,max(x)+5,0.1), y = int_ci$upr, lwd = 2, col = green)

int_pi = as.data.frame(predict(m, newdata, interval="prediction"))
lines(x = seq(min(x)-5,max(x)+5,0.1), y = int_pi$lwr, lwd = 2, col = "darkgray")
lines(x = seq(min(x)-5,max(x)+5,0.1), y = int_pi$upr, lwd = 2, col = "darkgray")

legend("bottomright", col=c(green,"gray"), lwd = 2, c("confidence","prediction"), bg = "white")
dev.off()

# 

newdata = data.frame(Biological = 100)
predict(m , newdata, interval = "confidence")
predict(m , newdata, interval = "prediction")
