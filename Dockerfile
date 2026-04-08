FROM python:3.11-slim

WORKDIR /workspace

COPY pyproject.toml README.md ./
COPY app ./app
COPY config ./config
COPY docs ./docs

RUN pip install --no-cache-dir -e .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
