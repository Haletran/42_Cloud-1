## SIMPLE MAKEFILE FOR STARTING THE PROJECT

all: vm-start start

build:
	@ansible-playbook playbook/install_docker.yml

vm-start:
	@cd src && vagrant up

stop:
	@cd src && vagrant halt

reset:
	@cd src && vagrant destroy -f

re: reset start