![LateX CV to PDF](https://github.com/thomas-chauvet/latex2pdf-action/workflows/LateX%20CV%20to%20PDF/badge.svg)

# latex2pdf-action

GitHub action to convert LaTeX documents to PDF files using `LuaTeX`.

## Features

- Compile LaTeX documents to PDF using LuaTeX
- Support for custom CTAN packages
- Table of Contents (ToC) generation with double compilation
- Based on lightweight TinyTeX distribution
- Ubuntu 24.04 LTS base image for security and stability

# Parameters

- `output_dir`: use it to get the PDF file at a specific location at the end of the compilation.
- `main_latex_file`: main latex file to convert (ex: `main.tex`).
- `ctan_packages`: Extra package from CTAN to install. List of packages available [here](http://mirror.ctan.org/systems/texlive/tlnet/archive). Each package must be separated by a space (ex: "moderncv xargs")."
- `toc`: boolean to add ToC or not. Default `false`. It will compile the document twice to generate the ToC with `LuaTeX`.

# Use it in your pipeline

You can refer to the [example](https://github.com/thomas-chauvet/latex2pdf-action/blob/main/.github/workflows/test.yml) attached in this repository.

In the example below we compile the document in PDF and upload as an artefact of the pipeline:

```yml
name: LateX to PDF

on:
  push:
    branches: 
      - main
      - develop
    tags:
       - '*'
  pull_request:
    branches: [ main ]

jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v4
      - name: latex2pdf
        id: compile-latex-document
        uses: thomas-chauvet/latex2pdf-action@1.0.5
        with:
          output_dir: output
          main_latex_file: test.tex
          ctan_packages: amsmath amsfonts lua-uni-algos
      - name: Upload PDF to the workflow tab
        id: upload-workflow-tab
        uses: actions/upload-artifact@v4
        with:
          name: output
          path: output/test.pdf
```

You can find a more complete example in my [CV repository](https://github.com/thomas-chauvet/cv_latex) with everything to release the PDF document.

# Development

## Test locally

Build docker image:
```bash
docker build -t latex2pdf .
```

Run the example:
```bash
docker run \
  -e OUTPUT_DIR="output" \
  -e MAIN_LATEX_FILE="test.tex" \
  -e CTAN_PACKAGES="amssymb latexsym amsmath" \
  -v "${PWD}/resources/test.tex":"/test.tex" \
  -v "${PWD}/output":"/output" \
  latex2pdf
```

# Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## Running Tests

The project includes automated tests that run on every push. You can see the test workflow in [.github/workflows/test.yml](.github/workflows/test.yml).

# Notes

The Docker image used to compile documents is based on Ubuntu 24.04 LTS and the excellent work of [@Yihui](https://github.com/yihui) for [TinyTeX](https://github.com/yihui/tinytex). This allows the image to stay relatively small and use only what is needed.

## License

This project is open source and available under the MIT License.
