import pydantic


class UserPicture(pydantic.BaseModel):
    filename: str
    image: str
