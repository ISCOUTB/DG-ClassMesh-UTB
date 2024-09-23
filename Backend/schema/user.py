from .base import OurBaseModel,EmailStr
class CreateUser(OurBaseModel):
    id: str
    first_name:str
    last_name:str
    email: EmailStr
    password: str

class UserResponse(OurBaseModel):
    id: str
    fullname: str
    email: EmailStr

    @staticmethod
    def from_orm(user):
        return UserResponse(
            id=user.codigo,
            fullname=f"{user.first_name} {user.last_name}",
            email=user.email
        )
