# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# 
# # Exploratory Data Analysis
# 
# # 1) Evaluating films by mpaa rating: child-friendly or not
# 
# # We decided to reclassify movies as child-friendly or otherwise. We defined films rated G or PG as "child_friendly" and films rated PG13, R or Unrated as "not_for_children." 
# 
# movies$mpaa_rating_new[movies$mpaa_rating=="G"|movies$mpaa_rating=="PG"]="child_friendly"
# movies$mpaa_rating_new[movies$mpaa_rating=="PG-13"|movies$mpaa_rating=="R"|movies$mpaa_rating=="Unrated"]="not_for_children"
# movies$mpaa_rating_new = as.factor(movies$mpaa_rating_new)
# 
# summary(movies$mpaa_rating_new)
# 
# # Our summary of the new variable indicates that 75 of the movies in the database are child friendly, and 368 are not for children.
# 
# boxplot(movies$audience_score~movies$mpaa_rating_new)
# 
# # The boxplot indicates that movies not for children tend to have slightly higher audience score than movies for children. However, an inference test is necessary before drawing conclusions about the significance of this difference.
# 
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# inference(y = movies$audience_score, x = movies$mpaa_rating_new, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical", order = c("child_friendly","not_for_children"))
# 
# # The hypothesis test yields a p-value of .1604. Therefore, there is not sufficient evidence to reject the null hypothesis that there is no difference between the mean audience scores of child-friendly movies and movies not for children.
# # Because whether or not the movie is child-friendly does not appear to be a significant predictor of audience score, we will not pursue a study that focuses on this particular variable.
# 
# # 2) We are interested in the relationship between Oscars and audience score. We decided to re-level this variable into two categories. If a film received an oscar for best picture, director, actor, or actress, we considered it a success. If a movie did not receive any such award, we classified it as a failure.
# 
# movies$oscar5[movies$best_pic_win=="yes"|movies$best_actor_win=="yes"|movies$best_actress_win=="yes"|movies$best_dir_win=="yes"]="Oscar"
# movies$oscar5[movies$best_pic_win=="no"&movies$best_actor_win=="no"&movies$best_actress_win=="no"&movies$best_dir_win=="no"]="No_Oscar"
# movies$oscar5=as.factor(movies$oscar5)
# 
# summary(movies$oscar5)
# 
# # The summary of our new variable has 324 films with no Oscar, and 119 films with an Oscar.
# 
# boxplot(movies$audience_score~movies$oscar5)
# 
# # The boxplot indicates (unsurprisingly) that movies receiving Oscars have a higher median audience score than movies not receiving Oscars. An inference test is necessary for determining whether or not this difference is significant.
# 
# inference(y = movies$audience_score, x = movies$oscar5, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical", order = c("Oscar","No_Oscar"))
# 
# # The hypothesis test yields a p-value of 8e-04. There is sufficient evidence to support the alternative hypothesis that there is an association between whether or not a film received an Oscar and its audience score.
# 
# # 3) We would like to examine the relationship between genre and audience score. However, we chose to re-level the variables into two categories: high grossing genre (Action and Adventure, Drama) and low grossing genres (all other genres).
# 
# movies$genre_new2[movies$genre=="Action & Adventure" | movies$genre=="Drama" ]="Highest Grossing Genre"
# movies$genre_new2[movies$genre=="Horror"|movies$genre=="Mystery & Suspense"|movies$genre=="Comedy"|movies$genre=="Other"]="Lower Grossing Genres"
# movies$genre_new2=as.factor(movies$genre_new2)
# 
# summary(movies$genre_new2)
# 
# # The summary of our new variable has 55 high grossing movies and 388 low grossing movies.
# 
# boxplot(movies$audience_score~movies$genre_new2)
# 
# # The boxplot indicates a significant higher average audience score among the lower grossing genre. A hypothesis test is necessary to determine if the difference is statistically significant.
# 
# inference(y = movies$audience_score, x = movies$genre_new2, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical", order = c("Highest Grossing Genre","Lower Grossing Genres"))
# 
# # The hypothesis test yields a p-value of .0026. There is sufficient evidence to support the alternative hypothesis that there is an association between high/low grossing genre and average audience score.
# 
# # Inference
# 
# # After a bit of research, we found that Action and Adventure is by far the highest grossing genre of the bunch, and comedy is the next highest. After comedy, there is not a close third genre in terms of grossing. We have decided to create a variable with three levels: highest grossing genre, second highest grossing genre, and lowest grossing genres according to the aforementioned divisions.
# 
# # Is there a difference between the mean audience score between the highest grossing movie genre (action and adventure), and lower grossing movie genres? 
# 
# # Control: To improve our model, we will only look at films that did not win Oscars. Oscar winning films tend to have either exceptionally talented actors, actresses, directors, or some other unusual quality (a large production or advertising budget, for example). By only examining films that have not won Oscars, we hope to control for some (but certainly not all) of those potentially confounding variables. We decided not to include films receiving any Oscar--for an actor, actress, director, or best picture--because we felt that films receiving any such award belong to a different class of film. We would like to focus on movies more representative of the general movie population, which does not include Oscar-winners.
# 
# # First, we must check the conditions for inference for an ANOVA test comparing three independent means:
#   
# #  1) The INDEPENDENCE condition is satisfied because...
# # a) Within groups:
# #  We can assume the sample is random. 
# #  The sample size of 443 is less than 10% of the total population of movies made between 1974 and 2014. 
# # b) between groups 
# # High grossing movies and low grossing movies are non-paired data 
# #  2) The APPROXIMATELY NORMAL condition is satisfied because…
# # Based on the box plots, the distributions should be nearly normal. However, the higher-grossing genre appears to have a slight skew, so we should proceed with caution
# #  3) The EQUAL VARIANCE condition is satisfied because...
# # a) The boxplots show approximately equal variance.
# movies$genre_new6[movies$genre=="Action & Adventure"]="Highest Grossing Genre"
# movies$genre_new6[movies$genre=="Comedy"]="Second Highest Grossing Genre"
# movies$genre_new6[movies$genre=="Drama"|movies$genre=="Horror"|movies$genre=="Mystery & Suspense"|movies$genre=="Other"]="Lower Grossing Genres"
# movies$genre_new6=as.factor(movies$genre_new6)
# by(movies$audience_score, movies$genre_new6, sd)
# # b) The standard deviations for each level (17.75, 19.18, 17.31) are roughly similar.
# # c) The lowest-grossing genre demonstrates a larger variance (probably due to the greater quantity of movies in this category), so we should proceed with caution
# 
# # Now that the conditions for inference have been satisfied, we can continue. 
# 
# # The following are the necessary codes for our re-leveling of the genre variable.
# 
# movies$genre_new6[movies$genre=="Action & Adventure"]="Highest Grossing Genre"
# movies$genre_new6[movies$genre=="Comedy"]="Second Highest Grossing Genre"
# movies$genre_new6[movies$genre=="Drama"|movies$genre=="Horror"|movies$genre=="Mystery & Suspense"|movies$genre=="Other"]="Lower Grossing Genres"
# movies$genre_new6=as.factor(movies$genre_new6)
# 
# # To limit our data to films that did not receive an Oscar in any category:
#   
# movies1 <- subset(movies, oscar5 == "No_Oscar")
# 
# # Null hypothesis: There is no association between audience score and the genre level of grossing.
# # Alternative hypothesis: There is an association between audience score and the genre level of grossing.
# 
# inference(y = movies1$audience_score, x = movies1$genre_new6, est = "mean", type = "ht", null = 0, alternative = "greater", method = "theoretical", order = c("Highest Grossing Genre","Second Highest Grossest Genre", "Lower Grossing Genres"))
# 
# #Our hypothesis test yields a p-value of 5.452e-06. Therefore, we have sufficient evidence to reject the null hypothesis, which stated that audience score and genre level of grossing are independent. Given that the p-value is near zero, there is strong evidence of an association between audience score and genre level of grossing.
# 
# 
# 
# # Modeling
# 
# # We began from a model including all of the new variables we reported in our EDA. After using the p-value method of elimination, our final model looked like this:
# 
# mlr = lm(audience_score ~ type + genre_new6 + runtime + imdb_num_votes + critics_score, data = movies)
# summary(mlr)
# 
# # As the model illustrates, our remaining explanatory variables were type, level of grossing genre, runtime, number of votes on imdb, and critics score. We were enthusiastic to see that the explanatory variable that has been the subject of our research (genre level of grossing) was among the significant explanatory variables. This finding validates the conclusion of our inference test.
# 
# # Our R squared value for the model is .5154; the adjusted R squared is .5076. In other words, the explained variability of our model is 51.54%.
# 
# # We were disappointed, but not altogether surprised, that the percentage of variability explained by our model is not dissimilar to the value of a model using only original explanatory variables. Although our model reorganized the levels of the original variables, we did not provide any new data. Therefore, it would be unrealistic to expect a dramatically higher R squared value.
# 
# # All else held constant, the model predicts that feature films are expected on average to have an audience score 15.43 points lower than an average documentary.
# # All else held constant, the model predicts that TV movies are expected on average to have an audience score 10.02 points lower than an average documentary.
# # All else held constant, the model predicts that films in the lower grossing genres are expected on average to have an audience score 5.463 points higher than an average film in the high grossing category.
# # All else held constant, the model predicts that films in the second highest grossing genres are expected on average to have an audience score 4.373 points higher than an average film in the high grossing category.
# # All else held constant, the model predicts that for every one minute increase in runtime, the audience score of the movie is expected on average to increase by .117 points.
# # All else held constant, the model predicts that for every additional vote on imbd, the audience score of the movie is expected on average to increase by .00004301 points.
# # All else held constant, the model predicts that for every one point increase in the score by the critics, the audience score of the movie is expected on average to increase by .0379 points.
# 
# # Conditions:
#   
# #  1) Linear relationships between (numerical) x and y: 
# plot(mlr$residuals)
# # The scatterplot shows a random scatter around zero, so we determine this condition to be met.
# #  2) Nearly normal residuals with mean 0
# hist(mlr$residuals)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# # Both the histogram and normal probability plot describe a distribution that is nearly normal and centered at zero. Therefore, this condition is met.
# #  3) Constant variability of residuals
# plot(mlr$residuals)
# # Again consulting the scatterplot, it is evident that there is no apparent fan shape or other pattern to the distribution of the residuals. Therefore, this condition is met.
# #  4) Independent residuals
# plot(movies$audience_score ~ movies$year)
# # Though the number of movies released per year appears to have increased over time, our plot does not indicate a relationship between the year a movie was released and it audience score. Because there does not appear to be a relationship between year (time of data collection) and audience score, this condition is also met.
# 
# # ALL conditions are met. Therefore, our regression model is appropriate and we have little cause for concern.
# 
# 
# 
# 
# # Prediction
# 
# # We decided to use our model to predict the audience score for Furious 7, which was released on April 3, 2015.
# 
# # The movie was a feature film, an Action & Adventure movie (and therefore in the high grossing genre category), had a runtime of 137 minutes, 107,974 votes on imdb, and a critics score of 67.
# 
# movies$genre_new6[movies$genre=="Action & Adventure"]="Highest Grossing Genre"
# movies$genre_new6[movies$genre=="Comedy"]="Second Highest Grossing Genre"
# movies$genre_new6[movies$genre=="Drama"|movies$genre=="Horror"|movies$genre=="Mystery & Suspense"|movies$genre=="Other"]="Lower Grossing Genres"
# movies$genre_new6=as.factor(movies$genre_new6)
# 
# newdata = data.frame(genre_new6 = "Highest Grossing Genre", type="Feature Film", runtime = 137, imdb_num_votes = 107974, critics_score = 67)
# predict(mlr, newdata, interval="prediction")
# 
# # Our model predicts that the audience score for Furious 7 is 65.37. The 95% confidence interval is (38.49, 92.26). According to Rotten Tomatoes, the actual audience score is 88.
# # Therefore, the residual is 88 - 65.37 = 22.63. Though our prediction is off, the actual value is contained by our 95% confidence interval. 
# 
# # Conclusion
# 
# # As the exploratory data analysis and inference revealed, there is indeed a statistically significant relationship between the level of grossing genre and the audience score. Such an association is confirmed by the multiple linear regression model, which was constructed utilizing the backwards elimination p-value method. However, the relationship between the explanatory variable we created and the response variable is the inverse of what we would consider intuitive. When a movie is high grossing, we would expect it to receive high audience scores, regardless of if it obtained lower critics’ scores. Contrary to this expectation, the higher grossing genres of “Action & Adventure” and “Comedy” had lower mean audience scores than the lower grossing genres. This is especially evident as, all else held constant, movies in a lower grossing genre would have the greatest effect on the slope based on the regression model, and the second highest grossing genre would have the second greatest effect. Therefore, it is evident that on average, people seek entertainment from popular films which they do not esteem with high audience scores, suggesting that audiences sometimes do not get the most enjoyment out of the most watched (most money making) films.
# # According to Rotten Tomatoes, the audience score for Furious 7 is 86, but according to our model the predicted audience score is about 65. The 95% confidence interval for the audience score based on the model is 38.486 to 92.260, so the true audience score is contained within the confidence interval. Although our model was not exact in predicting the audience score, there are confounding variables which could affect the score. For example, since Furious 7 is the seventh movie in this legacy, those who seek to watch it already have an affinity for Fast and Furious movies which might influence their reviews. 
# # One caveat to our analysis is that we did not look at each genre independently aside from Action & Adventure and Comedy. Therefore, there might be certain genres within the mass group “Lower Grossing Genres” which have particularly high scores and others which do not surpass the scores of Action & Adventure or Comedy. 
# # Some limitations to our analysis are contained in the variable we created regarding grossing genres. Although there were general trends relating to genres and grossing, it does not stand that all action movies receive more money than all other movies. This is another caveat of our analysis; grossing level is a broad generalization. Therefore, we would desire information about the box office intake of each movie individually, as well as production budget information so we could accurately portray the relationship between grossing and audience score. 
# 
