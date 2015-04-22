library(stringr)
library(downloader)
library(magrittr)

team_dirs = dir("Project 2/",full.names = TRUE)

n_team = length(team_dirs)

teams = dir("Project 2/") %>%
        str_extract(".*\\(") %>%
        str_replace(" \\(", "")

rmse_team = data.frame(team = teams, rmse = rep(NA, n_team))

load("movies_pred.RData")

movies_pred$log_imdb_num_votes = log(movies_pred$imdb_num_votes)

for(i in 1:n_team){
  print(i)
  cur_dir = file.path(team_dirs[i], "/Submission attachment(s)")
  print(cur_dir)
  R_files = dir(cur_dir,"\\.R$",full.names = TRUE)
  
  if(length(R_files) > 1){stop(print(i))}
  
  try( source(R_files) )
  if(exists("mlr")){
    pred = predict(mlr, newdata = movies_pred)
    diff_sq = sum((pred - movies$audience_score)^2)
    n = dim(movies_pred)[1]
    rmse_team[i, 2] = sqrt(diff_sq / n)   
  } else {
    rmse_team[i, 2] = NA
  }
  to_remove = setdiff(ls(), c("movies_pred", "n_team", "rmse_team", "team_dirs"))
  rm(list=to_remove)
}

rmse_team[which.min(rmse_team$rmse),]

rmse_team[order(rmse_team$rmse),]

# winner Team BAM! - lowest RMSE without using audience_rating

# > rmse_team[order(rmse_team$rmse),]
# team     rmse
# 13                      MyLA 23.66330
# 3              Bae's Theorem 24.27433
# 5               Code Masters 24.59577
# 10                     Llama 24.59577
# 18                       One 24.59577
# 23             Stat-tastic 4 24.59577
# 1     And then there was One 24.62816
# 11                 Mathletes 24.63199
# 2                AristoStats       NA
# 4                Blue Devils       NA
# 6            Delta Crunchers       NA
# 7                 Dreamworks       NA
# 8             Fantastic Four       NA
# 9                       KRAY       NA
# 12                Mean Girls       NA
# 14              No Boundries       NA
# 15     Non-Standard Deviants       NA
# 16             Not Yo Studio       NA
# 17            Notorious BIGT       NA
# 19          R Ya Ready Kids?       NA
# 20                   R-tists       NA
# 21            Secret Service       NA
# 22         Standard Deviants       NA
# 24               Stats Stars       NA
# 25                 Statstars       NA
# 26                 Team iCan       NA
# 27                Team Nicky       NA
# 28          Team No Mistakes       NA
# 29 The N's Justify the Means       NA
# 30              The Outliers       NA