from .base import OurBaseModel
from datetime import time

class ScheduleBase(OurBaseModel):
    day_of_week: str
    start_time: time
    end_time: time


