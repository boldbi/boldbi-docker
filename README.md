<a href="https://www.boldbi.com"><img alt="boldbi" width="400" src="https://cdn.boldbi.com/DevOps/boldbi-logo.svg"></a>
<br/>
<br/>

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/boldbi/boldbi-docker?sort=semver)](https://github.com/boldbi/boldbi-docker/releases/latest)
[![Documentation](https://img.shields.io/badge/docs-help.boldbi.com-blue.svg)](https://help.boldbi.com/embedded-bi)
[![File Issues](https://img.shields.io/badge/file_issues-boldbi_support-blue.svg)](https://www.boldbi.com/support)

# What is Bold BI

Bold BI is a powerful business intelligence dashboard software that helps you to get meaningful insights from your business data and make better decisions.

It is an end-to-end solution for creating, managing, and sharing interactive business dashboards that include a powerful dashboard designer for composing easily.

With deep embedding, you can interact more with your data and get insights directly from your application.

# Deployment Prerequisites

### Hardware requirements

The following hardware requirements are necessary to run the Bold BI solution:

* Operating System: You can use the Bold BI Docker on the following operating systems: 
  * Windows
  * Linux
  * Mac
* CPU: 2-core.
* Memory: 4 GB RAM.
* Disk Space: 8 GB or more.

### Software requirements

The following software requirements are necessary to run the Bold BI Enterprise edition:

* Database: Microsoft SQL Server 2012+ | PostgreSQL | MySQL
* Application: [Docker](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/) 
* Web Browser: Microsoft Edge, Mozilla Firefox, and Chrome

# Supported tags

| Tags               | OS Version    | Last Modified(MM/DD/YYYY)|
| -------------      | ------------- | ------------- |
| `6.8.9`, `latest` | Debian 10  (amd64,arm64)    | 07/05/2023 |
| `6.8.9-alpine`    | Alpine 3.13  (amd64)  | 07/05/2023 |
| `6.8.9-focal`     | Ubuntu 20.04  (amd64)       | 07/05/2023 |
|`6.8.9-arm64`      | Debian 10 (arm64)|07/05/2023

# How to use this image

The above Bold BI image can be deployed using Docker or Docker Compose. In the following section, we are going to starts the BoldBI and a separate PostgreSQL instance with volume mounts for data persistence.

### Using Docker Compose 

1. Download docker compose file using the below command.
   ```sh
   curl -o docker-compose.yml "https://raw.githubusercontent.com/Vinoth-Krishnamoorthy/boldbi-docker/main/deploy/single-container/docker-compose.yml"
   ```
2.Open the docker compose file and fill the mandatory fields - App_URL and Unlock Key.

3. Run docker compose up command
   ```sh
  docker-compose up -d
   ```
4. After running the command, you can access the Bold BI App by entering APP_URL in a browser.


### Using Docker 

1. Run the below command to run Postgres SQL container.
2. Run the below command to run Bold BI after replacing mandatory fields -App_URL and Unlock Key.
   ```sh
   docker run --name boldbi -p 8085:80 -p 443:443 \
      -e APP_URL=http://localhostORhost-ip:8085 \   
      -e BOLD_SERVICES_UNLOCK_KEY=<Bold_BI_license_key>  \
      -e BOLD_SERVICES_DB_TYPE=postgresql  \
      -e BOLD_SERVICES_DB_HOST=pgdb \
      -e BOLD_SERVICES_DB_USER=postgres \
      -e BOLD_SERVICES_DB_PASSWORD=Admin@123 \
      -e BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB=postgres \
      -e BOLD_SERVICES_USER_EMAIL=adminuser@boldbi.com \
      -e BOLD_SERVICES_USER_PASSWORD=Admin@123 \ 
      -v boldbidata:/application/app_data \
      -v postgresdata:/etc/nginx/sites-available \
      -d syncfusion/boldbi
   ```
   Refer this document to get Bold BI unlock key.
   You need to pass the same credentials that you passed in the first command as arugument here. 
4. After running the command, you can access the Bold BI App by entering APP_URL in a browser.

# How to deploy Bold BI using advanced configuration

In this section, we will see how to run Bold BI application using advanced configuration like persistence volumne and configure auto deployment using existing DB servers and run multi containers Bold BI. 

## Persistent Volume

Volumes are the preferred way to persist data in Docker containers and services. While bind mounts are dependent on the directory structure and OS of the host machine, volumes are completely managed by Docker.

### Persisting application data

You can store the application data in your host machine to make the Bold BI container a stateful application. Bold BI application will read and write the data in your host machine.
 
Replace the `<host_path_for_appdata_files>` value with a directory path from your host machine in the advanced docker run command.

> **For example**<br/>
> Windows: `-v D:/boldbi/app_data:/application/app_data`<br/>
> Linux: `-v /home/boldbi/app_data:/application/app_data`

### Nginx configuration

You can mount a host directory to the Bold BI container for maintaining the Nginx configuration. You can also store SSL certificates in this directory and can configure Nginx with them.

Replace the `<host_path_for_nginx_config>` value with a directory path from your host machine in the advanced docker run command.

> **For example**<br/>
> Windows: `-v D:/boldbi/nginx:/etc/nginx/sites-available`<br/>
> Linux: `-v /home/boldbi/nginx:/etc/nginx/sites-available`

Once, the Bold BI container started to run, you can check the directory in your host machine. The `boldbi-nginx-config` file will be generated there. You can configure the Nginx inside the container using this file.

## Application Startup

Bold BI application startup can be configured manually if you don't wish to configure application startup automatically. Please refer to the following link, for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup

## Start multiple containers Bold BI with `docker-compose`

Bold BI also comes with multiple images for each of the services in it to run on docker-compose, which is mainly for the production environment to scale services within Bold BI. Please refer to [this guide](docs/multiple-container.md) to get to know about the multiple images and compose details to deploy Bold BI in an advanced docker-compose environment.

# License

https://www.boldbi.com/terms-of-use#embedded<br />

The images are provided for your convenience and may contain other software that is licensed differently (Linux system, Bash, etc. from the base distribution, along with any direct or indirect dependencies of the Bold BI platform).

These pre-built images are provided for convenience and include all optional and additional libraries by default. These libraries may be subject to different licenses than the Bold BI product.

If you want to install Bold BI from scratch and precisely control which optional libraries are installed, please download the stand-alone product from boldbi.com. If you have any questions, please contact the Bold BI team (https://www.boldbi.com/support).

It is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# FAQ

[How to configure SSL for Bold BI application in single container and multiple container?](https://github.com/boldbi/boldbi-docker/blob/main/docs/FAQ/how-to-configure-ssl-for-docker-compose.md)

[How to reset the database for Bold BI application in docker environment?](https://github.com/boldbi/boldbi-docker/blob/main/docs/FAQ/how-to-configure-ssl-for-docker-compose.md)

[How to auto deploy multiple services Bold BI via docker-compose?](https://github.com/boldbi/boldbi-docker/blob/main/docs/FAQ/how-to-auto-deploy-bold-bi-multiple-services-in-docker-compose.md)

