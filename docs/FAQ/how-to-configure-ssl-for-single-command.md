# How to configure ssl for single command deployment

1. Copy the SSL certificate `.key` and `.crt` format and paste inside the nginx mount folder. 
2. Refer below document for SSL changes in `nginx` file .

   https://github.com/boldbi/boldbi-docker/blob/main/docs/ssl-termination.md
   
3. Restart the Bold BI container using below command.
   ~~~sh
   docker restart <container-name or container ID>
   ~~~