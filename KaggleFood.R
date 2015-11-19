#Kaggle Compitition
library(tree)
library(rjson)
setwd("~/Desktop/fall_2014_work/ISLR")
########################################################################
#First we load the data and shape it.
json_data <- fromJSON(file="train.json")
#This is temporary to explore and fine tue the code
json_data <- json_data[1:100]
head(json_data)
########################################################################
#We want to access the data in a meaningful way.
#We want to create a data.frame for all my values
my.id <- unlist(lapply(json_data, function(x) unlist(x$id)))
my.cuisine <- unlist(lapply(json_data, function(x) unlist(x$cuisine)))
my.ingredients <- unique(unlist(lapply(json_data, function(x) unlist(x$ingredients))))
#Alphabetizes my list of ingredients
my.ingredients <- my.ingredients[order(my.ingredients)]
#Created an empty matrix to create a binary variable for each unique ingredient
my.count <- matrix(0,ncol=length(my.ingredients),nrow=length(my.id))
my.data.frame <- data.frame(my.id, my.cuisine, my.count)
colnames(my.data.frame) <- c("ID","CUISINE", my.ingredients)
########################################################################
#Counting the ingredients
########################################################################
temp <- lapply(json_data, function(x) unlist(x$ingredients))
for(i in 1:length(my.id)){ my.data.frame[i,colnames(my.data.frame)%in%temp[[i]]] <- 1 }
########################################################################
# Creating our forest
########################################################################
#Now that we have our data in binary variables we can use different prediction techniques
#How can we help this data along
#1) Possibly the number of spices?
#2) We could could combine certain ingrediant names if they are very  similar
