#Load
download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")
  
#Introduction
##There is no code for this section. 

#EDA
##Exploratory Analysis Before Control Univariate
summary(movies$audience_score)
hist(movies$audience_score)
summary(movies$type)

##Exploratory Analysis Before Control Bivariate
boxplot(movies$audience_score ~ movies$type)

##Exploratory Analysis After Control
Control1 <- subset(movies, genre != "Horror")
Control2 <- subset(Control1, genre != "Mystery & Suspense")
Control3 <- subset(Control2, genre != "Comedy")

###Exploratory Analysis After Control Univariate
summary(Control3$audience_score)
hist(Control3$audience_score)
summary(Control3$type)

###Exploratory Analysis After Control Bivariate
boxplot(Control3$audience_score ~ Control3$type)

#Inference
##Conditions
hist(movies$audience_score)
boxplot(movies$audience_score ~ movies$type)
Documentary <- subset(movies, type == "Documentary")
hist(Documentary$audience_score)
Feature_Film <- subset(movies, type == "Feature Film")
hist(Feature_Film$audience_score)
TV_Movie <- subset(movies, type == "TV Movie")
hist(TV_Movie$audience_score)

##Load Inference Package
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")

##Actual Inference
inference(y = movies$audience_score, x = movies$type, est = "mean", 
          type = "ht", null = 0, alternative = "greater", method = "theoretical")

#The "Best" Model
##Original MLR
originalmlr <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating +
            best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
summary(originalmlr)

##Best Model MLR
mlr <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
summary(mlr)

##Conditions for MLR
hist(mlr$residuals)
qqnorm(mlr$residuals)
qqline(mlr$residuals)
plot(mlr$residuals ~ mlr$fitted) 
abline(h = 0, lty =3)
plot (abs(mlr$residuals) ~ mlr$fitted)
summary(mlr$residuals)

#Prediction
furious = data.frame(type = "Feature Film", genre = "Action & Adventure", runtime = 137, year = 2015, imdb_num_votes = 104976, critics_score = 82)
predict(mlr , furious , interval = "prediction")

#Conclusion
##How we gathered means for types of films.
summary(Feature_Film$audience_score)
summary(Documentary$audience_score)
summary(TV_Movie$audience_score)