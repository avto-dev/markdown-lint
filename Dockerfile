FROM node:12-alpine as builder

ARG MARKDOWN_CLI_VERSION="0.23.2"

RUN set -x \
    # package page: <https://github.com/igorshubovych/markdownlint-cli>
    && npm install -g --production "markdownlint-cli@${MARKDOWN_CLI_VERSION}" \
    # prepare files for "runtime"
    && mkdir -p /tmp/rootfs/usr/local/lib \
    && cp -R /usr/local/lib/node_modules /tmp/rootfs/usr/local/lib

COPY ./docker-entrypoint.sh /tmp/rootfs/docker-entrypoint.sh
COPY ./lint /tmp/rootfs/lint

RUN set -x \
    # change node files owner
    && chown -R node:node \
        /tmp/rootfs/usr/local/lib/node_modules \
        /tmp/rootfs/lint

# Image hub: <https://hub.docker.com/r/mhart/alpine-node>, sources: <https://github.com/mhart/alpine-node>
FROM mhart/alpine-node:slim-12

LABEL \
    # Docs: <https://github.com/opencontainers/image-spec/blob/master/annotations.md>
    org.opencontainers.image.title="Markdown linter" \
    org.opencontainers.image.description="Markdown linter with rules and settings presetts" \
    org.opencontainers.image.url="https://github.com/avto-dev/markdown-lint" \
    org.opencontainers.image.source="https://github.com/avto-dev/markdown-lint" \
    org.opencontainers.image.vendor="avto-dev" \
    org.opencontainers.image.licenses="MIT"

COPY --from=builder /tmp/rootfs /

RUN set -x \
    # create node user and group
    && addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    # install required for image dependencies
    && apk add --no-cache bash \
    && ln -s /usr/local/lib/node_modules/markdownlint-cli/markdownlint.js /usr/local/bin/markdownlint \
    && /usr/local/bin/markdownlint --version

ENTRYPOINT ["/docker-entrypoint.sh"]
