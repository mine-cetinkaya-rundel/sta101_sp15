# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# 
# # EDA
# plot(movies$audience_score ~ movies$genre)
# plot(movies$audience_score ~ movies$critics_rating)
# by(movies$audience_score, movies$genre, summary)
# by(movies$audience_score, movies$genre, sd)
# # Critics_rating vs audience score for each genre:
# sub_AA = subset(movies, movies$genre == "Action & Adventure")
# sub_comedy = subset(movies, movies$genre == "Comedy")
# sub_drama = subset(movies, movies$genre == "Drama")
# sub_horror = subset(movies, movies$genre == "Horror")
# sub_MS = subset(movies, movies$genre == "Mystery & Suspense")
# sub_other = subset(movies, movies$genre == "Other")
# plot(sub_AA$audience_score ~ sub_AA$critics_rating)
# plot(sub_comedy$audience_score ~ sub_comedy$critics_rating)
# plot(sub_drama$audience_score ~ sub_drama$critics_rating)
# plot(sub_horror$audience_score ~ sub_horror$critics_rating)
# plot(sub_MS$audience_score ~ sub_MS$critics_rating)
# plot(sub_other$audience_score ~ sub_other$critics_rating)
# 
# 
# # INFERENCE
# inference(y = movies$audience_score, x = movies$genre, est = "mean", type = "ht", conflevel = 0.95, null = 0, alternative = "greater", method = "theoretical")
# # CONDITIONS FOR ANOVA
# # Approximate Normality Condition:
# qqnorm(sub_AA$audience_score)
# qqline(sub_AA$audience_score)
# hist(sub_AA$audience_score, breaks = 20)
# qqnorm(sub_comedy$audience_score)
# qqline(sub_comedy$audience_score)
# hist(sub_comedy$audience_score, breaks = 20)
# qqnorm(sub_drama$audience_score)
# qqline(sub_drama$audience_score)
# hist(sub_drama$audience_score, breaks = 20)
# qqnorm(sub_horror$audience_score)
# qqline(sub_horror$audience_score)
# hist(sub_horror$audience_score, breaks = 20)
# qqnorm(sub_MS$audience_score)
# qqline(sub_MS$audience_score)
# hist(sub_MS$audience_score, breaks = 20)
# qqnorm(sub_other$audience_score)
# qqline(sub_other$audience_score)
# hist(sub_other$audience_score, breaks = 20)
# 
# 
# #MLR
# m_full = lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
# summary(m_full)$adj.r.squared
# mlr = lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
# summary(mlr)$adj.r.squared
# #CONDITIONS FOR MLR:
# #Linearity
# plot(mlr$residuals ~ mlr$fitted.values)
# abline(h = 0, lty = 3)
# #Normal residuals
# hist(mlr$residuals, breaks = 20)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# #Constant Variability
# plot(abs(mlr$residuals) ~ movies$audience_score)
# #Independence of residuals
# m1 = lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
# plot(m1$residuals, xlab = 'Order of Data Collection', ylab = 'Residuals')
# 
# # Prediction
# cinderella = data.frame(type = "Feature Film", genre = "Drama", runtime = 105, year = 2015, mpaa_rating = "PG", imdb_num_votes = 31820, critics_score = 85, critics_rating = "Certified Fresh", best_pic_win = "no", top200_box = "yes")
# predict(mlr, newdata = cinderella)
# predict(mlr, newdata = cinderella, interval = "prediction")
# 
# summary(mlr)