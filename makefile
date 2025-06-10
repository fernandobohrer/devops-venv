.DEFAULT_GOAL := .check-target

UPDATES_TO_IGNORE = molecule-plugins|resolvelib|setuptools

.PHONY: .check-target
.check-target:
	$(error No target specified. Please provide a target and try again.)

.PHONY: .pipenv-install
.pipenv-install:
	@ mkdir -p .venv
	@ pipenv install > /dev/null 2>&1

.PHONY: bootstrap
bootstrap: .pipenv-install
	@ pipenv shell

.PHONY: cleanup
cleanup:
	@ rm -rf .venv Pipfile.lock

.PHONY: check-updates
check-updates: .pipenv-install
	@ pipenv run pip list --outdated | egrep -v "${UPDATES_TO_IGNORE}"
	@ make -s cleanup
