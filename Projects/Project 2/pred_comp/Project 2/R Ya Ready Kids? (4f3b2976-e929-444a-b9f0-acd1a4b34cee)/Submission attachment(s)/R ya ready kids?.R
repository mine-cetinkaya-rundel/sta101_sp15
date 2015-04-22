#Data
download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")

#EDA
hist(movies$audience_score)
hist(movies$critics_score)
table(movies$best_pic_win)

plot(movies$audience_score ~ movies$critics_score)
line = lm(movies$audience_score ~ movies$critics_score)
abline(line)
boxplot(movies$audience_score ~ movies$critics_rating)


#Infrence
inference(y = movies$audience_score, x = movies$critics_rating, est = "mean", type = "ht", alternative = "greater", method = "theoretical")
#conditions
fresh <- subset(movies, critics_rating == "Fresh")
hist(fresh$audience_score)
qqnorm(fresh$audience_score)
qqline(fresh$audience_score)
certifiedfresh <- subset(movies, critics_rating == "Certified Fresh")
hist(certifiedfresh$audience_score)
qqnorm(certifiedfresh$audience_score)
qqline(certifiedfresh$audience_score)
rotten <- subset(movies, critics_rating == "Rotten")
hist(rotten$audience_score)
qqnorm(rotten$audience_score)
qqline(rotten$audience_score)
#Full model
Full = lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
#Backwards adjusted r^2 code
mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
summary(mlr)
#diagnostic plots
hist(mlr$residuals)
qqnorm(mlr$residuals)
qqline(mlr$residuals)
plot(mlr$residuals)
abline(h = 0, lty = 3)
plot(mlr$residuals ~ mlr$fitted)
abline(h = 0, lty = 3)
plot(mlr$residuals, xlab='Order of Data Collection', ylab='Residuals')

#Backward p-value seleciton
movies_P <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
summary(movies_P)

#Prediction
Chappie = data.frame(type = "Feature Film", genre = "Action & Adventure", runtime = 120, year = 2015, mpaa_rating = "R",imdb_num_votes = 33835, critics_score = 30, critics_rating = "Rotten", best_pic_win = "no", top200_box = "no")
predict(mlr, Chappie, interval = "prediction")

blacksoul = data.frame(type = "Feature Film", genre = "Drama", runtime = 103, year = 2015, mpaa_rating = "Unrated",imdb_num_votes = 490, critics_score = 95, critics_rating = "Fresh", best_pic_win = "no", top200_box = "no")
predict(mlr, blacksoul, interval = "prediction")

Furious7 = data.frame(type = "Feature Film", genre = "Action & Adventure", runtime = 137, year = 2015, mpaa_rating = "PG-13",imdb_num_votes = 109668, critics_score = 82, critics_rating = "Certified Fresh", best_pic_win = "no", top200_box = "no")
predict(mlr, Furious7, interval = "prediction")

summary(mlr)