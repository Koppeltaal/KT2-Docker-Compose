# KT2-Docker-Compose

Docker compose project to spawn the required system components that make up the
KT2 architecture: A FHIR store, an IDP, an Authorization service and the Domain
service.

## Running

```shell
$> docker-compose pull
$> docker-compose up
# [...]run tests etc.[...]
$> docker-compose down -v
```

**NOTE** how the `down -v` command will delete the containers and their data. This
setup's intention it to aid in (automated) test setups where a deterministic
and known initial state is required. When running the containers, the
underlying Postgres database is restored with:

* An initialized FHIR store service
* A first identity/account created in the Keycloak IDP:
  * username: `testrunner`
  * password: `testrunner`
* An initialized Domain service where:
  * The "Admin" role is granted to the predefined KT2 client registation, and
    its status is set to "active"
  * An additional KT2 client registration is available called "Test service",
    also with the "Admin" role and the status is set to "active".
* The "Test service" SMART client registation client id is:
  `552bfe09-3ea6-4bf8-9ecc-876276934aaa`

## Services

Once the containers are running you can access the services:

  * Keygen: This service ensures a key pair is generated. The public/private key can be found in `./secrets`. The public 
    key will automatically be added to the database. **NOTE**: Keep in mind, if you change the key pair, the
    `03-update-publickey.sql` query will not be executed as the `initdb.d` is only executed when the db is not 
    initialized yet.
  * IDP (Keycloak): http://localhost:8083/
  * Authorization service: http://localhost:8082/
  * Domain admin service: http://localhost:8081/
  * FHIR store/service: http://localhost:8080/
  * The base URL for the FHIR store is:
    http://localhost:8080/fhir/DEFAULT
  * The metadata URL for the FHIR store is:
    http://localhost:8080/fhir/DEFAULT/metadata
  * The SMART configuration can be found at:
    http://localhost:8080/fhir/DEFAULT/.well-known/smart-configurations

### Regenerate a clean state 
By default, this project restores database dumps in order to start quickly and provide a deterministic state.
However, this causes maintenance issues. When the database scheme changes, this can cause problems. As a solution, this 
project provides the [build_and_dump](./build_and_dump/README.md) folder. **NOTE**: This script will throw away all existing data from the 
volume! Click on the link to see the build_and_dump README for more information.

#### Regenerate a Keycloak realm export
Keycloak is always populated with a config file against an empty database. If you wish to extend the  config file, 
execute the following command after the Keycloak state is correct.
```bash
docker exec kt2_keycloak /opt/keycloak/bin/kc.sh export --realm kt2 --file /opt/keycloak/data/import/keycloak-kt2-realm.json
```
This will overwrite the config file at `/config/keycloak-kt2-realm.json`.

## Notes / Caveats

* The client registration will have "super powers" and not just a limited set
  of permissions. It is the intention to resolve that in the near future.
* The start up time of the full setup take a relatively long time (several tens
  of seconds). This makes integrating this in automated test suites less than
  ideal. Again, we have a start for this project now and the intention is to
  resolve this in the near future by streamlining or fine-tuning startup times.
