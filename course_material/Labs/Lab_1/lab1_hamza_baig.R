# get working directory
#getwd()

#import libraries
library(ggplot2)


# Data Exploration

# 1. import data
data <- read.csv("Heart_Attack.csv")


# 2. summary of data
# It gives information about all the columns/variables such as min. value of each column, max. value, mean, median, etc.
summary(data)

# 3. structure of data
# It explains the structure of data; the number of columns/variables in data and the number of observations with data types with possible values.
str(data)
# 3. dimension of data
# Gives the dimension of data; number of rows/observations and columns/variables
dim(data)

# 4. First 8 rows
head(data, 8)
# 4. Last 5 rows
tail(data, 5)

# 5. Column names of dataset.
colnames(data)

# Data Pre-Processing

# There is no class variable/column in the provided dataset
# class_var <- data$class 

# Assuming you're asking about the variable that represents the label in the dataset, then it will be the output variable, and it represents whether a patient can have heart attack or not.

# 6. Class Variable is output. 
class_variable <- data$output

# 7. Datatype of output variable - integer 
class(class_variable)

# 8. Change data type of output to factor
data$class <- as.factor(data$output)
# 8. Show output
data$class

# 9. Sum of missing values
print("Sum of missing values:")
sum(is.na(data))

# 10. Sum of missing values for each column/variable
colSums(is.na(data))

# 11. Replace missing values
data[is.na(data)] <- 0
# 11. Check if values replaced - should return 0
sum(is.na(data))

# 12. Rename the sex attribute
data$sex <- ifelse(data$sex == 0, "Male", "Female")
# 12. Check if renamed (0 to Male and 1 to Female)
data$sex


# Data Visualization

# 13. scatter plot between cholestrol and age.
plot(data$chol, data$age, xlab = "Cholesterol", ylab = "Age", main = "Scatter Plot of Cholesterol and Age")
# 13. a
points(data$chol, data$age, col = "blue")
# 13. b
points(data$chol, data$age, col = "red",pch=6)

# 14. ggplot 
# library imported above
# Plot between age and cholestrol, based on output.
ggplot(data, aes(x=age, y=chol,color=output)) + geom_point(shape=15)

# 15. Barplot
barplot(table(data$age), main = "Age distribution", xlab = "Age", ylab = "Frequency", col = "blue")

# 16. Histogram for chest pain
# a. Minimum and maximum
minimum_cp <- min(data$cp)
maximum_cp <- max(data$cp)
# b and c - histogram
hist(data$cp, breaks = seq(minimum_cp, maximum_cp, 1), xlab="Chest pain",ylab="Frequency",main = "Chest Pain Type",col="red")

# 17. Boxplot for age
boxplot(data$age,main="Age distribution", xlab="Age",ylab="Frequency")

# 18. Correlation plot between all the outputs.
plot(data)





