download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")
# Baes Theorem

# What are the most important predictors of audience scores of Feature Films?
# we chose to focus only on feature films because they have a much wider range of audience scores than the other two types
boxplot(movies$audience_score~movies$type)
feature <- subset(movies, type == "Feature Film")
feature = droplevels(feature)
table(feature$type)

# EDA show visuals for explanatory variables that appear to impact audience_score
plot(feature$audience_score~feature$genre)
plot(feature$audience_score~feature$runtime)
plot(feature$audience_score~feature$imdb_num_votes)
plot(feature$audience_score~feature$critics_score)
plot(feature$audience_score~feature$critics_rating)
plot(feature$audience_score~feature$best_pic_nom)
plot(feature$audience_score~feature$best_pic_win)
plot(feature$audience_score~feature$audience_rating)

# inference
# is there a significant difference between mean audience scores and mean critics scores of Feature Films?
scorediff <- feature$audience_score - feature$critics_score
hist(scorediff)
inference(scorediff, est="mean", type="ht", null=0, alternative="twosided", method="theoretical")# H_0: All means are equal.
inference(scorediff, est="mean", type="ci", null=0, alternative="twosided", method="theoretical")# H_0: All means are equal.

# best model
mlr_full <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box, data=feature)
summary(mlr_full) 
# drop best_actor_win p-value = 0.9823
# drop best_dir_win p-value = 0.92555
# drop best_pic_nom p-value = 0.79438
# drop best_actress_win p-value = 0.64467
# drop best_pic_win p-value = 0.27882
# drop top200_box p-value = 0.1592
# drop mpaa_rating because all levels > 0.05
# drop critics_rating because both levels > 0.05
# drop year p-value 0.086095
mlr <- lm(audience_score ~ genre + runtime + imdb_num_votes + critics_score, data=feature)
summary(mlr)
# R^2 = 0.5198. 51.98% of the variation is explained by the model.

# diagnostics of final model
# linearity for numerical explanatory variables
plot(mlr$residuals ~ feature$runtime) # random scatter
plot(mlr$residuals ~ feature$imdb_num_votes) # fan shape
plot(mlr$residuals ~ feature$critics_score) # random scatter
# nearly normal residuals
hist(mlr$residuals) # nearly normal, somewhat left skewed, centered around 0
qqnorm(mlr$residuals) # very normal
qqline(mlr$residuals)
# constant variability of residuals
plot(mlr$residuals ~ mlr$fitted) # random scatter
abline(h=0, lty=3)
# independent residuals = each movie's audience score is independent of another movie

# prediction Gone Girl
gonegirl = data.frame(genre = "Mystery & Suspense", runtime = 149, imdb_num_votes = 376277, critics_score = 79)
predict(mlr, gonegirl, interval="prediction")
20.28 + 1.263*1 + 0.1127*149 + 0.00004347*376277 + 0.3723*79
# describing uncertainty
hist(feature$runtime)
summary(feature$runtime)
hist(feature$imdb_num_votes)
summary(feature$imdb_num_votes)
hist(feature$critics_score)
summary(feature$critics_score)
summary(feature$genre)

# end code
summary(mlr)
