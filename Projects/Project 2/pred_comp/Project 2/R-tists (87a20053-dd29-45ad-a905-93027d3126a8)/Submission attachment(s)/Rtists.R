load("movies.Rdata")
setwd("~/Project 2")

outlier_removed<-subset(movies, movies$audience_score >22 | movies$audience_score <22 & movies$critics_score>100 | movies$critics_score<100)
diff_audience_critics<-outlier_removed$audience_score-outlier_removed$critics_score
summary(diff_audience_critics)
plot(outlier_removed$year, diff_audience_critics)
diff_audience_critics_abs<-abs(diff_audience_critics)

#UNIVARIATE STATISTICS
summary(diff_audience_critics_abs)
sd(diff_audience_critics_abs)
summary(outlier_removed$audience_score)
sd(outlier_removed$audience_score)
summary(outlier_removed$type)
summary(outlier_removed$genre)
summary(outlier_removed$runtime)
sd(outlier_removed$runtime)
summary(outlier_removed$year)
summary(outlier_removed$mpaa_rating)
summary(outlier_removed$imdb_num_votes)
sd(outlier_removed$imdb_num_votes)
summary(outlier_removed$critics_score)
sd(outlier_removed$critics_score)
summary(outlier_removed$critics_rating)
summary(outlier_removed$best_pic_nom)
summary(outlier_removed$best_pic_win)
summary(outlier_removed$best_actor_win)
summary(outlier_removed$best_actress_win)
summary(outlier_removed$best_dir_win)
summary(outlier_removed$top200_box)

#BIVARIATE STATISTICS
plot(outlier_removed$critics_rating, outlier_removed$critics_score)
CertifiedFresh<- subset(outlier_removed, critics_rating == "Certified Fresh")
mean(CertifiedFresh$critics_score)
sd(CertifiedFresh$critics_score)
Rotten<-subset(outlier_removed, critics_rating == "Rotten")
mean(Rotten$critics_score)
sd(Rotten$critics_score)
plot(outlier_removed$year, outlier_removed$audience_score)
plot(outlier_removed$year, diff_audience_critics_abs)
cor(outlier_removed$year, diff_audience_critics_abs)
plot(outlier_removed$critics_score, outlier_removed$audience_score)
cor(outlier_removed$critics_score, outlier_removed$audience_score)

download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
load("inference.RData")

#Inference
inference(y = diff_audience_critics_abs, x = outlier_removed$critics_rating, est = "mean", type = "ht", alternative = "greater", method = "theoretical")
 
#MODEL CREATION with outlier
m_moviesone<-lm(audience_score~type, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~genre, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~runtime, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~year, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~mpaa_rating, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~imdb_num_votes, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~critics_score, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~critics_rating, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~best_pic_nom, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~best_pic_win, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~best_actor_win, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~best_actress_win, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~best_dir_win, data = movies)
summary(m_moviesone)$adj.r.squared
m_moviesone<-lm(audience_score~top200_box, data = movies)
summary(m_moviesone)$adj.r.squared

m_moviestwo<-lm(audience_score~critics_score+type, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+genre, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+runtime, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+year, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+mpaa_rating, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+imdb_num_votes, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+critics_rating, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+best_pic_nom, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+best_pic_win, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+best_actor_win, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+best_actress_win, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+best_dir_win, data = movies)
summary(m_moviestwo)$adj.r.squared
m_moviestwo<-lm(audience_score~critics_score+top200_box, data = movies)
summary(m_moviestwo)$adj.r.squared

m_moviesthree<-lm(audience_score~critics_score+genre+type, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+runtime, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+year, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+mpaa_rating, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+imdb_num_votes, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+critics_rating, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+best_pic_nom, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+best_pic_win, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+best_actor_win, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+best_actress_win, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+best_dir_win, data = movies)
summary(m_moviesthree)$adj.r.squared
m_moviesthree<-lm(audience_score~critics_score+genre+top200_box, data = movies)
summary(m_moviesthree)$adj.r.squared

m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + type, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + runtime, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + year, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + mpaa_rating, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + critics_rating, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + best_pic_nom, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + best_pic_win, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + best_actor_win, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + best_actress_win, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + best_dir_win, data = movies)
summary(m_moviesfour)$adj.r.squared
m_moviesfour<-lm(audience_score~critics_score+genre+imdb_num_votes + top200_box, data = movies)
summary(m_moviesfour)$adj.r.squared

m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + year, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + mpaa_rating, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + critics_rating, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + best_pic_nom, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + best_pic_win, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + best_actor_win, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + best_actress_win, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + best_dir_win, data = movies)
summary(m_moviesfive)$adj.r.squared
m_moviesfive<-lm(audience_score~critics_score+genre+imdb_num_votes + type + top200_box, data = movies)
summary(m_moviesfive)$adj.r.squared

m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + mpaa_rating, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + critics_rating, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + best_pic_nom, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + best_pic_win, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + best_actor_win, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + best_actress_win, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + best_dir_win, data = movies)
summary(m_moviessix)$adj.r.squared
m_moviessix<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + top200_box, data = movies)
summary(m_moviessix)$adj.r.squared

