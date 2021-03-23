# Bold BI on Docker

Bold BI can be deployed using docker-compose. Nginx will run in a separate container as reverse proxy to route traffic to other containers. Please follow these steps to deploy Bold BI using the docker-compose deployment.

Download the configuration files [here](deploy/). This directory includes docker-compose YML file and configuration file for Nginx.

## docker-compose changes

1. Open **docker-compose.yml** file from the downloaded files. Replace your DNS or IP address, on which you are going to access the application in `<application_base_url>` place.
    
    For example, `http://example.com`, `https://example.com`, `http://<ip_address>`

2. Read the optional client library license agreement from the following link.

    [Consent to deploy client libraries](consent-to-deploy-client-libraries.md)

3. Note the optional client libraries from the above link as comma separated names and replace it in `<comma_separated_library_names>` place.

    ![docker-compose.yml](images/baseurl_clientlibrary.png) 

4. Provide the **default.conf** file path, which you have downloaded earlier in `<default_conf_path>` place.

    For example, `"./default.conf:/etc/nginx/conf.d/default.conf"`
        `"D:/boldbi/docker/default.conf":"/etc/nginx/conf.d/default.conf"`
        `"/var/boldbi/docker/default.conf:/etc/nginx/conf.d/default.conf"`

    ![docker-compose.yml](images/default_conf_path.png) 

5. Allocate a directory in your host machine to store the shared folders for applications’ usage. Replace the directory path with `<host_path>` in **docker-compose.yml** file.

    For example, `device: 'D:/boldbi/shared'`
        `device: '/var/boldbi/shared'`

    ![docker-compose.yml](images/shared_location.png) 

## Configure SSL
If you have an SSL certificate for your domain and need to configure the site with your SSL certificate, follow these steps or you can skip this.

1. Uncomment the following marked lines in the **default.conf** file.

    ![ssl configuration](images/uncomment_ssl_redirect.png)

    ![ssl configuration](images/uncomment_lines.png)

2. Comment the following marked line in the **default.conf** file.

    ![ssl configuration](images/comment_lines.png)

3. Replace the example.com with your domain name.

4. Uncomment the following marked lines in the **docker-compose.yml** file.
    
    ![ssl configuration](images/uncomment_docker.png)

5. Replace the certificate and key file paths, which were stored in your host machine in `<ssl_cert_file_path>` and `<ssl_key_file_path>` places on **docker-compose.yml** file.

    For example, 
    `- "D:/certificates/boldbi.crt:/etc/ssl/domain.crt"`
    `- "D:/certificates/boldbi.key:/etc/ssl/domain.crt"`

    `- "/var/mycertificates/boldbi.crt:/etc/ssl/domain.crt"`
    `- "/var/mycertificates/boldbi.key:/etc/ssl/domain.crt"`

6. If you need to use **Bing Map** widget feature, enter value for `widget_bing_map_enable` environment variable as `true` and API key value for `widget_bing_map_api_key` on **docker-compose.yml** file.

    ![Bing Map](images/bing_map_key.png) 

> **NOTE:** If you are configuring the application with SSL, then you need to update the `<application_base_url>` in the **docker-compose.yml** with `HTTPS`.


## Deploy Bold BI using docker-compose

1. Run the **docker-compose.yml** file using the following docker command.

```sh
docker-compose up
```

2. Wait till you see the applications in running state. Then, use your DNS or IP address to access the application in the browser.

3. Configure the Bold BI On-Premise application startup to use the application. For more details on configuring the application startup, please refer the following link.
    
    https://help.boldbi.com/embedded-bi/application-startup
