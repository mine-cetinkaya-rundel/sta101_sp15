library(openintro)

set.seed(135)

a = rnorm(100, mean = 10, sd = 7)
b = rnorm(100, mean = 20, sd = 6)
c = rnorm(100, mean = 50, sd = 5)
num1 = c(a,b,c)
cat = c(rep("Gr 1", 100), rep("Gr 2", 100), rep("Gr 3", 100))
mean(num1)

d = rnorm(100, mean = 10, sd = 2)
e = rnorm(100, mean = 40, sd = 3)
f = rnorm(100, mean = 90, sd = 1)
num2 = c(d,e,f)
mean(num2)

g = rnorm(100, mean = 20, sd = 10)
h = rnorm(100, mean = 30, sd = 12)
i = rnorm(100, mean = 40, sd = 8)
num3 = c(g,h,i)
mean(num3)

pdf("within_between.pdf", width = 10, height = 3)
par(mfrow=c(1,3), mar = c(2,3,3,2), cex.axis = 1.5, cex.main = 1.5)

boxplot(num1 ~ cat, ylim = c(-2,112), main = "Plot 1")

boxplot(num2 ~ cat, ylim = c(-2,112), main = "Plot 2")

boxplot(num3 ~ cat, ylim = c(-2,112), main = "Plot 3")
dev.off()