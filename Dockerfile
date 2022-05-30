FROM openjdk:17-jdk-alpine

MAINTAINER mohammali <mohammali-@hotmail.com>

# Configure environment
ENV     APP_HOME /app
ENV     APP_BIN=${APP_HOME}/bin \
        APP_CONF=${APP_HOME}/conf \
        APP_LOGS=${APP_HOME}/logs \
        APP_FILES=${APP_HOME}/files \
        APP_USER=springboot \
        JMX_PORT=1098 \
        RMI_PORT=1099 \
        JAVA_DEBUG=false \
        APP_NAME=spring-scala

# Create user and group running application
RUN addgroup -S ${APP_USER} && adduser -S ${APP_USER} -G ${APP_USER}

# Layout folders
RUN     mkdir ${APP_HOME} && \
        mkdir -m 0754 ${APP_BIN} && \
        mkdir -m 0740 ${APP_CONF} && \
        mkdir -m 0755 ${APP_LOGS} && \
        mkdir -m 0777 ${APP_FILES} && \
        chown -R ${APP_USER}:${APP_USER} ${APP_HOME}

# Run as not-root
USER    ${APP_USER}

# Export logs
VOLUME  ${APP_LOGS}
VOLUME  ${APP_FILES}

# Expose JXM, RMI
EXPOSE  ${JMX_PORT} ${RMI_PORT}

WORKDIR ${APP_HOME}

# Add custom entrypoint script
COPY docker-entrypoint.sh /

# Install application
COPY target/service.jar ${APP_BIN}

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
CMD ["service"]
