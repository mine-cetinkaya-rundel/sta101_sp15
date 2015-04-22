# #load data
# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# #1
# #exploratory data analysis
# drama <- subset(movies, genre == "Drama")
# drama <- droplevels(drama)
# hist(drama$audience_score)
# summary(drama$audience_score)
# boxplot(drama$critics_score ~ drama$audience_rating)
# plot(drama$audience_score ~ drama$runtime)
# m_runtime <- lm(audience_score ~ runtime, data = drama)
# abline(m_runtime)
# summary(m_runtime)
# plot(drama$audience_score ~ drama$imdb_num_votes)
# m_imdb_num_votes <- lm(audience_score ~ imdb_num_votes, data = drama)
# abline(m_imdb_num_votes)
# summary(m_imdb_num_votes)
# plot(drama$audience_score ~ drama$critics_score)
# m_critics_score <- lm(audience_score ~ critics_score, data = drama)
# abline(m_critics_score)
# summary(m_critics_score)
# 
# #2
# #inference
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# by(drama$critics_score,drama$audience_rating, mean)
# inference(y = drama$critics_score, x = drama$audience_rating, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical")
# inference(y = drama$critics_score, x = drama$audience_rating, est = "mean", type = "ci", null = 0, alternative = "twosided", method = "theoretical", order = c("Spilled","Upright"))
# 
# #3
# #model of best fit
# mlr <- lm(audience_score ~ runtime + imdb_num_votes + critics_score, data = drama)
# summary(mlr)
# hist(mlr$residuals)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# plot(mlr$residuals)
# abline(h = 0, lty = 3)
# plot(mlr$residuals ~ mlr$fitted.values)
# abline(h = 0, lty = 3)
# plot(drama$runtime, drama$imdb_num_votes)
# plot(drama$runtime, drama$critics_score)
# plot(drama$critics_score, drama$imdb_num_votes)
# 
# #4
# #predict function
# Fifty_Shades_of_Grey = data.frame(imdb_num_votes = 136276, critics_score = 25, runtime = 110) 
# 
# predict(mlr, newdata = Fifty_Shades_of_Grey, interval = "prediction")
# 
