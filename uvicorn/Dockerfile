FROM cgr.dev/chainguard/python:latest-dev as builder
USER root
WORKDIR /app

# TODO: Use rye or uv?
COPY requirements.lock pyproject.toml README.md ./
RUN python -m venv venv
ENV PATH=/app/venv/bin:$PATH
RUN pip install -r requirements.lock
# RUN ["python", "-m", "compileall", "venv"]


FROM cgr.dev/chainguard/python:latest
WORKDIR /app

# # AWS Lambda Web Adapter
# COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter
 
COPY --from=builder /app/venv /app/venv
ENV PATH=/app/venv/bin:$PATH
COPY ./src/ .

ENTRYPOINT ["python", "-m", "gunicorn", "hello:app", "-k", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0:8080"]
