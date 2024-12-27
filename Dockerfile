FROM ahmettoguz/postgresql-client

WORKDIR /ahmet

COPY ./init.sql .

CMD /usr/bin/psql -U "$USERNAME" -d "$DATABASE" -h "$HOST" -f /ahmet/init.sql