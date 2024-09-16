from sqlalchemy import Column, String, Integer, JSON
from config.db import Base

class Course(Base):

    __tablename__ = 'courses'
    NRC = Column(Integer,primary_key=True, index = True)
    name = Column(String(50))
    course_number = Column(String(50))
    faculty = Column(String(50))
    schedule = Column(JSON)
