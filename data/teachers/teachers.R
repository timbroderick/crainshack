# This tells R and R studio where we are on our computer

setwd("~/anaconda3/envs/notebook/crainshack/data/teachers")

# This is a set of libraries that make working with R easier
# they're kind of like shortcuts for things we do all the time

library("tidyverse")

# load in the data we'll work with. Notice that we don't have to have a full file path like
# ~/anaconda3/envs/notebook/crainshack/data/teachers/teachers.csv
# Instead, we can load the file

teachers <- read_csv("teachers.csv")
#---------------------------------

# get the summary statistics
summary(teachers)

# we can save these to refer to the later. This code puts the summary stats into a dataframe
# and then saves it as a csv file we can open in excel if we want
dfsum <- data.frame(unclass(summary(teachers)), check.names = FALSE, stringsAsFactors = FALSE)
write_csv(dfsum,'teachers_summary.csv')

# learn more about the data types
sapply(teachers, class)

# select only a few columns
df <- select(teachers,'last_name','first_name','salary')
df

# Select columns with distinct names of schools
df <- teachers %>% distinct(school)
df

# distinct schools and salaries
df <- teachers %>% distinct( school,salary )
df

# order by salary descending
df <- select(teachers,'last_name','first_name','salary') %>% arrange(desc(salary))
df

# %>% is what's known as a "pipe." It allows you to chain commands together in a string

# order by salary ascending
df <- select(teachers,'last_name','first_name','salary') %>% arrange(salary)
df

# ordering by two things
df <- select(teachers,'last_name','school','hire_date') %>% arrange(school,desc(hire_date))
df

# filter rows
df <- select(teachers,'last_name','school','hire_date') %>% filter(school == "Myers Middle School")
df

# filtering using different comparison operators

# this is does not equal
df <- select(teachers,'school') %>% filter(school != "F.D. Roosevelt HS")
df

# hire date is before
df <- select(teachers,'last_name','school','hire_date') %>% filter(hire_date < "2000-01-01")
df

# salary is greater than or equal to
df <- select(teachers,'last_name','first_name','salary') %>% filter(salary >= 43500)
df

# salary is between
df <- select(teachers,'last_name','first_name','salary') %>% filter( (salary > 40000) & (salary < 65000) )
df

# filtering by partial words or phrases

# returns just Sam, uppercase
df <- select(teachers,'first_name') %>% filter( str_detect(first_name, 'Sam' ) )
df

# would return Sam or sam
df <- select(teachers,'first_name') %>% filter( str_detect(first_name, regex('sam', ignore_case=TRUE) ) )
df

# the . means the phrase could be part of a complete word, but specifically be at the beginning
df <- select(teachers,'school') %>% filter( str_detect(school, regex('roo.', ignore_case=TRUE) ) )
df

# mixing selectors
# And is &, or is |
df <- select(teachers,'last_name','first_name','salary') %>% filter( (last_name == "Cole") | (last_name == "Bush") )
df

# school is Roosevelt, salary is < 38999 or > 40000 
df <- select(teachers,'last_name','first_name','school','salary') %>% filter( school == "F.D. Roosevelt HS" & (salary < 38000 | salary > 40000)  )
df

# select first, last school hire salary, school roo sort desc salary
df <- select(teachers,'last_name','first_name','school','hire_date','salary') %>% filter( str_detect(school, regex('roo.', ignore_case=TRUE) ) ) %>% arrange(desc(hire_date))
df

