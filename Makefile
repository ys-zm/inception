DATA = ~/data
WP_DATA = ~/data/wordpress
DB_DATA = ~/data/mariadb

# default target
all: up

# creates necessary directories
# starts the containers and leave them running
up: build
	mkdir -p $(DATA)
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up -d

# stops and removes all services defined in the Docker Compose file
down:
	docker compose -f ./srcs/docker-compose.yml down

# stops all services defined in the Docker Compose file
stop:
	docker compose -f ./srcs/docker-compose.yml stop

# builds or rebuilds services defined in the Docker Compose file
build:
	docker compose -f ./srcs/docker-compose.yml build

# Stops containers and performs comprehensive cleanup of Docker containers, images, volumes, and networks
clean: stop
	rm -rf $(DATA)
	docker system prune --all

# clean the containers
# stop all running containers and remove them
# remove all images, volumes and networks
# remove the wordpress and mariadb data directories
# "|| true" ensures the Makefile continues even if there are no containers to remove, preventing an error from halting the process
clean: stop
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@sudo rm -rf $(WP_DATA) || true
	@sudo rm -rf $(DB_DATA) || true

# goes a step futher, prunes the Docker system, removing all unused data
prune: clean
	@docker system prune -a --volumes -f

re: clean up

.PHONY: all dirs up build down stop clean re

