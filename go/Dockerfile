FROM cgr.dev/chainguard/go:latest as build
WORKDIR /work

COPY go.mod main.go ./
ENV CGO_ENABLED=0
RUN go build -o hello .



FROM cgr.dev/chainguard/static:latest

# # AWS Lambda Web Adapter
# COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter

COPY --from=build /work/hello /hello
CMD ["/hello"]
