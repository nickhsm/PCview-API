import fastapi
import base64
import detector
import config
from fastapi.middleware.cors import CORSMiddleware

from models.post_upload_image import Image


app = fastapi.FastAPI(docs_url=config.documentation_url)

origins = config.cors_origins.split(",")

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/upload")
def query_image(image: Image):
    """
    Give it a base64 encoded image and this function will return the following (example):
    {
        "result": {
            "class": "CPU",
            "score": 99.9945297241211
        }
    }
    """
    base64_string = image.image

    image_blob = base64.b64decode(base64_string)

    return_data = detector.detect_picture(image_blob)

    return {"result": return_data}
