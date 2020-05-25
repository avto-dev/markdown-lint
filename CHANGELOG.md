# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## Unreleased

### Added

- Added support for Keep-a-Changelog's links in the heading
- Added support for using en dashes instead of minus signs

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

- GutHub action parameter `path` renamed to `args`

## v0.0.1 - 2020-01-18

### Added

- Docker image auto-building
- Rules set (`CHANGELOG-RULE-001`, `CHANGELOG-RULE-002`, `CHANGELOG-RULE-003`) for changelog file linting
- Config file for changelog file linting

[keepachangelog]:https://keepachangelog.com/en/1.0.0/
[semver]:https://semver.org/spec/v2.0.0.html

<!-- markdownlint-disable-file MD024 -->
