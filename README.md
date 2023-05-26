# KT2-Docker-Compose
Docker compose project that helps to easily spawn the required components for Koppeltaal 2.0. Mainly used for development-purposes.

## Running
```shell
docker-compose pull
docker-compose up
```

### Getting Started
The docker compose project executes the following:

- Start a PostgreSQL database
    - With username/pwd: postgres/postgres
    - Initialized databases used by the containers
    - Data written to a volume
- Start a [Keycloak IDP](http://localhost:8083/)
  - With username/pwd: admin/admin
  - This is used instead of IRMA/YIVI
  - Imports a fully configured Realm that is used by the applications
- Starts the [auth service](http://localhost:8082/)
- Starts the [Domain Admin](http://localhost:8081/)
  - When first logging in here, you need to register a new account. Any account logs in as an admin.
- Starts the [FHIR service](http://localhost:8080/fhir/DEFAULT/metadata)

#### One-time steps after initial startup

1. Go to [Domain Admin](http://localhost:8081/)
2. Register a new user
3. Set the `admin` role and status to `approved` of the `Smart Registration Service - Domain Admin` client
4. Optionally restart the domain admin container to verify that domain admin is authorized to create a server startup `AuditEvent` resource 
