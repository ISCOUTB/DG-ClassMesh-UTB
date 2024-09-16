from fastapi import FastAPI

app = FastAPI()

@app.get('/',tags='Home')


def Home():
    return "Hello world"
