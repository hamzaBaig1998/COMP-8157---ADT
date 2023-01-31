import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

# Load the dataset
df = pd.read_csv('sandp500.csv')

# Convert the date column to a pandas datetime index
df['date'] = pd.to_datetime(df['date'])
df = df.set_index('date')

# Plot the close price over time
plt.plot(df['close'])
plt.xlabel('Year')
plt.ylabel('Close Price')
plt.title('S&P 500 Index Close Price over Time')
plt.show()

# Split the data into training and testing sets
train = df[:int(0.8*(len(df)))]
test = df[int(0.8*(len(df))):]

# Train a linear regression model on the training data
regressor = LinearRegression()
regressor.fit(np.array(train.index).reshape(-1, 1), train['close'])

# Use the trained model to make predictions on the test data
predictions = regressor.predict(np.array(test.index).reshape(-1, 1))

# Evaluate the model's performance
mse = mean_squared_error(test['close'], predictions)
r2 = r2_score(test['close'], predictions)
print(f'Mean Squared Error: {mse}')
print(f'R^2 Score: {r2}')

# Plot the actual and predicted close prices
plt.plot(test.index, test['close'], label='Actual Close Price')
plt.plot(test.index, predictions, label='Predicted Close Price')
plt.xlabel('Year')
plt.ylabel('Close Price')
plt.title('S&P 500 Index Close Price: Actual vs. Predicted')
plt.legend()
plt.show()
