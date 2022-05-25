
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

ENV_FILE = ./srcs/.env

VOLUMES_DIR = $(HOME)/data
#docker rmi $(docker image ls -qa)
#docker compose --env-file ./config/.env.dev config 

all: prune up
	@ $(NAME)

$(NAME): prune
	@ sudo mkdir -p ${VOLUMES_DIR}/www
	@ sudo mkdir -p ${VOLUMES_DIR}/db
	@ docker compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV_FILE) up --build --force-recreate

# docker-compose rm -f
up:
	@ sudo mkdir -p ${VOLUMES_DIR}/www
	@ sudo mkdir -p ${VOLUMES_DIR}/db
	@ docker compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV_FILE) up --build --force-recreate

ps:
	@ docker compose -f $(DOCKER_COMPOSE_FILE) ps

# docker logs --tail 50 --follow --timestamps nginx
logs:
	@ docker compose -f $(DOCKER_COMPOSE_FILE) logs

down:
	@ docker compose -f $(DOCKER_COMPOSE_FILE) down -v

#@ docker-compose rm -f
prune: down
	@ docker system prune -f

fclean: prune
	@ sudo rm -rf ${VOLUMES_DIR}

#sudo kill $(sudo lsof -t -i:80)
ports:
	@ lsof -i -P -n | grep LISTEN

nginx:
	@ docker exec -it nginx /bin/bash

wordpress:
	@ docker exec -it wordpress /bin/bash

mariadb:
	@ docker exec -it mariadb /bin/bash

.PHONY: all up ps logs down prune fclean ports nginx wordpress mysql
