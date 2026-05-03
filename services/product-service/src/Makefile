all: run

# This makefile contains some convenience commands for deploying and publishing.

# For example, to build and run the docker container locally, just run:
# $ make

# or to publish the :latest version to the specified registry as :1.0.0, run:
# $ make publish version=1.0.0

name = ecs-refarch-cloudformation/product-service
registry ?= <your-account-id>.dkr.ecr.<region>.amazonaws.com
version ?= latest

binary:
	$(call blue, "Building Linux binary ready for containerisation...")
	docker run --rm -v "$(CURDIR)":/app -w /app golang:1.21 sh -c 'CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o app'
	$(call blue, "Building docker image...")
	docker build -t ${name}:${version} .
	$(MAKE) clean

run: image
	$(call blue, "Running Docker image locally...")
	docker run -i -t --rm -p 8001:8001 ${name}:${version} 

publish:  
	$(call blue, "Publishing Docker image to registry...")
	docker tag ${name}:latest ${registry}/${name}:${version}
	docker push ${registry}/${name}:${version} 

clean: 
	@rm -f app 

define blue
	@if [ -t 1 ]; then tput setaf 6; fi
	@echo $1
	@if [ -t 1 ]; then tput sgr0; fi
endef
