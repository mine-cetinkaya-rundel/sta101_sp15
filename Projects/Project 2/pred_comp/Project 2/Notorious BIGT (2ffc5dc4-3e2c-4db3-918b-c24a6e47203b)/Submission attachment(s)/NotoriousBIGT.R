# # load data
# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# 
# # EDA
# summary(movies$runtime)
# hist(movies$audience_score)
# movies$length = NA  
# movies$length[movies$runtime > 120] = "long"
# movies$length[movies$runtime <  120] = "normal"
# movies$length = as.factor(movies$length)  
# boxplot(movies$audience_score ~ movies$length)
# 
# # Inference
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# inference(y=movies$audience_score, x = movies$length, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical", order = c("long", "normal"))
# inference(y = movies$audience_score, x = movies$length, est = "mean", type = "ci", null = 0, alternative = "twosided", method = "theoretical", order=c("long", "normal"))
# 
# # Best Model
# mlr<-lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box , data = movies)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# hist(mlr$residuals)
# movies_num = subset(movies,select = c("runtime", "year", "imdb_num_votes", "critics_score"))
# plot(movies_num)
# plot(mlr$residuals ~ mlr$fitted)
# plot(mlr$residuals)
# 
# # Prediction
# focus = data.frame(type = "Feature Film", genre = "Drama", runtime = 105, year = 2015, mpaa_rating = "R", imdb_num_votes = 38482, critics_score = 56, critics_rating = "Rotten", best_pic_win = "no", top200_box = "no")
# predict(mlr, focus, interval = "prediction")
# 
# summary(mlr)
# 
