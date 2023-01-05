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

## Deployment Prerequisites

### Hardware requirements

The following hardware requirements are necessary to run the Bold BI solution:

* Operating System: You can use the Bold BI Docker on the following operating systems: 
  * Windows
  * Ubuntu 20.04 LTS
  * Cent OS 7
  * Mac
* CPU: 4-core.
* Memory: 16 GB RAM.
* Disk Space: 8 GB or more.

### Software requirements

The following software requirements are necessary to run the Bold BI Enterprise edition:

* Database: Microsoft SQL Server 2012+ | PostgreSQL | MySQL
* Application: Docker
* Web Browser: Microsoft Edge, Mozilla Firefox, and Chrome

# Supported tags

| Tags               | OS Version    | Last Modified |
| -------------      | ------------- | ------------- |
| `5.3.53`, `latest` | Debian 10  (amd64,arm64)    | 11/24/2022 |
| `5.3.53-alpine`    | Alpine 3.13  (amd64)  | 11/24/2022 |
| `5.3.53-focal`     | Ubuntu 20.04  (amd64)       | 11/24/2022 |
|`5.3.53-arm64`      | Debian 10 (arm64)|11/24/2022

# How to use this image
## Start a Bold BI instance
<br />
To quickly get started, run the following command to run Bold BI on your host machine. With this command, you would be able to access the instance from the host without the container’s IP address and the standard port mappings.<br/><br/>

```sh
docker run --name boldbi -p 80:80 -d syncfusion/boldbi
```

