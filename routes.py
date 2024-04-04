from fastapi import APIRouter, HTTPException
from fastapi.responses import JSONResponse
from models import TextIn, TextOut, ListOut
from controller import suggestion_pipeline
from vertex_api import summarize
import json

router = APIRouter()

@router.post("/suggestions", response_model=ListOut)
async def suggest_replies(text_in: TextIn):
    print(f"Received request: {text_in}")
    try:
        suggestions = suggestion_pipeline(text_in.text)
        if suggestions is None:
            return JSONResponse(content={"suggestions": []})
        suggestions = json.loads(suggestions)
        return JSONResponse(content={"suggestions": suggestions})
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@router.post("/summarize", response_model=TextOut)
async def summarize_conversation(text_in: TextIn):
    print(f"Received request: {text_in}")
    try:
        summary = summarize(text_in.text)
        return JSONResponse(content={"suggestions": summary})
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))