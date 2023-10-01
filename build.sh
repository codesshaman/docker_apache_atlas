#!/bin/bash

docker exec -it apache_atlas mvn -U \
    -DskipTests \
    -Drat.skip=true \
    -Drat.numUnapprovedLicenses=200 \
    -Dmaven.wagon.http.ssl.insecure=true \
    -Dmaven.wagon.http.ssl.ignore.validity.dates=true \
    clean install
