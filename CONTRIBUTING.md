# Contributing to latex2pdf-action

Thank you for your interest in contributing to latex2pdf-action! This document provides guidelines and instructions for contributing.

## Development Setup

### Prerequisites

- Docker installed on your system
- Git for version control
- A GitHub account

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/thomas-chauvet/latex2pdf-action.git
cd latex2pdf-action
```

2. Build the Docker image:
```bash
docker build -t latex2pdf .
```

3. Test locally with the provided test files:
```bash
docker run \
  -e OUTPUT_DIR="output" \
  -e MAIN_LATEX_FILE="test.tex" \
  -e CTAN_PACKAGES="amssymb latexsym amsmath" \
  -v "${PWD}/resources/test.tex":"/test.tex" \
  -v "${PWD}/output":"/output" \
  latex2pdf
```

## Making Changes

### Workflow

1. Fork the repository
2. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes
4. Test your changes locally
5. Commit your changes with clear, descriptive commit messages
6. Push to your fork and submit a pull request

### Testing

Before submitting a pull request, ensure that:

1. The Docker image builds successfully
2. All test cases in `.github/workflows/test.yml` pass
3. Your changes work with different LaTeX documents (test with resources/test.tex, resources/test-fontawesome.tex, and resources/test-toc.tex)

### Pull Request Guidelines

- Provide a clear description of the changes
- Reference any related issues
- Ensure all tests pass
- Update documentation if necessary
- Keep changes focused and atomic

## Code Style

- Use clear, descriptive variable names
- Add comments for complex logic
- Follow shell script best practices in `entrypoint.sh`
- Keep Dockerfile layers optimized for caching

## Reporting Issues

When reporting issues, please include:

- A clear description of the problem
- Steps to reproduce the issue
- Expected vs actual behavior
- Your LaTeX document structure (if relevant)
- Error messages or logs

## Questions?

Feel free to open an issue for any questions or discussions about contributing.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
