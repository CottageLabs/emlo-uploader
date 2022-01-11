FROM amancevice/pandas:1.3.4-slim

WORKDIR /usr/src/app

RUN apt-get update && apt-get -y install libpq-dev gcc

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .
COPY docker/ .

CMD ["./entrypoint.sh"]
