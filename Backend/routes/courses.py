from fastapi import APIRouter,Depends, HTTPException
from models import Faculty, Schedule
from schema import CourseCreate,CourseResponse,CourseBase,ScheduleBase
from config.db import Session, get_db
from models import Course
from datetime import time

router = APIRouter()
@router.post("/courses", response_model=CourseResponse)  # Puedes cambiar el response_model si quieres
def create_course(course_data: CourseResponse, db: Session = Depends(get_db)): # PRESTA ATENCION AQUI USAS ESTO PARA PROBAR PERO REALMENTE ESTAS INSEGURO ACERCA DE COURSE RESPONSE YA QUE SON IGUALES JAJA
    # Verificar si el ID del curso ya existe
    existing_course = db.query(Course).filter(Course.id == course_data.id).first()
    if existing_course:
        raise HTTPException(status_code=400, detail="Course ID already exists.")

    # Crear el curso
    course = Course(
        id=course_data.id,  # Usar el ID proporcionado
        name=course_data.name,
        course_number=course_data.course_number,
        profesor = course_data.profesor,
        faculty_id=course_data.faculty_id
    )
    db.add(course)
    db.commit()  # Guardar el curso primero para obtener el ID

    # Crear los horarios
    for schedule_data in course_data.schedules:
        schedule = Schedule(
            course_id=course.id,  
            day_of_week=schedule_data.day_of_week,
            start_time=schedule_data.start_time.strftime("%H:%M") ,
            end_time=schedule_data.end_time.strftime("%H:%M")
        )
        db.add(schedule)

    db.commit()  # Guardar los horarios en la base de datos

    return course  # Retornar el curso creado

@router.get("/courses", response_model=list[CourseResponse])
def get_course(db: Session = Depends(get_db)):
    courses = db.query(Course).all()
    return courses

@router.get("/courses/{course_number}", response_model=list[CourseResponse])
async def get_course_by_number(course_number: str, db: Session = Depends(get_db)):
    course = db.query(Course).filter(Course.course_number == course_number).all()
    if course is None:
        raise HTTPException(status_code=404, detail="Course not found")
    return course


@router.get("/faculty/{faculty_id}/courses", response_model=list[CourseResponse])
async def get_courses_by_faculty(faculty_id: str, db: Session = Depends(get_db)):
    courses = db.query(Course).filter(Course.faculty_id == faculty_id).all()
    if courses is None:
        raise HTTPException(status_code=404, detail="Courses not found")
    return courses