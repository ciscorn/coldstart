IMAGE_PREFIX = asia-northeast1-docker.pkg.dev/hello-cloud-run-1234/cloud-run-source-deploy/hello-world

deploy-python:
	docker buildx build ./python/ --platform linux/amd64 -t ${IMAGE_PREFIX}-python:latest
	docker push ${IMAGE_PREFIX}-python:latest
	gcloud run deploy hello-world-python \
		--image=${IMAGE_PREFIX}-python:latest \
		--region=asia-northeast1 \
		--allow-unauthenticated

deploy-go:
	docker buildx build ./go/ --platform linux/amd64 -t ${IMAGE_PREFIX}-go:latest
	docker push ${IMAGE_PREFIX}-go:latest
	gcloud run deploy hello-world-go \
		--image=${IMAGE_PREFIX}-go:latest \
		--region=asia-northeast1 \
		--allow-unauthenticated

deploy-bun:
	docker buildx build  ./bun/ --platform linux/amd64 -t ${IMAGE_PREFIX}-bun:latest
	docker push ${IMAGE_PREFIX}-bun:latest
	gcloud run deploy hello-world-bun \
		--image=${IMAGE_PREFIX}-bun:latest \
		--region=asia-northeast1 \
		--allow-unauthenticated

deploy-rust:
	docker buildx build  ./rust/ --platform linux/amd64 -t ${IMAGE_PREFIX}-rust:latest
	docker push ${IMAGE_PREFIX}-rust:latest
	gcloud run deploy hello-world-rust \
		--image=${IMAGE_PREFIX}-rust:latest \
		--region=asia-northeast1 \
		--allow-unauthenticated
