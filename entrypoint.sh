#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h $DB_HOST -U $DB_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create if it doesn't exist.
if [[ -z `PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USER -Atqc "\\list ${DB_NAME}"` ]]; then
  echo "Database ${DB_NAME} does not exist. Creating..."
  PGPASSWORD=$DB_PASSWORD createdb -h $DB_HOST -U $DB_USER -E UTF8 $DB_NAME -l en_US.UTF-8 -T template0
  echo "Database ${DB_NAME} created."
fi

exec python main.py
