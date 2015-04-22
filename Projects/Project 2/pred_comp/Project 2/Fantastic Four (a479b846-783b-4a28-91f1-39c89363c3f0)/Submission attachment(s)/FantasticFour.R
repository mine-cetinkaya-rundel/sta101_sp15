# #Project 2
# #Fantastic Four
# #Casey Chiaviello, Liam Brennan, Rachel Stand, Yolanda Qin
# 
# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# 
# #Part 1: Introduction
# 
# summary(movies)
# summary(movies$audience_score)
# summary(movies$critics_score)
# 
# #Part 2: EDA
# 
# #Scatterplot of Audience Score vs Critic Score and Critic Rating
# plot(movies$audience_score ~ movies$critics_score)
# plot(movies$audience_score ~ movies$critics_rating)
# 
# #Scatterplot Matrices of Audience Score vs Critic Score
# par(mfrow=c(1,1))
# pairs.panel.cor <- function(x, y, digits=2, prefix="", cex.cor)
# {
#   usr <- par("usr"); on.exit(par(usr))
#   par(usr = c(0, 1, 0, 1))
#   r = (cor(x, y))
#   txt <- format(c(r, 0.123456789), digits=digits)[1]
#   txt <- paste(prefix, txt, sep="")
#   if(missing(cex.cor)) cex <- 0.8/strwidth(txt)
#   text(0.5, 0.5, txt, cex = cex * abs(r))
# }
# pairs(audience_score~critics_score, data=movies, lower.panel=panel.smooth, upper.panel=pairs.panel.cor)
# 
# #Correlation Coefficients between Audience Score and Critic Score
# cor(movies$audience_score, movies$critics_score)
# 
# #Paratmeter Estimate of Audience Score and Critic Score
# m_acscore <- lm(audience_score ~ critics_score, data = movies)
# plot(m_acscore)
# summary(m_acscore)
# plot(m_acscore$residuals)
# abline(h = 0, lty = 3)
# 
# #Parameter Estimate of Audience Score and Critic Score, while controlling for genre
# m_acscore2 <- lm(movies$audience_score ~ movies$critics_score + movies$genre)
# plot(m_acscore2)
# summary(m_acscore2)
# plot(m_acscore2$residuals)
# abline(h = 0, lty = 3)
# 
# #Parameter Estimate of Audience Score and Critic Score, while controlling for best picture nomination
# m_acscore3 <- lm(movies$audience_score ~ movies$critics_score + movies$best_pic_nom)
# plot(m_acscore3)
# summary(m_acscore3)
# plot(m_acscore3$residuals)
# abline(h = 0, lty = 3)
# 
# #Part 3: Inference
# #Research question: Is there a difference in means score between the audience score and the critics score?
# t.test(movies$critics_score, movies$audience_score)
# 
# #Part 4: The "Best" Model
# 
# #Full Model
# #Adjusted R-squared = 0.7997 
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$mpaa_rating + movies$imdb_num_votes + movies$critics_score + movies$critics_rating + movies$best_pic_nom + movies$best_pic_win + movies$best_actor_win + movies$best_actress_win + movies$best_dir_win + movies$top200_box + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out best_pic_nom
# #Adjusted R-squared = 0.8002
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$mpaa_rating + movies$imdb_num_votes + movies$critics_score + movies$critics_rating + movies$best_pic_win + movies$best_actor_win + movies$best_actress_win + movies$best_dir_win + movies$top200_box + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out best_dir_win
# #Adjusted R-squared = 0.8006
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$mpaa_rating + movies$imdb_num_votes + movies$critics_score + movies$critics_rating + movies$best_pic_win + movies$best_actor_win + movies$best_actress_win + movies$top200_box + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out critics_rating
# #Adjusted R-squared = 0.8011
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$mpaa_rating + movies$imdb_num_votes + movies$critics_score + movies$best_pic_win + movies$best_actor_win + movies$best_actress_win + movies$top200_box + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out best_pic_win
# #Adjusted R-squared = 0.8015
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$mpaa_rating + movies$imdb_num_votes + movies$critics_score + movies$best_actor_win + movies$best_actress_win + movies$top200_box + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out mpaa_rating
# #Adjusted R-squared = 0.7996
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$imdb_num_votes + movies$critics_score + movies$best_actor_win + movies$best_actress_win + movies$top200_box + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out top200_box
# #Adjusted R-squared= 0.7998
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$imdb_num_votes + movies$critics_score + movies$best_actor_win + movies$best_actress_win + movies$audience_rating)
# summary(mfull)
# 
# #Model after taking out best_actor_win
# #Adjusted R-squared= 0.80
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$imdb_num_votes + movies$critics_score + movies$best_actress_win + movies$audience_rating)
# summary(mfull)
# 
# 
# #Model after taking out best_actress_win
# #Adjusted R-Squared= 0.7997
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$runtime + movies$year + movies$imdb_num_votes + movies$critics_score + movies$audience_rating)
# summary(mfull)
# 
# 
# #Model after taking out runtime
# #Adjusted R-Squared= 0.7991
# mfull <- lm(movies$audience_score ~ movies$type + movies$genre + movies$year + movies$imdb_num_votes + movies$critics_score + movies$audience_rating)
# summary(mfull)
# 
# #The best linear model is:
# mlr <- lm(movies$audience_score ~ movies$type + movies$genre + movies$year + movies$imdb_num_votes + movies$critics_score + movies$audience_rating)
# 
# #Conditions for MLR are fulfilled
# #There is constant scatter in residuals (no pattern) so we can assume that there is a linear relationship between X and Y and that there is constant variability of residuals
# #The residual plot also proves that the residuals are independent because if we look at the index on the x-axis, it is clear that there is no pattern in the order of data collections.
# plot(mlr$residuals)
# abline(h = 0, lty = 3)
# 
# #The histogram of the residuals and the normal probability plot of the residuals are nearly normal (if anything, a little left-skewed) so we can assume nearly normal residuals
# hist(mlr$residuals)
# qqnorm(mlr$residuals)
# 
# #Part 5: Prediction
# mlr <- lm(movies$audience_score ~ movies$type + movies$genre + movies$year + movies$imdb_num_votes + movies$critics_score + movies$audience_rating)
# #Audience score hat: = 2.720e+02 + (-1.021e+01)typeFeatureFilm + (-6.609e+00)typeTVMovie + (0)typeDocumentary + (2.178e+00)genreComedy + (3.635e+00)genreDrama + (-1.839e+00)genreHorror + (1.355e-02)genreMysterySuspense + (3.023e+00)genreOther + (0)genreActionAdventure + (-1.145e-01)year + (3.170e-05)imdb_num_votes + (1.758e-01)critics_score + (2.434e+01)audience_ratingUpright + (0)audience_ratingSpilled
# #Predicted audience score for the movie Boyhood = 2.720e+02 + (-1.021e+01)typeFeatureFilm + (3.635e+00)genreDrama + (-1.145e-01)year + (3.170e-05)imdb_num_votes + (1.758e-01)critics_score + (2.434e+01)audience_ratingUpright
# #Predicted audience score for the movie Boyhood = 272 + (-10.21 * 1) + (3.635 * 1) + (-0.1145 * 2014) + (0.0000317 * 190500) + (0.1758 * 98) + (24.34 * 1) = 82.42925
# 
# #Uncertainty
# mpredict <- lm(audience_score ~ type + genre + year + imdb_num_votes + critics_score + audience_rating, data = movies)
# mlr <- lm(audience_score ~ type + genre + year + imdb_num_votes + critics_score + audience_rating, data = movies)
# 
# Boyhood = data.frame("type" = "Feature Film", "genre" = "Drama", "year" = 2014,"imdb_num_votes" = 190500, "critics_score" = 98, "audience_rating" = "Upright")
# predict(mpredict, Boyhood, interval = "confidence")
# predict(mlr, Boyhood, interval = "confidence")
# 
# summary(mlr)
# 
# 
# 
# 
