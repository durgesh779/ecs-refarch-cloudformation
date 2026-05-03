all: run

# Professional identification for the service
name = ecs-refarch-cloudformation/website-service
registry ?= <your-account-id>.dkr.ecr.<region>.amazonaws.com
version ?= latest

# 1. FIXED: Removed empty GOPATH mount and upgraded to Go 1.25
# 2. FIXED: Added 'go mod tidy' to handle modern dependencies automatically
binary:
	$(call blue, "Building Linux binary ready for containerisation...")
	docker run --rm -v "$(CURDIR)":/app -w /app golang:1.25 sh -c 'go mod tidy && CGO_ENABLED=0 go build -o app main.go'

image: binary
	$(call blue, "Building docker image...")
	docker build -t ${name}:${version} .
	$(MAKE) clean

run: image
	$(call blue, "Running Docker image locally...")
	docker run -i -t --rm -p 8000:8000 ${name}:${version} 

# 3. FIXED: Changed tag source from 'latest' to '${version}' 
# This ensures it pushes the specific Git SHA built in GitHub Actions.
publish: image
	$(call blue, "Publishing Docker image to registry...")
	docker tag ${name}:${version} ${registry}/${name}:${version}
	docker push ${registry}/${name}:${version} 

clean: 
	@rm -f app 

# 4. FIXED: Added TTY check to prevent 'tput' errors in GitHub Actions
define blue
	@if [ -t 1 ]; then tput setaf 6; fi
	@echo $1
	@if [ -t 1 ]; then tput sgr0; fi
endef