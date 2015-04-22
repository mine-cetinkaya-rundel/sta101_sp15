load("movies.RData")

# BEGIN YOUR CODE

#EDA: We begin by showing a strong linear association between critic_score and audience_score in the scatterplot.
# We then show side-by-side boxplots of the average audience score between movie ratings, then using our new diff variable we do another set of side-by-side
# boxplots using the diff variable instead. These are the bivariate analysis we wanted to check straight away to answer our research question.
#Finally, we demonstrate one of the variables we tested but ended up not including, the director variable. This variable and others
# have too many levels to have high predictive power, so we chose not to include them in our final presentation.

plot(movies$audience_score ~ movies$critics_score)
boxplot(movies$audience_score ~ movies$mpaa_rating)
boxplot(movies$diff ~ movies$mpaa_rating)
movies$diff <- movies$audience_score - movies$critics_score

#The director variable, for example, has too many levels.
summary(movies$director)

# In addition, after we did our univariate analysis, we chose to tranform two of our numerical variables, imdb_num_votes and runtime, to remove many outliers and
# get a better multiple regression model. Here are what the graphs look like, before and after.

hist(movies$runtime)
hist(log (movies$runtime))

hist(movies$imdb_num_votes)
hist(log(movies$imdb_num_votes))

# INFERENCE: Using our diff variable again, we conduct inference with the hypothesis in our presentation.

download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")

movies$diff <- movies$audience_score - movies$critics_score

inference(y = movies$diff, x = movies$mpaa_rating, est = "mean", type = "ht", null = 0, alternative = "greater", method = "theoretical")

# MULTIPLE LINEAR REGRESSION
# mlr_total is the model we started out with in our backwards elimination- one that includes all of our variables. However, after
# we run our first regression, we start to cut out variables based on p-value (keeping in mind the flaws of this strategy)
# and arrive at our final model, mlr.

mlr_total <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data = movies)
summary(mlr_total)
mlr <- lm(audience_score ~ type + genre + log(runtime) + year + mpaa_rating + log(imdb_num_votes) + critics_score + critics_rating + top200_box, data = movies)
summary(mlr)

# CHECKING CONDITIONS

#1) linearity between our numerical variables (log(runtime), year, log(imdb_num_votes), and critics score).
# All the graphs seem to demonstrate random scatter around 0.
plot(mlr$residuals ~ log(movies$runtime))
plot(mlr$residuals ~ movies$year)
plot(mlr$residuals ~ log(movies$imdb_num_votes))
plot(mlr$residuals ~ movies$critics_score)

#2) Nearly normal residuals around 0- this condition requires random scatter of residuals around 0, which seem to be met in the 
#histogram and normal probability plot below. We consider this satisfied by the look of the plots below.

hist(mlr$residuals)
qqnorm(mlr$residuals)
qqline(mlr$residuals)

#3) We need to check the residual plot of residuals vs. predicted (value of response variable, i.e. audience score).
# There seems to be no fan shape- we consider this condition satisfied.
plot(mlr$residuals~ mlr$fitted)
plot(abs(mlr$residuals)~ mlr$fitted)

#4)Independent residuals. We are confident that these are individual observations given the fact that they are individual movies. 
# We can check anyway using the residuals plot.
plot(mlr$residuals)


# PREDICTION
#We chose Selma as the film we were going to predict.

interval = "prediction"
results = lm(audience_score ~ type + genre + log(runtime) + year + mpaa_rating + log(imdb_num_votes) + critics_score + critics_rating + top200_box, data = movies)
predict(results,data.frame(type = "Feature Film", genre = "Drama", runtime = 127, year = 2015, mpaa_rating = "PG-13",imdb_num_votes = 30502,critics_score = 99, critics_rating = "Fresh", top200_box = "no"), interval = "prediction")
# END YOUR CODE

summary(mlr)