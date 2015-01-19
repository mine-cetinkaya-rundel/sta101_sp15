# library
library(stringr)
library(dplyr)

# load data
#d = read.csv("survey_raw_1_13.csv")
d1 = read.csv("survey_raw_1_15_m.csv", stringsAsFactors = FALSE)
d2 = read.csv("survey_raw_1_15_j.csv", stringsAsFactors = FALSE)
names(d2) = names(d1)
d = rbind(d1, d2)

# weird empty columns created by sakai 
comment_columns = which(str_detect(names(d), "Grader.s.comments"))
columns_to_remove = c(1, 2, comment_columns)

# remove empty/unused columns
d = d[,-columns_to_remove]

# s/b 53 columns left
dim(d)

# read survey questions file
survey_questions <- data.frame(name = readLines("~/Desktop/Teaching/Sta101_S15/Class survey/survey_questions_S15"), stringsAsFactors = FALSE)

# find rows in the text file starting with numbers
# subset the text file for those rows only
rows_with_names = which(str_match(survey_questions[,1], "^[0-9]*") != "")
vars = survey_questions[rows_with_names,]

# strip out variable names
varnames = str_match(vars, ".  *(.*):")[, 2]

# add variable names to data file
names(d) = varnames

# numeric cols
num_vars1 = which(lapply(d, class) %in% c("numeric", "integer"))
Sys.setlocale('LC_ALL','C') 
num_vars2 = as.numeric(which(lapply(d[1,], function(x) str_detect(x, "1: ")) == TRUE))
num_vars = c(num_vars1, num_vars2)

# replace "1: " with "" in num_vars2 columns
d[,num_vars2] = lapply(d[,num_vars2], function(x) str_replace(x, "1: ", ""))

# replace encoding for apostrophe with "'"
d = lapply(d, function(x) str_replace(x, "\xd5", "'"))
d = lapply(d, function(x) str_replace(x, "\xfc\xbe\x8d\x96\x90\xbc", "'"))

# replace "N/A" with NA
d = lapply(d, function(x) str_replace(x, "N/A", NA))
d = lapply(d, function(x) str_replace(x, "No Answer", NA))
d = lapply(d, function(x) str_replace(x, "NA", NA))

# replace "Shhhhh\xc9." with "Shhhhh!"
d = lapply(d, function(x) str_replace(x, "Shhhhh\xc9.", "Shhhhh!"))

# replace nonsense
d = lapply(d, function(x) str_replace(x, "I don't know", NA))
d = lapply(d, function(x) str_replace(x, "Idk", NA))
d = lapply(d, function(x) str_replace(x, "no idea", NA))

# replace "5?" with 5
d = lapply(d, function(x) str_replace(x, fixed("5?"), fixed("5")))

# replace "10+" with 10
d = lapply(d, function(x) str_replace(x, fixed("10+"), fixed("10")))

# replace written out numbers
number_words = c("fourteen", "fourty one", "Sixty", "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "Ten")
numbers = as.character(c(14, 41, 60, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
n = length(numbers)

d = data.frame(d, stringsAsFactors = FALSE)
for(i in 1:n){
  d[,num_vars2] = lapply(d[,num_vars2], function(x) str_replace(x, ignore.case(number_words[i]), numbers[i]))
}

# check
for(i in 1:53){
  print(i)
  print(names(d)[i])
  print(table(d[,i]))
}

# shuffle
n = nrow(d)
new_order = sample(1:n, n, replace = FALSE)
d = d[new_order,]

# write out
write.csv(d, file = "surveyS15_1_15.csv", row.names = FALSE)

# read in and check
dd = read.csv("surveyS15_1_15.csv")
str(dd)
