.PHONY: install test demo clean

install:
	pip install -e ".[dev]"

test:
	pytest -q

demo:
	containerinv demo --out demo

clean:
	rm -rf demo out .pytest_cache build *.egg-info
