FROM node:13-alpine

LABEL \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="Markdown linter" \
  org.label-schema.description="Markdown linter with rules and settings presetts" \
  org.label-schema.version="1.x" \
  org.label-schema.vendor="avto-dev" \
  org.label-schema.vcs-url="https://github.com/avto-dev/markdown-lint"

RUN set -x \
  # package page: <https://github.com/igorshubovych/markdownlint-cli>
  && npm install -g markdownlint-cli \
  && markdownlint --version

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ADD ./lint /lint

ENTRYPOINT ["/docker-entrypoint.sh"]
