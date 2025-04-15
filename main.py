import fastapi
import base64
import detector

from models.post_upload_image import Image


app = fastapi.FastAPI(docs_url=None)


@app.post("/upload")
def query_image(image: Image):
    base64_string = image.image

    image_blob = base64.b64decode(base64_string)

    return_data = detector.detect_picture(image_blob)

    return {"result": return_data}
