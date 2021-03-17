version: "3"

services:
  
  attack-website:
    image: resolvn/attack-website
    container_name: attack-website
    ports:
      - "8095:80"
    restart: unless-stopped
