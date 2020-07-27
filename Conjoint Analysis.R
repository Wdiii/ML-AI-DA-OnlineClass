# Fares: price vs speed in-class example

fares <- c("$3.1", "$3.7", "$4.3")
duration <- c("10min", "20min")
factor_levels <- as.data.frame(c(fares, duration))
colnames(factor_levels) <- "levels"
data <- expand.grid(fares, duration)
colnames(data) <- c("fares", "duration")

Rating <- c(100,92,71,94,82,60)
data <- cbind(data, Rating)

# Let us make dummy variables 
# $4.3 will be 0,0 and 20min is 0 too
data$F1 <- ifelse(data$fares == "$3.1",1,0)
data$F2 <- ifelse(data$fares == "$3.7",1,0)
data$D1 <- ifelse(data$duration == "10min",1,0)

# Let us run a regression to get the coefficients of the model
reg <- lm( Rating ~ F1 + F2 + D1, data = data)

coefficients <- as.data.frame(reg$coefficients)
colnames(coefficients) <- 'coefficients'
coefficients

summary(reg)

# Likeliness of reading a novel, in-class video example

# install.packages("conjoint")
# install.packages("fpc")

library(conjoint)
require(fpc) # for clustering

pages <- c("less than 500", "500 to 1000", "more than 1000")
genre <- c("fiction", "non-fiction")
author <- c("known", "unknown")
factor_levels <- as.data.frame(c(pages, genre, author))
colnames(factor_levels) <- "levels"
data <- expand.grid(pages, genre, author)
colnames(data) <- c("Pages", "Genre", "Author")

# Creating a set of profiles for the factors
facdesign <- caFactorialDesign(data = data, type = "full")
encdesign <- caEncodedDesign(facdesign)

cor(encdesign)

# Fill in random responses for the 10 respondents for all the 12 profiles created
set.seed(1)
response <- as.data.frame(sample(1:12, 12, rep= FALSE))
# it will random show from 1 to 12 without repeat
for (i in 2 : 10) {
  temp <- as.data.frame(sample(1:12, 12, rep = FALSE)) 
  response <- cbind(response, temp)
}

response <- t(response)
row.names(response) <- c(1:10)
colnames(response) <- c(paste("Profile", c(1:12)))
response <- as.data.frame(response)

# Now we have factors and response

# Partial utility
partutil <- caPartUtilities(y = response[1:5,], x = encdesign, z = factor_levels)
util <- caUtilities(y = response, x = encdesign, z = factor_levels)
# The output and graphs show the estimated impact on utility by each
# of the factor levels and also the importance of each factor.

# Conjoint Analysis
analysis <- Conjoint(response, encdesign, factor_levels)

# Obtaining the importance of each of the factors 
Importance <- caImportance(response, encdesign)
Factor <- c("Pages","Genre", "Author")

FactorImp <- as.data.frame(cbind(Factor,Importance))
# Pages Genre and Author are equal weight.

# Segmentation and Cluster Plot
pref <- as.vector(t(response))
seg <- caSegmentation(pref, encdesign, c = 2)

cluster <- as.data.frame(seg$sclu)
colnames(cluster) <- "Cluster"

plotcluster(seg$util,seg$sclu, pch = 20, xlab = " ", ylab = " ", main = "K-Means Clustering Result")
# try to group segment of different types of book

# A similar example of chocolate dataset
data(chocolate)
str(cprof)

# Calculate utilities provided by each factor level to the first respondent
util <- caUtilities(y = cprefm[1,], x = cprof, z = clevn)
util
# five graphs with utility

# Calculate the part utilties for each of the levels for the first 5 respondents
partutil <- caPartUtilities(y = cprefm[1:5,], x = cprof, z = clevn)

# Conjoint analysis
Conjoint(y = cpref, x = cprof, z = clevn)
# It seems that kind is more important than the rest 4 factors, 
# "Dark" chocolate seems to provide the most utility to a consumer

# Let us determine the level of importance of each of the factors 
Importance <- caImportance(cprefm, cprof)
Factor <- c("Kind","Price", "Packing", "Weight", "Calorie")

FactorImp <- as.data.frame(cbind(Factor,Importance))

# Segmentation and Cluster Plot
seg <- caSegmentation(cpref, cprof, c = 3)
seg

cluster <- as.data.frame(seg$sclu)
colnames(cluster) <- "Cluster"

plotcluster(seg$util,seg$sclu, pch = 20, xlab = " ", ylab = " ", main = "K-Means Clustering Result")
# We can see 3 cluster assignments

