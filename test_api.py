import os
import requests
from dotenv import load_dotenv

load_dotenv()

api_key=os.getenv("AVIATIONSTACK_API_KEY")
URL= f"https://api.aviationstack.com/v1/flights?access_key={api_key}"
response=requests.get(URL)
data=response.json()

print(data)