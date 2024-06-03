FROM cgr.dev/chainguard/node:latest as builder
WORKDIR /app
USER root

COPY package*.json tsconfig.json ./
COPY src ./src
RUN [ "npm", "install" ]
RUN [ "npx", "tsc" ]

FROM cgr.dev/chainguard/node:latest
WORKDIR /app
USER root

# AWS Lambda Web Adapter
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter

COPY package*.json tsconfig.json ./
COPY --from=builder /app/src ./src

RUN [ "npm", "ci", "--omit=dev", "--no-audit", "--loglevel", "verbose" ]
CMD [ "src/index.js" ]
