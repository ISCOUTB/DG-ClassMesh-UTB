from pydantic import BaseModel, EmailStr

class OurBaseModel(BaseModel):
    class config():
        orm_mode = True