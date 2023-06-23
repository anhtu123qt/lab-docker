COMPOSE_FILE=docker-compose.yml

### DOCKER COMPOSE COMMANDS
.PHONY: compose-ps
compose-ps:
	docker compose ps
.PHONY: compose-build
compose-up-build:
	docker compose -f $(COMPOSE_FILE) up -d --build

.PHONY: compose-up
compose-up:
	docker compose -f $(COMPOSE_FILE) up -d

.PHONY: compose-down
compose-down:
	docker compose -f $(COMPOSE_FILE) down

.PHONY: compose-down-up-ps
compose-down-up-ps:
	make compose-down
	make compose-up-build
	make compose-ps

#### DOCKER EXEC COMMANDS

