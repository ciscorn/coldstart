FROM cgr.dev/chainguard/python:latest-dev as builder
WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt --user



FROM cgr.dev/chainguard/python:latest
WORKDIR /app

# # AWS Lambda Web Adapter
# COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter

COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
COPY --from=builder /home/nonroot/.local/bin/gunicorn /gunicorn
COPY main.py .

ENTRYPOINT ["/gunicorn", "main:app", "-b", ":8080"]
