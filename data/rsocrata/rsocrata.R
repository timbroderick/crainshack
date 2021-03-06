# Script teaching data import, manipulation, and visualization with Chicago public salary data 

setwd("~/anaconda3/envs/notebook/crainshack/data/rsocrata")

# Install and load necessary packages -------------------------------------
# install.packages("tidyverse") 
# install.packages("RSocrata")

library(tidyverse)
#install.packages("RSocrata")
library(RSocrata)


# Basic functions in R ----------------------------------------------------
1 + 1
2 * 3

data("mtcars")
View(mtcars)
class(mtcars)

class(1)
class(TRUE)
class("TRUE")

summary(mtcars)
head(mtcars)
str(mtcars)


# Work with Chicago Data Portal public salary information -----------------
# Read some data in
salaries <- read_csv("https://data.cityofchicago.org/resource/tt4n-kn4t.csv") 
# For some reason, this only reads in 1000 rows: likely something to do with the API
salaries_all <- read.socrata("https://data.cityofchicago.org/resource/tt4n-kn4t.csv")
salaries_all <- as_tibble(salaries_all)

class(salaries_all)
head(salaries_all)
View(salaries_all)
names(salaries_all)

# Filter by non-hourly employees only
ft_salaries <- filter(salaries_all, salary_or_hourly == "Salary")

# Who are the top earners?
select(ft_salaries, annual_salary, department, name) %>%
  arrange(desc(annual_salary))

# Who's the top paid in each department?
top_paid <- select(ft_salaries, annual_salary, department, name) %>%
  group_by(department) %>% 
  arrange(desc(annual_salary)) %>% 
  slice(1)

View(top_paid)

# What's the median salary for each department?
median_paid <- select(ft_salaries, annual_salary, department, name) %>%
  group_by(department) %>% 
  summarize(med_salary = median(annual_salary))

# Challenge! Sort median_paid from highest to lowest salary
arrange(median_paid, desc(med_salary))

View(median_paid)

# Make a plot of the distribution of median salary
ggplot(median_paid, aes(x = med_salary)) +
  geom_histogram(fill = "blue") +
  labs(x = "Median Salary",
       title = "Distribution of Median Salaries")


# Questions ---------------------------------------------------------------

# How to look up information about a function?
?class

# Type Ctrl-Enter to run a line of code

# Where to find packages to use?
# CRAN Task Views are a good start, though sometimes somewhat overwhelming: https://cran.r-project.org/
# I recommend starting with the tidyverse package, which gives you a good set of beginner tools, then expanding your repertoire as needed 

# Sometimes multiple packages can have functions named the same thing
# In this case, use the packagename::functionname() syntax if you need the masked function
base::intersect()
dplyr::intersect()