# Private Docker Registry & Jenkins for Ubuntu 22.04

1. rename provisioning/hosts.yml.dst to hosts.yml and edit.

1. install on VM:

>cd provisioning && make server


1. generate file htpasswd for Basic auth

>docker run --rm registry:2.6 htpasswd -Bbn username password > htpasswd

1. Copy SSH key for user deploy on VM. 

>make authorize


1. Deploy from project root:

>cd .. && HOST=server_ip PORT=ssh_port HTPASSWD_FILE=htpasswd make deploy


1. Open jenkins.yuor.site in browser and wait until "Unlock Jenkins" prompt.

1. Run command:
>cd provisioning && make show-initial-password

1. In case of problems, try at server VM.
>docker compose down --remove-orphans && docker system prune -af && docker volume prune
