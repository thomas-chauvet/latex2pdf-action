# CLAUDE.md

## Project Overview

GitHub Action that converts LaTeX documents to PDF using LuaTeX. It runs inside a Docker container based on Ubuntu 18.04 with TinyTeX, a lightweight TeX distribution.

## Repository Structure

```
├── action.yml          # GitHub Action definition (inputs, runtime config)
├── Dockerfile          # Container: Ubuntu Bionic + TinyTeX + LuaTeX
├── entrypoint.sh       # Main script: installs packages, compiles LaTeX
├── resources/          # Test LaTeX files
│   ├── test.tex              # Math packages test
│   ├── test-fontawesome.tex  # FontAwesome/moderncv test
│   └── test-toc.tex          # Table of Contents test
├── .github/workflows/
│   └── test.yml        # CI: 3 parallel test jobs
├── .dockerignore
├── .gitignore          # Comprehensive LaTeX auxiliary file patterns
└── README.md
```

## Key Files

- **action.yml**: Defines 4 inputs: `output_dir`, `main_latex_file`, `ctan_packages`, `toc`. Runs via Docker.
- **entrypoint.sh**: POSIX shell script (`#!/bin/sh -l`). Installs xetex + optional CTAN packages via `tlmgr`, runs `lualatex` (twice if TOC enabled).
- **Dockerfile**: Single-layer apt install (perl, wget, libfontconfig1, fonts-font-awesome), then TinyTeX bootstrap.

## Development Workflow

### Testing locally with Docker

```bash
docker build -t latex2pdf .
docker run -e OUTPUT_DIR="output" -e MAIN_LATEX_FILE="test.tex" \
  -e CTAN_PACKAGES="amsmath" -v "${PWD}/resources:/var/local" latex2pdf
```

### CI

The workflow in `.github/workflows/test.yml` triggers on pushes to `master`/`develop`, tags, and PRs to `master`. It runs 3 parallel jobs testing different LaTeX features (math, fontawesome, TOC) and uploads PDF artifacts.

## Coding Conventions

- **Shell**: POSIX sh, not bash. Use `[ ]` tests, not `[[ ]]`.
- **Dockerfile**: Combine apt commands into single RUN to minimize layers.
- **File naming**: Lowercase with hyphens (`test-fontawesome.tex`).
- **Action inputs**: Snake_case (`output_dir`, `main_latex_file`).
- **CI job naming**: `compile-latex-document-with-{feature}`.
- **No error handling in entrypoint** — relies on shell fail-fast behavior.
- **Unquoted variable expansion** is used in `entrypoint.sh` (intentional, kept minimal).

## Dependencies

- **Base**: Ubuntu 18.04 (Bionic)
- **TeX**: TinyTeX (from yihui.org), LuaTeX compiler, tlmgr package manager
- **System**: perl, wget, libfontconfig1, fonts-font-awesome
- **Always installed at runtime**: xetex
- **Common CTAN packages**: amsmath, amsfonts, moderncv, colortbl, fontawesome, lua-uni-algos

## Common Tasks

| Task | Command |
|------|---------|
| Build Docker image | `docker build -t latex2pdf .` |
| Run action locally | See Docker run example above |
| Add a new test | Create `.tex` in `resources/`, add job in `test.yml` |
| Add a new input | Update `action.yml` inputs + `entrypoint.sh` logic |
