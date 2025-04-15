import tensorflow as tf
import PIL
import numpy as np
import json
import io

def detect_picture(image_data):
    model = tf.keras.models.load_model("AI-models/trained_model.keras")

    with open("AI-models/class_names.json", "r", encoding="UTF-8") as file:
        dictionary = json.load(file)

    class_names = dictionary["classes"]

    img_height = 180
    img_width = 180

    img = PIL.Image.open(io.BytesIO(image_data)).resize((img_height, img_width))

    img_array = tf.keras.utils.img_to_array(img)
    img_array = tf.expand_dims(img_array, 0)

    predictions = model.predict(img_array)
    score = tf.nn.softmax(predictions[0])

    return {"class": class_names[np.argmax(score)], "score": float(100 * np.max(score))}
