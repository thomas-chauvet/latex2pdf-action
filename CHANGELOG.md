# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-02-06

### Fixed

- Fixed TOC compilation bug: first lualatex pass was missing `-output-directory`, causing .aux files to land in the wrong directory
- Fixed typos in action.yml ("intance", "there's is")
- Fixed CTAN URL to use HTTPS

### Added

- Added required env var guards (`OUTPUT_DIR`, `MAIN_LATEX_FILE`) for fail-fast behavior
- Added MIT LICENSE file
- Added `outputs` section to action.yml documenting the `time` output
- Added `permissions: contents: read` to CI workflow (security best practice)

### Changed

- Quoted all shell variables in entrypoint.sh (except intentional `$CTAN_PACKAGES` word-splitting)
- Renamed CI workflow from "LateX CV to PDF" to "Test LaTeX to PDF"
- Renamed CI upload steps and artifact names for consistency
- Updated README badge to stable workflow-file format
- Fixed README heading hierarchy
- Updated Docker run examples to match current CI packages
- Updated CLAUDE.md to reflect current repository state (Ubuntu 24.04, sequential CI steps, etc.)
- Updated pre-commit hook versions to latest stable releases

## [1.1.0] - Previous Release

### Changed

- Updated base Docker image from Ubuntu 18.04 (bionic) to Ubuntu 24.04 LTS for improved security and stability
- Updated GitHub Actions in workflow from v2 to v4 (actions/checkout@v4, actions/upload-artifact@v4)
- Renamed default branch from `master` to `main` throughout documentation and workflows
- Updated deprecated `::set-output` command to use `$GITHUB_OUTPUT` environment file
- Improved documentation with additional sections and clearer structure

### Added

- Added `set -e` to entrypoint.sh for proper error handling and exit codes
- Added TOC parameter to action.yml environment variables
- Added CONTRIBUTING.md with development guidelines
- Added CHANGELOG.md to track project changes
- Added Features section to README
- Added Contributing section to README
- Added License information to README
- Added test validation section to documentation
- Added pre-commit configuration for automated code quality checks (ShellCheck, Hadolint, Prettier, etc.)
- Added Code Quality section to README with pre-commit setup instructions

### Fixed

- Fixed missing TOC environment variable in action.yml that prevented the feature from working
- Fixed deprecated GitHub Actions syntax

## [1.0.5] - Previous Release

### Added

- Support for Table of Contents (ToC) generation
- Documentation for the `toc` parameter

[2.0.0]: https://github.com/thomas-chauvet/latex2pdf-action/compare/1.1.0...2.0.0
[1.1.0]: https://github.com/thomas-chauvet/latex2pdf-action/compare/1.0.5...1.1.0
[1.0.5]: https://github.com/thomas-chauvet/latex2pdf-action/releases/tag/1.0.5
