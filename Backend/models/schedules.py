from sqlalchemy import Column, Integer, String, Time, ForeignKey, Date
from sqlalchemy.orm import relationship
from config.db import Base

class Schedule(Base):
    __tablename__ = 'schedules'
    id = Column(Integer, primary_key=True, index=True)       # ID autoincremental
    course_id = Column(Integer, ForeignKey('courses.id'))    # Relación con Course
    day_of_week = Column(String(10))                         # Día de la semana (Lunes, Martes, etc.)
    start_time = Column(Time)                                # Hora de inicio
    end_time = Column(Time)                                  # Hora de finalización
    start_date = Column(Date)                                # Fecha de inicio
    end_date = Column(Date)                                  # Fecha de finalización

    # Relación inversa con el curso
    course = relationship('Course', back_populates='schedules')