![LateX CV to PDF](https://github.com/thomas-chauvet/latex2pdf-action/workflows/LateX%20CV%20to%20PDF/badge.svg)

# latex2pdf-action

GitHub action to convert LaTeX document in PDF file

# Parameters

- `output_dir`: use it to get the PDF file at a specific location at the end of the compilation.
- `main_latex_file`: main latex file to convert (ex: `main.tex`).
- `ctan_packages`: Extra package from CTAN to install. List of packages available [here](http://mirror.ctan.org/systems/texlive/tlnet/archive). Each package must be separated by a space (ex: "moderncv xargs")."

# Use it in your pipeline

You can refer to the [example](https://github.com/thomas-chauvet/latex2pdf-action/blob/master/.github/workflows/test.yml) attached in this repository.

In the example below we compile the document in PDF and upload as an artefact of the pipeline:

```yml
name: LateX to PDF

on:
  push:
    branches: 
      - master
      - develop
    tags:
       - '*'
  pull_request:
    branches: [ master ]

jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2
      - name: latex2pdf
        id: compile-latex-document
        uses: thomas-chauvet/latex2pdf-action@1.0.3
        with:
          output_dir: output
          main_latex_file: test.tex
          ctan_packages: amssymb latexsym amsmath
      - name: Upload PDF to the workflow tab
        id: upload-workflow-tab
        uses: actions/upload-artifact@v2
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

# Notes

The `Docker` images used to compile the document is based on `Ubuntu` and the excellent work of @Yihui for [TinyTeX](https://github.com/yihui/tinytex). It allows the image to stay relatively small and use only what is needed.
