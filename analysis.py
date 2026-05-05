import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

df = pd.read_csv("Customer_Churn_Dataset.csv")
df['TotalCharges'] = pd.to_numeric(df['TotalCharges'], errors='coerce')
df['LTV']=df['MonthlyCharges']* df['tenure']

print(df.head())
print(df.isnull().sum())

sns.countplot(x='Churn', data=df)
plt.title("Churn Rate")
plt.show()

sns.barplot(x='Churn', y='MonthlyCharges', data=df)
plt.title("Average Monthly Charges by Churn")
plt.show()

sns.barplot(x='Churn', y='tenure', data=df)
plt.title("Average Tenure by Churn")
plt.show()

sns.countplot(x='Contract', hue='Churn', data=df)
plt.title("Churn by Contract Type")
plt.show()

df['LTV_segment']= pd.qcut(df['LTV'], 3, labels=['Low Value', 'Medium Value', 'High Value'])

sns.countplot(x='LTV_segment', hue='Churn', data=df)
plt.title("Churn across LTV Segments")
plt.show()

df.to_csv("telco_cleaned.csv", index=False)
