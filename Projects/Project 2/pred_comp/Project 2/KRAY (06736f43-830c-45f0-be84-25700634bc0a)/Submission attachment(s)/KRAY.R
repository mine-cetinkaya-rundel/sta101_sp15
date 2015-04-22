summary(movies)
plot(movies$audience_score ~ movies$genre)
plot(movies$runtime ~ movies$genre)
plot(movies$audience_score ~ movies$mpaa_rating)
plot(movies$runtime ~ movies$mpaa_rating)
plot(movies$audience_score ~ movies$critics_score)
#subset all drama movies
drama <- subset(movies, movies$genre == "Drama")
plot(drama$audience_score ~ drama$mpaa_rating)
#subset all comedy movies
comedy <- subset(movies, movies$genre == "Comedy")
plot(comedy$audience_score ~ comedy$mpaa_rating)
#Part 2: Inference
#Research Question: Is there a difference in average audience scores across movies of different mpaa ratings?
ANOVA <- aov(movies$audience_score ~ movies$mpaa_rating)
summary(ANOVA)
#The p-value is less than .001. Thus, we conclude that at least one mean for average mpaa rating is different than another mean for mpaa rating. This suggests that audience score may vary by mpaa rating and would be an important factor to include in our model.
#Part 3: Modeling
mlr <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score, data=movies)
summary(mlr)
#checking conditions:
#1. Linear relationships between x and y
plot(mlr$residuals ~ movies$imdb_num_votes)
plot(mlr$residuals ~ movies$runtime)
plot(mlr$residuals ~ movies$critics_score)
# The plots of the relationships between residuals and numerical x values (IMDB number of votes, runtime, and critics score) show random scatter around 0. 
#2. Nearly normal residuals with mean 0
hist(mlr$residuals)
# The histogram of residuals is slightly left skewed, centered at 0. The slight left skew could be due to a potential outlier with a residual of -60.
qqnorm(mlr$residuals)
qqline(mlr$residuals)
# The normal probability plot of residuals appears nearly normal.
#3. Constant variability of residuals
plot(mlr$residuals ~ mlr$fitted)
# There appears to be random scatter around 0, suggesting that the variability of residuals is constant for high and low values.
#4. Independence of residuals
plot(mlr$residuals)
# The plot of residuals shows random scatter around 0.
# linear model: audience score(hat) = 37.33 - 16.01(type:Feature Film) - 12.27(type:TV Movie) + 4.362(genre:Comedy) + 8.434(genre:Drama) - 4.626(genre:Horror) - .8108(genre:Mystery & Suspense) + 5.422(genre:Other) + .0993(runtime) + .000045(imdb_num_votes) + .3707(critics_score)
#Prediction for Insurgent
#audience score(hat) = 37.33 - 16.01(type:Feature Film) + 8.434(genre:Drama) + .0993(119) + .000045(34134) + .3707(31)
37.33 - 16.01 + 8.434 + .0993*119 + .000045*34134 + .3707*31
# predicted audience score = 54.60
# Prediction for American Sniper
# by hand: audience score(hat) = 37.33 - 16.01(type:Feature Film) + 8.434(genre:Drama) + .0993(134) + .000045(168544) + .3707(73)
# predicted audience score = 77.71 (actual score = 86)
AmSniper = data.frame(type = "Feature Film", genre = "Drama", runtime = 134, imdb_num_votes = 168544, critics_score = 73)
predict(mlr, AmSniper, interval = "prediction")
# We are 95% confident that the audience score for American Sniper is between 51.92 and 103.49. The margin of error around this prediction is 25.80.
# Comparison to model made with forwards R-squared:
mlr2 <- lm(audience_score ~ type + genre + runtime + imdb_num_votes + critics_score + year + mpaa_rating + top200_box + best_pic_win + critics_rating, data = movies)
summary(mlr2)
AmSniper = data.frame(type = "Feature Film", genre = "Drama", runtime = 134, imdb_num_votes = 168544, critics_score = 73, year = 2015, mpaa_rating = "R", top200_box = "yes", best_pic_win = "no", critics_rating = "Fresh")
predict(mlr2, AmSniper, interval = "prediction")

