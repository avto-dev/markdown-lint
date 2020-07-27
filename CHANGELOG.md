# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## UNRELEASED

### Fixed

- Quoting of `INPUT_*` env variables to allow multiple arguments in 1 env var

## v1.3.0 - 2020-06-19

### Added

- Support for globstar (`**`) by changing the shell to bash [#6]

[#6]:https://github.com/avto-dev/markdown-lint/pull/6

## v1.2.0 - 2020-05-28

### Added

- Support for Keep-a-Changelog's links in the heading [#4]
- Support for using en dashes instead of minus signs [#4]
- Support for passing multiple parameters to `markdown-lint` [#3]

## v1.1.0 - 2020-02-11

### Added

- Changelog rule `CHANGELOG-RULE-004` - Only one "unreleased" version header allowed

### Changed

- Changelog rule `CHANGELOG-RULE-004` enabled in changelog linter config `changelog.yml`

## v1.0.0 - 2020-01-18

### Changed

- First public release

## v0.0.2 - 2020-01-18

### Changed

- GitHub action parameter `path` renamed to `args`

## v0.0.1 - 2020-01-18

### Added

- Docker image auto-building
- Rules set (`CHANGELOG-RULE-001`, `CHANGELOG-RULE-002`, `CHANGELOG-RULE-003`) for changelog file linting
- Config file for changelog file linting

[keepachangelog]:https://keepachangelog.com/en/1.0.0/
[semver]:https://semver.org/spec/v2.0.0.html
[#3]:https://github.com/avto-dev/markdown-lint/pull/3
[#4]:https://github.com/avto-dev/markdown-lint/pull/4
