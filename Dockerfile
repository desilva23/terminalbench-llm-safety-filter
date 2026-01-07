FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y jq yq

COPY . /app
RUN pip install pytest pyyaml

CMD ["bash", "run-tests.sh"]
