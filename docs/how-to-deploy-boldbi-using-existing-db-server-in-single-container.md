 # How to deploy the Bold BI application using existing server database details.

 This quick-start guide demonstrates how to use Compose to set up and run Bold BI. Before starting, make sure you have installed [Compose](https://docs.docker.com/compose/install/)

In the following section, we are going to starts BoldBI and a separate PostgreSQL instance with volume mounts for data persistence using Docker Compose.

1. Download docker compose file using the following command.
   
   ```sh
   curl -o docker-compose.yml "https://raw.githubusercontent.com/Vinoth-Krishnamoorthy/boldbi-docker/main/deploy/single-container-with-env-variable/docker-compose.yml"
   ```
3. Open the docker compose file and fill the mandatory fields - <b>APP_BASE_URL</b>, <b>Unlock Key</b> and <b>Database details</b>

    ![docker-compose-database-detail](/docs/images/database-env-value.png)

      <b>APP_BASE_URL Guidance:</b>
      * Provide the HTTP scheme for APP_BASE_URL value.
      For example, <br/>
          `http://example.com` <br/>
          `http://<public_ip_address>` <br/>
      * For `Windows` and `MacOS` use either http://host.docker.internal or http://localhost. Docker Desktop provides `host.docker.internal` and `gateway.docker.internal` DNS for communication between docker applications and host machine. Please make sure that the host.docker.internal DNS has your IPv4 address mapped in your hosts file on Windows(C:\Windows\System32\drivers\etc\hosts).
      * For `Linux` use the Machine Public IP address as the value for APP_URL with the HTTP scheme.
 
   <b>Environment variable Usage:</b>


    | Name                          |Required| Description   | 
   | -------------                 |----------| ------------- |
   |`BOLD_SERVICES_UNLOCK_KEY`|Yes|License key for activating Bold BI. Please refer to [this document](https://help.boldbi.com/embedded-bi/faq/how-to-get-offline-unlock-key/) to download the key. <br/> If you don't have the download key option, please create a support ticket [here](https://support.boldbi.com/create). |
   |`BOLD_SERVICES_DB_TYPE`|Yes|Type of database server can be used for configuring Bold BI.<br/><br />The following DB types are accepted:<br />1. mssql – Microsoft SQL Server/Azure SQL Database<br />2. postgresql – PostgreSQL Server<br />3. mysql – MySQL/MariaDB Server|
   |`BOLD_SERVICES_DB_HOST`|Yes|Name of the Database Server|
   |`BOLD_SERVICES_DB_PORT`|No|The system will use the following default port numbers based on the database server type.<br />PostgrSQL – 5234<br />MySQL -3306<br /><br />Please specify the port number for your database server if it is configured on a different port.<br /><br />For MS SQL Server, this parameter is not necessary.|
   |`BOLD_SERVICES_DB_USER`|Yes|Username for the database server<br /><br />Please refer to [this documentation](https://help.boldbi.com/embedded-bi/faq/what-are-the-database-permissions-required-to-set-up-bold-bi-embedded/) for information on the user's permissions.|
   |`BOLD_SERVICES_DB_PASSWORD`|Yes|The database user's password|
   |`BOLD_SERVICES_DB_NAME`|No|If the database name is not specified, the system will create a new database called bold services.<br /><br />If you specify a database name, it should already exist on the server.|
   |`BOLD_SERVICES_POSTGRESQL_MAINTENANCE_DB`|Yes|For PostgreSQL DB Servers, this is an optional parameter.<br />The system will use the database name `postgres` by default.<br />If your database server uses a different default database, please provide it here.|
   |`BOLD_SERVICES_DB_ADDITIONAL_PARAMETERS`|No|If your database server requires additional connection string parameters, include them here.<br /><br />Connection string parameters can be found in the official document.<br />My SQL: https://dev.mysql.com/doc/connector-net/en/connector-net-8-0-connection-options.html<br />PostgreSQL: https://www.npgsql.org/doc/connection-string-parameters.html<br />MS SQL: https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectionstring<br /><br /><b>Note:</b> A semicolon(;) should be used to separate multiple parameters.|
   |`BOLD_SERVICES_USER_EMAIL`|Yes|It should be a valid email.|
   |`BOLD_SERVICES_USER_PASSWORD`|Yes|It should meet our password requirements.<br /> <br />**Note:** <br />Password must meet the following requirements. It must contain at least 6 characters, 1 uppercase character, 1 lowercase character, 1 numeric character, 1 special character |
4. Run docker compose up command.
   
   ```sh
   docker-compose up -d
   ```
   ![docker-compose-command](/docs/images/docker-compose-up.png)
   

      > **Note:**
      > The docker volumes `boldservices_data` and `db_data` persists data of Bold BI and PostgreSQL respectively. [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)
5. After running the command, access the Bold BI App by entering APP_URL in a browser.At this point, Bold BI should be running in `<app_base_url>:8085` (as appropriate)

   ![docker-compose-startup](/docs/images/docker-startup.png)


   > **Note:**
   > The BoldBI site is not immediately available on port 8085 because the containers are still being initialized and may take a couple of minutes for the first load.

### Shutdown and cleanup

The command `docker-compose down` removes the containers and default network, but preserves the volumes of Bold BI and PostgreSQL. <br /><br />
The command `docker-compose down --volumes` removes the containers, default network, and all the volumes.


