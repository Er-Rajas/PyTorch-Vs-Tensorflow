import pandas as pd
from joblib import load
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
import numpy as np


# Load model
model = load(r"D:\Project\Major Project\Energy Forecasting\model\rf_model.pkl")

# Load synthetic data
df = pd.read_csv("D:\Project\Major Project\Energy Forecasting\data\processed\synthetic_solar_data.csv", parse_dates=['DATE_TIME'])

print(df.columns)

# Separate features
X_test = df[[
    'AMBIENT_TEMPERATURE', 'MODULE_TEMPERATURE', 'IRRADIATION',
    'DC_PER_IRR', 'HOUR_SIN', 'HOUR_COS', 'IS_NIGHT', 'DAWN_DUSK',
    'TEMP_DIFF', 'IRR_15MIN_AGO', 'TEMP_30MIN_AGO', 'DAY_OF_WEEK',
    'IS_WEEKEND'
]]

# Predict
y_pred = model.predict(X_test)

# Add predicted column to DataFrame
df['DC_POWER_PREDICTED'] = y_pred

# Visualize
import matplotlib.pyplot as plt

plt.figure(figsize=(12,5))
plt.plot(df['DATE_TIME'], df['DC_POWER'], label='Actual', linewidth=2)
plt.plot(df['DATE_TIME'], df['DC_POWER_PREDICTED'], label='Predicted', linestyle='--')
plt.xlabel('Time')
plt.ylabel('DC Power (kW)')
plt.title('DC Power Forecast on Synthetic 25W System')
plt.legend()
plt.grid(True)
plt.show()


# y_true and y_pred must already be defined
y_true = df['DC_POWER']                     # actual value from your synthetic data
y_pred = df['DC_POWER_PREDICTED']           # predicted by your ML model

# Metrics
mae = mean_absolute_error(y_true, y_pred)
print("RMSE:", np.sqrt(mean_squared_error(y_true, y_pred)))  # squared=False gives RMSE
r2 = r2_score(y_true, y_pred)

# Print them
print(f"Evaluation Metrics on Synthetic Data:")
print(f" R² Score: {r2:.4f}")
print(f" MAE     : {mae:.4f} kW")
# print(f" RMSE    : {rmse:.4f} kW")