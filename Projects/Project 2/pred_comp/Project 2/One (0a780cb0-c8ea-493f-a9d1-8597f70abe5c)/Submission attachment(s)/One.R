load("movies.Rdata")
#visualing data for EDA
summary(movies)
barplot(table(movies$mpaa_rating))
summary(movies$critics_rating)
hist(movies$audience_score,main="Audience Scores",xlab="Score")
mean(movies$audience_score)
sd(movies$audience_score)
#subsetting into Short and Long movies
ShortMovie <- subset(movies, runtime<100)
LongMovie <- subset(movies, runtime>99)
boxplot(ShortMovie$audience_score ~ ShortMovie$genre)
by(ShortMovie$audience_score,ShortMovie$genre,mean)
boxplot(LongMovie$audience_score ~ LongMovie$genre)
by(LongMovie$audience_score,LongMovie$genre,mean)
#creating a new categorical variable "kid_friendly"
movies$kid_friendly = NA 
movies$kid_friendly[movies$mpaa_rating %in% c("G", "PG","PG-13")] = "yes"
movies$kid_friendly[movies$mpaa_rating %in% c("R", "Unrated")] = "no"
movies$kid_friendly = as.factor(movies$kid_friendly)
#looking at distribution of audience and critic scores across the levels of kid_friendly
boxplot(movies$audience_score ~ movies$kid_friendly,main="Audience Score vs. Kid Friendliness",xlab="Kid Friendly",ylab="Score")
by(movies$audience_score,movies$kid_friendly,mean)
boxplot(movies$critics_score ~ movies$kid_friendly,main="Critics Score vs. Kid Friendliness",xlab="Kid Friendly",ylab="Score")
by(movies$critics_score,movies$kid_friendly,mean)
#visualing correlation between critics_score and audience_score
plot(movies$audience_score~movies$critics_score,main="Audience Scores vs. Critics Scores",xlab="Critics Score",ylab="Audience Score")
lm(movies$audience_score ~ movies$critics_score)
abline(lm(movies$audience_score ~ movies$critics_score))
cor(movies$critics_score,movies$audience_score)
#subsetting into Kid Friendly and Non-kid-friendly groups and performing inference
KidFriendly <- subset(movies, movies$kid_friendly == "yes")
NotKidFriendly <- subset(movies, movies$kid_friendly == "no")
hist(KidFriendly$audience_score)
hist(NotKidFriendly$audience_score)
qqnorm(KidFriendly$audience_score)
qqline(KidFriendly$audience_score)
qqnorm(NotKidFriendly$audience_score)
qqline(NotKidFriendly$audience_score)
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")
inference(y = movies$audience_score, x = movies$kid_friendly, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical")
#Checking Conditions for MLR, starting with Linearity
mlr <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
summary(mlr)
plot(mlr$residuals ~ movies$critics_score)
plot(mlr$residuals ~ movies$runtime)
plot(mlr$residuals ~ movies$imdb_num_votes)
plot(mlr$residuals ~ movies$runtime,main="Residuals vs. Runtime",xlab="Runtime",ylab="Residuals")
abline(h=0)
plot(mlr$residuals ~ movies$imdb_num_votes,main="Residuals vs. IMDB Votes",xlab="IMDB Number Votes",ylab="Residuals")
abline(h=0)
plot(mlr$residuals ~ movies$critics_score,main="Residuals vs. Critics Score",xlab="Critics Score",ylab="Residuals")
abline(h=0)
#Then Nearly Normal Residuals
hist(mlr$residuals,main="Histogram of Residuals",xlab="m_final Residuals")
qqnorm(mlr$residuals)
qqline(mlr$residuals)
#Then Constant Variability
plot(mlr$resid~mlr$fitted.values,main="Residuals vs. Fitted Values",xlab="Fitted Values",ylab="Residuals")
abline(h=0)
plot(abs(mlr$residuals) ~ mlr$fitted) 
#Finally Independent Residuals
plot(mlr$residuals) 
abline(h=0)
#Round 1 MLR - remove best_dir_win
m1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
summary(m1)
#Round 2 MLR - remove best_pic_nom
m2 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win +  top200_box, data = movies)
summary(m2)
#Round 3 MLR - remove best_actor_win
m3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win +  top200_box, data = movies)
summary(m3)
#Round 4 MLR - remove best_actress_win
m4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win +  top200_box, data = movies)
summary(m4)
#Round 5 MLR - remove best_pic_win
m5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win +  top200_box, data = movies)
summary(m5)
#Round 6 MLR - remove top200_box
m6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating +  top200_box, data = movies)
summary(m6)
#Round 7 MLR - remove mpaa_rating
m7 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating, data = movies)
summary(m7)
#Round 8 MLR - remove critics_rating
m8 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating, data = movies)
summary(m8)
#Round 9 MLR - remove year
m9 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score, data = movies)
summary(m9)
#Final Model
mlr <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data = movies)
summary(mlr)
#Using the mlr to predict audience score for Fast and Furious
37.33 - 16.01 + 5.422 + 0.09928*137 + 0.0000450*101748 + 0.3707*82
#the real score was 88%
furious7 = data.frame(type = "Feature Film", genre = "Other", runtime = 137, imdb_num_votes = 101748, critics_score = 82)
predict(mlr , furious7 , interval = "prediction")
