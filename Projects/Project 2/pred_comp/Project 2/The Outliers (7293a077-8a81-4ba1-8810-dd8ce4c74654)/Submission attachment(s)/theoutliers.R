# # BEGIN OUR CODE
# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# 
# # Exploratory Data Analysis
# movies$runtime_cat = NA
# movies$runtime_cat[movies$runtime>=90 & movies$runtime<=120] = "medium"
# movies$runtime_cat[movies$runtime < 90] = "low"
# movies$runtime_cat[movies$runtime > 120] = "high"
# by(movies$audience_score, movies$runtime_cat, mean)
# m1 <- lm(audience_score ~ runtime_cat, data = movies)
# m2 <- lm(audience_score ~ runtime, data = movies)
# summary(m1)
# summary(m2)
# plot(movies$audience_score ~ movies$runtime)
# abline(m2)
# cor(movies$audience_score, movies$runtime)
# plot(jitter(movies$audience_score) ~ movies$runtime)
# 
# # Inference
# plot(movies$runtime, movies$audience_score)
# boxplot(movies$audience_score ~ movies$runtime_cat)
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# inference(y = movies$audience_score, x = movies$runtime_cat, est = "mean", type = "ht", method = "theoretical", alternative = "greater")
# 
# # Modeling
# m_full <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
# summary(m_full)
# m_1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box, data = movies)
# summary(m_1)
# m_2 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box, data = movies)
# m_3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box, data = movies)
# m_4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
# m_5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + top200_box, data = movies)
# m_6 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + best_pic_win + top200_box, data = movies)
# m_7 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + top200_box, data = movies)
# m_8 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score, data = movies)
# mlr <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
# summary(mlr) 
# 
# # Prediction
# newdata = data.frame(type = "Feature Film", genre = "Other", runtime = 125, imdb_num_votes = 136917, critics_score = 25)
# predict(mlr, newdata, interval="predict")
# 
# # END OUR CODE
# summary(mlr)
