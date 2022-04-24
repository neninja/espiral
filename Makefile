up:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml up -d

up-build:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml up -d --build

sh:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml exec app sh

down:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml down

pdf:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml -f .docker/docker-compose-pdf.yml up
