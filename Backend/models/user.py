from sqlalchemy import Column, String, Integer
from config.db import Base

class User(Base):
    __tablename__ = 'users'
    id = Column(String(10), primary_key=True, index=True)
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    email = Column(String(100), unique=True, index=True, nullable=False)
    password = Column(String(255), nullable=False)
    
    def full_name(self):
        return f"{self.first_name} {self.last_name}"
