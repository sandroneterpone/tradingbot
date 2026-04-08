PYTHON ?= python

install:
	$(PYTHON) -m pip install -e .[dev]

run:
	uvicorn app.main:app --reload

test:
	pytest -q

lint:
	ruff check app tests

format:
	ruff format app tests
