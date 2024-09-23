from .base import OurBaseModel


class FacultyCreate(OurBaseModel):
    id: str
    name: str

class FacultyResponse(OurBaseModel):
    id: str
    name: str

