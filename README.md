<p align="center">
 <img src="https://hsto.org/webt/jj/z4/-o/jjz4-ofmx_k18yeslacjnjuzrve.png" width="128" alt="icon">
</p>

# Pre-configured linter for markdown

[![Build][badge_automated]][link_hub]
[![Build][badge_build]][link_hub]
[![Docker Pulls][badge_pulls]][link_hub]
[![Issues][badge_issues]][link_issues]
[![License][badge_license]][link_license]

## What is this?

This repository contains Dockerfiles with application for markdown files linting. Additionally we provides setting _(rules)_ for the most useful cases, like changelog file linting.

### Supported tags

Tag name |       Full image name       | Dockerfile
:------: | :-------------------------: | :--------:
 `1.x`   | `avtodev/markdown-lint:1.x` | [link](https://github.com/avto-dev/markdown-lint/blob/image-1.x/Dockerfile)

## v1.x

This image contains [markdownlint-cli][markdownlint-cli] and:

- Additional rules for `changelog` file linting
- Configuration file for `changelog` file linting _(it uses additional linting rules)_

> Image can be updated in any time, but all changes will be backwards compatible.

### Usage

For example, you can lint your `CHANGELOG.md` file using following command:

```bash
$ docker run \
    --rm -v "$(pwd)/CHANGELOG.md:/CHANGELOG.md"\
    avtodev/markdown-lint:1.x \
    --rules /lint/rules/changelog.js --config /lint/config/changelog.yml /CHANGELOG.md
```

### License

MIT. Use anywhere for your pleasure.

[badge_automated]:https://img.shields.io/docker/cloud/automated/avtodev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_pulls]:https://img.shields.io/docker/pulls/avtodev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_issues]:https://img.shields.io/github/issues/avto-dev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_build]:https://img.shields.io/docker/cloud/build/avtodev/markdown-lint.svg?style=flat-square&maxAge=30
[badge_license]:https://img.shields.io/github/license/avto-dev/markdown-lint.svg?style=flat-square&maxAge=30
[link_hub]:https://hub.docker.com/r/avtodev/markdown-lint/
[link_license]:https://github.com/avto-dev/markdown-lint/blob/master/LICENSE
[link_issues]:https://github.com/avto-dev/markdown-lint/issues
[markdownlint-cli]:https://github.com/igorshubovych/markdownlint-cli
