.DEFAULT_GOAL := bootstrap

.PHONY: _pipenv_install
_pipenv_install:
	@ mkdir -p .venv
	@ pipenv install > /dev/null 2>&1

.PHONY: bootstrap
bootstrap: _pipenv_install
	@ pipenv shell

.PHONY: cleanup
cleanup:
	@ if [ -d ".venv" ] ; then pipenv --rm ; fi
	@ rm -rf Pipfile.lock

.PHONY: check_updates
check_updates: _pipenv_install
	@ pipenv update --bare --outdated ; return 0
