library(downloader)
library(xtable)

download("http://stat.duke.edu/~mc301/data/acs.RData", destfile = "acs.RData")
load("acs.RData")
acs_sub = subset(acs, acs$employment == "employed" & acs$income > 0)
table(acs_sub$employment)

acs_sub = droplevels(acs_sub) # note that we overwrite acs_sub
table(acs_sub$employment)

names(acs_sub)

## non-log
m_full = lm(income ~ hrs_work + race + age + gender + citizen, data = acs_sub)

xtable(summary(m_full), digits = 2)


plot(m_full$residuals ~ m_full$fitted.values)
hist(m_full$residuals)
qqnorm(m_full$residuals)
qqpline(m_full$residuals)
m_full = lm(log(income) ~ hrs_work + race + age + gender + citizen, data = acs_sub)
rsqadj_full = summary(m_full)$adj.r.squared

rsqadj_step1 = rep(NA, 5)
# remove hrs_work
m_step1_1 = lm(log(income) ~ race + age + gender + citizen, data = acs_sub)
rsqadj_step1[1] = summary(m_step1_1)$adj.r.squared

# remove race
m_step1_2 = lm(log(income) ~ hrs_work + age + gender + citizen, data = acs_sub)
rsqadj_step1[2] = summary(m_step1_2)$adj.r.squared

# remove age
m_step1_3 = lm(log(income) ~ hrs_work + race + gender + citizen, data = acs_sub)
rsqadj_step1[3] = summary(m_step1_3)$adj.r.squared

# remove gender
m_step1_4 = lm(log(income) ~ hrs_work + race + age + citizen, data = acs_sub)
rsqadj_step1[4] = summary(m_step1_4)$adj.r.squared

# remove citizen
m_step1_5 = lm(log(income) ~ hrs_work + race + age + gender, data = acs_sub)
rsqadj_step1[5] = summary(m_step1_5)$adj.r.squared

which.max(c(rsqadj_full, rsqadj_step1))
