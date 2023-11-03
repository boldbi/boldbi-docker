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

* Operating System: Use the Bold BI Docker on the following operating systems: 
  * Windows
  * Linux
  * Mac
* CPU: 2-core.
* Memory: 4 GB RAM.
* Disk Space: 8 GB or more.

### Software requirements

The following software requirements are necessary to run the Bold BI Enterprise edition:

* Database: Microsoft SQL Server 2012+ | PostgreSQL | MySQL
* Application: [Docker](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/). 
* Web Browser: Microsoft Edge, Mozilla Firefox, and Chrome.

# Supported tags

| Tags               | OS Version    | Last Modified(MM/DD/YYYY)|
| -------------      | ------------- | ------------- |
| `6.16.12`, `latest` | Debian 10  (amd64,arm64)    | 11/03/2023 |
| `6.16.12-alpine`    | Alpine 3.13  (amd64, arm64)  | 11/03/2023 |
| `6.16.12-focal`     | Ubuntu 20.04  (amd64, arm64)       | 11/03/2023 |

# How to use this image?

The above Bold BI image can be deployed using Docker or Docker Compose. In the following section, we are going to start the Bold BI application and a separate PostgreSQL instance with volume mounts for data persistence using Docker Compose.

1. Download the Docker Compose file by using the following command.
   
   ```sh
   curl -o docker-compose.yml "https://raw.githubusercontent.com/boldbi/boldbi-docker/main/deploy/single-container-pre-configured/docker-compose.yml"
   ```
2. Open the Docker Compose file, fill the BOLD_SERVICES_UNLOCK_KEY value, and save it. You can refer to [this](https://support.boldbi.com/kb/article/12983/how-to-get-offline-license-key-for-bold-bi) KB document to obtain the offline Bold BI unlock key.

    ![docker-compose-variable](docs/images/docker-compose-variable.png)

3. Run the command below. This command will start the Bold BI and Postgres SQL containers and display the Bold BI logs to provide information about the installation status of the Bold BI application.
   
   ```sh
   docker-compose up -d; docker-compose logs -f boldbi
   ```
   ![docker-compose-command](docs/images/docker-compose-up.png)

4. Now, access the Bold BI application by entering the URL as `http://localhost:8085` or `http://host-ip:8085` in the browser. When opening this URL in the browser, it will configure the application startup in the background and display the page below within a few seconds. The default port number mentioned in the compose file is 8085. If you are making changes to the port number, then you need to use that port number for accessing the Bold BI application.
   
   ![docker-compose-startup](docs/images/docker-startup.png)

# How to Deploy Bold BI using Advanced Configuration?

In this section, you will learn how to run the Bold BI application using advanced configurations such as configuring Bold BI using an existing DB server, using a host directory as a persistent volume, configuring startup manually, configuring an SSL certificate, and running a multi-container BI application.

1. [How to deploy Bold BI using existing DB server](docs/how-to-deploy-bold-bi-using-existing-db-server.md)? 

2. [How to deploy Bold BI and configure startup manually](docs/how-to-deploy-bold-bi-and-configure-startup-manually.md)?

3. [How to use host path as Persistent Volume](docs/how-to-use-host-path-as-persistent-volume-for-bold-bi-deployment.md)?

4. [How to configure SSL certificate for Bold BI](docs/FAQ/how-to-configure-ssl-for-docker-compose.md)?

5. [How to start multiple containers Bold BI with Docker Compose](docs/multiple-container.md)?

6. [Bold BI supported environment variables and their usage](docs/environment-variable.md)?

# License

https://www.boldbi.com/terms-of-use#embedded<br />

The images are provided for your convenience and may contain other software that is licensed differently (Linux system, Bash, and more from the base distribution, along with any direct or indirect dependencies of the Bold BI platform).

These pre-built images are provided for your convenience and include all optional and additional libraries by default. These libraries may be subject to different licenses than the Bold BI product.

If you want to install Bold BI from scratch and precisely control which optional libraries are installed, please download the stand-alone product from boldbi.com. If you have any questions, please contact the Bold BI team (https://www.boldbi.com/support).

It is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# FAQ

[How to configure SSL for Bold BI application in single container and multiple container?](https://github.com/boldbi/boldbi-docker/blob/main/docs/FAQ/how-to-configure-ssl-for-docker-compose.md)

[How to reset the database for Bold BI application in docker environment?](https://github.com/boldbi/boldbi-docker/blob/main/docs/FAQ/how-to-configure-ssl-for-docker-compose.md)

[How to auto deploy multiple services Bold BI via docker-compose?](https://github.com/boldbi/boldbi-docker/blob/main/docs/FAQ/how-to-auto-deploy-bold-bi-multiple-services-in-docker-compose.md)

[How to upgrade a new image in docker environment using docker compose yaml file?](https://support.boldbi.com/kb/article/462/how-to-upgrade-a-new-image-in-docker-environment-using-docker-compose-yaml-file)

