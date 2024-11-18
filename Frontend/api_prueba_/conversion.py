import json
from datetime import datetime

# Cargar el JSON original
with open("extracted_courses.json", "r") as file:
    original_data = json.load(file)

# Función para transformar el horario al nuevo formato
def transform_schedule(schedule):
    return [
        {
            "day_of_week": day,
            "start_time": f"{time['start_time']}:00",
            "end_time": f"{time['end_time']}:00"
        }
        for time in schedule
        for day in time["days"]
    ]

# Transformar los datos al nuevo formato
transformed_data = [
    {
        "name": course["courseTitle"],
        "course_number": course["courseNumber"],
        "profesor": course["profesor"],
        "faculty_id": course["facultyAbbr"],
        "id": course["id"],
        "schedules": transform_schedule(course["schedule"])
    }
    for course in original_data
]

# Guardar el JSON transformado
with open("transformed_data.json", "w") as file:
    json.dump(transformed_data, file, indent=4)

print("Transformación completada. JSON guardado como 'transformed_data.json'")
