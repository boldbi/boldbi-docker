## Run `Bold Bi` via `docker-compose`


 This quick-start guide demonstrates how to use Compose to set up and run Bold BI. Before starting, make sure you have [Compose installed](https://docs.docker.com/compose/install/)


## Define the Project
  1. Create an empty project directory.<br/>
  You can name the directory something easy for you to remember. This directory is the context for your application image. The directory should only contain resources to build that image.<br/>
  This project directory contains a docker-compose.yml file which is complete in itself for a good starter BoldBI project.This project directory contains a `docker-compose.yml` file which is complete in itself for a good starter BoldBI project.
  
  > **Tip:**
    You can use either a `.yml` or `.yaml` extension for this file. They both work.
  
  2.  Change into your project directory.<br/>
  For example, if you named your directory `my_boldbi`:

  ```sh
   $  cd my_boldbi/
   ```
   3. Create a docker-compose.yml file that starts your `BoldBI` blog and a separate `PostgreSQL` instance with volume mounts for data persistence:

<br/>

```sh
version: '3.5'

services:
  boldbi:
   image: syncfusion/boldbi
   restart: always
   ports:
      - 8080:80
   # environment:
     # - APP_BASE_URL=<app_base_url>
   networks:
     - boldbi
   volumes:
     - boldbi_data:/application/app_data
    
  pgdb:
    image: postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: <Password>
    volumes:
      - db_data:/var/lib/postgresql
    networks:
      - boldbi

networks:
  boldbi:
  
volumes:
  boldbi_data:
  db_data:
  ```

> **Note:**
> The docker volumes boldbi_data and db_data persists updates made by B to the database, as well as the installed themes and plugins. [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)

## Build the project

Now, run `docker-compose up -d` from your project directory.
<br />

This runs `docker-compose up` in detached mode, pulls the needed Docker images, and starts the boldbi and database containers, as shown in the example below.
```sh
docker-compose up -d

Creating network "my_boldbi_boldbi" with the default driver
Creating volume "my_boldbi_boldbi_data" with local driver
Creating volume "my_boldbi_db_data" with local driver
Pulling db (postgres:)...
latest: Pulling from library/postgres
7d63c13d9b9b: Pull complete
cad0f9d5f5fe: Pull complete
<...>
Digest:sha256:db927beee892dd02fbe963559f29a7867708747934812a80f83bff406a0d54fd
Status: Downloaded newer image for postgres:latest
Creating my_boldbi_boldbi_1 ... done
Creating my_boldbi_db_1     ... done
```
## Bring up BoldBI in a web browser

At this point, BoldBI should be running in http://localhost:8080 or http://host-ip:8080 (as appropriate)

> **Note:**
> The BoldBI site is not immediately available on port 8080 because the containers are still being initialized and may take a couple of minutes before the first load.
<br />

## Application Startup

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup

## Shutdown and cleanup
The command `docker-compose down` removes the containers and default network, but preserves your BoldBI database. <br /><br />
The command `docker-compose down --volumes` removes the containers, default network, and the BoldBI database.

