ARG APP_IMAGE=python:3.6.1-alpine

FROM $APP_IMAGE AS base

FROM base as builder

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt

RUN pip install --install-option="--prefix=/install" -r /requirements.txt

FROM base
ENV FLASK_APP routes.py
WORKDIR minimal-flask-example/src/
COPY --from=builder /install /usr/local
ADD . minimal-flask-example/src/

ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]
