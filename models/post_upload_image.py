import pydantic


class Image(pydantic.BaseModel):
    filename: str
    image: str
