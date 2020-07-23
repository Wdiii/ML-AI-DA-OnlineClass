###############################################################
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to build a
# Logit model on a given set of data.
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
###############################################################
#
###  required libraries  ###
# Run the following code to load the packages (libraries)
# If the library package does not load properly, make sure 
# that you have installed the package onto  your system.  
# Use the 'Packages' tab in RStudio to install the package.
# 
#We will create a dataset for this assignment.  The code below will create a 
# data set with three variables x1, x2, and y.  The three column vectors will be
# stored in the dataframe called data.

set.seed(500)
x1 = rnorm(1000)
x2 = rnorm(1000)
z = 1 + 3*x1 + 5*x2        
pr = 1/(1+exp(-z))
y = rbinom(1000,1,pr)
data = data.frame(Y = y,X1 = x1, X2 = x2)

#####################################################
# QUESTION 1: Run a Logit regression to see how the variables X1 and X2
# impact Y. Use the glm() command ans store the results in 'model1'
### Start Code

model1 <- glm(Y~ X1+X2, family = binomial, data)

### End Code

# Run the following to get the results of your Logit regression.  Describe the results

summary(model1)
#From the coefficient, we could get Y=1.21+2.96*X1+5.11*X2 
#So 1 unit change in X1 will increase the log pdds by 2.96 
#And 1 unit change in X2 will increase the log pdds by 5.11 
#We can also get the odds by using e(y) and probability is odds/(1+odds)

#####################################################
# QUESTION 2: Now that we have the coefficients for the variables.  
# Write down the regression equation for the model.

# Y=1.21+2.96*X1+5.11*X2 

# 1. Assume the following values for the independent variables: X1 = 0.3922, X2 = 0.0052

# Calculate the log odds and store in 'logodds1'
# Calculate the odds and store in 'Odds1'
# Calculate the the probability of Y = 1 and store in 'Probability1'

logodds1 <- 1.2053+2.9631*0.3922+5.1127*0.0052
Odds1 <- exp(logodds1)
Probability1 <- Odds1/(1+Odds1)

# Run the following print command
print(paste("The log odds and probability of Y being 1 are", logodds1, "and", Probability1, "repectively."))

# 2. Assume the following values for the independent variables:  X1 = -0.8273, X2 = 0.02274

# Calculate the log odds and store in 'logodds2'
# Calculate the odds and store in 'Odds2'
# Calculate the the probability of Y = 1 and store in 'Probability2'

logodds2 <- 1.2053-2.9631*0.8273+5.1127*0.02274
Odds2 <- exp(logodds2)
Probability2 <- Odds2/(1+Odds2)

# Run the following print command
print(paste("The log odds and probability of Y being 1 are", logodds2, "and", Probability2, "repectively."))

