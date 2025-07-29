# devops virtual environment

This repository creates a `python` based virtual environment using `uv` and automatically installs the dependencies listed in the `pyproject.toml` file into the environment.

## 🚀 Motivation

The virtual environment created by this repository is designed for developing Ansible roles and playbooks, as well as for working on devops related activities.

The main advantage of using a virtual environment is its ability to isolate dependencies, ensuring that the packages listed in the `pyproject.toml` file won't interfere with or affect other packages installed on your system.

## 🧰 Dependencies

- [uv][01]

Refer to your operating system's package manager or documentation to install the dependencies on your machine.

## ⚡ Quick start

1. To create and initialize the `python` based virtual environment, run `make bootstrap`.

1. Switch to any directory where you are working on Ansible related activities to leverage tools like `ansible`, `ansible-creator`, `ansible-galaxy`, `ansible-lint`, `ansible-playbook`, `ansible-vault`, `molecule`, `pre-commit` and `yamllint`.

   1. To create a new Ansible role: `ansible-galaxy role init role-name`. More details can be found [here][02].

   1. To create a new Ansible project: `ansible-creator init playbook organization.project`. More details can be found [here][03].

1. When you are finished with your work, simply exit the virtual environment by typing `exit` in the terminal. This will bring you back to the directory where this repository is located.

1. To completely remove the virtual environment, run `make cleanup`.

## 📝 License

This project is licensed under the terms of the [MIT license][04].

[01]: https://docs.astral.sh/uv/
[02]: https://www.redhat.com/sysadmin/developing-ansible-role
[03]: https://ansible.readthedocs.io/projects/creator/installing/#initialize-ansible-project
[04]: /LICENSE
