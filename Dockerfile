ARG IMG_VERSION=2.5.0-alpine3.7
FROM ruby:${IMG_VERSION}
ARG BUILD_DATE
ARG GIT_SHA
CMD ["sass"]
ENTRYPOINT ["sass"]
LABEL org.schema-label.build-date=${BUILD_DATE} \
      org.schema-label.vcs-ref=${GIT_SHA} \
      org.schema-label.vcs-url="https://github.com/darrengruen/docker-sass" \
      org.schema-label.name="Docker SASS" \
      org.schema-label.description="SASS in a Docker container"

RUN apk add --update alpine-sdk
RUN gem install sass