m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + critics_rating, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + best_pic_nom, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + best_pic_win, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + best_actor_win, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + best_actress_win, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + best_dir_win, data = movies)
summary(m_moviesseven)$adj.r.squared
m_moviesseven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + top200_box, data = movies)
summary(m_moviesseven)$adj.r.squared

m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + critics_rating, data = movies)
summary(m_movieseight)$adj.r.squared
m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating +best_pic_nom, data = movies)
summary(m_movieseight)$adj.r.squared
m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating +best_pic_win, data = movies)
summary(m_movieseight)$adj.r.squared
m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating+best_actor_win, data = movies)
summary(m_movieseight)$adj.r.squared
m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating+best_actress_win, data = movies)
summary(m_movieseight)$adj.r.squared
m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating+best_dir_win, data = movies)
summary(m_movieseight)$adj.r.squared
m_movieseight<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating+top200_box, data = movies)
summary(m_movieseight)$adj.r.squared

m_moviesnine<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating, data = movies)
summary(m_moviesnine)$adj.r.squared
m_moviesnine<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+best_pic_nom, data = movies)
summary(m_moviesnine)$adj.r.squared
m_moviesnine<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+best_pic_win, data = movies)
summary(m_moviesnine)$adj.r.squared
m_moviesnine<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+best_actor_win, data = movies)
summary(m_moviesnine)$adj.r.squared
m_moviesnine<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+best_actress_win, data = movies)
summary(m_moviesnine)$adj.r.squared
m_moviesnine<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+best_dir_win, data = movies)
summary(m_moviesnine)$adj.r.squared

m_moviesten<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_nom, data = movies)
summary(m_moviesten)$adj.r.squared
m_moviesten<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win, data = movies)
summary(m_moviesten)$adj.r.squared
m_moviesten<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_actor_win, data = movies)
summary(m_moviesten)$adj.r.squared
m_moviesten<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_actress_win, data = movies)
summary(m_moviesten)$adj.r.squared
m_moviesten<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_dir_win, data = movies)
summary(m_moviesten)$adj.r.squared

m_movieseleven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win+best_pic_nom, data = movies)
summary(m_movieseleven)$adj.r.squared
m_movieseleven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win+best_actor_win, data = movies)
summary(m_movieseleven)$adj.r.squared
m_movieseleven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win+best_actress_win, data = movies)
summary(m_movieseleven)$adj.r.squared
m_movieseleven<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win+best_dir_win, data = movies)
summary(m_movieseleven)$adj.r.squared

m_movies_full<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win, data = movies)
summary(m_movies_full)$adj.r.squared

#MODEL CREATION without outlier
m_outlierone<-lm(audience_score~type, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~genre, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~runtime, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~year, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~mpaa_rating, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~imdb_num_votes, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~critics_score, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~critics_rating, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~best_pic_nom, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~best_pic_win, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~best_actor_win, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~best_actress_win, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~best_dir_win, data = outlier_removed)
summary(m_outlierone)$adj.r.squared
m_outlierone<-lm(audience_score~top200_box, data = outlier_removed)
summary(m_outlierone)$adj.r.squared

m_outliertwo<-lm(audience_score~critics_score+type, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+genre, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+runtime, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+year, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+mpaa_rating, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+imdb_num_votes, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+critics_rating, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+best_pic_nom, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+best_pic_win, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+best_actor_win, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+best_actress_win, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared
m_outliertwo<-lm(audience_score~critics_score+best_dir_win, data = outlier_removed)
summary(m_outliertwo)$adj.r.square
m_outliertwo<-lm(audience_score~critics_score+top200_box, data = outlier_removed)
summary(m_outliertwo)$adj.r.squared

m_outlierthree<-lm(audience_score~critics_score+genre+type, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+runtime, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+year, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+mpaa_rating, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+critics_rating, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+best_pic_nom, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+best_pic_win, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+best_actor_win, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+best_actress_win, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+best_dir_win, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+top200_box, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared

m_outlierfour<-lm(audience_score~critics_score+genre+imdb_num_votes+type, data = outlier_removed)
summary(m_outlierfour)$adj.r.squared

m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes+runtime, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared

m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes+year, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes+mpaa_rating, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes+critics_rating, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes+best_pic_nom, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierthree<-lm(audience_score~critics_score+genre+imdb_num_votes+best_pic_win, data = outlier_removed)
summary(m_outlierthree)$adj.r.squared
m_outlierfour<-lm(audience_score~critics_score+genre+imdb_num_votes+best_actor_win, data = outlier_removed)
summary(m_outlierfour)$adj.r.squared
m_outlierfour<-lm(audience_score~critics_score+genre+imdb_num_votes+best_actress_win, data = outlier_removed)
summary(m_outlierfour)$adj.r.squared
m_outlierfour<-lm(audience_score~critics_score+genre+imdb_num_votes+best_dir_win, data = outlier_removed)
summary(m_outlierfour)$adj.r.squared
m_outlierfour<-lm(audience_score~critics_score+genre+imdb_num_votes+top200_box, data = outlier_removed)
summary(m_outlierfour)$adj.r.squared

m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+year, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+mpaa_rating, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+critics_rating, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+best_pic_nom, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+best_pic_win, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+best_actor_win, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+best_actress_win, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+best_dir_win, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared
m_outlierfive<-lm(audience_score~critics_score+genre+imdb_num_votes+type+top200_box, data = outlier_removed)
summary(m_outlierfive)$adj.r.squared

m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+mpaa_rating, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+critics_rating, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+best_pic_nom, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+best_pic_win, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+best_actor_win, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+best_actress_win, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+best_dir_win, data = outlier_removed)
summary(m_outliersix)$adj.r.squared
m_outliersix<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+top200_box, data = outlier_removed)
summary(m_outliersix)$adj.r.squared

