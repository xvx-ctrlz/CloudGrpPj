from fastapi import FastAPI
from databases import Database
import os
from dotenv import load_dotenv

load_dotenv()  # Load environment variables

# Database connection details
DATABASE_URL = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"

app = FastAPI()

# Initialize the database
database = Database(DATABASE_URL)

@app.on_event("startup")
async def startup():
    await database.connect()

@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

@app.get("/health")
async def health_check():
    return {"status": "up"}

# Example route to fetch something from your database
@app.get("/data")
async def get_data():
    query = "SELECT * FROM your_table LIMIT 1"  # Adjust query to your needs
    return await database.fetch_one(query)
