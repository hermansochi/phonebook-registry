# Private Docker Registry for Ubuntu 22.04

1. Rename provisioning/hosts.yml.dist to hosts.yml and add server address and username.

2. Rename provisioning/server.yml.dist to server.yml and change username.

3. Rename provisioning/authorize.yml.dist to authorize.yml and add change username and patch to public key.

4. install on VM:

>cd provisioning && make server

5. generate file htpasswd for Basic auth

>docker run --rm registry:2.6 htpasswd -Bbn username password > htpasswd

6. Copy SSH key for user deploy on VM. 

>make authorize

7. Deploy from project root:

>cd .. && HOST=server_ip PORT=ssh_port HTPASSWD_FILE=htpasswd make deploy

8. In case of problems, try at server VM.
>docker compose down --remove-orphans && docker system prune -af && docker volume prune
