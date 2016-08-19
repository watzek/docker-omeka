# Omeka for Docker
## How to use me:
### I just want a fresh, containerized install of Omeka:
- ensure the latest versions of `docker` and `docker-compose` are installed.
- copy the contents of `docker-compose.yml` to a local file, or simply clone the whole repo.
- run `docker-compose up -d` to bring up the `mysql` and `omeka` containers.
- open a browser and install your Omeka at `localhost:8000`.

#### this will:
- create a `mysql` container with the latest version of mysql, root password `omeka`, and database named `omeka`
- make the `mysql` container's database accessible at `./.data/`
- create an `omeka` container with the latest version of Omeka, serving the app to port 8000 locally, linked to the `mysql` container

### I want to make my own custom Omeka image:

- clone the repository and run `docker build -t my-custom-omeka .`
- see the wiki for more information on how the Omeka image is built.
