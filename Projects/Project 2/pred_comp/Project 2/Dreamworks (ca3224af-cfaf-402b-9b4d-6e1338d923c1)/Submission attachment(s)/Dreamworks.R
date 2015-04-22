# #Load Data 
# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# 
# #EDA
# #Control for Certified Fresh in order to compare critics scores and audience scores for mpaa_rating.
# movies_eda <- subset(movies, movies$critics_rating == "Certified Fresh")
#   #New subset with 60 observations 
# 
# summary(movies_eda$audience_score)
# summary(movies_eda$critics_score)
# summary(movies_eda$mpaa_rating)
# 
# plot(movies_eda$audience_score ~ movies_eda$mpaa_rating)
# plot(movies_eda$critics_score ~ movies_eda$mpaa_rating)
# 
# #Does this show that there is audience and critic score agreement over certified fresh movies based on mpaa_rating?
# movies_edaG <- subset(movies_eda, movies_eda$mpaa_rating == "G")
# movies_edaPG <- subset(movies_eda, movies_eda$mpaa_rating == "PG")
# movies_edaPG13 <- subset(movies_eda, movies_eda$mpaa_rating == "PG-13")
# movies_edaR <- subset(movies_eda, movies_eda$mpaa_rating == "R")
# movies_edaU <- subset(movies_eda, movies_eda$mpaa_rating == "Unrated")
# 
# #Compare medians of audience scores and critics scores for movies that are rated G
# summary(movies_edaG$audience_score)
# summary(movies_edaG$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are rated PG
# summary(movies_edaPG$audience_score)
# summary(movies_edaPG$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are rated PG-13
# summary(movies_edaPG13$audience_score)
# summary(movies_edaPG13$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are rated R
# summary(movies_edaR$audience_score)
# summary(movies_edaR$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are Unrated
# summary(movies_edaU$audience_score)
# summary(movies_edaU$critics_score)
# #Seeing this pattern: That critics are less critical than the audience for all mpaa_ratings for all Certified Fresh movies we wondered if this would change if we looked at the other extreme - Rotten movies. 
# 
# #Rotten Movies 
# movies_edaR <- subset(movies, movies$critics_rating == "Rotten")
# plot(movies_edaR$audience_score ~ movies_edaR$mpaa_rating)
# plot(movies_edaR$critics_score ~ movies_edaR$mpaa_rating)
# 
# #Does this show that there is audience and critic rating agreement over certified fresh movies based on mpaa_rating?
# movies_edaRG <- subset(movies_edaR, movies_edaR$mpaa_rating == "G")
# movies_edaRPG <- subset(movies_edaR, movies_edaR$mpaa_rating == "PG")
# movies_edaRPG13 <- subset(movies_edaR, movies_edaR$mpaa_rating == "PG-13")
# movies_edaRR <- subset(movies_edaR, movies_edaR$mpaa_rating == "R")
# movies_edaRU <- subset(movies_edaR, movies_edaR$mpaa_rating == "Unrated")
# 
# #Compare medians of audience scores and critics scores for movies that are rated G
# summary(movies_edaRG$audience_score)
# summary(movies_edaRG$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are rated PG
# summary(movies_edaRPG$audience_score)
# summary(movies_edaRPG$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are rated PG-13
# summary(movies_edaRPG13$audience_score)
# summary(movies_edaRPG13$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are rated R
# summary(movies_edaRR$audience_score)
# summary(movies_edaRR$critics_score)
# 
# #Compare medians of audience scores and critics scores for movies that are Unrated
# summary(movies_edaRU$audience_score)
# summary(movies_edaRU$critics_score)
# 
# #We found that the opposite phenomenon we discovered for Certified Fresh happens for Rotten movies. For films that critics rated Rotten, across mpaa_rating, the audience was less critical and gave higher scores.
# 
# 
# #Determining whether or not to include variables for inference 
# summary(movies)
# 
# #Create subset based on which observations we are no longer interested in 
# movies_sub <- subset(movies, movies$year > 1999 & movies$mpaa_rating != "Unrated" & movies$type == "Feature Film")
#   #new subset with 205 observations 
# 
# #Drop levels to overwrite movies_sub 
# movies_sub <- droplevels(movies_sub)
# 
# #Download inference function 
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# #Hypothesis test 
# inference(y = movies_sub$audience_score, x = movies_sub$mpaa_rating, est = "mean", type = "ht", alternative = "greater", method = "theoretical")
# 
# #exclude best_pic_nom, best_pic_win, best_dir_win, top200_box because very few cases received yes's in each category 
# #Type is not included in the linear model because when we dropped the other 2 levels only Feature Film remains
# 
# #take out mpaa_rating because shown to be not significant in inference 
# 
# m_full <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m_full)$adj.r.squared #without mpaa_rating .4880769
# 
# m_full1 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m_full)$adj.r.squared # with mpaa_rating .4903
# 
# #We chose to keep mpaa_rating, despite the lack of a significant differene in the inference results because the model including mpaa_rating resulted in a higher R^2 value
# 
# m1 = lm(audience_score ~ runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m1) #without genre 
# 
# m2 = lm(audience_score ~ genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m2) #without runtime
# 
# m3 = lm(audience_score ~ genre + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m3) #without year 
# 
# m4 <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m4)$adj.r.squared #without mpaa_rating 
# 
# m5 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m5)$adj.r.squared #without imdb_num_votes 
# 
# m6 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_actor_win + best_actress_win, data = movies_sub)
# summary(m6)$adj.r.squared #without critics_score 
# 
# m7 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub)
# summary(m7)$adj.r.squared #without critics_rating 
# 
# m8 <-  lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actress_win, data = movies_sub)
# summary(m8)$adj.r.squared #without best_actor_ win 
# 
# m9 <-lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win, data = movies_sub)
# summary(m9)$adj.r.squared #without best_actress_win 
# 
# #New model without critics_rating 
# m_full2 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_full2)$adj.r.squared #.4906
# 
# m_1 <- lm(audience_score ~ runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_1)$adj.r.squared #without genre
# 
# m_2 <- lm(audience_score ~ genre + year + mpaa_rating + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_2)$adj.r.squared #without runtime 
# 
# m_3 <- lm(audience_score ~ genre + runtime + mpaa_rating + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_3)$adj.r.squared #without year 
# 
# m_4 <- lm(audience_score ~ genre + runtime + year + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_4)$adj.r.squared #without mpaa_rating 
# 
# m_5 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_5)$adj.r.squared #without imdb_num_votes
# 
# m_6 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + best_actor_win + best_actress_win, data = movies_sub) 
# summary(m_6)$adj.r.squared #without critics_score
# 
# m_7 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_actress_win, data = movies_sub)
# summary(m_7)$adj.r.squared #without best_actor_win 
# 
# m_8 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_actor_win, data = movies_sub) 
# summary(m_8)$adj.r.squared #without best_actress_win 
# 
# #Best model 
# mlr <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_actor_win + best_actress_win, data = movies_sub) 
# summary(mlr) # R^2 .5256 
# 
# #Diagnostics
# 
#   #Linearity 
# plot(mlr$residuals ~ movies_sub$runtime)
# abline(h = 0, lty = 3) # adds a horizontal dashed line at y = 0
# plot(mlr$residuals ~ movies_sub$imdb_num_votes)
# abline(h = 0, lty = 3) # adds a horizontal dashed line at y = 0
# plot(mlr$residuals ~ movies_sub$critics_score)
# abline(h=0, lty = 3) # adds a horizontal dashed line at y = 0
# 
#   #Nearly Normal
# hist(mlr$resid)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# 
#   #Constant Variability
# plot(mlr$resid ~ mlr$fitted.values)
# abline(h = 0, lty = 3) # adds a horizontal dashed line at y = 0
# 
#   #Independence
# plot(mlr$resid) 
# abline(h = 0, lty = 3) # adds a horizontal dashed line at y = 0
# 
# #Fifty Shades of Grey Prediction 
# 
# fiftyshadesprediction = data.frame(genre = "Drama", runtime = 125, year = 2015, mpaa_rating = "R", imdb_num_votes = 138,684, critics_score = 25, best_actor_win = "no", best_actress_win = "no")
# 
# #Predicted Audience Score
# predict(mlr, fiftyshadesprediction, prediction = "interval")
# 
# #Prediction Interval 
# predict(mlr, fiftyshadesprediction, interval = "prediction")
