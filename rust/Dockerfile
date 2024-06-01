FROM cgr.dev/chainguard/rust:latest as builder
USER root
WORKDIR /app

COPY Cargo.toml Cargo.lock ./
COPY src/ ./src/
RUN RUSTFLAGS="-C target-feature=+crt-static" cargo build --release --target x86_64-unknown-linux-gnu


FROM cgr.dev/chainguard/static:latest

# # AWS Lambda Web Adapter
# COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter

COPY --from=builder /app/target/x86_64-unknown-linux-gnu/release/hello-world /hello-world
CMD ["/hello-world"]
