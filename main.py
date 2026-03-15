from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(title="Bluedemo API", version="1.0.0")

# 配置 CORS，允许微信小程序跨域请求
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class NameRequest(BaseModel):
    name: str


@app.get("/")
async def root():
    return {"message": "Bluedemo API Service"}


@app.post("/api/hello")
async def hello(name_request: NameRequest):
    """
    接收 name 参数，返回 Hello Word + name
    """
    return {"message": f"Hello Word {name_request.name}"}
