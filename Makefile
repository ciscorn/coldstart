IMAGE_PREFIX = asia-northeast1-docker.pkg.dev/hello-cloud-run-1234/cloud-run-source-deploy/hello-world


## gcloud auth configure-docker asia-northeast1-docker.pkg.dev


deploy-go:
	docker buildx build ./go/ --platform linux/amd64 -t ${IMAGE_PREFIX}-go:latest
	docker push ${IMAGE_PREFIX}-go:latest
	gcloud run deploy hello-world-go \
		--image=${IMAGE_PREFIX}-go:latest \
		--region=asia-northeast1 \
		--memory=128Mi \
		--allow-unauthenticated

deploy-bun:
	docker buildx build  ./bun/ --platform linux/amd64 -t ${IMAGE_PREFIX}-bun:latest
	docker push ${IMAGE_PREFIX}-bun:latest
	gcloud run deploy hello-world-bun \
		--image=${IMAGE_PREFIX}-bun:latest \
		--region=asia-northeast1 \
		--memory=128Mi \
		--allow-unauthenticated

deploy-rust:
	docker buildx build  ./rust/ --platform linux/amd64 -t ${IMAGE_PREFIX}-rust:latest
	docker push ${IMAGE_PREFIX}-rust:latest
	gcloud run deploy hello-world-rust \
		--image=${IMAGE_PREFIX}-rust:latest \
		--region=asia-northeast1 \
		--memory=128Mi \
		--allow-unauthenticated

deploy-gunicorn:
	docker buildx build ./gunicorn/ --platform linux/amd64 -t ${IMAGE_PREFIX}-gunicorn:latest
	docker push ${IMAGE_PREFIX}-gunicorn:latest
	gcloud run deploy hello-world-gunicorn \
		--image=${IMAGE_PREFIX}-gunicorn:latest \
		--region=asia-northeast1 \
		--memory=128Mi \
		--allow-unauthenticated

deploy-uvicorn:
	docker buildx build ./uvicorn/ --platform linux/amd64 -t ${IMAGE_PREFIX}-uvicorn:latest
	docker push ${IMAGE_PREFIX}-uvicorn:latest
	gcloud run deploy hello-world-uvicorn \
		--image=${IMAGE_PREFIX}-uvicorn:latest \
		--region=asia-northeast1 \
		--memory=128Mi \
		--allow-unauthenticated