After running the command, you can access the Bold BI App by entering `http://localhost` or `http://host-ip` in a browser. To know more about application startups, refer [here](#application-startup).

## Advanced command


```sh
docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=<app_base_url> \
     -e OPTIONAL_LIBS=<optional_library_names> \
     -e widget_bing_map_enable=<true/false>\
     -e widget_bing_map_api_key=<widget_bing_map_api_key> \
     -v <host_path_for_appdata_files>:/application/app_data \
     -v <host_path_for_nginx_config>:/etc/nginx/sites-available \
     -d syncfusion/boldbi:<tag>
```
### Example for Advanced docker run command

```sh
docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=https://example.com \
     -e OPTIONAL_LIBS=mongodb,mysql,influxdb,snowflake,oracle,clickhouse,google \
     -e widget_bing_map_enable=true\
     -e widget_bing_map_api_key=<widget_bing_map_api_key> \
     -v D:/boldbi/app_data:/application/app_data \
     -v D:/boldbi/nginx:/etc/nginx/sites-available \
     -d syncfusion/boldbi:5.3.53
``` 

Bold BI accepts the following environment variables from the command line.
| Name                          |Required| Description   | 
| -------------                 |----------| ------------- | 
| `APP_URL`                     |No <br /><br /><br /> Needed when configuring with domain or IP| Domain or IP address with http/https protocol.<br/>For example, <br/>`http://<public_DNS_address>`<br/>`http://<public_ip_address>` <br/><br/>The default APP_URL is `http://localhost`<br/><br/> <b>Note:</b><br/>•	If you are using the IP address for the Base URL, make sure you are using the public IP of the machine instead of internal IP or local IP address. Applications can communicate with each other using the public IP alone. Host machine IP will not be accessible inside the application container.<br/>• For linux depoyment the default APP_URL is http://localhost or http://172.17.0.1<br/>• You can provide the HTTP or HTTPS scheme for APP_BASE_URL value.<br/>• Please refer to this section for [SSL Termination](docs/SSL-Termination).|
|`OPTIONAL_LIBS`|No|	These are the client libraries used in Bold BI by default.<br/><br/>`'mongodb,mysql,influxdb,snowflake,oracle,clickhouse,google'`<br/><br/>Please refer [Consent to deploy client libraries](docs/consent-to-deploy-client-libraries.md) Libraries section to know more.|
| `widget_bing_map_enable`      |No| If you need to use Bing Map widget feature, enable this to `true`.<br/>By default this feature will be set to `false`. | 
| `widget_bing_map_api_key`     |No| API key value for the Bing Map. |
|`<host_path_for_appdata_files>` |No|Persistent volume path for Bold BI application data|
|`<host_path_for_nginx_config>` |No|Persistent volume path for Nginx configuration|

<br />

## Environment variables for configuring `Application Startup` in backend

The below Environment variables are optional. If not provided a manual Application Startup configuration is needed.

| Name                          |Required| Description   | 
| -------------                 |----------| ------------- |
|`BOLD_SERVICES_UNLOCK_KEY`|Yes|License key of Bold BI|
|`BOLD_SERVICES_DB_TYPE`|Yes|Type of database server can be used for configuring the Bold BI.<br/><br />The following DB types are accepted:<br />1. mssql – Microsoft SQL Server/Azure SQL Database<br />2. postgresql – PostgreSQL Server<br />3. mysql – MySQL/MariaDB Server|
|`BOLD_SERVICES_DB_HOST`|Yes|Name of the Database Server|
|`BOLD_SERVICES_DB_PORT`|No|The system will use the following default port numbers based on the database server type.<br />PostgrSQL – 5234<br />MySQL -3306<br /><br />Please specify the port number for your database server if it is configured on a different port.<br /><br />For MS SQL Server, this parameter is not necessary.|
|`BOLD_SERVICES_DB_USER`|Yes|Username for the database server<br /><br />Please refer to [this documentation](https://help.boldbi.com/embedded-bi/faq/what-are-the-database-permissions-required-to-set-up-bold-bi-embedded/) for information on the user's permissions.|
|`BOLD_SERVICES_DB_PASSWORD`|Yes|The database user's password|
|`BOLD_SERVICES_DB_NAME`|No|If the database name is not specified, the system will create a new database called bold services.<br /><br />If you specify a database name, it should already exist on the server.|
|`BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB`|No|For PostgreSQL DB Servers, this is an optional parameter.<br />The system will use the database name `postgres` by default.<br />If your database server uses a different default database, please provide it here.|
|`BOLD_SERVICES_DB_ADDITIONAL_PARAMETERS`|No|If your database server requires additional connection string parameters, include them here.<br /><br />Connection string parameters can be found in the official document.<br />My SQL: https://dev.mysql.com/doc/connector-net/en/connector-net-8-0-connection-options.html<br />PostgreSQL: https://www.npgsql.org/doc/connection-string-parameters.html<br />MS SQL: https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectionstring<br /><br /><b>Note:</b> A semicolon(;) should be used to separate multiple parameters.|
|`BOLD_SERVICES_USER_EMAIL`|Yes|It should be a valid email.|
|`BOLD_SERVICES_USER_PASSWORD`|Yes|It should meet our password requirements.|
| `BOLD_SERVICES_BRANDING_MAIN_LOGO`<br /> `BOLD_SERVICES_BRANDING_LOGIN_LOGO`<br /> `BOLD_SERVICES_BRANDING_EMAIL_LOGO`<br /> `BOLD_SERVICES_BRANDING_FAVICON`<br /> `BOLD_SERVICES_BRANDING_FOOTER_LOGO`<br />                    |No <br /><br /><br /> If you want branding images otherwise not needed| If you want to upload the custom image as a logo of the site you can use the environement variable  If this environment variable is not present, Bold BI will use its default logo.<br /><br /> Type : URL <br /> <br /> Examble : https://cdn.boldbi.com/wp/pages/boldbi-header-menu-logo.svg <br /> <br /> Format : png, svg, jpg, jpeg <br /> <br /> **Note:** Enter the image URL for all the variables Not assign for only one.If any one of the image values is given consider other variables as required.|
|`BOLD_SERVICES_SITE_NAME`|No <br /> <br /> If you want custom site name otherwise not needed | Enter the custom site name as value |
|`BOLD_SERVICES_SITE_IDENTIFIER`|No <br /> <br /> If you want custom site identifier otherwise not needed | Enter the custom site identifier name as value |

### Auto deployment docker run command
```sh
docker run --name boldbi -p 80:80 -p 443:443 \
      -e APP_URL=<app_base_url> \
      -e OPTIONAL_LIBS=<optional_library_names> \
      -e widget_bing_map_enable=<true/false>\
      -e widget_bing_map_api_key=<widget_bing_map_api_key> \
      -e BOLD_SERVICES_UNLOCK_KEY=<Bold_BI_license_key>  \
      -e BOLD_SERVICES_DB_TYPE=<data_base_server_type>  \
      -e BOLD_SERVICES_DB_HOST=<data_base_server_host> \
      -e BOLD_SERVICES_DB_PORT=<data_base_server_port> \
      -e BOLD_SERVICES_DB_USER=<data_base_user_name> \
      -e BOLD_SERVICES_DB_PASSWORD=<data_base_server_password> \ 
      -e BOLD_SERVICES_DB_NAME=<excisting_data_base_name> \
      -e BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB=<maintenance_db_name> \
      -e BOLD_SERVICES_USER_EMAIL=<Bold_BI_user_email> \
      -e BOLD_SERVICES_USER_PASSWORD=<Bold_BI_user_password> \ 
      -e BOLD_SERVICES_BRANDING_MAIN_LOGO=<branding_image_url> \
      -e BOLD_SERVICES_BRANDING_LOGIN_LOGO=<branding_image_url> \
      -e BOLD_SERVICES_BRANDING_EMAIL_LOGO=<branding_image_url> \
      -e BOLD_SERVICES_BRANDING_FAVICON=<branding_image_url> \
      -e BOLD_SERVICES_BRANDING_FOOTER_LOGO=<branding_image_url> \
      -e BOLD_SERVICES_SITE_NAME=<site_name> \
      -e BOLD_SERVICES_SITE_IDENTIFIER=<site_identifier_name> \
      -v <host_path_for_appdata_files>:/application/app_data \
      -v <host_path_for_nginx_config>:/etc/nginx/sites-available \
      -d syncfusion/boldbi:<tag>
```
## Example for Auto deployment docker run command

```sh
docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=https://example.com \
     -e OPTIONAL_LIBS=mongodb,mysql,influxdb,snowflake,oracle,clickhouse,google \
     -e widget_bing_map_enable=true\
     -e widget_bing_map_api_key=<widget_bing_map_api_key> \
     -e BOLD_SERVICES_UNLOCK_KEY=<Bold_BI_license_key>  \
     -e BOLD_SERVICES_DB_TYPE=<data_base_server_type_Eg: mssql, mysql and postgresql>  \
     -e BOLD_SERVICES_DB_HOST=localhost \
     -e BOLD_SERVICES_DB_PORT=5432 \
     -e BOLD_SERVICES_DB_USER=boldbi-user \
     -e BOLD_SERVICES_DB_PASSWORD=boldbi@123 \ 
     -e BOLD_SERVICES_DB_NAME=bold-services \
     -e BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB=<maintenance_db_name> \
     -e BOLD_SERVICES_USER_EMAIL=admin@boldbi.com \
     -e BOLD_SERVICES_USER_PASSWORD=Admin@123 \ 
     -e BOLD_SERVICES_BRANDING_MAIN_LOGO=https://cdn.boldbi.com/wp/pages/boldbi-header-menu-logo.svg \
     -e BOLD_SERVICES_BRANDING_LOGIN_LOGO=https://cdn.boldbi.com/wp/pages/boldbi-header-menu-logo.svg \
     -e BOLD_SERVICES_BRANDING_EMAIL_LOGO=https://cdn.boldbi.com/wp/pages/boldbi-header-menu-logo.svg \
     -e BOLD_SERVICES_BRANDING_FAVICON=https://cdn.boldbi.com/wp/pages/boldbi-header-menu-logo.svg \
     -e BOLD_SERVICES_BRANDING_FOOTER_LOGO=https://cdn.boldbi.com/wp/pages/boldbi-header-menu-logo.svg \
     -e BOLD_SERVICES_SITE_NAME=bold-dashboards \
     -e BOLD_SERVICES_SITE_IDENTIFIER=branding \
     -v D:/boldbi/app_data:/application/app_data \
     -v D:/boldbi/nginx:/etc/nginx/sites-available \
     -d syncfusion/boldbi:5.3.53
```



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

Configure the Bold BI On-Premise application startup to use the application. Please refer to the following link, for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup

# Docker compose:<br/>
* [BoldBI in single container image](#start-single-container-bold-bi-with-docker-compose).

* [BoldBI in multiple container image](#start-multiple-containers-bold-bi-with-docker-compose).
## Start single container Bold BI with `docker-compose`
You can use docker-compose to easily run Bold BI in an isolated environment built with Docker containers. The image shown here is a single image containing multiple Bold BI services targeted for simplifying evaluation and minimalistic production use cases.
<br/>
Create a docker-compose.yml file that starts your `Bold BI` as well as a separate `PostgreSQL` instance with volume mounts for data persistence:

```sh
version: '3.5'

services:
  boldbi:
   image: syncfusion/boldbi
   restart: always
   ports:
     - 8085:80
   # environment:
     # - APP_URL=<app_base_url>
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
      - db_data:/var/lib/postgresql/data/
    networks:
      - boldbi

networks:
  boldbi:
  
volumes:
  boldbi_data:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '<host_path_boldbi_data>'
  db_data:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '<host_path_db_data>'
  ```

> **Note:**
> The docker volumes `boldbi_data` and `db_data` persists data of Bold BI and PostgreSQL, respectively. [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)

Now, run `docker-compose up -d` from your project directory.<br/>
 Please refer to [this guide](docs/single-container.md) to deploy Bold BI in a simplified docker-compose environment with single image.

## Start multiple containers Bold BI with `docker-compose`

Bold BI also comes with multiple images for each of the services in it to run on docker-compose, which is mainly for the production environment to scale services within Bold BI. Please refer to [this guide](docs/multiple-container.md) to get to know about the multiple images and compose details to deploy Bold BI in an advanced docker-compose environment.

# License

https://www.boldbi.com/terms-of-use/embedded<br />

The images are provided for your convenience and may contain other software that is licensed differently (Linux system, Bash, etc. from the base distribution, along with any direct or indirect dependencies of the Bold BI platform).

These pre-built images are provided for convenience and include all optional and additional libraries by default. These libraries may be subject to different licenses than the Bold BI product.

If you want to install Bold BI from scratch and precisely control which optional libraries are installed, please download the stand-alone product from boldbi.com. If you have any questions, please contact the Bold BI team (https://www.boldbi.com/support).

It is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
