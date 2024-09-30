from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from config.db import Base

class Faculty(Base):
    __tablename__ = 'faculties'
    id = Column(String(8), primary_key=True, index=True)      
    name = Column(String(100), unique=True, nullable=False) 
    courses = relationship('Course', back_populates='faculty')
