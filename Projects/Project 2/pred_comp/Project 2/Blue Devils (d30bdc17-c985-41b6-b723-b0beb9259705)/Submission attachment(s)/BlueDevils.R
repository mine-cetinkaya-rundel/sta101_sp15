download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")

load("movies.Rdata")
View(movies)
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")

##### Exploratory Data Analysis

inference(y = movies$audience_score, est = "mean", type = "ci", null = 0, alternative = "twosided", method = "theoretical")

inference(y = movies$critics_score, est = "mean", type = "ci", null = 0, alternative = "twosided", method = "theoretical")

AudiCritic= lm(audience_score ~ critics_score , data= movies )
summary(AudiCritic)
plot(movies$audience_score ~ movies$critics_score)
abline(AudiCritic)
plot(AudiCritic$residuals)
abline(h=0, lty=3)
plot(AudiCritic$residuals ~ movies$audience_score)
abline(h=0, lty=3)
hist(AudiCritic$residuals)
qqnorm(AudiCritic$residuals)
qqline(AudiCritic$residuals)

##### Inference

movies$audicriticdiff<-movies$audience_score-(movies$critics_score)
inference(y = movies$audicriticdiff, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical")

##### Multiple Linear Regression

##### First Round

mlr_moviesall= lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data= movies )
summary(mlr)

plot(mlr_moviesall$residuals)
abline(h=0, lty=3)
plot(mlr_moviesall$residuals ~ movies$audience_score)
abline(h=0, lty=3)
hist(mlr_moviesall$residuals)
qqnorm(mlrs_moviesall$residuals)
qqline(mlr_moviesall$residuals)

##### Final Round

mlr= lm(audience_score ~ type + genre + runtime +imdb_num_votes + critics_score , data= movies )
summary(mlr)

plot(mlr$residuals)
abline(h=0, lty=3)
plot(mlr$residuals ~ movies$audience_score)
abline(h=0, lty=3)
hist(mlr$residuals)
qqnorm(mlr$residuals)
qqline(mlr$residuals)

##### Prediction

movprediction = data.frame(genre = "Action & Adventure", runtime = 140, imdb_num_votes = 155784, type = "Feature Film", critics_score = 82)

predict(mlr , movprediction , interval= "prediction")
