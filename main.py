from fastapi import FastAPI
from routes import router
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router)

# to run:
# uvicorn main:app --reload
# ngrok http --domain=logical-witty-ocelot.ngrok-free.app 8000