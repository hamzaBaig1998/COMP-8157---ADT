import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

# Load the S&P 500 Index dataset
df = pd.read_csv('sandp500.csv')

# Pre-process the data
df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')
df.set_index('date', inplace=True)
df['close'] = df['close'].astype(float)
df['close'] = df['close'].rolling(window=10).mean() # Use a rolling mean of 10 days
df.dropna(inplace=True)

# Split the data into training and test sets
X = df.index
y = df['close']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

# Train the linear regression model
regressor = LinearRegression()
regressor.fit(X_train.to_frame(), y_train)

# Make predictions on the test set
y_pred = regressor.predict(X_test.to_frame())

# Plot the actual and predicted stock prices
plt.plot(X_test, y_test, color='red', label='Actual Stock Price')
plt.plot(X_test, y_pred, color='blue', label='Predicted Stock Price')
plt.title('Stock Price Prediction')
plt.xlabel('Date')
plt.ylabel('Stock Price')
plt.legend()
plt.show()
