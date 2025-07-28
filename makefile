.DEFAULT_GOAL := _check-target

.PHONY: _check-target
_check-target:
	@echo "🚨 No target specified. Provide a target and try again."
	@echo ""
	@make -s help

.PHONY: help
help:
	@echo "💡 Available targets:"
	@echo "     bootstrap            Creates a virtual environment and launches a bash shell with the virtualenv activated."
	@echo "     check-for-updates    Checks for dependencies updates (excluding: $(UPDATES_TO_IGNORE))."
	@echo "     cleanup              Removes the virtual environment and associated lock file."

REQUIREMENTS_FILE := pyproject.toml
UPDATES_TO_IGNORE := molecule|molecule-plugins
CUSTOM_BASHRC := /tmp/.bootstrap_bashrc_$(shell head /dev/urandom | tr -dc a-z0-9 | head -c 8)

.PHONY: _install-dependencies
_install-dependencies:
	@echo "🏗️  Installing dependencies.."
	@uv venv --quiet
	@uv pip install --native-tls -r $(REQUIREMENTS_FILE) --quiet
	@echo "🚀 Dependencies installed."

.PHONY: bootstrap
bootstrap: _install-dependencies
	@echo "➡️  Activating virtual environment.."
	@echo '[ -f ~/.bashrc ] && source ~/.bashrc' > "$(CUSTOM_BASHRC)"
	@echo 'source .venv/bin/activate' >> "$(CUSTOM_BASHRC)"
	@echo 'trap "exit 0" EXIT' >> "$(CUSTOM_BASHRC)"
	@bash --rcfile "$(CUSTOM_BASHRC)"
	@rm -f "$(CUSTOM_BASHRC)"
	@echo "⬅️  Deactivated virtual environment."

.PHONY: check-for-updates
check-for-updates: _install-dependencies
	@echo "🔍 Checking for dependencies updates (excluding: $(UPDATES_TO_IGNORE)).."
	@UPDATES=$$(uv tree --outdated --depth 1 --quiet | grep latest | grep -vE "$(UPDATES_TO_IGNORE)" | sed 's/^[├└┬── ]*//'); \
		if [ -n "$$UPDATES" ]; then \
			echo "⚠️  The dependencies below are out of date:"; \
			echo ""; \
			echo "$$UPDATES"; \
			echo ""; \
		else \
			echo "✅ All dependencies are up to date!"; \
		fi
	@make -s cleanup

.PHONY: cleanup
cleanup:
	@rm -rf .venv uv.lock
	@echo "🧽 Cleanup process complete."
