import os
import json
import requests
import snowflake.connector
from dotenv import load_dotenv

load_dotenv()

# --- Secrets, same pattern as test_api.py ---
api_key = os.getenv("AVIATIONSTACK_API_KEY")
sf_account = os.getenv("SNOWFLAKE_ACCOUNT")
sf_user = os.getenv("SNOWFLAKE_USER")
sf_password = os.getenv("SNOWFLAKE_PASSWORD")
sf_warehouse = os.getenv("SNOWFLAKE_WAREHOUSE")
sf_database = os.getenv("SNOWFLAKE_DATABASE")
sf_schema = os.getenv("SNOWFLAKE_SCHEMA")

# --- Pull data (identical to what test_api.py already does) ---
url = f"https://api.aviationstack.com/v1/flights?access_key={api_key}"
response = requests.get(url)
response.raise_for_status()
data = response.json()

# --- Connect to Snowflake ---
conn = snowflake.connector.connect(
    account=sf_account,
    user=sf_user,
    password=sf_password,
    warehouse=sf_warehouse,
    database=sf_database,
    schema=sf_schema
)
cursor = conn.cursor()

# --- Create Bronze table if it doesn't exist yet ---
cursor.execute("""
CREATE TABLE IF NOT EXISTS raw_flights (
    raw_data VARIANT,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
""")

# --- Insert the whole raw JSON blob as one VARIANT row ---
cursor.execute(
    "INSERT INTO raw_flights (raw_data) SELECT PARSE_JSON(%s)",
    (json.dumps(data),)
)

print(f"Inserted a batch of {len(data.get('data', []))} flight records.")

cursor.close()
conn.close()