init: docker-down-clear docker-pull docker-build docker-up
up: docker-up
down: docker-down

docker-up:
	docker compose up -d

docker-down:
	docker compose down --remove-orphans

docker-down-clear:
	docker compose down -v --remove-orphans

docker-pull:
	docker compose pull

docker-build:
	docker compose build

htpasswd:
docker run --rm registry:2.6 htpasswd -Bbn username password > htpasswd

adduser:
docker run --rm registry:2.6 htpasswd -B user1 password1 > htpasswd1

deploy:
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'docker network create --driver=overlay traefik-public || true'
	ssh deploy@${HOST} -p ${PORT} 'rm -rf registry && mkdir registry'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:registry/docker-compose.yml
	scp -P ${PORT} -r docker deploy@${HOST}:registry/docker
	scp -P ${PORT} ${HTPASSWD_FILE} deploy@${HOST}:registry/htpasswd
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'cd registry && docker stack deploy -c docker-compose.yml registry'
