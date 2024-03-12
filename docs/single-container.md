## Run single container `Bold BI` via `docker-compose`

 This quick-start guide demonstrates how to use Compose to set up and run Bold BI. Before starting, make sure you have installed [Compose](https://docs.docker.com/compose/install/)

### Define the Project

  1. Create an empty project directory.<br/>
  You can name the directory something easy for you to remember. This directory is the context for your application image.<br/>
  This project directory should contains a `docker-compose.yml` file which is complete in itself for a good starter BoldBI project.
  
  2.  Change into your project directory.
  For example, if you named your directory `my_boldbi`

      ```sh
      $  cd my_boldbi/
      ```

  3. Create a `docker-compose.yml` file that starts your `BoldBI`  and a separate `PostgreSQL` instance with volume mounts for data persistence:
      > **Tip:**
        You can use either a `.yml` or `.yaml` extension for this file. They both works well.

      ```sh
      version: '3.5'

      services:
        boldbi:
          image: syncfusion/boldbi
          restart: always
          ports:
            - 8085:80
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
  4. You can also change the Port number other than `8085`.

  6. Allocate a directory in your host machine to store the shared folders for applications’ usage. Replace the directory path with `<host_path_boldbi_data>` and `<host_path_db_data>` in **docker-compose.yml** file.

       For example, <br><b>Windows:</b> `device: 'D:/boldbi/boldbi_data'` and `device: 'D:/boldbi/db_data'` <br><b>Linux:</b> `device: '/var/boldbi/boldbi_data'` and `device: '/var/boldbi/db_data'`

      > **Note:**
      > The docker volumes `boldbi_data` and `db_data` persists data of Bold BI and PostgreSQL respectively. [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)

### Build the project

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
### Bring up Bold BI in a web browser

At this point, you can access the Bold BI application by entering the URL as `http://localhost:8085` or `http://host-ip:8085` in the browser. When opening this URL in the browser, it will configure the application startup in the background and display the page below within a few seconds. The default port number mentioned in the compose file is 8085. If you are making changes to the port number, then you need to use that port number for accessing the Bold BI application.
   
   ![docker-compose-startup](images/docker-startup.png)

   > **Note:** Don't use localhost IP (`http://127.0.0.1`) with `port` to access the application.
### Application Startup

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup

> **Note:**
> To use the above configured PostgreSQL server in Bold BI please use `pgdb` as the PostgreSQL server name.

### Shutdown and cleanup

The command `docker-compose down` removes the containers and default network, but preserves the volumes of Bold BI and PostgreSQL. <br /><br />
The command `docker-compose down --volumes` removes the containers, default network, and all the volumes.

