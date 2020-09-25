FROM node:12-alpine as builder

ARG MARKDOWN_CLI_VERSION="0.23.2"

# install packages
RUN set -x \
    # `markdownlint-cli` sources: <https://github.com/igorshubovych/markdownlint-cli>
    && npm install -g --production "markdownlint-cli@${MARKDOWN_CLI_VERSION}" \
    # `ncc` sources: <https://github.com/vercel/ncc>
    && npm install -g --production "@vercel/ncc@0.24.1"

# prepare "file system structure" for runtime
RUN set -x \
    && mkdir -p /tmp/rootfs/usr/local/bin

# pack `markdownlint-cli` into single file and put into required location
RUN set -x \
    && ncc build /usr/local/lib/node_modules/markdownlint-cli --minify --no-cache --out /tmp/markdownlint-cli-packed \
    && mv /tmp/markdownlint-cli-packed/index.js /tmp/rootfs/usr/local/bin/markdownlint

# copy additional image files
COPY ./docker-entrypoint.sh /tmp/rootfs/docker-entrypoint.sh
COPY ./lint /tmp/rootfs/lint

# Image hub: <https://hub.docker.com/r/mhart/alpine-node>, sources: <https://github.com/mhart/alpine-node>
FROM mhart/alpine-node:slim-12 as runtime

LABEL \
    # Docs: <https://github.com/opencontainers/image-spec/blob/master/annotations.md>
    org.opencontainers.image.title="Markdown linter" \
    org.opencontainers.image.description="Markdown linter with rules and settings presetts" \
    org.opencontainers.image.url="https://github.com/avto-dev/markdown-lint" \
    org.opencontainers.image.source="https://github.com/avto-dev/markdown-lint" \
    org.opencontainers.image.vendor="avto-dev" \
    org.opencontainers.image.licenses="MIT"

# copy all files from builder as a single layer
COPY --from=builder /tmp/rootfs /

RUN set -x \
    # create node user and group
    && addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    # setup files owner
    && chown -R node:node /lint \
    # install required for image dependencies
    && apk add --no-cache bash \
    && /usr/local/bin/markdownlint --version

ENTRYPOINT ["/docker-entrypoint.sh"]
