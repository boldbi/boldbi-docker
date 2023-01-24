# How to upgrade a new image in docker environment using docker environment.

1. Navigate to the docker compose deployment file location.

2. Back up the `app_data` and `database data` the same volumes that you used before in the current container to avoid data loss.

3. Use the below command to down your existing container.

   ~~~sh
   docker-compose down
   ~~~

4. Replace the new image tag in your docker compose file and save the changes. Its applicable for both single compose and multi compose yaml file.

5. Use the below command to up your container with new image tag. 

   ~~~sh
   docker-compose up -d
   ~~~~