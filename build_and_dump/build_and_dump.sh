#!/bin/sh
echo "Stopping all services and removing volumes and clear the volumes."
docker compose -f ./../docker-compose.yml down -v
docker compose down -v

echo "Starting build_and_dump docker compose (detached) - this eventually builds a fresh database."
docker compose up -d

until curl --silent --fail http://localhost:8080/fhir/DEFAULT/metadata
do
  echo "HAPI server health check not ready yet"
  sleep 5
done

echo "HAPI server is running - creating backup"
docker exec kt2_postgres pg_dump -F plain -U postgres -C fhir_service > ../docker-entrypoint-initdb.d/01-restore-fhir-database.sql

echo "Backup created, stopping docker and removing volumes"
docker compose down -v
