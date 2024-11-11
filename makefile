.PHONY: default
default: _cleanup _bootstrap

.PHONY: _bootstrap
_bootstrap:
	@ mkdir -p .venv
	@ pipenv install > /dev/null 2>&1
	@ pipenv shell

.PHONY: _cleanup
_cleanup:
	@ if [ -d ".venv" ] ; then pipenv --rm ; fi
	@ rm -rf Pipfile.lock