m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+critics_rating, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_pic_nom, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_pic_win, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_actor_win, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_actress_win, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_dir_win, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared
m_outlierseven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box, data = outlier_removed)
summary(m_outlierseven)$adj.r.squared

m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+critics_rating, data = outlier_removed)
summary(m_outliereight)$adj.r.squared

m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_pic_nom, data = outlier_removed)
summary(m_outliereight)$adj.r.squared
m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_pic_win, data = outlier_removed)
summary(m_outliereight)$adj.r.squared
m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_actor_win, data = outlier_removed)
summary(m_outliereight)$adj.r.squared
m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_actress_win, data = outlier_removed)
summary(m_outliereight)$adj.r.squared
m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+best_dir_win, data = outlier_removed)
summary(m_outliereight)$adj.r.squared
m_outliereight<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box, data = outlier_removed)
summary(m_outliereight)$adj.r.squared

m_outliernine<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating, data = outlier_removed)
summary(m_outliernine)$adj.r.squared
m_outliernine<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+best_pic_nom, data = outlier_removed)
summary(m_outliernine)$adj.r.squared
m_outliernine<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+best_pic_win, data = outlier_removed)
summary(m_outliernine)$adj.r.squared
m_outliernine<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+best_actor_win, data = outlier_removed)
summary(m_outliernine)$adj.r.squared
m_outliernine<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+best_actress_win, data = outlier_removed)
summary(m_outliernine)$adj.r.squared
m_outliernine<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+best_dir_win, data = outlier_removed)
summary(m_outliernine)$adj.r.squared

m_outlierten<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_pic_nom, data = outlier_removed)
summary(m_outlierten)$adj.r.squared
m_outlierten<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_pic_win, data = outlier_removed)
summary(m_outlierten)$adj.r.squared  						
m_outlierten<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_actor_win, data = outlier_removed)
summary(m_outlierten)$adj.r.squared
m_outlierten<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_actress_win, data = outlier_removed)
summary(m_outlierten)$adj.r.squared
m_outlierten<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_dir_win, data = outlier_removed)
summary(m_outlierten)$adj.r.squared

m_outliereleven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_pic_win+best_pic_nom, data = outlier_removed)
summary(m_outliereleven)$adj.r.squared
m_outliereleven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_pic_win+best_actor_win, data = outlier_removed)
summary(m_outliereleven)$adj.r.squared
m_outliereleven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_pic_win+best_actress_win, data = outlier_removed)
summary(m_outliereleven)$adj.r.squared
m_outliereleven<-lm(audience_score~critics_score+genre+imdb_num_votes+type+runtime+year+mpaa_rating+top200_box+critics_rating+best_pic_win+best_dir_win, data = outlier_removed)
summary(m_outliereleven)$adj.r.squared

mlr_full<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + year + mpaa_rating + top200_box+critics_rating+best_pic_win, data = outlier_removed)
summary(mlr_full)$adj.r.squared

#FINAL MODEL without outlier
mlr<-lm(audience_score~critics_score+genre+imdb_num_votes + type + runtime + mpaa_rating + top200_box+best_pic_win, data = outlier_removed)
summary(mlr)$adj.r.squared
summary(mlr)

#CHECKING CONDITIONS
#Nearly normal residuals: To check this condition, we plot a histogram and normal probability plot of the residuals.  
qqnorm(mlr$residuals)
qqline(mlr$residuals)
hist(mlr$residuals)

#Constant variability of residuals: 
plot(mlr$fitted.values, (mlr$residuals))

#Linear relationships between the response variable and numerical explanatory variables: 
plot(mlr$residuals~ outlier_removed$runtime)
plot(mlr$residuals~ outlier_removed$year)
plot(mlr$residuals~ outlier_removed$imdb_num_votes)
plot(mlr$residuals, outlier_removed$critics_score)

#Prediction
#American Sniper - used because we have a known value for best_pic_win variable.
newdata=data.frame(type="Feature Film",  genre="Drama",  runtime=134,  year=2015,  mpaa_rating="R",  imdb_num_votes=171952,  critics_score=73,  critics_rating="Certified Fresh",  best_pic_win="no",  top200_box="yes")
predict(mlr, newdata, interval="prediction")