version: "3"

services:

  mm-db:
    image: resolvn/postgres:12.6
    container_name: mattermost-postgresql
    restart: unless-stopped
    volumes:
      - /home/resolvn/docker/mattermost/postgresql/data:/var/lib/postgresql/data
      - /etc/localtime:/etc/localtime:ro
    environment:
      - POSTGRES_USER=resolvn
      - POSTGRES_PASSWORD=resolvn!resolvn!
      - POSTGRES_DB=mattermost
  
  mm-app:
    image: resolvn/mattermost:5.33
    container_name: mattermost-app
    ports:
      - "8065:8065" 
    restart: unless-stopped
    volumes:
      - /home/resolvn/docker/mattermost/config:/mattermost/config:rw
      - /home/resolvn/docker/mattermost/data:/mattermost/data:rw
      - /home/resolvn/docker/mattermost/logs:/mattermost/logs:rw
      - /home/resolvn/docker/mattermost/plugins:/mattermost/plugins:rw
      - /home/resolvn/docker/mattermost/client-plugins:/mattermost/client/plugins:rw
      - /etc/localtime:/etc/localtime:ro
    environment:
      - MM_USERNAME=resolvn
      - MM_PASSWORD=resolvn!resolvn!
      - MM_DBNAME=mattermost
      - MM_SQLSETTINGS_DATASOURCE=postgres://resolvn:resolvn!resolvn!@mm-db:5432/mattermost?sslmode=disable&connect_timeout=10

