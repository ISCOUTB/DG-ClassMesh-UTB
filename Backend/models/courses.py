from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from config.db import Base

class Course(Base):
    __tablename__ = 'courses'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100),nullable = False)
    course_number = Column(String(10),nullable = False)
    profesor = Column(String(50), nullable = True, index = True )
    faculty_id = Column(String(8), ForeignKey('faculties.id'),nullable = False)
    faculty = relationship('Faculty', back_populates='courses')
    schedules = relationship('Schedule', back_populates='course')