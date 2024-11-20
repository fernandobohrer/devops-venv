.DEFAULT_GOAL := bootstrap

.PHONY: _pipenv-install
_pipenv-install:
	@ mkdir -p .venv
	@ pipenv install > /dev/null 2>&1

.PHONY: bootstrap
bootstrap: _pipenv-install
	@ pipenv shell

.PHONY: cleanup
cleanup:
	@ rm -rf .venv Pipfile.lock

.PHONY: check-updates
check-updates: _pipenv-install
	@ pipenv update --bare --outdated
