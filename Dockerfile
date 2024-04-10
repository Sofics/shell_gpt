FROM python:3-slim

ENV DEFAULT_MODEL=ollama/mixtral:8x7b-instruct-v0.1-q3_K_L
ENV API_BASE_URL=http://10.31.13.98:11434
ENV DEFAULT_COLOR=yellow
ENV USE_LITELLM=true
ENV OPENAI_API_KEY=bad_key
ENV DEFAULT_TEMPERATURE=0.1
ENV DEFAULT_TOP_P=0.9
ENV IN_CONTAINER=true
ENV OS_OUTSIDE_CONTAINER="Linux/Red Hat Enterprise Linux 8.8 (Ootpa)"

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y gcc
RUN pip install --no-cache /app[litellm] && mkdir -p /tmp/shell_gpt

VOLUME /tmp/shell_gpt

ENTRYPOINT ["sgpt"]
