from fastapi import APIRouter,Depends
from models import User
from schema import UserResponse,CreateUser
from config.db import get_db, Session

router =APIRouter()

@router.get("/users",response_model=list[UserResponse])
def get_users(db:Session = Depends(get_db) ):
    users = db.query(User).all()
    return users


@router.post("/users",response_model=UserResponse)
def add_user(user:CreateUser,db:Session=Depends(get_db)):
    new_user = User(id = user.id,first_name = user.first_name, last_name = user.last_name, email = user.email, password = user.password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user