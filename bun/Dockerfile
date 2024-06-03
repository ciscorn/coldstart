FROM cgr.dev/chainguard/bun:latest as builder
WORKDIR /app
USER root

COPY package.json bun.lockb tsconfig.json ./
RUN [ "bun", "install" ]
COPY src/index.ts .
RUN [ "bun", "build", "index.ts", "--minify", "--outdir", "dist" ]


FROM cgr.dev/chainguard/bun:latest
WORKDIR /app
USER root

# AWS Lambda Web Adapter
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter
 
COPY --from=builder /app/dist/index.js .
ENTRYPOINT [ "bun", "run", "index.js" ]
