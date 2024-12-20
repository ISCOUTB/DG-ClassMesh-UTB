from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.ext.declarative import declarative_base
from typing import Generator


URL_DB = "postgresql://postgres:postgres@127.0.0.1:5432/postgres"
engine = create_engine(URL_DB)

SessionLocal = sessionmaker(autocommit = False,autoflush = False, bind = engine)


Base = declarative_base()

def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()