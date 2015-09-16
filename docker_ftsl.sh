## Docker na prática
## FTSL - UTFPR - 2015-09-16
## https://github.com/flavioarcega/ftsl

sudo docker version
sudo service docker start
# arch (nao instala pelo curl do site)
sudo pacman -S docker
sudo systemctl start docker
sudo docker version

# comandos
docker

## baixando e executando o postgres
# procura as imagens no repositorio docker
# versao web: https://hub.docker.com
# repo OFICIAL soh tem o nome dele. nao OFICIAL tem o
# nomedeusuario/repositorio
sudo docker search postgres
# o name pode ser qualquer coisa. o 9.3 eh a versao (pode ser conferida
# no site)
sudo docker run --name meubanco -d postgres:9.3
# no Dockerfil tem
# FROM debian:jessie
# veja no dockerfile do Debian
sudo docker ps
sudo docker ps -a
# pode usar o alias (NAMES) ou o ID
ifconfig
# ele cria uma interface de rede virtual para hospedar suas maquinas
# virtuais, a docker0
sudo docker inspect meubanco
# retorna em formato JSON
# para ver o IP
sudo docker inspect meubanco | grep IPA
# instala o pgadmin3
sudo pacman -S pgadmin3
pgadmin3 # abre uma interface, preenche com
# meubanco
# IP ... etc
# ele vai conectar ao banco de dados (para testar)

# mostra as imagens disponiveis (as ISOs)
sudo docker images

# para entrar no container
sudo docker exec -it meubanco /bin/bash
# os comandos sao os do debian, que ele eh baseado
ls
pwd
# veja que soh o postgres esta rodando, para ser mesmo bem enxuto
ps aux
exit

# para ver de fora o que acontece la dentro
sudo docker logs meubanco
# para remover um container
# sudo docker rm meubanco
# para remover as imagens (desnecessarias depois de instalar)
# sudo docker rmi postgres:9.3
# os containers ficam em /var/lib/docker/containers

## Linkar containers!!

# instala o tomcat
sudo docker run --name servico -d tomcat:7.0
sudo docker ps -a
sudo docker rm meubanco
sudo docker inspect servico | grep IPA 
# entre em 127.17.0.2:8080 para ver o servico funcionando

# copia um arquivo local para o container
sudo docker cp ~/GitHub/ftsl/servlet.war servico:/usr/local/tomcat/webapps
# entra em 127.17.0.2:8080/servlet

# vai instalar o fedora e ja linkar com o tomcat
sudo docker run --name bomb1 --link servico:servicoaddr -d debian
sudo docker ps -a

# Criando um daemon para acessar a aplicação (teste de stress do
# servidor)
sudo docker run -it --name bomb2 --link servico:servicoaddr -d fedora:21 \
     /bin/bash -c "while true; do curl aplicacao:8080/servlet/; done"
# veja no navegador o incremento no numero de acessos
sudo docker ps -a
# pode criar varios bombs desse para estressar ainda mais

sudo docker exec -it bomb2 /bin/bash
cat /etc/hosts
exit

## DATA VOLUMES
# usa diretorios compartilhados
sudo docker stop servico
sudo docker run --name servico2 \
     -v ~/GitHub/ftsl:/usr/local/tomcat/webapps \ 
-d tomcat:7.0

## Criando imagens
# Criando uma imagem a partir do container:
sudo docker commit -m "Criando uma iso para a aplicação" -a "Fernando" bomb2 flavioarcega/ftsl-app:0.1
sudo docker images
# para enviar para o docker hub
sudo docker login
sudo docker push flavioarcega/ftsl-app:0.3

sudo docker run -d flavioarcega/ftsl-app:0.3
sudo docker images

# Um repo do github pode alimentar uma imagem do docker hub. Cada novo
# commit no github ja cria uma nova imagem automaticamente 
sudo docker build -t flavioarcega/ftsl-app:0.2 https://raw.githubusercontent.com/flavioarcega/ftsl/master/Dockerfile

# eh possivel criar um container com uma imagem do emacs por exemplo, e
# ao rodar ele traz a interface grafica
