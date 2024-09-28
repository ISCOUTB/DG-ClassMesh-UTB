from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Permitir solicitudes CORS
origins = [
    "http://localhost:8000",  # Flutter local
    "http://127.0.0.1:8000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Base de datos simulada
courses_db = {
    "csb": [
        {
            "name": "Calculo",
            "abbreviation": "cal",
            "monday": True,
            "tuesday": False,
            "wednesday": True,
            "thursday": False,
            "friday": True,
            "start_time": "08:00",
            "end_time": "09:50"
        },
        {
            "name": "Matematicas",
            "abbreviation": "mat",
            "monday": True,
            "tuesday": True,
            "wednesday": False,
            "thursday": False,
            "friday": True,
            "start_time": "10:00",
            "end_time": "11:50"
        },
        # Agrega más cursos según sea necesario
    ],
    "ing": [
        {
            "name": "Programacion",
            "abbreviation": "prog",
            "monday": True,
            "tuesday": True,
            "wednesday": True,
            "thursday": False,
            "friday": False,
            "start_time": "12:00",
            "end_time": "13:50"
        },
        # Agrega más cursos según sea necesario
    ],
    "hum": [
        {
            "name": "Historia",
            "abbreviation": "hist",
            "monday": False,
            "tuesday": True,
            "wednesday": False,
            "thursday": True,
            "friday": False,
            "start_time": "14:00",
            "end_time": "15:50"
        },
        # Agrega más cursos según sea necesario
    ],
}

faculties_db = [
    {"id": 1, "name": "Facultad de Ciencias Basicas", "abbreviation": "csb"},
    {"id": 2, "name": "Facultad de Ingenieria", "abbreviation": "ing"},
    {"id": 3, "name": "Facultad de Humanidades", "abbreviation": "hum"},
]

class Course(BaseModel):
    name: str
    abbreviation: str
    monday: bool
    tuesday: bool
    wednesday: bool
    thursday: bool
    friday: bool
    start_time: str  # Formato HH:MM
    end_time: str    # Formato HH:MM

class Faculty(BaseModel):
    id: int
    name: str
    abbreviation: str

@app.get("/faculties", response_model=List[Faculty])
def get_faculties():
    return faculties_db

@app.get("/faculties/{faculty_abbr}/courses", response_model=List[Course])
def get_courses(faculty_abbr: str):
    # Comprobar si la abreviatura existe en la base de datos de cursos
    if faculty_abbr in courses_db:
        return courses_db[faculty_abbr]
    else:
        # Si la abreviatura no se encuentra, devolver error 404
        raise HTTPException(status_code=404, detail="Faculty not found")
