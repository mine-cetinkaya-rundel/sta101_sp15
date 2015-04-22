# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# 
# #### Exploratory Data Analysis
# movies$win_aa = NA
# movies$win_aa[movies$best_actor_win == "yes" | movies$best_actress_win == "yes"] = "yes"
# movies$win_aa[movies$best_actor_win == "no" & movies$best_actress_win == "no"] = "no"
# movies$win_aa = as.factor(movies$win_aa) # Create new variable including all movies that have either a winning best actor or a winning best actress
# summary(movies$win_aa)
# by(movies$audience_score, movies$win_aa, summary)
# by(movies$audience_score, movies$win_aa, mean)
# 
# #### Inference Test
# inference(y = movies$audience_score, x=movies$win_aa, est = "mean", type = "ht", null = 0, alternative = "twosided", method="theoretical")
# 
# #### Modeling
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score + critics_rating + best_pic_nom + best_pic_win + win_aa + best_dir_win + top200_box, data = movies) # Full model
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score + critics_rating + best_pic_nom + best_pic_win + win_aa + top200_box, data = movies) # Take out best_dir_win
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score + critics_rating + best_pic_win + win_aa + top200_box, data = movies) # Take out best_pic_nom
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score + critics_rating + best_pic_win + top200_box, data = movies) # Take out win_aa
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score + critics_rating + top200_box, data = movies) # Take out best_pic_win
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score + top200_box, data = movies) # Take out critics_rating
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + mpaa_rating + critics_score, data = movies) # Take out top200_box
# summary(m_full)
# m_full <- lm(audience_score ~ genre + runtime + imdb_num_votes + mpaa_rating + critics_score, data = movies) # Take out year = BEST MODEL found using p-value backwards selection
# summary(m_full)
# confint(m_full)
# plot(m_full$residuals ~ m_full$fitted.values) # Test for linearity condition
# abline(0, 0)
# qqnorm(resid(m_full))
# qqline(resid(m_full))
# hist(resid(m_full)) # Test for normal distribution of residuals condition
# plot(abs(m_full$residuals) ~ m_full$fitted.values) # Test for constant linearity condition
# abline(0, 0)
# plot(resid(m_full)) # Test for independence of observations condition
# abline(0,0)
# 
# #### Prediction
# insurg = data.frame(genre = "Drama", runtime = 119, imdb_num_votes = 33618, mpaa_rating = "PG-13", critics_score = 31)
# predict(m_full, insurg, interval = "confidence") # Confidence interval for Insurgent
# predict(m_full, insurg, interval = "prediction") # Prediction interval for Insurgent
# 
# mlr = lm(audience_score ~ genre + runtime + imdb_num_votes + mpaa_rating + critics_score, data = movies)
