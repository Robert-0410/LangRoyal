from typing import Union

from fastapi import FastAPI

import random

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}


@app.get("/perform")
def perform():
    a = random.randint(0, 10000)
    b = random.randint(1, 10000)
    return {
        "num1": a,
        "num2": b,
        "addition" : a + b,
        "subtraction" : a - b,
        "multiplication" : a * b,
        "division" : a / b
    }
