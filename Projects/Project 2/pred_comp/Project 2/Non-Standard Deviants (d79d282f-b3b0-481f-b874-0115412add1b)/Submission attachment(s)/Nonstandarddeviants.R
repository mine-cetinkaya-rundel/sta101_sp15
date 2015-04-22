# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# ##Part 1
# summary(movies$genre) ##looks at summary of different genres 
# drama <- subset(movies, movies$genre == "Drama") ##different subsets of decades for comedy 
# drama80s <- subset(drama, year>=1974 & year<1990 )
# drama90s <- subset(drama, year>=1990 & year<2000)
# drama00s <- subset(drama, year>=2000)
# by(movies$audience_score, movies$genre, mean)
# mean(drama80s$audience_score) ## mean of audience scores 
# mean(drama90s$audience_score)
# mean(drama00s$audience_score)
# summary(drama80s$audience_score) ## IQR, Min/max
# summary(drama90s$audience_score)
# summary(drama00s$audience_score)
# boxplot(drama80s$audience_score, drama90s$audience_score, drama00s$audience_score) ##Boxplot 
# hist(drama80s$audience_score) ##histogram of scores 
# hist(drama90s$audience_score)
# hist(drama00s$audience_score)
# ##Part 2
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# attach(drama) ##new variables for decades 
# drama$year2[year<1990] <- "Old"
# drama$year2[year>=1990 & year<2000] <- "Medium"
# drama$year2[year>=2000] <- "New"
# detach(drama)
# by(drama, drama$year2, dim)
# inference(y = drama$audience_score, x = drama$year2, est = "mean", type = "ht", alternative = "greater", method = "theoretical",)
# qqnorm(drama$audience_score) ##conditions for normality 
# qqline(drama$audience_score)
# qqnorm(drama80s$audience_score)
# qqline(drama80s$audience_score)
# qqnorm(drama90s$audience_score)
# qqline(drama90s$audience_score)
# qqnorm(drama00s$audience_score)
# qqline(drama00s$audience_score)
# hist(drama$audience_score)
# ##critics response
# inference(y = drama$critics_score, x = drama$year2, est = "mean", type = "ht", alternative = "greater", method = "theoretical",)
# qqnorm(drama80s$critics_score)
# qqline(drama80s$critics_score)
# qqnorm(drama90s$critics_score)
# qqline(drama90s$critics_score)
# qqnorm(drama00s$critics_score)
# qqline(drama00s$critics_score)
# ## Part 3
# attach(movies)
# movies$year2[year<1990] <- "Old"
# movies$year2[year>=1990 & year<2000] <- "Medium"
# movies$year2[year>=2000] <- "New"
# detach(movies)
# mlr = lm(audience_score~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win  + top200_box, data=movies)
# summary(mlr)
# plot(mlr$residuals ~ mlr$fitted)## Diagnostics 
# plot(mlr$residuals)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# hist(mlr$residuals)
# ## Part 4
# shades=data.frame(type="Feature Film", genre="Drama", runtime=125,  year=2015, mpaa_rating="PG-13", imdb_num_votes=138744, critics_score=25, critics_rating= 'Rotten', best_pic_win="no", top200_box="yes" )
# predict(mlr, newdata=shades)
# 
