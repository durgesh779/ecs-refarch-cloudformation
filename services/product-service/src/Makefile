all: run

name = ecs-refarch-cloudformation/product-service
registry ?= <your-account-id>.dkr.ecr.<region>.amazonaws.com
version ?= latest

# 1. Separated the binary and image targets
binary:
	$(call blue, "Building Linux binary...")
	docker run --rm -v "$(CURDIR)":/app -w /app golang:1.26 sh -c 'CGO_ENABLED=0 go build -o app main.go'

# 2. Re-added the missing 'image' target
image: binary
	$(call blue, "Building docker image...")
	docker build -t ${name}:${version} .
	$(MAKE) clean

run: image
	$(call blue, "Running Docker image locally...")
	docker run -i -t --rm -p 8001:8001 ${name}:${version} 

# 3. Updated to tag the specific version instead of 'latest'
publish: image
	$(call blue, "Publishing Docker image to registry...")
	docker tag ${name}:${version} ${registry}/${name}:${version}
	docker push ${registry}/${name}:${version} 

clean: 
	@rm -f app 

define blue
	@if [ -t 1 ]; then tput setaf 6; fi
	@echo $1
	@if [ -t 1 ]; then tput sgr0; fi
endef