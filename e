version: "3"

services:

  postgresql:
    image: resolvn/bitnami-postgres:13.2
    container_name: redmine-postgres
    restart: unless-stopped
    environment:
      - POSTGRESQL_USERNAME=resolvn
      - ALLOW_EMPTY_PASSWORD=yes
      - POSTGRESQL_DATABASE=redmine
    volumes:
      - /home/resolvn/docker/redmine/postgres:/bitnami/postgresql
      - /etc/localtime:/etc/localtime:ro

  redmine:
    image: resolvn/redmine:4.1.1
    container_name: redmine-app
    restart: unless-stopped
    ports:
      - "8000:3000"
    environment:
      - REDMINE_DB_POSTGRES=postgresql
      - REDMINE_DB_USERNAME=bn_resolvn
      - REDMINE_DB_NAME=redmine
      - REDMINE_USERNAME=resolvn
      - REDMINE_PASSWORD=Resolvn1!Resolvn1!
    volumes:
      - /home/resolvn/docker/redmine/redmine_data:/bitnami
    depends_on:
      - postgresql
