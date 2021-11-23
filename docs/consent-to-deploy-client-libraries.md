## Consent to deploy client libraries

By giving consent to install client libraries to connect with Oracle, PostgreSQL, MySQL, MongoDB, InfluxDB, and Snowflake.Data, you can use the following libraries in your Bold BI container. Bold BI uses these client libraries to connect with their respective SQL database variants. Read about the licenses of each library to give consent for usage. 

### mongo-csharp-driver
* MongoDB

[Apache License, Version 2.0](https://github.com/mongodb/mongo-csharp-driver/blob/master/License.txt)

### Snowflake.Data
* Snowflake.Data

[Apache License, Version 2.0](https://github.com/snowflakedb/snowflake-connector-net/blob/master/LICENSE)

### Oracle.ManagedDataAccess
* Oracle

[Oracle License](https://www.oracle.com/downloads/licenses/distribution-license.html)

### Npgsql 4.0.0
* PostgreSQL
* Amazon Redshift
* Google Cloud - PostgreSQL
* Amazon Aurora - PostgreSQL

[PostgreSQL License](https://github.com/npgsql/npgsql/blob/main/LICENSE)

### MySQLConnector 0.45.1
* MySQL
* MemSQL
* MariaDB
* Google Cloud – MySQL
* Amazon Aurora - MySQL
* CDATA

[MIT License](https://github.com/mysql-net/MySqlConnector/blob/master/LICENSE)

### Amazon Athena
* Amazon Athena

[Amazon Athena](http://aws.amazon.com/apache2.0/)

### InfluxData.Net
* InfluxDB

[MIT License](https://github.com/pootzko/InfluxData.Net/blob/master/LICENSE)

### PhantomJS WebKit

PhantomJS is a headless WebKit scriptable with JavaScript. It is a free software or open source that may contain MIT, BSD, LGPL, GPL, or other similar licenses. 
It contains third-party code. This executable file is necessary to achieve the Image and PDF export functionalities in dashboard, widgets, and schedules. 
Without this file, the Image and PDF export options in dashboard, widgets, and schedules will no longer be available. 
It is your decision to download Phantom JS, but you must accept all its terms and conditions, if you want to use it with Syncfusion’s products.
  
You can read the [License](https://github.com/ariya/phantomjs/blob/master/LICENSE.BSD) and [Third-Party](https://github.com/ariya/phantomjs/blob/master/third-party.txt) documents.


### Client library names as arguments for Bold BI deployment in Docker

Find the names of client libraries, which needs to be passed as a comma separated string for an environment variable in **docker run command** file.

| Library                   | Name          |
| -------------             | ------------- |
| mongo-csharp-driver       | mongodb       |
| Snowflake.Data            | snowflake     |
| Oracle.ManagedDataAccess  | oracle        |
| Npgsql 4.0.0              | npgsql        |
| MySQLConnector 0.45.1     | mysql         |
| InfluxData.Net            | influxdb      |
| PhantomJS WebKit          | phantomjs     |
| Amazon Athena             | athena


> **Note :**
By default all the client libraries will be installed in the Bold BI docker container and also you can still overwrite them mentioning the required libraries in the docker run command.


### Example command for using optional libraries in Bold BI

```sh
docker run --name boldbi -p 8085:80 -e OPTIONAL_LIBS=phantomjs,mongodb,mysql -d syncfusion/boldbi
```



