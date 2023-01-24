# How to upgrade a new image using docker command

1. Take backup for your app_data and nginx volumes. This will help to retain the old data in case of any issues with the new deployment.

2. Stop and remove your old container.

   ~~~sh
   docker stop {Container_id/name}
   docker rm -f {Container_id/name
   ~~~

3. Follow the below link to deploy a new container with the same volumes that you used before in the old container to avoid data loss.

   https://hub.docker.com/r/syncfusion/boldbi

4. Find the example docker command with the new image.

   ~~~sh
   docker run --name boldbi -p 80:80 -p 443:443 \
     -e APP_URL=<app_base_url> \
     -e OPTIONAL_LIBS=<optional_library_names> \
     -e widget_bing_map_enable=<true/false>\
     -e widget_bing_map_api_key=<widget_bing_map_api_key> \
     -v <host_path_for_appdata_files>:/application/app_data \
     -v <host_path_for_nginx_config>:/etc/nginx/sites-available \
     -d syncfusion/boldbi:<upgrade image tag>
   ~~~

>**Note:** Make sure the `app_base_url`, `<host_path_for_appdata_files>` and `<host_path_for_nginx_config>` are the same path that you used in the previous container.