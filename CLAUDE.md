# CLAUDE.md

## Project Overview

GitHub Action that converts LaTeX documents to PDF using LuaTeX. It runs inside a Docker container based on Ubuntu 24.04 LTS with TinyTeX, a lightweight TeX distribution.

## Repository Structure

```
├── action.yml          # GitHub Action definition (inputs, outputs, runtime config)
├── Dockerfile          # Container: Ubuntu 24.04 LTS + TinyTeX + LuaTeX
├── entrypoint.sh       # Main script: installs packages, compiles LaTeX
├── LICENSE             # MIT License
├── resources/          # Test LaTeX files
│   ├── test.tex              # Math packages test
│   ├── test-fontawesome.tex  # FontAwesome/moderncv test
│   ├── test-toc.tex          # Table of Contents test
│   └── README.md             # Test file documentation
├── .github/workflows/
│   └── test.yml        # CI: sequential test steps in single job
├── .pre-commit-config.yaml   # Pre-commit hooks configuration
├── .dockerignore
├── .gitignore          # Comprehensive LaTeX auxiliary file patterns
├── CHANGELOG.md
├── CONTRIBUTING.md
└── README.md
```

## Key Files

- **action.yml**: Defines 4 inputs (`output_dir`, `main_latex_file`, `ctan_packages`, `toc`) and 1 output (`time`). Runs via Docker.
- **entrypoint.sh**: POSIX shell script (`#!/bin/sh -l`) with `set -e`. Requires `OUTPUT_DIR` and `MAIN_LATEX_FILE` env vars (fails fast if unset). Installs xetex + optional CTAN packages via `tlmgr`, runs `lualatex` (twice if TOC enabled).
- **Dockerfile**: Ubuntu 24.04 LTS base, single-layer apt install (perl, wget, libfontconfig1, fonts-font-awesome), then TinyTeX bootstrap.

## Development Workflow

### Testing locally with Docker

```bash
docker build -t latex2pdf .
docker run -e OUTPUT_DIR="output" -e MAIN_LATEX_FILE="test.tex" \
  -e CTAN_PACKAGES="amsmath amsfonts lua-uni-algos" \
  -v "${PWD}/resources/test.tex":"/test.tex" \
  -v "${PWD}/output":"/output" latex2pdf
```

### Pre-commit hooks

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

### CI

The workflow in `.github/workflows/test.yml` triggers on pushes to `main`/`develop`, tags, and PRs to `main`. It runs sequential test steps in a single job testing different LaTeX features (math, fontawesome, TOC) and uploads PDF artifacts.

## Coding Conventions

- **Shell**: POSIX sh, not bash. Use `[ ]` tests, not `[[ ]]`.
- **Dockerfile**: Combine apt commands into single RUN to minimize layers.
- **File naming**: Lowercase with hyphens (`test-fontawesome.tex`).
- **Action inputs**: Snake_case (`output_dir`, `main_latex_file`).
- **CI step naming**: `compile-latex-document-with-{feature}`.
- **Error handling**: `set -e` in entrypoint for fail-fast; required env vars guarded with `${VAR:?}`.
- **Variable quoting**: All variables should be quoted, except `$CTAN_PACKAGES` which uses intentional word-splitting (marked with `# shellcheck disable=SC2086`).

## Dependencies

- **Base**: Ubuntu 24.04 LTS (Noble)
- **TeX**: TinyTeX (from yihui.org), LuaTeX compiler, tlmgr package manager
- **System**: perl, wget, libfontconfig1, fonts-font-awesome
- **Always installed at runtime**: xetex
- **Common CTAN packages**: amsmath, amsfonts, moderncv, colortbl, fontawesome, lua-uni-algos

## Common Tasks

| Task                 | Command                                               |
| -------------------- | ----------------------------------------------------- |
| Build Docker image   | `docker build -t latex2pdf .`                         |
| Run action locally   | See Docker run example above                          |
| Run pre-commit hooks | `pre-commit run --all-files`                          |
| Add a new test       | Create `.tex` in `resources/`, add step in `test.yml` |
| Add a new input      | Update `action.yml` inputs + `entrypoint.sh` logic    |

## External LLMs

- `codex` - OpenAI Codex CLI (`codex exec -s read-only "prompt"`)
- `gemini` - Google Gemini CLI (`gemini -s "prompt"`)
