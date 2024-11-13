.DEFAULT_GOAL := bootstrap

.PHONY: bootstrap
bootstrap:
	@ mkdir -p .venv
	@ pipenv install > /dev/null 2>&1
	@ pipenv shell

.PHONY: cleanup
cleanup:
	@ if [ -d ".venv" ] ; then pipenv --rm ; fi
	@ rm -rf Pipfile.lock
