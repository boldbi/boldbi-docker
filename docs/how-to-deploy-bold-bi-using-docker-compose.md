 # How to deploy Bold BI and configure startup manually?

In the following section, we are going to deploy single container Bold BI application using Docker Compose and configure application startup manually. 

**Bold BI Deployment:**

1. Download docker compose file using the following command.
   
   ```sh
   curl -o docker-compose.yml "https://raw.githubusercontent.com/Vinoth-Krishnamoorthy/boldbi-docker/main/deploy/single-container/docker-compose.yml"
   ```
3. Open the docker compose file and fill the mandatory field - <b>APP_URL</b>

    ![docker-compose-database-detail](/docs/images/single-container-app-url.png)

      <b>APP_URL Guidance:</b>
      * Provide the HTTP scheme for APP_BASE_URL value.
      For example, <br/>
          `http://example.com` <br/>
          `http://<public_ip_address>` <br/>
      * For `Windows` and `MacOS` use either http://host.docker.internal or http://localhost. Docker Desktop provides `host.docker.internal` and `gateway.docker.internal` DNS for communication between docker applications and host machine. Please make sure that the host.docker.internal DNS has your IPv4 address mapped in your hosts file on Windows(C:\Windows\System32\drivers\etc\hosts).
      * For `Linux` use the Machine Public IP address as the value for APP_URL with the HTTP scheme.
 
4. Run docker compose up command.
   
   ```sh
   docker-compose up -d
   ```
    ![docker-compose-command](/docs/images/docker-compose-up.png)
   

      > **Note:**
      > The docker volumes `boldbi_data` persists data of Bold BI. [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)
5. After running the command, access the Bold BI App by entering `APP_URL` in a browser.At this point, Bold BI should be running in `<app_url>:8085` (as appropriate)

   ![docker-compose-startup](/docs/images/docker-startup.png)


   > **Note:**
   > The BoldBI site is not immediately available on port 8085 because the containers are still being initialized and may take a couple of minutes for the first load.

**Application Startup**

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup

**Shutdown and Cleanup**

The command `docker-compose down` removes the containers and default network, but preserves the volumes of Bold BI and PostgreSQL. <br /><br />
The command `docker-compose down --volumes` removes the containers, default network, and all the volumes.
