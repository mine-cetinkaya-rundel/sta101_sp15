# library
library(stringr)
library(dplyr)

# load data
d = read.csv("survey_raw_1_13.csv")

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

# replace "1: " with ""
d = apply(d, 2, function(x) str_replace(x, "1: ", ""))

# replace "\xd5" with "'"
d = apply(d, 2, function(x) str_replace(x, "\xd5", "'"))

# replace "N/A" with NA
d = apply(d, 2, function(x) str_replace(x, "N/A", NA))
d = apply(d, 2, function(x) str_replace(x, "No Answer", NA))
d = apply(d, 2, function(x) str_replace(x, "NA", NA))

# replace "Shhhhh\xc9." with "Shhhhh!"
d = apply(d, 2, function(x) str_replace(x, "Shhhhh\xc9.", "Shhhhh!"))

# save
surveyS15 = d

# write out
write.csv(surveyS15, file = "surveyS15_1_13.csv", row.names = FALSE)
