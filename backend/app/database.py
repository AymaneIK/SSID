from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

# Use SQLite for easy local development without installing external database servers
SQLALCHEMY_DATABASE_URL = "sqlite:///./ssid.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
