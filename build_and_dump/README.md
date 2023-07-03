# Build and Dump

This `docker compose` project removes all old volumes, starts the services
against empty databases to create the schemes with the project's initialization
logic instead.

The main use-case is rebuilding the `/docker-entrypoint-initdb.d/01-restore-fhir-database.sql`
file as the FHIR service can change over time.

In other words, the main target audience for build-and-dump tooling is the
__maintainers__ of this KT2 Docker Compose repository and configuration.

## Important

Running this scrip removes all volumes

## Explanation

Have a look at the [build_and_dump.sh](./build_and_dump.sh) for the stepts that
are executed

## Running the script

In order to run the script execute the following steps:

1. Make sure you `cd` into the `build_and_dump` folder
2. Make sure it's okay that all current data is removed
3. Execute the script `./build_and_dump.sh`
4. Wait until the sh script is done and verify that the
   `/docker-entrypoint-initdb.d/01-restore-fhir-database.sql` is updated
5. After this, you can simply run `docker compose` from the root of the
   project, and it will use the new data
6. When all looks good after tests, this can be committed

### Domain admin and Keycloak backups?

1. Keycloak is fully restored from the [config
   file](../config/keycloak-kt2-realm.json)
2. Domain admin has a very low risk of changing over time and is simply
   restored in a [static backup
   file](../docker-entrypoint-initdb.d/02-restore-domain-admin-database.sql)
