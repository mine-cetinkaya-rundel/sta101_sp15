download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.RData")
load("movies.RData")
horroraction <- subset(movies, genre== "Horror"|genre=="Action & Adventure")
horroraction = droplevels(horroraction)
hist(horroraction$runtime)
hist(horroraction$year)
hist(horroraction$imdb_num_votes)
plot(horroraction$critics_rating)
summary(horroraction$imdb_num_votes)
summary(horroraction$critics_score)
horroraction$mp2 = NA
horroraction$mp2 = horroraction$mpaa_rating
horroraction$mp2[horroraction$mp2 %in% c("PG", "Unrated")] = "PG"
horroraction$mp2 = as.factor(horroraction$mp2)
horroraction$mp2 = droplevels(horroraction$mp2)
horroraction$yearr = NA
horroraction$yearr[horroraction$year >= 2000] = "after 2000"
horroraction$yearr[horroraction$year < 2000] = "before 2000"
horroraction$yearr = as.factor(horroraction$yearr)

before2000 <- subset(horroraction, year<2000)
after2000 <- subset(horroraction, year>=2000)
t.test(before2000$audience_score, after2000$audience_score)

boxplot(before2000$audience_score, after2000$audience_score)

horroraction1 <- lm(audience_score ~ runtime + yearr + mp2 + critics_score + imdb_num_votes + critics_rating, data= horroraction)
summary(horroraction1)
horroraction2 <- lm(audience_score ~ runtime + yearr + critics_score + imdb_num_votes + critics_rating, data= horroraction)
summary(horroraction2)
horroraction3 <- lm(audience_score ~ runtime + critics_score + imdb_num_votes + critics_rating, data= horroraction)
summary(horroraction3)
horroraction4 <- lm(audience_score ~ critics_score + imdb_num_votes + critics_rating, data= horroraction)
summary(horroraction4)
mlr <- lm(audience_score ~ critics_score + imdb_num_votes, data= horroraction)
summary(mlr)

hist(mlr$residuals)
plot(mlr$residuals ~ mlr$fitted)
qqnorm(mlr$residuals)
qqline(mlr$residuals) 

hunger = data.frame(critics_score = 65, imdb_num_votes = 187820)
predict(mlr, hunger, interval = "prediction")
