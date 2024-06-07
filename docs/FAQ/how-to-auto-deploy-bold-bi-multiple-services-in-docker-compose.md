# How to auto deploy multiple services Bold BI via docker-compose.

This section allows you to deploy [Bold BI](https://www.boldbi.com/) in docker-compose without manual activation of licensing and configuring startup from the browser.

## Steps for Bold BI multiple services auto deployment using docker-compose.

  1. Create an empty project directory.<br/>
  You can name the directory something easy for you to remember. This directory is the context for your application image. This project directory should contains a `docker-compose.yml` file which is complete in itself for a good starter BoldBI project.

  2. Download the configuration files [here](/deploy/multiple-container/auto-deploy/). This directory includes docker-compose YML file and configuration file for Nginx.
  
      > **Tip:**
        You can use either a `.yml` or `.yaml` extension for this file. They both works well.
  
  3.  Change into your project directory.
  For example, if you named your directory `my_boldbi`

      ```sh
      $  cd my_boldbi/
      ```

  4. Create a docker-compose.yml file that starts your `BoldBI`  and a separate `PostgreSQL` instance with volume mounts for data persistence:

      ```sh
     
     version: '3.5'

      services:
        id-web:
          container_name: id_web_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/bold-identity:7.9.27
          restart: on-failure
          environment:
            - APP_BASE_URL=<app_base_url>
            - INSTALL_OPTIONAL_LIBS=mongodb,mysql,influxdb,snowflake,oracle,clickhouse,google
          volumes: 
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        id-api:
          container_name: id_api_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/bold-identity-api:7.9.27
          restart: on-failure
          volumes: 
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        id-ums:
          container_name: id_ums_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/bold-ums:7.9.27
          restart: on-failure
          environment:
            - BOLD_SERVICES_HOSTING_ENVIRONMENT=docker
           # - BOLD_SERVICES_UNLOCK_KEY=<Bold_BI_license_key>
           # - BOLD_SERVICES_DB_TYPE=<data_base_server_type>
           # - BOLD_SERVICES_DB_HOST=<data_base_server_host>
           # - BOLD_SERVICES_DB_PORT=<data_base_server_port>
           # - BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB=<maintenance_db_name>
           # - BOLD_SERVICES_DB_USER=<data_base_user_name>
           # - BOLD_SERVICES_DB_PASSWORD=<data_base_server_password>
           # - BOLD_SERVICES_USER_EMAIL=<Bold_BI_user_email>
           # - BOLD_SERVICES_USER_PASSWORD=<Bold_BI_user_password>
          volumes:
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        bi-web:
          container_name: bi_web_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/boldbi-server:7.9.27
          restart: on-failure
          volumes: 
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        bi-api:
          container_name: bi_api_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/boldbi-server-api:7.9.27
          restart: on-failure
          volumes: 
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
            - bi-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        bi-jobs:
          container_name: bi_jobs_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/boldbi-server-jobs:7.9.27
          restart: on-failure
          volumes: 
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
            - bi-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        bi-dataservice:
          container_name: bi_dataservice_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/boldbi-designer:7.9.27
          restart: on-failure
          # environment:                         ## Refer README.md for available environment variables.
          #   - widget_bing_map_enable=false
          #   - widget_bing_map_api_key=""
          #   - AppSettings__locale-path=""
          #   - AppSettings__BrowserTimezone=fasle
          #   - AppSettings__CustomSizePDFExport=fasle
          volumes:
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
            - bi-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        bi-etl:
          container_name: bi_etl_container
          image: us-docker.pkg.dev/boldbi-294612/boldbi/bold-etl:7.9.27
          restart: on-failure
          volumes:
            - boldservices_data:/application/app_data
          networks:
            - boldservices
          depends_on:
            - id-web
            - bi-web
          healthcheck:
              test: ["CMD", "curl", "-f", "http://localhost/health-check"]
              interval: 10s
              timeout: 10s
              retries: 5

        reverse-proxy:
          container_name: nginx
          image: nginx
          restart: on-failure
          volumes:
            -  "<default_conf_path>:/etc/nginx/conf.d/default.conf"
            # - "<ssl_cert_file_path>:/etc/ssl/domain.crt"
            # - "<ssl_key_file_path>:/etc/ssl/domain.key"
          ports:
            - "8085:80"
            # - "443:443"
          environment:
            - NGINX_PORT=80
          networks:
            - boldservices
          depends_on:
            - id-web
            - id-api
            - id-ums
            - bi-web
            - bi-api
            - bi-jobs
            - bi-dataservice
        pgdb:
          image: postgres
          restart: always
          environment:
            POSTGRES_PASSWORD: <Password>
          volumes:
            - db_data:/var/lib/postgresql/data/
          networks:
            - boldservices

      networks:
        boldservices:

      volumes:
        boldservices_data:
          driver: local
          driver_opts:
            type: 'none'
            o: 'bind'
            device: '<host_path_boldservices_data>'
        db_data:
          driver: local
          driver_opts:
            type: 'none'
            o: 'bind'
            device: '<host_path_db_data>'

        ```
  
  5. Replace `<app_base_url>` with your DNS or IP address, by which you want to access the application.
    
      For example, <br/>
          `http://example.com` <br/>
          `https://example.com` <br/>
          `http://<public_ip_address>` <br/>
          `http://host.docker.internal` <br/>

      > **Note:**
      > * If you are using the IP address for the Base URL, make sure you are using the public IP of the machine instead of internal IP or local IP address. Applications can communicate with each other using the public IP alone. Host machine IP will not be accessible inside the application container.
      > * Use http://host.docker.internal instead of http://localhost. Host machine localhost DNS will not be accessible inside the container. So, docker desktop provides `host.docker.internal` and `gateway.docker.internal` DNS for communication between docker applications and host machine. Please make sure that the host.docker.internal DNS has your IPv4 address mapped in your hosts file on Windows(C:\Windows\System32\drivers\etc\hosts) or Linux (/etc/hosts).
      > * Provide the HTTP or HTTPS scheme for APP_BASE_URL value.

<br />

  6. Uncommand and enter the variable information needed to complete the auto-deployment.
     ```sh
        environment:
          - BOLD_SERVICES_HOSTING_ENVIRONMENT=docker
         # - BOLD_SERVICES_UNLOCK_KEY=<Bold_BI_license_key>
         # - BOLD_SERVICES_DB_TYPE=<data_base_server_type>
         # - BOLD_SERVICES_DB_HOST=<data_base_server_host>
         # - BOLD_SERVICES_DB_PORT=<data_base_server_port>
         # - BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB=<maintenance_db_name>
         # - BOLD_SERVICES_DB_USER=<data_base_user_name>
         # - BOLD_SERVICES_DB_PASSWORD=<data_base_server_password>
         # - BOLD_SERVICES_USER_EMAIL=<Bold_BI_user_email>
         # - BOLD_SERVICES_USER_PASSWORD=<Bold_BI_user_password>
     ```
     
     ### Environment variables details for configuring Application Startup in the backend.
     
      | Name                          |Required| Description   | 
      | -------------                 |----------| ------------- |
      |`BOLD_SERVICES_UNLOCK_KEY`|Yes|License key for activating the Bold BI. Please refer to [this document](https://help.boldbi.com/embedded-bi/faq/how-to-get-offline-unlock-key/) to download the key. <br/> If you don't have the download key option, please create a support ticket [here](https://support.boldbi.com/create). |
      |`BOLD_SERVICES_DB_TYPE`|Yes|Type of database server can be used for configuring the Bold BI.<br/><br />The following DB types are accepted:<br />1. mssql – Microsoft SQL Server/Azure SQL Database<br />2. postgresql – PostgreSQL Server<br />3. mysql – MySQL/MariaDB Server|
      |`BOLD_SERVICES_DB_HOST`|Yes|Name of the Database Server|
      |`BOLD_SERVICES_DB_PORT`|No|The system will use the following default port numbers based on the database server type.<br />PostgrSQL – 5234<br />MySQL -3306<br /><br />Please specify the port number for your database server if it is configured on a different port.<br /><br />For MS SQL Server, this parameter is not necessary.|
      |`BOLD_SERVICES_DB_USER`|Yes|Username for the database server<br /><br />Please refer to [this documentation](https://help.boldbi.com/embedded-bi/faq/what-are-the-database-permissions-required-to-set-up-bold-bi-embedded/) for information on the user's permissions.|
      |`BOLD_SERVICES_DB_PASSWORD`|Yes|The database user's password|
      |`BOLD_SERVICES_DB_NAME`|No|If the database name is not specified, the system will create a new database called bold services.<br /><br />If you specify a database name, it should already exist on the server.|
      |`BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB`|Yes|For PostgreSQL DB Servers, this is an optional parameter.<br />The system will use the database name `postgres` by default.<br />If your database server uses a different default database, please provide it here.|
      |`BOLD_SERVICES_DB_ADDITIONAL_PARAMETERS`|No|If your database server requires additional connection string parameters, include them here.<br /><br />Connection string parameters can be found in the official document.<br />My SQL: https://dev.mysql.com/doc/connector-net/en/connector-net-8-0-connection-options.html<br />PostgreSQL: https://www.npgsql.org/doc/connection-string-parameters.html<br />MS SQL: https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectionstring<br /><br /><b>Note:</b> A semicolon(;) should be used to separate multiple parameters.|
      |`BOLD_SERVICES_USER_EMAIL`|Yes|It should be a valid email.|
      |`BOLD_SERVICES_USER_PASSWORD`|Yes|It should meet our password requirements.<br /> <br />**Note:** <br />Password must meet the following requirements. It must contain,At least 6 characters, 1 uppercase character, 1 lowercase character, 1 numeric character, 1 special character |
      
      **Example:**

      ![auto-deploy-env](../images/auto-deploy-env.png)
 
  7. You can also change the Port number other than `8085`

  8. Provide the **default.conf** file path, which you have downloaded earlier in `<default_conf_path>` place.

       For example, <br>`"./default.conf:/etc/nginx/conf.d/default.conf"`<br>
        `"D:/boldbi/docker/default.conf":"/etc/nginx/conf.d/default.conf"`<br>
        `"/var/boldbi/docker/default.conf:/etc/nginx/conf.d/default.conf"`

     ![docker-compose.yml](../images/default_conf_path.png)

  9. Allocate a directory in your host machine to store the shared folders for applications’ usage. Replace the directory path with `<host_path_boldservices_data>` and `<host_path_db_data>` in **docker-compose.yml** file.

       For example, <br><b>Windows:</b> `device: 'D:/boldbi/boldservices_data'` and `device: 'D:/boldbi/db_data'` <br><b>Linux:</b> `device: '/var/boldbi/boldservices_data'` and `device: '/var/boldbi/db_data'`

      > **Note:**
      > The docker volumes `boldservices_data` and `db_data` persists data of Bold BI and PostgreSQL respectively. [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)
      
  10. If you need to use Bing Map widget feature, enable this to true and enter the API key value for `- widget_bing_map_api_key`. By default this feature will be set to false.
   
      ![docker-compose-bingmap](../images/bingmap.png)

### Build the project

Now, run `docker-compose up -d` from your project directory.
<br />

This runs `docker-compose up` in detached mode, pulls the needed Docker images, and starts the boldbi and database containers, as shown in the example below.

### Bring up BoldBI in a web browser

At this point, BoldBI should be running in `<app_base_url>:8085` (as appropriate)

> **Note:**
> The BoldBI site is not immediately available on port 8085 because the containers are still being initialized and may take a couple of minutes before the first load.

### Application Startup

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup

> **Note:**
> To use the above configured PostgreSQL server in Bold BI please use `pgdb` as the PostgreSQL server name.

### Shutdown and cleanup

The command `docker-compose down` removes the containers and default network, but preserves the volumes of Bold BI and PostgreSQL. <br /><br />
The command `docker-compose down --volumes` removes the containers, default network, and all the volumes.
