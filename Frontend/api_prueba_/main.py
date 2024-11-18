from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
from itertools import product
from datetime import datetime
import json

from fastapi.middleware.cors import CORSMiddleware




# FastAPI app
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permitir todas las solicitudes
    allow_credentials=True,
    allow_methods=["*"],  # Permitir todos los métodos HTTP
    allow_headers=["*"],  # Permitir todos los encabezados
)

# Modelos de datos
class Schedule(BaseModel):
    days: List[str]  # Días de la semana: ["Lunes", "Miércoles"]
    start_time: str  # Hora de inicio: "08:00"
    end_time: str    # Hora de fin: "10:00"

class Course(BaseModel):
    facultyName: str
    facultyAbbr: str
    id: int
    courseNumber: str
    NRC: str
    courseTitle: str
    schedule: List[Schedule]

# Función para cargar los cursos desde el archivo JSON
def cargar_cursos_desde_archivo(nombre_archivo: str) -> List[Course]:
    with open(nombre_archivo, "r", encoding="utf-8") as file:
        data = json.load(file)
    return [Course(**course) for course in data]

# Función para verificar si dos horarios se solapan
def horarios_se_solapan(horario1: Schedule, horario2: Schedule) -> bool:
    # Verifica si comparten algún día
    dias_comunes = set(horario1.days).intersection(horario2.days)
    if not dias_comunes:
        return False

    # Convertir las horas a datetime para facilitar comparación
    formato_hora = "%H:%M"
    inicio1 = datetime.strptime(horario1.start_time, formato_hora)
    fin1 = datetime.strptime(horario1.end_time, formato_hora)
    inicio2 = datetime.strptime(horario2.start_time, formato_hora)
    fin2 = datetime.strptime(horario2.end_time, formato_hora)

    # Revisar si los horarios se solapan
    return not (fin1 <= inicio2 or inicio1 >= fin2)

# Función para verificar si una combinación de horarios es válida
def es_combinacion_valida(combinacion: List[Schedule]) -> bool:
    for i in range(len(combinacion)):
        for j in range(i + 1, len(combinacion)):
            if horarios_se_solapan(combinacion[i], combinacion[j]):
                return False
    return True

# Función para generar combinaciones válidas
def generar_combinaciones_validas(courses: List[Course]) -> List[List[Schedule]]:
    # Obtén las posibles combinaciones de horarios de cada curso
    posibles_horarios = [course.schedule for course in courses]
    combinaciones = product(*posibles_horarios)  # Genera el producto cartesiano

    combinaciones_validas = []
    for combinacion in combinaciones:
        # Verifica si hay conflictos entre los horarios de la combinación
        if es_combinacion_valida(combinacion):
            combinaciones_validas.append(combinacion)

    return combinaciones_validas

# Endpoint para generar combinaciones de horarios
@app.get("/generate-combinations/")
def generate_combinations():
    # Cargar cursos desde el archivo JSON
    nombre_archivo = "extracted_courses.json"
    courses = cargar_cursos_desde_archivo(nombre_archivo)

    # Generar combinaciones válidas
    combinaciones_validas = generar_combinaciones_validas(courses)
    
    # Formatear la respuesta
    return {
        "total_combinations": len(combinaciones_validas),
        "combinations": [
            [
                {
                    "days": schedule.days, 
                    "start_time": schedule.start_time, 
                    "end_time": schedule.end_time
                } 
                for schedule in combinacion
            ]
            for combinacion in combinaciones_validas
        ]
    }
