version: '3'

services:

  redis:
    image: resolvn/redis:6.2.1
    container_name: opencti-redis
    restart: always
    volumes:
      - /home/resolvn/docker/opencti/redisdata:/data
  elasticsearch:
    image: resolvn/elasticsearch:7.11.1
    container_name: opencti-es
    volumes:
      - /home/resolvn/docker/opencti/elasticesdata:/usr/share/elasticsearch/data
    environment:
      - discovery.type=single-node
    restart: always
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
  minio:
    image: resolvn/minio:RELEASE.2021-03-01
    container_name: opencti-minio
    volumes:
      - /home/resolvn/docker/opencti/s3data:/data
    ports:
      - "9000:9000"
    environment:
      - MINIO_ACCESS_KEY=resolvnresolvn
      - MINIO_SECRET_KEY=resolvnresolvn
    command: server /data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 30s
      timeout: 20s
      retries: 3
    restart: always
  rabbitmq:
    image: resolvn/rabbitmq:3.8.14
    container_name: opencti-rabbitmq
    environment:
      - RABBITMQ_DEFAULT_USER=resolvn
      - RABBITMQ_DEFAULT_PASS=resolvn
    volumes:
      - /home/resolvn/docker/opencti/amqpdata:/var/lib/rabbitmq
    restart: always
  opencti:
    image: resolvn/opencti-platform:4.2.4
    container_name: opencti-platform
    environment:
      - NODE_OPTIONS=--max-old-space-size=8096
      - APP__PORT=8080
      - APP__ADMIN__EMAIL=resolvn@resolvn.com
      - APP__ADMIN__PASSWORD=resolvn
      - APP__ADMIN__TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - APP__LOGS_LEVEL=error
      - APP__LOGS=./logs
      - APP__REACTIVE=true
      - APP__COOKIE_SECURE=false
      - REDIS__HOSTNAME=redis
      - REDIS__PORT=6379
      - ELASTICSEARCH__URL=http://elasticsearch:9200
      - MINIO__ENDPOINT=minio
      - MINIO__PORT=9000
      - MINIO__USE_SSL=false
      - MINIO__ACCESS_KEY=resolvnresolvn
      - MINIO__SECRET_KEY=resolvnresolvn
      - RABBITMQ__HOSTNAME=rabbitmq
      - RABBITMQ__PORT=5672
      - RABBITMQ__PORT_MANAGEMENT=15672
      - RABBITMQ__MANAGEMENT_SSL=false
      - RABBITMQ__USERNAME=resolvn
      - RABBITMQ__PASSWORD=resolvn
      - PROVIDERS__LOCAL__STRATEGY=LocalStrategy
    ports:
      - "8080:8080"
    depends_on:
      - redis
      - elasticsearch
      - minio
      - rabbitmq
    restart: always
  worker:
    image: resolvn/opencti-worker:4.2.4
    environment:
      - OPENCTI_URL=http://opencti:8080
      - OPENCTI_TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - WORKER_LOG_LEVEL=info
    depends_on:
      - opencti
    deploy:
      mode: replicated
      replicas: 3
    restart: always
  connector-history:
    image: resolvn/opencti-history:4.2.4
    container_name: opencti-history
    environment:
      - OPENCTI_URL=http://opencti:8080
      - OPENCTI_TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - CONNECTOR_ID=84f4c3ea-82b3-11eb-8dcd-0242ac130003
      - CONNECTOR_TYPE=STREAM
      - CONNECTOR_NAME=History
      - CONNECTOR_SCOPE=history
      - CONNECTOR_CONFIDENCE_LEVEL=3
      - CONNECTOR_LOG_LEVEL=info
    restart: always
  connector-export-file-stix:
    image: resolvn/opencti-export-stix:4.2.4
    container_name: opencti-exstix 
    environment:
      - OPENCTI_URL=http://opencti:8080
      - OPENCTI_TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - CONNECTOR_ID=84f4c66a-82b3-11eb-8dcd-0242ac130003
      - CONNECTOR_TYPE=INTERNAL_EXPORT_FILE
      - CONNECTOR_NAME=ExportFileStix2
      - CONNECTOR_SCOPE=application/json
      - CONNECTOR_CONFIDENCE_LEVEL=3
      - CONNECTOR_LOG_LEVEL=info
    restart: always
  connector-export-file-csv:
    image: resolvn/opencti-export-csv:4.2.4
    container_name: opencti-expcsv
    environment:
      - OPENCTI_URL=http://opencti:8080
      - OPENCTI_TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - CONNECTOR_ID=84f4c818-82b3-11eb-8dcd-0242ac130003
      - CONNECTOR_TYPE=INTERNAL_EXPORT_FILE
      - CONNECTOR_NAME=ExportFileCsv
      - CONNECTOR_SCOPE=text/csv
      - CONNECTOR_CONFIDENCE_LEVEL=3
      - CONNECTOR_LOG_LEVEL=info
    restart: always
  connector-import-file-stix:
    image: resolvn/opencti-import-stix:4.2.4
    container_name: opencti-imstix
    environment:
      - OPENCTI_URL=http://opencti:8080
      - OPENCTI_TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - CONNECTOR_ID=84f4c8fe-82b3-11eb-8dcd-0242ac130003
      - CONNECTOR_TYPE=INTERNAL_IMPORT_FILE
      - CONNECTOR_NAME=ImportFileStix2
      - CONNECTOR_SCOPE=application/json
      - CONNECTOR_CONFIDENCE_LEVEL=3
      - CONNECTOR_LOG_LEVEL=info
    restart: always
  connector-import-file-pdf-observables:
    image: resolvn/opencti-import-pdf:4.2.4
    container_name: opencti-impdf
    environment:
      - OPENCTI_URL=http://opencti:8080
      - OPENCTI_TOKEN=2e7586c6-836c-11eb-8dcd-0242ac130003
      - CONNECTOR_ID=84f4c9c6-82b3-11eb-8dcd-0242ac130003
      - CONNECTOR_TYPE=INTERNAL_IMPORT_FILE
      - CONNECTOR_NAME=ImportFilePdfObservables
      - CONNECTOR_SCOPE=application/pdf
      - CONNECTOR_CONFIDENCE_LEVEL=3
      - CONNECTOR_LOG_LEVEL=info
      - PDF_OBSERVABLES_CREATE_INDICATOR=False
    restart: always
