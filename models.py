from pydantic import BaseModel

class TextIn(BaseModel):
    text: str

class ListOut(BaseModel):
    suggestions: list[str]

class TextOut(BaseModel):
    summary: str