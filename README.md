# KT2-Docker-Compose

Docker compose project to spwan the required system components that make up the
Kt2 architecture: A FHIR store, an IDP, an Authorization service and the Domain
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
* The "Test service" client registation credentials are:
  * client_id: `552bfe09-3ea6-4bf8-9ecc-876276934aaa`
  * Public key (in PEM):
    ```
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAla+QxOQNCxgGa0QCvaE4
    Fo/l42wWHLHGQN2x97iSNIR63GrfSvMPqH7qw3g2LXQUTF7pVI+3hjWbzq3qUdhC
    nkS8vfmKh0Q6zkpr9P4jiPRCGZ+ZM6G0IqVz/AyN3hrY+cvYgArkFTLdtLLSuCjp
    w9bRirr1qOoL2iSE5+VDInxQmihXMZf0hNT0b0GDo39jTbr90PFbA5fxpffRKg9k
    NQaINSY0AKigjPVSFtneOY89fLCnmp6QJ63kq36MEmc7Kbz7YmJLZ3Nv+9km/PX/
    ZC9ZljsHSFh3bRws6pLdX6BajAyr6TUHnW8eBGZem8p6dvh2Yt6CGUxUVxycKFGy
    vwIDAQAB
    -----END PUBLIC KEY-----
    ```
  * The corresponding private key can be found in `secrets/signing-key.pem`

## Services

Once the containers are running you can access the services:

  * IDP (Keycloak): http://localhost:8083/
  * Authorization service: http://localhost:8082/
  * Domain admin service: http://localhost:8081/
  * FHIR store/service: http://localhost:8080/
  * The base URL for the FHIR store is:
    http://localhost:8080/fhir/DEFAULT/metadata
  * The metadata URL for the FHIR store is:
    http://localhost:8080/fhir/DEFAULT/metadata
  * The SMART configuration can be found at:
    http://localhost:8080/fhir/DEFAULT/.well-known/smart-configurations

## Notes / Caveats

* It is bad practice to commit secrets to GitHub. To unblock further steps we
  choose to compromise: **DO NOT USE THE SIGNING KEYS PROVIDED HERE FOR
  ANYTHING, BUT RUNNING A LOCAL TEST SETUP**. It is the intention to resolve
  this situation in the near future.
* The client registration will have "super powers" and not just a limited set
  of permissions. It is the intention to resolve that in the near future.
* The start up time of the full setup take a relatively long time (several tens
  of seconds). This makes integrating this in automated test suites less than
  ideal. Again, we have a start for this project now and the intention is to
  resolve this in the near future by streamlining or fine-tuning startup times.
