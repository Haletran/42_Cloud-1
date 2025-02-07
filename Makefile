## SIMPLE MAKEFILE FOR STARTING THE PROJECT

all: build

build:
	@cd src && ansible-playbook playbook/install_docker.yml && ansible-playbook playbook/install_container.yml

container:
	@cd src && ansible-playbook playbook/install_container.yml

vm-start:
	@cd src && vagrant up

stop:
	@cd src && vagrant halt

down: 
	@cd src && ansible-playbook playbook/reset_container.yml

reset:
	# @cd src && vagrant destroy -f
	@cd src && ansible-playbook playbook/reset_container.yml

re: reset build