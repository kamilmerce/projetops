FROM python:3.13.0-alpine3.20

WORKDIR /app

COPY sum.py /app/sum.py

ENTRYPOINT ["python", "/app/sum.py"]
