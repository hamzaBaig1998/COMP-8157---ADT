import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load the dataset
data = pd.read_csv("train.csv")

# Preprocess the data
# Handle missing values
data.fillna(0, inplace=True)

# Handle outliers
Q1 = data.quantile(0.25)
Q3 = data.quantile(0.75)
IQR = Q3 - Q1
data = data[~((data < (Q1 - 1.5 * IQR)) | (data > (Q3 + 1.5 * IQR))).any(axis=1)]

# Calculate the sum of all transactions per customer
data['total_transactions'] = data.groupby('fullVisitorId')['totals.transactionRevenue'].transform('sum')

# Plot the distribution of total transactions per customer
sns.distplot(np.log1p(data['total_transactions']))

# Plot the relationship between the number of visits and total transactions
sns.scatterplot(x='totals.visits', y='total_transactions', data=data)

# Plot the relationship between the number of hits and total transactions
sns.scatterplot(x='totals.hits', y='total_transactions', data=data)

# Plot the relationship between the source and total transactions
sns.boxplot(x='channelGrouping', y='total_transactions', data=data)

# Plot the relationship between the device and total transactions
sns.boxplot(x='device.deviceCategory', y='total_transactions', data=data)

# Plot the relationship between the browser and total transactions
sns.boxplot(x='device.browser', y='total_transactions', data=data)
