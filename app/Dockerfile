FROM python:3.11-slim-bookworm

WORKDIR /app

COPY requirements.txt .

RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir --force-reinstall --upgrade \
        "setuptools>=78.1.1" \
        "msgpack>=1.2.1" \
    && python -c "import msgpack, setuptools; print('msgpack:', msgpack.__version__); print('setuptools:', setuptools.__version__)" \
    && rm -rf /root/.cache/pip

COPY app.py .

RUN useradd --create-home appuser

USER appuser

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]