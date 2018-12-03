# This tells R and R studio where we are on our computer

setwd("~/anaconda3/envs/notebook/crainshack/data/hospitals")

# This is a set of libraries that make working with R easier
# they're kind of like shortcuts for things we do all the time

library("tidyverse")

# load in the data we'll work with. Notice that we don't have to have a full file path like
# ~/anaconda3/envs/notebook/crainshack/data/hospitals/hospitals.csv
# Instead, we can load the file

hospitals <- read_csv("ILhospitalsCBI_CBI.csv")
#---------------------------------

# preview the data
head(hospitals)

# get the summary statistics
summary(hospitals)

# we can save these to refer to the later. This code puts the summary stats into a dataframe
# and then saves it as a csv file we can open in excel if we want
dfsum <- data.frame(unclass(summary(hospitals)), check.names = FALSE, stringsAsFactors = FALSE)
write_csv(dfsum,'hospitals_summary.csv')

# learn more about the columns
sapply(hospitals, class)

# select only a few columns
df <- select(hospitals,'name','city','county','hospital_bed_size')
df

# learn more about the columns
sapply(df, class)

# Select columns with distinct names of county
df <- hospitals %>% distinct(county)
df # There are 108 counties in Illinois, but only 63 of them have hospitals 

# order by descending
df <- select(hospitals,'name','city','county','hospital_bed_size') %>% arrange(desc(county))
df

# %>% is what's known as a "pipe." It allows you to chain commands together in a string

# order by ascending
df <- select(hospitals,'name','city','county','hospital_bed_size') %>% arrange(county)
df

# ordering by two things
df <- select(hospitals,'name','city','county','hospital_bed_size') %>% arrange(city,desc(county))
df

# filter rows
df <- select(hospitals,'name','city','county','hospital_bed_size') %>% filter(hospital_bed_size == "100-299 beds")
df

# filtering using different comparison operators

# this is does not equal
df <- select(hospitals,'name','city','county','hospital_bed_size') %>% filter(hospital_bed_size != "100-299 beds")
df

# less than 60805
df <- select(hospitals,'name','city','county','zip_code') %>% filter(zip_code < "60805")
df

# greater than or equal to
df <- select(hospitals,'name','city','county','zip_code') %>% filter(zip_code >= "60805")
df

# between
df <- select(hospitals,'name','city','county','zip_code') %>% filter( (zip_code > 60805) & (zip_code < 62000) )
df


# Select some rows and do a histogram

df <- select(hospitals,'name','city','county','hospital_bed_size','urban_location_f','children_hospital_f')
df

# how are the size of hospitals distributed?
qplot(hospital_bed_size,
      data=df,
      fill=factor(urban_location_f)
)

# Where are children's hospitals most often located?
qplot(urban_location_f,
      data=df,
      fill=factor(children_hospital_f)
)
