# Use the official Python slim image
FROM python:3-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl

RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:${PATH}"

CMD ["init.sh", "-c", "/bin/zsh"]