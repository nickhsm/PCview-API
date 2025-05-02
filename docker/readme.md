# API Bestandstructuur

om de docker container(s) correct te laten werken hebben we volgende bestandstructuur nodig:

- `docker-compose.yml`
- **app/**
  - **AI-models/**
    - `class_names.json`
    - `trained_model.keras`
  - **models/**
    - `post_upload_image.py`
  - `.env`
  - `config.py`
  - `detector.py`
  - `Dockerfile`
  - `main.py`
  - `quiz.json`
  - `requirements.txt`
