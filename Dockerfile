FROM alpine:3.6
MAINTAINER Luke Wyatt (luke@meat.space)
LABEL company="Meatspace Studios"
LABEL version="l.0.0"
LABEL license="MIT"

# INSTALL APP DEPENDENCIES
RUN apk add --no-cache samba-client
RUN apk add --no-cache samba-common
RUN apk add --no-cache cifs-utils

# STAGE ENVIRONMENT
RUN mkdir -p /mount
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY docker-azure.sh /usr/src/app/
RUN chmod +x /usr/src/app/docker-azure.sh

ENTRYPOINT ["/usr/src/app/docker-azure.sh"]
CMD ["--help"]