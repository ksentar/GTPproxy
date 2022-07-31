-include .env
export

_: shell-api

env-init: 
	@test -f .env || cp .env.example .env

services-init: 
	@test -f .services.yaml || cp .services.example.yaml .services.yaml

gen-compose-file:
	@utils/gen-compose-file.py

up:
	@docker-compose up -d

up-d-build:
	@docker-compose up -d --build

restart-api:
	@docker-compose restart api

restart-admin:
	@docker-compose restart admin

logs-api:
	@docker-compose logs --tail=100 -f --no-log-prefix api

logs-admin:
	@docker-compose logs --tail=100 -f --no-log-prefix admin

prisma-db-pull:
	@docker-compose exec api npx prisma db pull

prisma-db-push:
	@docker-compose exec api npx prisma db push

prisma-migrate-deploy:
	@docker-compose exec api npx prisma migrate deploy

hasura-metadata-export:
	@docker-compose exec hasura hasura --skip-update-check metadata export

hasura-metadata-apply:
	@docker-compose exec hasura hasura --skip-update-check metadata apply

hasura-migrate-create:
	@docker-compose exec hasura hasura --skip-update-check migrate --database-name=default create ${NAME}

hasura-migrate-apply:
	@docker-compose exec hasura hasura --skip-update-check migrate --database-name=default apply

hasura-migrate-apply-down-1:
	@docker-compose exec hasura hasura --skip-update-check migrate --database-name=default apply --down 1

traefik-network-web-create:
	@docker network inspect web > /dev/null 2>&1 || docker network create web

shell-api:
	@docker-compose exec api ash

shell-admin:
	@docker-compose exec admin ash

shell-hasura:
	@docker-compose exec hasura bash

install: up

db-update: hasura-migrate-apply hasura-metadata-apply
