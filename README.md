# 42_Cloud-1

[Subject](https://cdn.intra.42.fr/pdf/pdf/147805/en.subject.pdf)

## Project

The VPS on `Vultr` is running on Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-42-generic x86_64) as required by the subject.
This VPS will be were the project will run, so the launch of everything can be done on the actual computer and
then it will be deployed on the VPS. 

Basically the goal of this project is to deploy a fully functionnal `Wordpress` instance on a `VPS` using `Docker` and `Ansible`.

### REQUIREMENTS

- Install Docker and docker-compose
```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce docker-compose
```

- Install Ansible (Configuration Management tool) 
```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt update && sudo apt install ansible
```

`Ansible` use declarative push-based YAML code to automate the configuration of the server,
called `Playbooks`.

```yaml
## basic example of an Ansible playbook that installs and starts the Nginx web server on a group of remote servers
---
- name: Install and start Nginx
  hosts: web_servers
  become: yes  # Run tasks with sudo

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
      when: ansible_os_family == "Debian"

    - name: Install Nginx on RedHat-based systems
      yum:
        name: nginx
        state: present
      when: ansible_os_family == "RedHat"

    - name: Start and enable Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

```bash
# Run the playbook to install and start Nginx on the web_servers group
ansible-playbook deploy.yml

# To connect to the remote servers and run commands
ansible -i src/inventory/hosts ubuntu -m ping --user root --ask-pass
```

### CONTAINERS

The Ansible playbook will deploy the following containers automatically:

- `Wordpress` (CMS) 
- `MySQL` (Database) 
- `PHPMyAdmin` (Database Management) 
- `Nginx` (Web Server)

and then i just need to setup `ssl` and `firewall` rules.


### Some ressource for the project

- [Ansible tutorial: install Wordpress with Ansible playbook (video)](https://www.youtube.com/watch?v=Gxbj28ZoUbI)
- [Automate your Docker deployments with Ansible (video)](https://www.youtube.com/watch?v=CQk9AOPh5pw)
- [This web UI for Ansible is so damn useful!(video)](https://www.youtube.com/watch?v=Gxbj28ZoUbI)
- [Things I wish I knew about Ansible from day 1](https://www.youtube.com/watch?v=Gxbj28ZoUbI)
- [Automate EVERYTHING with Ansible! (Ansible for Beginners)](https://www.youtube.com/watch?v=Gxbj28ZoUbI)