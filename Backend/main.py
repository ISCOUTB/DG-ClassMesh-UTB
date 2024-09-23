from fastapi import FastAPI, Depends, HTTPException
from config.db import engine, Base, get_db
from routes import faculty,users, courses

app = FastAPI()
Base.metadata.create_all(bind=engine)


app.include_router(faculty.router)
app.include_router(users.router)
app.include_router(courses.router)
@app.get("/items/{item_id}")
async def read_item(item_id):
    return {"item_id": item_id}


