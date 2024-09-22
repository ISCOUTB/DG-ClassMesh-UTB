from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from config.db import Base

class Course(Base):
    __tablename__ = 'courses'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50))
    course_number = Column(String(50))

    faculty_id = Column(Integer, ForeignKey('faculties.id'))

    faculty = relationship('Faculty', back_populates='courses')

    schedules = relationship('Schedule', back_populates='course')