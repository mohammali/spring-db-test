#!/bin/bash -e
# shellcheck disable=SC2093
exec java -Djava.security.egd=file:/dev/./urandom -jar /app/bin/service.jar

exec "$@"
