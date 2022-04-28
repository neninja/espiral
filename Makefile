up:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml up -d

up-build:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml up -d --build

sh:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml exec app sh

down:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml down

book:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml -f .docker/docker-compose-book.yml up

html:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml -f .docker/docker-compose-html.yml up

all:
	@docker-compose -p intro-dev-web -f .docker/docker-compose.yml -f .docker/docker-compose-build.yml up
