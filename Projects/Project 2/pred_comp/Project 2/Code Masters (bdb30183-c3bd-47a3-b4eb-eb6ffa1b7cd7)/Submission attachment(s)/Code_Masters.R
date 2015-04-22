#Code Masters
#Andrew Bartuska, Nicole Kozlak, Sydney Smith, Lija Zhang
#Do the Oscars Know Best?

download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")

#exploratory data analysis
summary (movies$critics_score)
boxplot (movies$critics_score, main = "Critics' Score", horizontal = TRUE, ylab = "Score")
hist (movies$critics_score, main = "Histogram of Critics Scores", xlab = "Critics Scores")

#new variable in "movies" for movies with high critics score (highscore)
movies$highscore = ifelse (movies$critics_score >= 75, c("YES"), c("NO"))
table (movies$highscore)

#new variable in "movies" for movies that have won any oscar (oscarwin)
movies$oscarwin = ifelse (movies$best_pic_win == "yes" | movies$best_actor_win == "yes" | movies$best_actress_win == "yes" | movies$best_dir_win == "yes", c("yes"), c("no"))
table (movies$oscarwin)

#EDA for high scoring movies and oscar winners
movies$highscore = factor(movies$highscore, levels = c("YES", "NO"))
movies$oscarwin = factor(movies$oscarwin, levels = c("yes", "no"))
mosaicplot (table (movies$highscore, movies$oscarwin), main = "High Scoring vs Oscar Winning Movies", xlab = "High Scoring Movies", ylab = "Oscar Winning Movies")

#subsetting for movies with high critics score
highscoring <- subset(movies, movies$highscore == "YES")

#EDA within high scoring subset
barplot (table (highscoring$oscarwin), main = "Oscar Wins within High Scoring Subset", xlab = "Oscar Wins")
hist (highscoring$audience_score, main = "Audience Scores within High Scoring Subset", xlab = "Audience Score")

#EDA for inference of audience scores vs. oscar wins within high scoring movies
by (highscoring$audience_score, highscoring$oscarwin, summary)
boxplot (highscoring$audience_score ~ highscoring$oscarwin, main = "Audience Scores", xlab = "Oscar Win")

download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")

#inference (audience score ~ oscarwin within highscoring movies)
inference(y = highscoring$audience_score, x = highscoring$oscarwin, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical")

#Modeling via Backwards p-selection
mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
             + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win 
             + best_actress_win + best_dir_win + top200_box, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
          + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win 
          + best_actress_win + top200_box, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
          + critics_score + critics_rating + best_pic_win + best_actor_win 
          + best_actress_win + top200_box, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
          + critics_score + critics_rating + best_pic_win
          + best_actress_win + top200_box, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
          + critics_score + critics_rating + best_pic_win
          + top200_box, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
          + critics_score + critics_rating
          + top200_box, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes 
          + critics_score + critics_rating, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes 
          + critics_score + critics_rating, data = movies)
summary(mlr)

mlr <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes 
          + critics_score, data = movies)
summary(mlr)

#best model
mlr <- lm(audience_score ~ type + genre + runtime + imdb_num_votes 
          + critics_score, data = movies)
summary(mlr)

plot (movies$audience_score ~ mlr$fitted, main = "Best Model", xlab = "Predicted Values", ylab = "Audience Score")
abline(lm(movies$audience_score ~ mlr$fitted))

#conditions for best model
plot(mlr$residuals ~ mlr$fitted, main = "Residual Plot", xlab = "Predicted", ylab = "Residuals")
abline(h = 0, lty = 3)
plot(mlr$residuals, ylab = "Residuals", main = "Index of Residuals")
hist(mlr$residuals, main = "Histogram of Residuals", xlab = "Residuals")
qqnorm(mlr$residuals, main ="Normal Probability Plot of Residuals")
qqline(mlr$residuals)

#summary of best model
summary (mlr)

#prediction for "Insurgent", a movie not in the initial dataset
insurgent = data.frame(title = "Insurgent", genre = "Action & Adventure", critics_score = 31, type = "Feature Film", runtime = 119, imdb_num_votes = 35802)
predict(mlr, insurgent, interval = "prediction")
