import io
import fastapi
import base64
from PIL import Image, ImageOps
from fastapi.middleware.cors import CORSMiddleware
import detector
import config
import json
import database

from models.post_upload_image import UserPicture
from queries import quiz_explanation


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
def query_image(image: UserPicture):
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

    # Make image square
    new_image = io.BytesIO()
    with Image.open(io.BytesIO(image_blob)) as image_to_edit:
        # Get size
        real_size = image_to_edit.size
        # Make size square
        new_size = (max(real_size[0], real_size[1]), max(real_size[0], real_size[1]))

        # Pad with white make square
        image_to_edit = ImageOps.pad(image_to_edit, new_size, color="#000")

        # Save to memory
        image_to_edit.save(new_image, format="jpeg")

    return_data = detector.detect_picture(new_image)

    return {"result": return_data}

@app.get("/quiz")
def get_quiz_awswers():
    """
    This will give quiz questions and answers in json format.
    """
    with open("quiz.json", encoding="UTF-8") as file:
        return json.load(file)

@app.get("/quiz/uitleg")
def post_quiz_explanation(type: str):
    """
    This will give an explanation about the component of a PC.
    """
    query = quiz_explanation.quiz_explanation_query
    neon_anwser = database.execute_sql_query(query, (type,))

    if isinstance(neon_anwser, Exception):
        return neon_anwser, 500

    return {"explanation": neon_anwser[0][0]}
