download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
load("movies.Rdata")

#Begining Our Code
library(downloader)
download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")


#EDA Section
summary(movies)

decade_1<- subset(movies, year >= 1974 & year < 1984,)
decade_2<- subset(movies, year >= 1984 & year < 1994,)
decade_3<- subset(movies, year >= 1994 & year < 2004,)
decade_4<- subset(movies, year >= 2004 &year < 2014,)

library(MASS)                 # load the MASS package 
decade1_pie = decade_1$mpaa_rating    
decade1_pie.freq = table(decade1_pie)
pie(decade1_pie.freq, main= "1974 - 1983")
table(decade1_pie) #There are zero PG-13 movies

decade2_pie = decade_2$mpaa_rating    
decade2_pie.freq = table(decade2_pie)
pie(decade2_pie.freq, main= "1984 - 1993")

decade3_pie = decade_3$mpaa_rating
decade3_pie.freq = table(decade3_pie)
pie(decade3_pie.freq, main= "1994 - 2004")

decade4_pie = decade_4$mpaa_rating  
decade4_pie.freq = table(decade4_pie)
pie(decade4_pie.freq, main= "2004 - 2014")

AfterPG13 <- subset(movies, year >= 1984,) #Knowing that PG13 movies weren't a category until 1984, we subset all of the movies out of this dataset before 1984 in order to not skew our data. 

summary(AfterPG13$mpaa_rating) #This shows that R is the most popular movie rating

plot(AfterPG13$audience_score ~ AfterPG13$mpaa_rating, main="Audience Score vs. MPAA Rating", ylab="Audience Score", xlab="MPAA Rating") #This shows the relationship between MPAA ratings and audience score

plot(AfterPG13$audience_rating ~ AfterPG13$mpaa_rating, main="Audience Rating vs. MPAA Rating", ylab="Audience Rating", xlab="MPAA Rating") #This is another visual to show the relationship between MPAA ratings and audience ratings

plot(AfterPG13$critics_score ~ AfterPG13$mpaa_rating, main="Critics Score vs. MPAA Rating", ylab="Critics Score", xlab="MPAA Rating") #This shows us the relationship between MPAA ratings and critic scores.


#Inference Section
inference(y = AfterPG13$audience_score, x = AfterPG13$mpaa_rating, est = "mean", type = "ht", alternative = "greater", method = "theoretical")

G_rated <- subset(AfterPG13, mpaa_rating=="G") #We must subset the audience scores for each mpaa rating to determine whether there is approximate normality for all groups involved in the ANOVA test
PG_rated <- subset(AfterPG13, mpaa_rating=="PG") #This subsets the data for PG rated movies
PG13_rated <- subset(AfterPG13, mpaa_rating=="PG-13") #This subsets the data for PG-13 rated movies
R_rated <- subset(AfterPG13, mpaa_rating=="R") #This subsets the data for R rated movies
Un_rated <- subset(AfterPG13, mpaa_rating=="Unrated") #This subsets the data for Unrated movies

par(mfrow=c(2,3))
qqnorm(G_rated$audience_score, main= "G-rated Movies") 
qqline(G_rated$audience_score)
qqnorm(PG_rated$audience_score, main= "PG-rated Movies") 
qqline(PG_rated$audience_score) 
qqnorm(PG13_rated$audience_score, main="PG-13 Rated Movies") 
qqline(PG13_rated$audience_score) 
qqnorm(R_rated$audience_score, main= "R-rated Movies") 
qqline(R_rated$audience_score) 
qqnorm(Un_rated$audience_score, main="Unrated Movies") 
qqline(Un_rated$audience_score) 


#MLR Section

mlr1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_dir_win + top200_box, data=AfterPG13)
summary(mlr1)

mlr2 <-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_dir_win + top200_box, data=AfterPG13)
summary(mlr2)

mlr3 <-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + top200_box, data=AfterPG13)
summary(mlr3)

mlr4 <-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + top200_box, data=AfterPG13)
summary(mlr4)

mlr5 <-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_nom + top200_box, data=AfterPG13)
summary(mlr5)

mlr6 <-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score +  critics_rating + top200_box, data=AfterPG13)
summary(mlr6) 

mlr <-lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + top200_box, data=AfterPG13)
summary(mlr) #This is the final model. Done by backwards p-value selection


#Conditions for MLR
plot(mlr$residuals ~ mlr$fitted.values, ylab="Residuals", xlab="Fitted Values") #This shows us the residuals vs. the predicted y, testing for constant variability
abline(h = 0, lty = 3) #This puts a line at y=0

hist(mlr$residuals, main="Histogram of Residuals", xlab="Residuals") #We use this to test if the condition for nearly normal residuals with mean 0 is met

qqnorm(mlr$residuals) #This gives us a normal probability plot of the residuals
qqline(mlr$residuals) #This puts in a diagonal line on the normal probability plot

plot(mlr$residuals, main="Time Order Plot", ylab="Residuals", xlab="Order") #This shows the time order condition
abline(h = 0, lty = 3)

plot(AfterPG13$type ~ AfterPG13$genre) #The following plots check for collinearity between the explanatory variables
plot(AfterPG13$genre, AfterPG13$runtime)
plot(AfterPG13$genre, AfterPG13$year)
plot(AfterPG13$genre, AfterPG13$imdb_num_votes)
plot(AfterPG13$genre, AfterPG13$critics_score) #slight collinearity
plot(AfterPG13$genre ~ AfterPG13$top200_box)

plot(AfterPG13$runtime ~ AfterPG13$year)
plot(AfterPG13$runtime ~ AfterPG13$imdb_num_votes)
plot(AfterPG13$runtime ~ AfterPG13$critics_score)
plot(AfterPG13$runtime ~ AfterPG13$top200_box) #slight collinearity

plot(AfterPG13$year ~ AfterPG13$imdb_num_votes)
plot(AfterPG13$year ~ AfterPG13$critics_score)
plot(AfterPG13$year ~ AfterPG13$top200_box)

plot(AfterPG13$imdb_num_votes ~ AfterPG13$critics_score)
mlr_originaldata <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_dir_win + top200_box, data=movies)
summary(mlr_originaldata) #MPAA ratings are significant if you include all of the years. But if you include only the years after 1984, then this is not a significant predictor. Interesting.


#Prediction Section
FiftyShades=data.frame(type="Feature Film", genre="Drama", runtime= 110, year=2015, imdb_num_votes= 138807, critics_score= 25, critics_rating="Rotten", top200_box="yes")
predict(mlr, FiftyShades, interval="prediction")

Furious7=data.frame(type="Feature Film", genre="Action & Adventure", runtime=140, year=2015, imdb_num_votes=109794, critics_score= 82, critics_rating="Certified Fresh", top200_box="yes")
predict(mlr, Furious7, interval="prediction")


#End Our Code

summary(mlr)

