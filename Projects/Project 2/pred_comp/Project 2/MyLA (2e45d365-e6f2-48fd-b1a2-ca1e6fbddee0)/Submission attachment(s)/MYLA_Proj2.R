# BEGIN YOUR CODE
# LOAD DATA
download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")
proj2 <- movies[c("title", "audience_score", "genre", "runtime", "mpaa_rating", "best_pic_nom", "best_pic_win",  "top200_box", "critics_score")]

# EXPLORATORY DATA ANALYSIS
summary(proj2)
plot(proj2$audience_score ~ proj2$genre)
plot(proj2$audience_score ~ proj2$runtime)
plot(proj2$audience_score ~ proj2$mpaa_rating)
plot(proj2$audience_score ~ proj2$best_pic_nom)
plot(proj2$audience_score ~ proj2$best_pic_win)
plot(proj2$audience_score ~ proj2$top200_box)
plot(proj2$audience_score ~ proj2$critics_score)

# MODEL SELECTION
prelim <- lm(audience_score ~ genre + runtime + mpaa_rating + best_pic_nom + best_pic_win + top200_box + critics_score, data = proj2)
summary(prelim)
prelim2 <- lm(audience_score ~ genre + runtime + mpaa_rating + best_pic_nom + best_pic_win + critics_score, data = proj2)
summary(prelim2)
prelim3 <- lm(audience_score ~ genre + runtime + mpaa_rating + best_pic_nom + critics_score, data = proj2)
summary(prelim3)
prelim4 <- lm(audience_score ~ genre + runtime + mpaa_rating + critics_score, data = proj2)
summary(prelim4)
prelim5 <- lm(audience_score ~ genre + runtime + critics_score, data = proj2)
summary(prelim5)
prelim6 <- lm(audience_score ~ runtime + critics_score, data = proj2)
summary(prelim6)

# BEST MODEL
mlr = prelim5

# DIAGNOSTICS
plot(mlr$residuals ~ proj2$runtime)
plot(mlr$residuals ~ proj2$critics_score)
hist(mlr$residuals)
qqnorm(mlr$residuals)
qqline(mlr$residuals)
plot(mlr$residuals ~ mlr$fitted)
plot(abs(mlr$residuals) ~ mlr$fitted)
abline(0,0)
plot(mlr$residuals, xlab='Order of Data Collection', ylab='Residuals')

# SUMMARY
summary(mlr)

# END YOUR CODE