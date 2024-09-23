from fastapi import APIRouter,Depends
from models import Faculty
from schema import FacultyCreate, FacultyResponse
from config.db import Session, get_db


router = APIRouter()

@router.get("/faculties", response_model=list[FacultyResponse])
def get_faculties(db: Session = Depends(get_db)):
    faculties = db.query(Faculty).all()
    return faculties

@router.post("/faculties",response_model=FacultyResponse)
def add_faculty(faculty: FacultyCreate, db: Session = Depends(get_db)):
    new_faculty = Faculty(id = faculty.id,name=faculty.name)
    db.add(new_faculty)
    db.commit()
    db.refresh(new_faculty)
    return new_faculty