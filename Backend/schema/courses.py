from .base import OurBaseModel
from .schedules import ScheduleBase
from typing import List

class CourseBase(OurBaseModel):
    name: str
    course_number: str
    profesor: str
    faculty_id: str


class CourseCreate(CourseBase):
    schedules: List[ScheduleBase]  # Incluye los horarios como una lista

class CourseResponse(CourseBase):
    id: int
    schedules: List[ScheduleBase]  # Para incluir los horarios en la respuesta
