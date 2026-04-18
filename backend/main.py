from fastapi import FastAPI
from app.routers import profile, directory, dashboard
from app.database import engine, Base

# Create DB Tables
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="SSID Backend API",
    description="Backend API for the SSID Flutter Mobile App",
    version="1.0.0"
)

# Include routers
app.include_router(profile.router)
app.include_router(directory.router)
app.include_router(dashboard.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to SSID Backend API! Modules connected: Dashboard, Profile, Directory."}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
