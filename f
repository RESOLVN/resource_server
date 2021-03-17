version: "3"

services:

  nextcloud:
    image: resolvn/nextcloud:21.0.0
    container_name: nextcloud
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - /home/resolvn/docker/nextcloud/config:/config
      - /home/resolvn/docker/nextcloud/data:/data     
    ports:
      - "8855:443"
    restart: unless-stopped
