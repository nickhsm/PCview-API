import os
from dotenv import load_dotenv

load_dotenv()

documentation_url = os.environ.get("DOCS_URL", None)
cors_origins = os.environ.get("ALLOWED_ORIGINS", "*")
db_connection = os.environ.get("DB_CONNECTION")
