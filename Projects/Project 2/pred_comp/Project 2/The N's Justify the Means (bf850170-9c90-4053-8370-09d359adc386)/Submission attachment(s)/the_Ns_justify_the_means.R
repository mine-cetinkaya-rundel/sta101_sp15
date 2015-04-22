# #load data 
# 
# library(downloader)
# download("https://stat.duke.edu/~mc301/data/movies.Rdata", destfile="movies.Rdata")
# load("movies.Rdata")
# download("https://stat.duke.edu/~mc301/R/inference.RData", destfile = "inference.RData")
# load("inference.RData")
# 
# #begin exploratory data analysis
# 
# by(movies$critics_score, movies$genre, summary)
# plot(movies$critics_score ~ movies$genre, main="Critics' Scores by Genre")
# 
# movies$decade = NA #re-leveling year into a categorical variable
# movies$decade[movies$year %in% c(1974, 1975, 1976, 1977, 1978, 1979)] = "1970s"
# movies$decade[movies$year %in% c(1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989)] = "1980s"
# movies$decade[movies$year %in% c(1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999)] = "1990s"
# movies$decade[movies$year %in% c(2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009)] = "2000s"
# movies$decade[movies$year %in% c(2010, 2011, 2012, 2013, 2014)] = "2010s"
# movies$decade = as.factor(movies$decade)
# 
# table(movies$decade, movies$genre)
# plot(movies$genre ~ movies$decade, main="Genres of Films Released by Decade")
# 
# #make a new subset of the data only including dramas
# 
# dramas <- subset(movies, genre == "Drama")
# dramas$decade = NA
# dramas$decade[dramas$year %in% c(1974, 1975, 1976, 1977, 1978, 1979)] = "1970s"
# dramas$decade[dramas$year %in% c(1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989)] = "1980s"
# dramas$decade[dramas$year %in% c(1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999)] = "1990s"
# dramas$decade[dramas$year %in% c(2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009)] = "2000s"
# dramas$decade[dramas$year %in% c(2010, 2011, 2012, 2013, 2014)] = "2010s"
# dramas$decade = as.factor(dramas$decade)
# 
# #summary statistics
# 
# by(dramas$critics_score, dramas$decade, summary)
# by(dramas$critics_score, dramas$decade, mean)
# by(dramas$critics_score, dramas$decade, sd)
# plot (dramas$critics_score ~ dramas$decade, main="Critics' Scores for Drama Films across Decades")
# 
# #inference
# 
# inference(x = dramas$decade, y = dramas$critics_score, est = "mean", type = "ht", method = "theoretical", alternative = "greater")
# 
# #modeling
# 
# #creating 2 more variables of interest (not part of our research question)
# movies$length = NA
# movies$length[movies$runtime < 90] = "short"
# movies$length[movies$runtime %in% c(90:120)] = "middle"
# movies$length[movies$runtime > 120] = "long"
# movies$length = as.factor(movies$length)
# movies$adult = NA
# movies$adult[movies$mpaa_rating %in% c("G", "PG", "PG-13")] = "no supervision"
# movies$adult[movies$mpaa_rating %in% c("R")] = "supervision required"
# movies$adult[movies$mpaa_rating %in% c("Unrated")] = "unrated"
# movies$adult = as.factor(movies$adult)
# 
# #begin backwards elimination stepwise model selection
# 
# m_full <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_full)$adj.r.squared # adj.r.squared = 0.5445
# 
# #1st step
# 
# m_step1 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5337
# m_step1 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5001
# m_step1 <- lm(audience_score ~ type + genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.54449
# m_step1 <- lm(audience_score ~ type + genre + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5438
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5419
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5149
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.4689
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5441
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.54558 (drop best_pic_nom)
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5448
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.54551
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5452
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.54556
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + decade + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5436
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box  + length + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5452
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + adult, data = movies)
# summary(m_step1)$adj.r.squared #0.5449
# m_step1 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_nom + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length, data = movies)
# summary(m_step1)$adj.r.squared #0.5445
# 
# #remove best_pic_nom, begin step 2
# 
# m_full_new <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# 
# m_step2 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5349
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5013
# m_step2 <- lm(audience_score ~ type + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5459
# m_step2 <- lm(audience_score ~ type + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5449
# m_step2 <- lm(audience_score ~ type + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5430
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5150
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.4701
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5451
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5455026
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5465788 (drop best_dir_win)
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_dir_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5263
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.546638
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + decade + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5447
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + length + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5462
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + adult, data = movies)
# summary(m_step2)$adj.r.squared #0.5460
# m_step2 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + best_dir_win + top200_box + decade + length, data = movies)
# summary(m_step2)$adj.r.squared #0.5456
# 
# #remove best_dir_win, begin step 3
# 
# m_full_new2 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# 
# m_step3 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5359
# m_step3 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5024
# m_step3 <- lm(audience_score ~ type + genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5466
# m_step3 <- lm(audience_score ~ type + genre + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5459
# m_step3 <- lm(audience_score ~ type + genre + runtime + year  + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5440
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5156
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.4713
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5462
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actor_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5466
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5476367 (drop best_actor_win)
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + top200_box + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5473
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + decade + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5458
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + length + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5473
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + adult, data = movies)
# summary(m_step3)$adj.r.squared #0.5470
# m_step3 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actor_win + best_actress_win + top200_box + decade + length, data = movies)
# summary(m_step3)$adj.r.squared #0.5466
# 
# #remove best_actor_win, begin step 4
# 
# m_full_new3 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# 
# m_step4 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5369
# m_step4 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5036
# m_step4 <- lm(audience_score ~ type + genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.54759
# m_step4 <- lm(audience_score ~ type + genre + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5470
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5450
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5165
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.4715
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5472
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_actress_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.54755
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.548341 (drop best_actress_win)
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + decade + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5467
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + length + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5482
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + adult, data = movies)
# summary(m_step4)$adj.r.squared #0.5480
# m_step4 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + best_actress_win + top200_box + decade + length, data = movies)
# summary(m_step4)$adj.r.squared #0.5476
# 
# #remove best_actress_win, begin with step 5
# 
# m_full_new4 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# 
# m_step5 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5476
# m_step5 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5046
# m_step5 <- lm(audience_score ~ type + genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.54826
# m_step5 <- lm(audience_score ~ type + genre + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5478
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5459
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5174
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.4727
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5478
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + top200_box + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.54827
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + decade + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.5472
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.549112 (drop decade)
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + adult, data = movies)
# summary(m_step5)$adj.r.squared #0.55865
# m_step5 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + decade + length, data = movies)
# summary(m_step5)$adj.r.squared #0.5483
# 
# #remove decade, begin step 6
# 
# m_full_new5 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# 
# m_step6 <- lm(audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5380
# m_step6 <- lm(audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5030
# m_step6 <- lm(audience_score ~ type + genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5488
# m_step6 <- lm(audience_score ~ type + genre + runtime + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5426
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5468
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5176
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.4762
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5481
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + top200_box + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5490
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + length + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5480
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + adult, data = movies)
# summary(m_step6)$adj.r.squared #0.5490
# m_step6 <- lm(audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.549112 (drop adult)
# 
# #remove adult, begin step 7
# 
# m_full_new6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# 
# m_step6 <- lm (audience_score ~ genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5380
# m_step6 <- lm (audience_score ~ type + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5030
# m_step6 <- lm (audience_score ~ type + genre + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5488
# m_step6 <- lm (audience_score ~ type + genre + runtime + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5426
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5450
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5176
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_rating + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.4762
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + best_pic_win + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5481
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + top200_box + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5490
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + length, data = movies)
# summary(m_step6)$adj.r.squared #0.5480
# m_step6 <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box, data = movies)
# summary(m_step6)$adj.r.squared #0.5490
# 
# #all adjusted R-squared values are below that of m_full_new6, so we can stop dropping variables
# 
# mlr <- lm (audience_score ~ type + genre + runtime + year + mpaa_rating + imdb_num_votes + critics_score + critics_rating + best_pic_win + top200_box + length, data = movies)
# 
# #conditions for mlr
# 
# plot(mlr$residuals)
# plot(mlr$residuals ~ mlr$fitted)
# hist(mlr$residuals)
# qqnorm(mlr$residuals)
# qqline(mlr$residuals)
# 
# #prediction for Furious 7
# 
# newdata = data.frame(critics_score = 82, genre = "Other", imdb_num_votes = 102132, type = "Feature Film", length = "long", year = 2015, mpaa_rating = "PG-13", critics_rating = "Certified Fresh", top200_box = "no", runtime = 137, best_pic_win = "no")
# predict(mlr, newdata, interval = "prediction")
# 
# #summary of final model
# 
# summary(mlr)
