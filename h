version: "3"

networks:
  gitea:
    external: false

services:

  gitea-web:
    image: resolvn/gitea:1.13.3
    container_name: gitea-web
    networks: 
      - gitea
    volumes:
      - /home/resolvn/docker/gitea/data:/data
      - /home/resolvn/docker/gitea/config:/etc/gitea  
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"
      - "2222:22"
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - DB_TYPE=postgres
      - DB_HOST=gitea-database:5432
      - DB_NAME=gitea
      - DB_USER=gitea
      - DB_PASSWD=gitea
    depends_on:
      - gitea-database
    restart: unless-stopped

  gitea-database:
    image: resolvn/postgres:12.6
    container_name: gitea-database
    networks:
      - gitea
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea
      - POSTGRES_DB=gitea
    volumes:
      - /home/resolvn/docker/gitea/postgresql:/var/lib/postgresql/data
    restart: unless-stopped
