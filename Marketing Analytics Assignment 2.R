
#############################################################
#
# Marketing Analytics Assignment 2.
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to perform a conjoint
# analyis.
#
# You will then be asked to interpret the # results.  
#
# For this assignment, you may use any resources necessary
# to be able to execute the code.  However, the interpretation 
# should reflect your own thinking.
#
# You are to work on the problem alone, without help 
# from any other person.
#
# In this assignment, you will create a portfolio with only two
# stocks.  Use the sample code for reference.
###############################################################

# INSTRUCTIONS:  Enter your code between the comments line 
# as directed.  Comments begin with a hashtag '#'.

# For example

### Start Code

### End Code

# If you are asked to interpret results, make sure to put your
# answers in a comment line.

################################################################ 

###  required libraries  ###
# Run the following code to load the packages (libraries)
# If the library package does not load properly, make sure 
# that you have installed the package onto  your system.  
# Use the 'Packages' tab in RStudio to install the package.

library(mosaicData)
data("SaratogaHouses")
attach(SaratogaHouses)


#####################################################
# QUESTION 1: Use the str() command on SaratogaHouses

# Broadly describe the data.

dim(SaratogaHouses)
# There are 1728 rows (observations) and 16 columns (variables) for this dataset

str(SaratogaHouses)
# The varaibles's name and data type can be shown by this code.
# We have age, bathrooms, bedrooms, centralAir, fireplaces, fuel, heating, landValue, livingArea, lotSize, newConstruction, pctCollege, price, rooms, sewer, waterfront.

#* End Question 1
######################################################
# 
#####################################################
# QUESTION 2:
# First we will look at the impact of fuel type on the price.

# Make a box plot of price by fuel type using boxplot()
boxplot(price ~ fuel)

# What is the thick line in the middle of the box represent?
# It represents the mean of price for different type of fuel.

# What is the lower and upper edges of the box represent?
# It shows the minimum and maximum data point except the outliers.

# Do the box plots look the same or difference.  Explain in one or two sentences.
# When we compare the mean of the three box plots, it looks similar. However, the max, min and quarter lines are quite different.
# The price of gas has a largest range and electric has a smallest range, so I think the three box plots are different. 

#* End Question 2
######################################################

#####################################################
# QUESTION 3:
# 
# Run an ANoVA using Price and Fuel.  Save the results of the ANOVA analysis
# in a variable AOV1 and use the aov() function.
# Display the results using the summary() function
AOV1 <- aov(price ~ fuel, data=SaratogaHouses)
summary(AOV1)

# What is the null hypothesis?
# The hypothesis is that the type of fuel will not affect the price.

# What is the p-value for fuel?  Interpret the results.
# The p-value for fuel is 63.16 <2e-16, which is less than 0.05. 
# So I can reject the null hypothesis because the type of fuel will affect the price.

#* End Question 3
######################################################
# 

#####################################################
# QUESTION 4:
#
# Make a box plot of price by waterfront type using boxplot()
boxplot(price ~ waterfront)

# Do the boxplots look the same or different. Explain.
# The box plot look different because the quarter line and mean are quite different for the two types.

# Run an ANoVA using Price and waterfront  Save the results of the ANOVA analysis
# in a variable AOV2 and use the aov() function.
# Display the results using the summary() function
AOV2 <- aov(price ~ waterfront, data=SaratogaHouses)
summary(AOV2)

# What is the null hypothesis?
# The hypothesis is that whether it has waterfront or not will not affect the price.

# What is the p-value for waterfront?  Interpret the results.
# The p-value is 1.21e-10, which is less than 0.05. 
# So it will reject the null hypotheses, the waterfront will affect the price.

#* End Question 4
######################################################

#####################################################
# QUESTION 5:

# Run the following code

#The following code creates two column vectors. One with all
#the prices of houses that have a water front, and a column of prices
#of houses without water front.

PWithWater <- price[waterfront== "Yes"]
PWoutWater <- price[waterfront=="No"]

# Using PWithWater and PWoutWater, perfrom a t-test using t.test()
t.test(PWithWater, PWoutWater)

# What is the null hypothesis?
# There is no difference in price between the two groups.

# What is the p-value for the t-test?  Interpret the results.
# The p-value is 0.001119, which is less than 0.05.
# It reject the null hypothesis, and the price is difference between the two groups.

# Let's assume equal variances of the two groups. Perform a t-test assuming equal
# variances, e.g, t.test(x,y, var.equal=TRUE)
t.test(PWithWater, PWoutWater, var.equal=TRUE)

# What is the null hypothesis?
# There is no difference in mean of price for two groups

# What is the p-value for the t-test?  Intperet the results.
# After estimating the variances and adjusting the degrees of freedom,
# the p-value is 1.21e-10, which is less than 0.05.
# So there is a difference in mean of price. 

#* End Question 5
######################################################

#####################################################
# QUESTION 6:
# 
# Run an additive ANoVA using Price, waterfront, and fuel.  Save the results of the ANOVA analysis
# in a variable AOV3 and use the aov() function.
# Display the results using the summary() function
AOV3 <- aov(price~waterfront+fuel, data=SaratogaHouses)
summary(AOV3)

# What is the p-value for waterfront?  Interpret the results.
# It is 2.29e-11, which is less than 0.05.
# So it has waterfront or not will affect the price.

# What is the p-value for fuel?  Interpret the results.
# It is 2e-16, which is less than 0.05.
# So the type of fuel will affect the price.

#* End Question 6
######################################################

#####################################################
# QUESTION 7:
# 
# Run an two-way ANoVA using Price, waterfront, and fuel with interaction.
# Save the results of the ANOVA analysis
# in a variable AOV4 and use the aov() function.
# Display the results using the summary() function
AOV4 <- aov(price ~ waterfront*fuel, price=SaratogaHouses)
summary(AOV4)

# What is the p-value for waterfront?  Interpret the results.
# It is 2.18e-11, which is less than 0.05.
# So it has waterfront or not will affect the price.

# What is the p-value for fuel?  Interpret the results.
# It is 2e-16, which is less than 0.05.
# So the type of fuel will affect the price.

# What is the p-value for the interaction of fuel and waterfront?  Interpret the results.
# It is 0.0513, which is over 0.05.
# So the interction of fuel and waterfront will not affect the housing price. 

# Run the following

interaction.plot(waterfront,fuel,price)

#Interpret the plot as best as you can. 
# The mean of price is highest with Yes in waterfront and fuel type gas.
# If there is a waterfront, no matter what type of fuel is using, the mean of price is higher than no waterfront. 
# Overall, the price will be higher with gas, then electric, then oil.
# However, the price of no waterfront with electric is lower than the price of no waterfront with oil. 

#* End Question 7
######################################################
