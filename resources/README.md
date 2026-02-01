# Test Resources

This directory contains LaTeX test files used to validate the latex2pdf-action functionality.

## Test Files

### test.tex
A comprehensive test file that includes:
- Mathematical equations and symbols (requires amsmath, amssymb, latexsym packages)
- Lists and enumeration
- Theorems and proofs
- Tables
- Basic graphics

This test validates that the action can handle complex mathematical documents.

### test-fontawesome.tex
A minimal test file that uses:
- The moderncv document class
- Font Awesome icons

This test validates that the action can:
- Install and use custom CTAN packages (moderncv, fontawesome)
- Handle special fonts and icon packages

### test-toc.tex
A simple test file with:
- Table of Contents
- Sections and subsections

This test validates that the `toc` parameter works correctly by:
- Compiling the document twice to generate the ToC
- Properly resolving all section references

## Running Tests

These test files are automatically run by the GitHub Actions workflow in `.github/workflows/test.yml`. Each test ensures that:
1. The Docker image builds successfully
2. LaTeX compilation completes without errors
3. PDF files are generated correctly
4. All required packages are installed properly
