# load("movies.Rdata")
# 
# #
# 
# #### EDA: 
# 
# aa <- subset(movies, genre=="Action & Adventure")
# cor(aa$audience_score, aa$year)
# cor(aa$audience_score, aa$imdb_num_votes)
# cor(aa$audience_score, aa$critics_score)
# drama <- subset(movies, genre=="Drama")
# cor(drama$audience_score, drama$runtime)
# ratedr <- subset(movies, mpaa_rating == "R")
# cor(ratedr$audience_score, ratedr$runtime)
# cor(ratedr$audience_score, ratedr$year)
# cor(ratedr$audience_score, ratedr$imdb_num_votes)
# cor(ratedr$audience_score, ratedr$critics_score)
# bestactor<-subset(movies, best_actor_win=="yes")
# cor(bestactor$audience_score, bestactor$runtime)
# 
# #### Inference:
# #Is there a difference in mean audience scores between PG movies and R movies? 
# 
# #Ho(null hypothesis): There is no difference between the mean audience scores of PG movies and R movies. 
# 
# #Ha(alternative hypothesis): There is a difference between the mean audience scores of PG movies and R movies. 
# 
# #Conditions:
# #1. independence: within groups, sampled obs. Must be independent (random sample/assignment, if sampling w/o replacement, n<10% of pop)
# #between groups: two pops must be ind. Of each other (non-paired) This is satisfied as 64<10% of all PG-rated movies and 221<10% of all R-rated movies. Also, this data set was sampled randomly.
# #2. sample size/skew: each sample size must be at least 30. This is satisfied. N > 30 for both PG-rated movies (64) and R-rated movies (221).
# 
# 
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# PG<-subset(movies, mpaa_rating=="PG")
# R<-subset(movies, mpaa_rating=="R")
# obs <- mean(R$audience_score)-mean(PG$audience_score)
# show(obs)
# sr <- sd(R$audience_score)
# show(sr)
# spg <- sd(PG$audience_score)
# show(spg)
# nr <- 221
# show(nr)
# npg <- 64
# show(npg)
# 
# #z value = (obs - null)/SE
# #SE = sq. root of (s rated PG^2/n rated PG + s rated R^2/n rated R)
# 
# SE <- sqrt(spg^2/npg + sr^2/nr)
# show(SE)
# Z <- obs/SE
# show(Z)
# p <- 2*pnorm(Z, mean=0, lower.tail=FALSE)
# show(p)
# 
# #Based off this high p-value, fail to reject the null hypothesis that mean audience scores are different between PG-rated and R-rated movies.
# 
# #### Modeling:
# 
# #We are using the backwards selection model, using p-values as our selecting criteria. We will begin with a full model. 
# #We are using the backwards selection model, using p-values as our selecting criteria. We will begin with a full model. 
# #Conditions for multiple linear regression:
# #1. linear relationship between the explanatory variable and the response - checked using scatterplots of MLR residuals vs. each numerical explanatory variable
# #2. nearly normal residuals with mean 0 - checked using a histogram of residuals
# #3. constant variability of residuals - checked using residuals plots vs. predicted y (fitted residuals plot)
# #4. independence of residuals and observations
# #code for checking conditions is underneath this backwards p-value test
# 
# m_movies <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
# summary(m_movies)
# m_no_best_dir_win<- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box, data = movies)
# summary(m_no_best_dir_win)
# m_no_best_pic_nom<-lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box, data = movies)
# summary(m_no_best_pic_nom)
# m_no_best_actor_win<-lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box, data = movies)
# summary(m_no_best_actor_win)
# m_no_best_actress_win<-lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
# summary(m_no_best_actress_win)
# m_no_critics_rating<-lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + top200_box, data = movies)
# summary(m_no_critics_rating)
# m_no_mpaa_rating<-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + best_pic_win + top200_box, data = movies)
# summary(m_no_mpaa_rating)
# m_no_best_pic_win<-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + top200_box, data = movies)
# summary(m_no_best_pic_win)
# m_no_top200_box<-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score, data = movies)
# summary(m_no_top200_box)
# mlr<-lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
# summary(mlr)
# 
# plot(mlr$residuals ~ movies$runtime)
# abline(h = 0, lty = 3)
# plot(mlr$residuals ~ movies$imdb_num_votes)
# abline(h = 0, lty = 3)
# plot(mlr$residuals ~ movies$critics_score)
# abline(h = 0, lty = 3)
# hist(mlr$residuals)
# plot(mlr)
# #“best” multiple linear regression model to explain audience movie scores:
#   
# #audience movie scores = 3.733e+01 - 1.601e+01typefeaturefilm - 1.227e+01typeTVMovie + 4.362e+00genreComedy + 8.434e+00genreDrama - 4.626e+00genreHorror - 8.108e-01genreMystery&Suspense + 5.422e+00genreOther + 9.928e-02runtime + 4.504e-05imdb_num_votes + 3.707e-01critics_score
# 
# #### Prediction:
# 
# #We chose to predict information about 50 Shades of Grey. 
# 
# shadesofgrey=data.frame(type = "Feature Film", genre = "Drama", runtime = 125, year = 2015, imdb_num_votes = 135829, critics_score = 25, top200_box="yes")
# predict(mlr , shadesofgrey , interval = "prediction")
# 
# #According to our model, 50 Shades of Grey, an R rated movie, is predicted to have have an audience movie score of 57.5506. The 95% prediction interval is (31.73924, 83.36196), meaning that the margin of error is 25.81136. We are 95% confident that the audience movie score of a 2015 drama feature film on the Top 200 Box Office list on BoxOfficeMojo with runtime of 125 mins and number of imdb votes = 135829 and critics score = 25 has a audience movie score between 31.73924 and 83.36196.
# 
# #
# 
# summary(mlr)