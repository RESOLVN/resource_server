version: "3"

services:
  
  diagrams-drawio:
    image: resolvn/draw.io:14.1.9
    container_name: diagrams-drawio    
    volumes:
      - /home/resolvn/docker/draw.io:/usr/local/diagrams
    ports:
      - "8010:8080"
    restart: unless-stopped