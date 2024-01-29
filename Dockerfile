FROM python:3.10-slim-bullseye

RUN pip install --upgrade pip
COPY . /imfe-docs
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8000

WORKDIR /imfe-docs

ENTRYPOINT ["mkdocs"]

CMD ["serve", "--dev-addr=0.0.0.0:8000"]
