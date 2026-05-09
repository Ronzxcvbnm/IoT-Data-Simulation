import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Number of records
num_records = 100

# Sample status options
statuses = ["In Transit", "Delivered", "Pending", "Delayed"]

# Store generated data
data = []

for _ in range(num_records):
    record = {
        # Random timestamp within last 24 hours
        "timestamp": datetime.now() - timedelta(
            minutes=np.random.randint(0, 1440)
        ),

        # Random package ID
        "package_id": np.random.randint(1000, 9999),

        # Random latitude (Philippines area sample)
        "latitude": round(np.random.uniform(5.0, 20.0), 6),

        # Random longitude (Philippines area sample)
        "longitude": round(np.random.uniform(115.0, 126.0), 6),

        # Random temperature for cold-chain monitoring
        "temperature": round(np.random.uniform(2.0, 8.0), 2),

        # RFID Tag
        "rfid_tag": f"RFID_{np.random.randint(0, 500)}",

        # Random shipment status
        "status": np.random.choice(statuses)
    }

    data.append(record)

# Convert to DataFrame
df = pd.DataFrame(data)

# Save files
df.to_csv("iot_data.csv", index=False)
df.to_json("iot_data.json", orient="records")

# Display first rows
print(df.head())