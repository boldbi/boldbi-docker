# How to use host path as persistent volume for Bold BI deployment?

You can store the application data on your host machine to make the Bold BI container a stateful application. The Bold BI application will read and write the data on your host machine. In the following section, we will learn how to use the host path as a persistent volume for Bold BI deployment.

1. When deploying the Bold BI application using Docker or Docker compose, you can pass the host path as a persistent volume. Here is an example using the Docker Command.
   
   ```sh
     docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=<app_url> \
     -v <host_path_for_appdata_files>:/application/app_data \
     -v <host_path_for_nginx_config>:/etc/nginx/sites-available \
     -d syncfusion/boldbi:<tag>
   ```
  
    <b>Persisting application app_data</b> </br></br>
     
    Replace the `<host_path_for_appdata_files>` value with a directory path from your host machine in the advanced docker run command.

   > **For example**<br/>
   > Windows: `-v D:/boldbi/app_data:/application/app_data`<br/>
   > Linux: `-v /home/boldbi/app_data:/application/app_data`

   <b>Nginx configuration</b>

   Replace the `<host_path_for_nginx_config>` value with a directory path from your host machine in the advanced docker run command.

   > **For example**<br/>
   > Windows: `-v D:/boldbi/nginx:/etc/nginx/sites-available`<br/>
   > Linux: `-v /home/boldbi/nginx:/etc/nginx/sites-available`

   <b>Example:</b>
   ```sh
    docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=https://example.com \
     -v D:/boldbi/app_data:/application/app_data \
     -v D:/boldbi/nginx:/etc/nginx/sites-available \
     -d syncfusion/boldbi:6.17.13
   ``` 
3. After running the command, access the Bold BI App by entering `APP_URL` in a browser. At this point, Bold BI should be running in `<app_url>` (as appropriate)

   ![docker-compose-startup](/docs/images/docker-startup.png)
 
    > **Note:**
   > The BoldBI site is not immediately available because the containers are still being initialized and may take a couple of minutes for the first load.

**Application Startup**

Configure the Bold BI On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

https://help.boldbi.com/embedded-bi/application-startup
