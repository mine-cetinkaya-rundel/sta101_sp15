download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")

#EDA
mean(movies$audience_score)
plot(movies$audience_score ~ movies$year, main = "Audience Score over Time", xlab = "Year", ylab = "Audience Score")
cor(movies$audience_score, movies$year)
bestpicnom <- subset(movies, best_pic_nom == "yes")
bestpicwin <- subset(movies, best_pic_win == "yes")
mean(bestpicnom$audience_score)
mean(bestpicwin$audience_score)
nobestpicnomorwin <- subset(movies, best_pic_nom == "no")
mean(nobestpicnomorwin$audience_score)
plot(bestpicnom$audience_score ~ bestpicnom$year, main = "Movies Nominated for Best Picture Over Time", xlab = "Year", ylab = "Audience Score")
cor(bestpicnom$audience_score, bestpicnom$year)
bestpicnomnooutlier <- subset(bestpicnom, title != "Born Yesterday")
plot(bestpicnomnooutlier$audience_score ~ bestpicnomnooutlier$year)
cor(bestpicnomnooutlier$audience_score, bestpicnomnooutlier$year)

#Inference
inference(y = movies$audience_score, x = movies$best_pic_nom, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical")
inference(y = movies$audience_score, x = movies$best_pic_nom, est = "mean", type = "ci", null = 0, alternative = "twosided", method = "theoretical", order = c("yes","no"))

#Model selection
movies_full <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
summary(movies_full)
movies_drop1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box, data = movies)
summary(movies_drop1)
movies_drop2 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box, data = movies)
summary(movies_drop2)
movies_drop3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box, data = movies)
summary(movies_drop3)
movies_drop4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
summary(movies_drop4)
movies_drop5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + top200_box, data = movies)
summary(movies_drop5)
movies_drop6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating, data = movies)
summary(movies_drop6) #Adjusted R-squared: 0.5475
movies_drop7mpaa <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating, data = movies)
summary(movies_drop7mpaa) #Adjusted R-squared: 0.5437
movies_drop7critrating <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score, data = movies)
summary(movies_drop7critrating) #Adjusted R-squared: 0.546
movies_drop7 = movies_drop7critrating
summary(movies_drop7)
movies_drop8 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score, data = movies)
summary(movies_drop8)
movies_drop9 <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
summary(movies_drop9)
movies_final = movies_drop9
mlr = movies_final
plot(movies_final$residuals ~ movies$audience_score, main = "Residuals vs. Audience Score", xlab = "Audience Score", ylab = "Residuals")
abline(h = 0, lty = 3)
plot(movies_final$residuals ~ movies$runtime, main = "Residuals vs. Runtime", xlab = "Runtime", ylab = "Residuals")
abline(h = 0, lty = 3)
plot(movies_final$residuals ~ movies$imdb_num_votes, main = "Residuals vs. Number of IMDB Votes", xlab = "Number of IMDB Votes", ylab = "Residuals")
abline(h = 0, lty = 3)
plot(movies_final$residuals ~ movies$critics_score, main = "Residuals vs. Critics Score", xlab = "Critics Score", ylab = "Residuals")
abline(h = 0, lty = 3)
hist(movies_final$residuals, main = "Final Model Residuals", xlab = "Residuals")
qqnorm(movies_final$residuals, main = "Normal Probability Plot of Residuals")
qqline(movies_final$residuals)
plot(movies_final$residuals ~ movies_final$fitted, main = "Residuals vs. Predicted Audience Score", xlab = "Predicted Audience Score", ylab = "Residuals")
abline(h = 0, lty = 3)
plot(abs(movies_final$residuals) ~ movies_final$fitted, main = "Absolute Value of Residuals vs. Predicted Audience Score", xlab = "Predicted Audience Score", ylab = "Absolute Value of Residuals")

#Prediction
furious7 = data.frame(type = "Feature Film", genre = "Action & Adventure", runtime = 137, imdb_num_votes = 102132, critics_score = 82)
predict(movies_final, newdata = furious7, interval = "prediction")

