FROM python:3-slim

ENV DEFAULT_MODEL=ollama/coding:latest
ENV API_BASE_URL=http://10.31.13.98:11436
ENV DEFAULT_COLOR=yellow
ENV USE_LITELLM=true
ENV OPENAI_API_KEY=bad_key
ENV SHELL_INTERACTION=false
# OS_NAME set to the output of "grep -oP '^PRETTY_NAME="\K[^"]+' /etc/os-release"
ENV OS_NAME="Red Hat Enterprise Linux 8.6 (Ootpa)"
ENV SHELL_NAME=auto

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y gcc
RUN pip install --no-cache /app[litellm] && mkdir -p /tmp/shell_gpt

VOLUME /tmp/shell_gpt

ENTRYPOINT ["sgpt"]
