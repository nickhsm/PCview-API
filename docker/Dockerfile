FROM python:3.11

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
EXPOSE 8000/tcp 8000/udp


CMD ["uvicorn", "main:app","--proxy-headers", "--host", "0.0.0.0", "--port", "8000"]
