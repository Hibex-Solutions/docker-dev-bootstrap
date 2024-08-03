FROM python:3.12-alpine3.19

WORKDIR /bootstrap

RUN pip install -U click

COPY . .

ENTRYPOINT ["python", "bootstrap.py"]
CMD [ "--help" ]

