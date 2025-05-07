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
def get_quiz_answer(classname: str):
    """
    This will give quiz questions and answers in json format.
    """
    query = quiz_explanation.quiz_query
    neon_answer = database.execute_sql_query(query, (classname,))

    if isinstance(neon_answer, Exception):
        return neon_answer, 500

    return_dictionary = {"lijst met vragen": []}
    lijst_met_vragen = return_dictionary["lijst met vragen"]

    dictionary_to_add_lijst_met_vragen = {}
    # This will be used for adding to te list above ^
    answer_list = []
    # This will contain the answer and correctness the be added to the list above ^
    to_be_added_to_answer_list = {}

    question = neon_answer[0][0]

    for line_from_sql in neon_answer:
        line_1_question = line_from_sql[0]
        line_2_explanation = line_from_sql[1]
        line_3_correct = line_from_sql[2]
        line_4_answer = line_from_sql[3]

        # reset everything
        if line_1_question != question:
            dictionary_to_add_lijst_met_vragen["antwoorden"] = answer_list
            answer_list = []
            lijst_met_vragen.append(dictionary_to_add_lijst_met_vragen)
            dictionary_to_add_lijst_met_vragen = {}
            question = line_1_question

        if line_1_question == question:
            dictionary_to_add_lijst_met_vragen["vraag"] = line_1_question
            dictionary_to_add_lijst_met_vragen["uitleg"] = line_2_explanation

            to_be_added_to_answer_list["antwoord"] = line_4_answer
            to_be_added_to_answer_list["juist"] = line_3_correct
            answer_list.append(to_be_added_to_answer_list)
            to_be_added_to_answer_list = {}

    # reset everything
    dictionary_to_add_lijst_met_vragen["antwoorden"] = answer_list
    answer_list = []
    lijst_met_vragen.append(dictionary_to_add_lijst_met_vragen)
    dictionary_to_add_lijst_met_vragen = {}
    question = line_1_question

    return return_dictionary

@app.get("/uitleg")
def post_quiz_explanation(type: str):
    """
    This will give an explanation about the component of a PC.
    """
    query = quiz_explanation.quiz_explanation_query
    neon_anwser = database.execute_sql_query(query, (type,))

    if isinstance(neon_anwser, Exception):
        return neon_anwser, 500

    return {"explanation": neon_anwser[0][0]}
