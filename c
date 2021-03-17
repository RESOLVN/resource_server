version: "3"

services:
  
  cyberchef:
    image: resolvn/cyberchef:9.27.6
    container_name: cyberchef   
    ports:
      - "8020:8000"
    restart: unless-stopped