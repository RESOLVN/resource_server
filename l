version: "3"

services:
 
  confluence-db:
    image: resolvn/postgres:12.6
    container_name: confluence-postgres
    restart: unless-stopped
    volumes:
      - /home/resolvn/docker/postgresql/data:/var/lib/postgresql/data
      - /etc/localtime:/etc/localtime:ro
    environment:
      - POSTGRES_USER=resolvn
      - POSTGRES_PASSWORD=resolvn!resolvn!
      - POSTGRES_DB=confluence
  
  confluence-app:
    image: resolvn/confluence:7.10
    container_name: confluence-app
    restart: unless-stopped
    volumes:
      - /home/resolvn/docker/confluence/uploads:/var/atlassian/application-data/confluence
    environment:
      - ATL_LICENSE_KEY=AAABgg0ODAoPeNpVUV1v2jAUffevsLSXTVrATjqgSJZG41TNRAgNXSdVvJhwKdaMw2wnNP3185IgdZJffI/u+bqfskrjTBhMv/k3J3ROKY75Ew5JSNFvaJ/BWFlpRieETMksiiha1acdmPzw03qMUYLiSjtRupU4AduA0JhXWoNSLSorfRh5SDbAnKkBrWtTHoUFLhwwr0ECMgnCCC1lCdpC8naWpu3AWit5kg72V/okE1Ix6/m/G7CVavSorE5I9ZsPwh5ZFl/i+ztu9o/7m9luTB+Kt1+7cszvFW/Sxft4cSxm01y+tD8m7Z/btVtXr+vLy/PZ3BXT/LJlW4a8iHaghS4/mvFOw8FpF2njhHFg+kyD95SzZco3ySqgN/Q2opQi/2H/DXLzKrS0wv2rtOhTfMWpLkcoNtCNr3o0IFFAJ73eIPHUnqFrOc6zLCnidLG85r/eKUQcbGnkuZPw1R1UDT4M/rwB04D5ginB3eW2czzEwAM9Shqh6t7cQSg/+AvwJrNyMCwCFC2PlUylitqHKpBNekXEZ19cATQyAhQplWqmCSpgKsUj6Z9B2gs6K0WF3w==X02iq
      - ATL_JDBC_URL=jdbc:postgresql://confluence-db:5432/confluence
      - ATL_JDBC_USER=resolvn
      - ATL_JDBC_PASSWORD=resolvn!resolvn!
      - ATL_DB_TYPE=postgresql
    ports:
      - "8090:8090"
      - "8091:8091"


