.PHONY: tasks

CMD=

tasks:
	@echo Usage: make [task]
	@echo -------------------
	@echo
	@cat Makefile


docker_clean:
	docker ps -a -q -f "status=exited" -f "name=rails-test-api" | xargs docker rm

docker_up:
	docker-compose up --build

docker_up_background:
	docker-compose up -d

docker_init:
	$(MAKE) docker_db
	$(MAKE) docker_seed

docker_db:
	docker-compose exec rails_test_api bundle exec rails db:create
	docker-compose exec rails_test_api bundle exec rails db:migrate

docker_seed:
	docker-compose exec rails_test_api bundle exec rake db:seed

# e.g. $ make docker_exec CMD='bundle exec rspec'
docker_exec:
	docker-compose exec rails_test_api $(CMD)

docker_bash:
	$(MAKE) docker_exec CMD='bash'

docker_attach:
	docker attach `docker ps -q -f name=rails-test-api_rails_test_api`
