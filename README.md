<a href="https://www.boldbi.com"><img alt="boldbi" width="400" src="https://www.boldbi.com/wp-content/uploads/2019/05/boldbi-header-menu-logo.svg"></a>
<br/>
<br/>

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/boldbi/boldbi-docker?sort=semver)](https://github.com/boldbi/boldbi-docker/releases/latest)
[![Documentation](https://img.shields.io/badge/docs-help.boldbi.com-blue.svg)](https://help.boldbi.com/embedded-bi)
[![File Issues](https://img.shields.io/badge/file_issues-boldbi_support-blue.svg)](https://support.boldbi.com)

# What is Bold BI

Bold BI is a powerful business intelligence dashboard software that helps you to get meaningful insights from your business data and make better decisions.

It is an end-to-end solution for creating, managing, and sharing interactive business dashboards that includes a powerful dashboard designer for composing easily.

With deep embedding, you can interact more with your data and get insights right from your application.

# Supported tags

| Tags               | OS Version    | Last Modified |
| -------------      | ------------- | ------------- |
| `4.1.36`, `latest` | Debian 10     | 04/16/2021 |
| `4.1.36-alpine`    | Alpine 3.13   | 05/17/2021 |
| `4.1.36-focal`     | Ubuntu 20.04        | 05/17/2021 |

# How to use this image

## Start a Bold BI instance

```sh
docker run --name boldbi -d syncfusion/boldbi
```

If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:

```sh
docker run --name boldbi -p 8080:80 -d syncfusion/boldbi
```

Then, access it via `http://localhost:8080` or `http://host-ip:8080` in a browser.

## Advanced configuration


```sh
docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=<app_base_url> \
     -e OPTIONAL_LIBS=<optional_library_names> \
     -e widget_bing_map_enable=<true/false>\
     -e widget_bing_map_api_key=<widget_bing_map_api_key> \
     -v <host_path_for_appdata_files>:/boldbi/app_data \
     -v <host_path_for_nginx_config>:/etc/nginx/sites-available \
     -d syncfusion/boldbi:<tag>
```
Bold BI accepts the following  Environments.
| Name                          | Description   | 
| -------------                 | ------------- | 
| `APP_URL`                     | Domain or IP address with http/https protocol.<br/><br/>For example, <br/>`http://<public_DNS_address>`<br/>`http://<public_ip_address>` <br/><br/>The default APP_URL is `http://localhost`<br/> | 
|`OPTIONAL_LIBS`|	These are the client libraries used in Bold BI by default.<br/><br/>`'phantomjs,mongodb,mysql,influxdb,snowflake,oracle,npgsql'`<br/><br/>Please refer <a href='#consent-to-deploy-client-libraries'>Consent to deploy client libraries</a> Libraries section to know more.|
| `widget_bing_map_enable`      | If you need to use Bing Map widget feature, enable this to `true`.<br/>By default this feature will be set to `false`. | 
| `widget_bing_map_api_key`     | API key value for the Bing Map. |
<br/>

> **Note:**
> * If you are using the IP address for the Base URL, make sure you are using the public IP of the machine instead of internal IP or local IP address. Applications can communicate with each other using the public IP alone. Host machine IP will not be accessible inside the application container.
> * Use `host.docker.internal` instead of `localhost` while accessing the database server in your host machine. Host machine localhost DNS will not be accessible inside the container. So, docker provides `host.docker.internal` and `gateway.docker.internal` DNS for communication between docker applications and host machine. Please make sure that the host.docker.internal DNS has your IPv4 address mapped in your hosts file on Windows(C:\Windows\System32\drivers\etc\hosts) or Linux (/etc/hosts).
> * Provide the HTTP or HTTPS scheme for APP_BASE_URL value.

## Consent to deploy client libraries

By giving consent to install client libraries to connect with Oracle, PostgreSQL, MySQL, MongoDB, InfluxDB, and Snowflake.Data, you can use the following libraries in your docker container. Bold BI uses these client libraries to connect with their respective SQL database variants. Read about the licenses of each library to give consent for usage. 

<br/>

| Library                   | DLLs           | License       | Name         |
| -------------             | ------------- | ------------- |------------- |
| mongo-csharp-driver       | MongoDB       | [Apache License, Version 2.0](https://github.com/mongodb/mongo-csharp-driver/blob/master/License.txt) | mongodb |
| Snowflake.Data            | Snowflake.Data| [Apache License, Version 2.0](https://github.com/snowflakedb/snowflake-connector-net/blob/master/LICENSE) | snowflake |
| Oracle.ManagedDataAccess  | Oracle        | [Oracle License](https://www.oracle.com/downloads/licenses/distribution-license.html) | oracle |
| Npgsql 4.0.0              | PostgreSQL <br/> Amazon Redshift <br/>Google Cloud - PostgreSQL <br/> Amazon Aurora - PostgreSQL | [PostgreSQL License](https://github.com/npgsql/npgsql/blob/main/LICENSE) | npgsql        |
| MySQLConnector 0.45.1     | MySQL <br/> MemSQL <br/> MariaDB <br/> Google Cloud – MySQL <br/> Amazon Aurora - MySQL <br/> CDATA | [MIT License](https://github.com/mysql-net/MySqlConnector/blob/master/LICENSE) | mysql         |
| InfluxData.Net            | InfluxDB | [MIT License](https://github.com/pootzko/InfluxData.Net/blob/master/LICENSE) | influxdb      |
| [PhantomJS WebKit](https://phantomjs.org)          | phantomjs | [License](https://github.com/ariya/phantomjs/blob/master/LICENSE.BSD) and [Third-Party](https://github.com/ariya/phantomjs/blob/master/third-party.txt) documents. | phantomjs     |

Find the names of client libraries in the last column of the above table, which needs to be passed as a comma-separated string for the `OPTIONAL_LIBS` environment variable in place of `<optional_library_names>` on the docker run command.
<br/>

If you want to use all client libraries in the Bold BI application, then pass the following string as a value for the `OPTIONAL_LIBS` environment variable. You need to add the names only for the libraries, which you are consenting to use with the Bold BI application.
<br/>

`phantomjs,mongodb,mysql,influxdb,snowflake,oracle,npgsql`

### Persisting application data

You can store the application data in your host machine to make the Bold BI container a stateful application. Existing containers can be deleted, and new ones can be created with the host machine directory attached to the container. Then, Bold BI application will read and write the data in your host machine.

Replace the `<host_path_for_appdata_files>` value with a directory path from your host machine in the advanced docker run command.

> **For example**<br/>
> Windows: `-v D:/boldbi/app_data:/boldbi/app_data`<br/>
> Linux: `-v /home/boldbi/app_data:/boldbi/app_data`
<br/>

### Nginx configuration

You can mount a host directory to Bold BI container for maintaining Nginx configuration. You can also store SSL certificates in this directory and can configure Nginx with them.

Replace the `<host_path_for_nginx_config>` value with a directory path from your host machine in the advanced docker run command.

> **For example**<br/>
> Windows: `-v D:/boldbi/nginx:/etc/nginx/sites-available`<br/>
> Linux: `-v /home/boldbi/nginx:/etc/nginx/sites-available`

Once, the Bold BI container started to run, you can check the directory in your host machine. The `boldbi-nginx-config` file will be generated there. You can configure the Nginx inside the container using this file.


### SSL configuration in Nginx

If you have an SSL certificate for your domain and need to configure the site with your SSL certificate, follow these steps:

1. Uncomment the following marked lines in the **boldbi-nginx-config** file.

    ![ssl configuration](images/uncomment_ssl_redirect.png)

    ![ssl configuration](images/uncomment_lines.png)

2. Comment the following marked line in the **boldbi-nginx-config** file.

    ![ssl configuration](images/comment_lines.png)

3. Replace the example.com with your domain name.

4. Place the certificate and key file in your host directory, which you mounted on the Bold BI application to store Nginx configuration. i.e. The directory path replaced with `<host_path_for_nginx_config>` value in the advanced docker run command. You can update the certificate and key file names in **boldbi-nginx-config** file.

    ![ssl configuration](images/ssl_certificate_name.png)

> **NOTE:** If you are configuring the application with SSL, then you need to update the `<app_base_url>` in docker run command with `HTTPS`.


### Example for Advanced docker run command

```sh
docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=https://example.com \
     -e OPTIONAL_LIBS=phantomjs,mongodb,mysql,influxdb,snowflake,oracle,npgsql \
     -e widget_bing_map_enable=true\
     -e widget_bing_map_api_key=<widget_bing_map_api_key> \
     -v D:/boldbi/app_data:/boldbi/app_data \
     -v D:/boldbi/nginx:/etc/nginx/sites-available \
     -d syncfusion/boldbi:4.2.68
``` 
## Run `Bold Bi` via `docker-compose`

Example `docker-compose.yml` for `Bold BI`:

```sh
version: '3.5'

services:
  boldbi:
   image: syncfusion/boldbi
   restart: always
   ports:
      - 8080:80
   environment:
     - APP_BASE_URL=<app_base_url>
   networks:
     - boldbi
   volumes:
     - shared:/boldbi/app_data
    
  pgdb:
    image: postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: <Password>
    volumes:
      - pgdb:/var/lib/postgresql
    networks:
      - boldbi

networks:
  boldbi:
  
volumes:
  shared:
  pgdb:
  ```

Run `docker-compose up`, wait for it to initialize completely, and visit http://localhost:8080, or http://host-ip:8080 (as appropriate).

# Application Startup

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup
