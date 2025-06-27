.DEFAULT_GOAL := _check-target

.PHONY: _check-target
_check-target:
	@echo "🚨 No target specified. Provide a target and try again."
	@echo ""
	@make -s help

.PHONY: help
help:
	@echo "💡 Available targets:"
	@echo "     bootstrap        Creates a virtual environment and launches bash with the virtualenv active"
	@echo "     check-updates    Shows outdated packages (ignoring: $(UPDATES_TO_IGNORE))"
	@echo "     cleanup          Removes the virtualenv and lock file"

REQUIREMENTS_FILE := pyproject.toml
UPDATES_TO_IGNORE := molecule-plugins
CUSTOM_BASHRC := /tmp/.bootstrap_bashrc_$(shell head /dev/urandom | tr -dc a-z0-9 | head -c 8)

.PHONY: _install-dependencies
_install-dependencies:
	@uv venv --quiet
	@uv pip install -r $(REQUIREMENTS_FILE) --quiet

.PHONY: bootstrap
bootstrap: _install-dependencies
	@echo "➡️  Activating virtual environment..."
	@echo '[ -f ~/.bashrc ] && source ~/.bashrc' > "$(CUSTOM_BASHRC)"
	@echo 'source .venv/bin/activate' >> "$(CUSTOM_BASHRC)"
	@echo 'trap "exit 0" EXIT' >> "$(CUSTOM_BASHRC)"
	@bash --rcfile "$(CUSTOM_BASHRC)"
	@rm -f "$(CUSTOM_BASHRC)"
	@echo "⬅️  Deactivated virtual environment."

.PHONY: check-updates
check-updates: _install-dependencies
	@echo "📜 Outdated packages (excluding: $(UPDATES_TO_IGNORE)):"
	@uv tree --outdated --depth 1 --quiet \
		| grep latest \
		| grep -vE "$(UPDATES_TO_IGNORE)" \
		| sed 's/^[├└┬── ]*//'
	@make -s cleanup

.PHONY: cleanup
cleanup:
	@rm -rf .venv uv.lock
	@echo "🧽 Cleanup process complete."
