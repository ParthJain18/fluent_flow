from fastapi import APIRouter, HTTPException, UploadFile, File, Form
from fastapi.responses import JSONResponse
from models import TextIn, TextOut, ListOut
from controller import suggestion_pipeline, test_gen
from vertex_api import summarize
import json
from PIL import Image
import pytesseract
import io
from language_dict import languages

router = APIRouter()

@router.post("/suggestions", response_model=ListOut)
async def suggest_replies(text_in: TextIn):
    print(f"Received request: {text_in}")
    try:
        suggestions = suggestion_pipeline(text_in.text)
        # suggestions = test_gen(text_in.text)
        if suggestions is None:
            return JSONResponse(content={"suggestions": []})
        suggestions = json.loads(suggestions)
        return JSONResponse(content={"suggestions": suggestions})
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail=str(e))
    
@router.post("/summarize", response_model=TextOut)
async def summarize_conversation(text_in: TextIn):
    print(f"Received request: {text_in}")
    try:
        summary = summarize(text_in.text)
        # summary = test_gen(text_in.text)
        return JSONResponse(content={"suggestions": summary})
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@router.post("/extract_text")
async def extract_text_from_image(lang: str = Form(...), file: UploadFile = File(...)):
    print(lang)
    contents = await file.read()
    image = Image.open(io.BytesIO(contents))
    image.save('debug.jpg')
    text = pytesseract.image_to_string(image, lang=languages[lang])
    print("text: ", text)
    return {"text": text}