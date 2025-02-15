test_all: test_pg test_mysql test_sqlite

test_pg: export DATABASE_URL=postgresql://username:password@localhost:5432/testsuite
test_pg:
	docker-compose -f scripts/docker-compose.yml up -d postgres
	bash scripts/test.sh -svv
	docker-compose -f scripts/docker-compose.yml stop postgres

test_mysql: export DATABASE_URL=mysql://username:password@127.0.0.1:3306/testsuite
test_mysql:
	docker-compose -f "scripts/docker-compose.yml" up -d mysql
	bash scripts/test.sh -svv
	docker-compose -f scripts/docker-compose.yml stop mysql

test_sqlite:
	bash scripts/test.sh -svv

test:
	pytest

coverage:
	pytest --cov=ormar --cov=tests --cov-fail-under=100 --cov-report=term-missing

black:
	black ormar tests

lint:
	black ormar tests
	flake8 ormar

mypy:
	mypy ormar tests
