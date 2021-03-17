version: "3"

services:
  
  attack-navigator:
    image: resolvn/attack-navigator:4.2
    container_name: attack-navigator  
    restart: unless-stopped
    ports:
      - "8050:80"
    volumes:
      - /home/resolvn/docker/attack-nav/attack_data:/usr/share/nginx/html/assets/attack_data   
