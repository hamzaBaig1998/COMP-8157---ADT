import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report

# Load the IBM HR Analytics Employee Attrition dataset into a pandas dataframe
df = pd.read_csv("https://www.kaggle.com/pavansubhasht/ibm-hr-analytics-attrition-dataset")

# Visualize the distribution of the target variable (Attrition)
sns.countplot(df['Attrition'])
plt.show()

# Prepare the features and target variable for the model
features = df.drop(['Attrition'], axis=1)
target = df['Attrition']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=0)

# Train a logistic regression model on the training data
model = LogisticRegression()
model.fit(X_train, y_train)

# Make predictions on the testing data
y_pred = model.predict(X_test)

# Evaluate the model using classification report
print(classification_report(y_test, y_pred))
