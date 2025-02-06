## SIMPLE MAKEFILE FOR STARTING THE PROJECT

all: vm-start build

build:
	@cd src && ansible-playbook playbook/install_docker.yml && ansible-playbook playbook/install_container.yml

container:
	@cd src && ansible-playbook playbook/install_container.yml


vm-start:
	@cd src && vagrant up

stop:
	@cd src && vagrant halt

reset:
	@cd src && vagrant destroy -f

restart:
	-cd src && vagrant ssh cloud-1 -c "docker stop phpmyadmin db wordpress"
	-cd src && vagrant ssh cloud-1 -c "docker rm phpmyadmin db wordpress"
	-cd src && vagrant ssh cloud-1 -c "docker container prune -f"
	-cd src && vagrant ssh cloud-1 -c "docker rmi $$(docker images -a -q)"
	-cd src && vagrant ssh cloud-1 -c "docker volume prune -f"
	-cd src && vagrant ssh cloud-1 -c "docker image prune -f -a"
	-cd src && vagrant ssh cloud-1 -c "docker network prune -f"
	-cd src && vagrant ssh cloud-1 -c "docker builder prune --all --force"

re: reset all

re2: restart container