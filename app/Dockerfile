FROM python:3.11-slim-bookworm

WORKDIR /app

COPY requirements.txt .

# Install runtime dependencies, then remove pip/setuptools/wheel from the final
# image. Flask and gunicorn do not need them at runtime, and their vendored
# copies (pip bundles setuptools 70.3.0 and msgpack) are what Trivy flags.
RUN pip install --no-cache-dir -r requirements.txt \
    && python -m pip uninstall -y setuptools wheel \
    && python -m pip uninstall -y pip \
    && rm -rf /root/.cache/pip

COPY app.py .

RUN useradd --create-home appuser

USER appuser

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]