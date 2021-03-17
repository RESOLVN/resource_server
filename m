version: "3"

services:

  mongo:
    image: resolvn/mongo:4.2
    container_name: vectr_mongodb
    networks:
      vectr_bridge:
        aliases:
          - vectr-mongo
    volumes:
      - /home/resolvn/docker/vectr/mongodb_data:/data/db
    env_file:
      - /home/resolvn/docker/vectr/.env
    restart: unless-stopped

  tomcat:
    image: resolvn/vectr:6.2.1
    container_name: vectr-tomcat
    networks:
      vectr_bridge:
        aliases:
          - vectr-tomcat
    volumes:
      - /home/resolvn/docker/vectr/tomcat/resources:/opt/vectr/resources
      - /home/resolvn/docker/vectr/tomcat/user:/opt/vectr/user
      - /home/resolvn/docker/vectr/tomcat/logs:/usr/local/tomcat/logs
    env_file:
      - /home/resolvn/docker/vectr/.env
    ports:
      - "${VECTR_PORT:-8081}:8443"
    restart: unless-stopped
    depends_on:
      - mongo

  webserver:
    image: resolvn/vectr-rta_web:1.0.4
    container_name: vectr-webserver
    networks:
      vectr_bridge:
        aliases:
          - vectr-rta-webserver
    links:
      - redis

  builder:
    image: resolvn/vectr-rta_builder:1.0.4
    container_name: vectr-builder
    networks:
      vectr_bridge:
        aliases:
          - vectr-rta-builder
    volumes:
      - /home/resolvn/docker/vectr/resources/runtimes:/builds
      - /home/resolvn/docker/vectr/atomic-red-team/atomics:/atomics
    links:
      - redis

  redis:
    image: resolvn/redis:6.2.1
    container_name: vectr-redis
    volumes:
      - /home/resolvn/docker/vectr/redis_data:/data
    networks:
      - vectr_bridge

networks:
  vectr_bridge:
    ipam:
      driver: default
      config:
        - subnet: "${VECTR_NETWORK_SUBNET:-10.0.27.0/24}"
