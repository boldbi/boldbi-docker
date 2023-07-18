 # How to deploy the Bold BI application in multi container using docker compose file
 
 This quick-start guide demonstrates how to use Compose to set up and run Bold BI. Before starting, make sure you have installed [Compose](https://docs.docker.com/compose/install/)

In the following section, we are going to starts BoldBI with volume mounts for data persistence using multi container Docker Compose.

1. Download docker compose file using the following command.
   
   ```sh
   curl -o docker-compose.yml "https://raw.githubusercontent.com/Vinoth-Krishnamoorthy/boldbi-docker/main/deploy/multi-container/docker-compose.yml"
   ```
3. Open the docker compose file and fill the mandatory fields - <b>APP_BASE_URL</b>, <b>Unlock Key</b> and <b>Database details</b>

    ![docker-compose-variable](/docs/images/app_base_url.png)

      <b>APP_BASE_URL Guidance:</b>
   
      * Provide the HTTP scheme for APP_BASE_URL value.
      For example, <br/>
          `http://example.com` <br/>
          `http://<public_ip_address>` <br/>
      * For `Windows` and `MacOS` use either http://host.docker.internal or http://localhost. Docker Desktop provides `host.docker.internal` and `gateway.docker.internal` DNS for communication between docker applications and host machine. Please make sure that the host.docker.internal DNS has your IPv4 address mapped in your hosts file on Windows(C:\Windows\System32\drivers\etc\hosts).
      * For `Linux` use the Machine Public IP address as the value for APP_BASE_URL with the HTTP scheme.

4. Run docker compose up command.
   
   ```sh
   docker-compose up -d
   ```
   ![docker-compose-command](/docs/images/docker-compose-up-multi.png)
   

      > **Note:**
      > The docker volumes of `boldservices_data` is persists data of Bold BI [Learn more about docker volumes](https://docs.docker.com/storage/volumes/)
5. After running the command, access the Bold BI App by entering APP_URL in a browser.At this point, Bold BI should be running in `<app_base_url>:8085` (as appropriate)

   ![docker-compose-startup](/docs/images/docker-startup.png)


   > **Note:**
   > The BoldBI site is not immediately available on port 8085 because the containers are still being initialized and may take a couple of minutes for the first load.

### Application Startup

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup


### Shutdown and cleanup

The command `docker-compose down` removes the containers and default network, but preserves the volumes of Bold BI and PostgreSQL. <br /><br />
The command `docker-compose down --volumes` removes the containers, default network, and all the volumes.




