# Fork of the REST version of Spring PetClinic Sample Application (Original:[spring-petclinic-rest](https://github.com/spring-petclinic/spring-petclinic-rest/)) used for the elective module 'Testen und DevOps in der agilen Softwareentwicklung' in the City University of Applied Sciences in Bremen.   

[![Build Status](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest/actions/workflows/maven-build.yml/badge.svg)](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest/actions/workflows/maven-build.yml) 
[![Build Status](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest/actions/workflows/postman.yml/badge.svg)](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest/actions/workflows/postman.yml) 
[![Build Status](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest/actions/workflows/deployment.yml/badge.svg)](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest/actions/workflows/deployment.yml) 

This backend version of the Spring Petclinic application only provides a REST API. **There is no UI**.
The [WPM_WISE21-22_spring-petclinic-angular project](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-angular) is a Angular front-end application which consumes the REST API.

## Understanding the Original Spring Petclinic application with a few diagrams

[See the presentation of the Original Spring Petclinic Framework version](http://fr.slideshare.net/AntoineRey/spring-framework-petclinic-sample-application)

### Petclinic ER Model

![alt petclinic-ermodel](petclinic-ermodel.png)

## Running petclinic locally

### With maven command line
```
git clone https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest.git
cd WPM_WISE21-22_spring-petclinic-rest
./mvnw spring-boot:run
```

### With Docker
```
docker run -p 9966:9966 siincy/wpm_wise2122_devops_spring_petclinic_deployment:rest
```

You can then access petclinic here: [http://localhost:9966/petclinic/](http://localhost:9966/petclinic/)

There are actuator health check and info routes as well: 
* [http://localhost:9966/petclinic/actuator/health](http://localhost:9966/petclinic/actuator/health)
* [http://localhost:9966/petclinic/actuator/info](http://localhost:9966/petclinic/actuator/info)

## OpenAPI REST API documentation presented here (after application start):

You can reach the swagger UI with this URL
[http://localhost:9966/petclinic/](http://localhost:9966/petclinic/swagger-ui.html).

You then can get the Open API description reaching this URL [http://localhost:9966/petclinic/v3/api-docs](http://localhost:9966/petclinic/v3/api-docs).

## Screenshot of the Angular client

<img width="1427" alt="WPM_WISE21-22_spring-petclinic-rest" src="angular_petclinic.png">

## Database configuration

In its default configuration, Petclinic uses an in-memory database (HSQLDB) which gets populated at startup with data.
A similar setups is provided for MySql and PostgreSQL in case a persistent database configuration is needed.
To run petclinic locally using persistent database, it is needed to change profile defined in application.properties file.

For MySQL database, it is needed to change param "hsqldb" to "mysql" in string
```
spring.profiles.active=hsqldb,spring-data-jpa
```
 defined in application.properties file.

Before do this, would be good to check properties defined in application-mysql.properties file.

```
spring.datasource.url = jdbc:mysql://localhost:3306/petclinic?useUnicode=true
spring.datasource.username=pc
spring.datasource.password=petclinic 
spring.datasource.driver-class-name=com.mysql.jdbc.Driver 
spring.jpa.database=MYSQL
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
spring.jpa.hibernate.ddl-auto=none
```      

You may also start a MySql database with docker:

```
docker run --name mysql-petclinic -e MYSQL_ROOT_PASSWORD=petclinic -e MYSQL_DATABASE=petclinic -p 3306:3306 mysql:5.7.8
```

For PostgeSQL database, it is needed to change param "hsqldb" to "postgresql" in string
```
spring.profiles.active=hsqldb,spring-data-jpa
```
 defined in application.properties file.

Before do this, would be good to check properties defined in application-postgresql.properties file.

```
spring.datasource.url=jdbc:postgresql://localhost:5432/petclinic
spring.datasource.username=postgres
spring.datasource.password=petclinic
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.database=POSTGRESQL
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=none
```
You may also start a Postgres database with docker:

```
docker run --name postgres-petclinic -e POSTGRES_PASSWORD=petclinic -e POSTGRES_DB=petclinic -p 5432:5432 -d postgres:9.6.0
```

## Security configuration
In its default configuration, Petclinic doesn't have authentication and authorization enabled.

### Basic Authentication
In order to use the basic authentication functionality, turn in on from the application.properties file
```
petclinic.security.enable=true
```
This will secure all APIs and in order to access them, basic authentication is required.
Apart from authentication, APIs also require authorization. This is done via roles that a user can have.
The existing roles are listed below with the corresponding permissions 
* OWNER_ADMIN -> OwnerController, PetController, PetTypeController (getAllPetTypes and getPetType), VisitController
* VET_ADMIN   -> PetTypeController, SpecialityController, VetController
* ADMIN       -> UserController

There is an existing user with the username `admin` and password `admin` that has access to all APIs.
 In order to add a new user, please use the following API:
```
POST /api/users
{
    "username": "secondAdmin",
    "password": "password",
    "enabled": true,
    "roles": [
    	{ "name" : "OWNER_ADMIN" }
	]
}
```

## Working with Petclinic in IntelliJ IDEA

### prerequisites
The following items should be installed in your system:
* Maven 3 (https://maven.apache.org/install.html)
* git command line tool (https://help.github.com/articles/set-up-git)
* IntelliJ IDEA with the Maven Helper plugin and JPA-Buddy plugin installed

### Steps:

1) In the command line
```
git clone https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest.git
```
2) Inside IntelliJ
```
File -> Open 
```


## Looking for something in particular?

| Layer | Source |
|--|--|
| REST API controllers | [REST folder](src/main/java/org/springframework/samples/petclinic/rest) |
| Service | [ClinicServiceImpl.java](src/main/java/org/springframework/samples/petclinic/service/ClinicServiceImpl.java) |
| JDBC | [jdbc folder](src/main/java/org/springframework/samples/petclinic/repository/jdbc) |
| JPA | [jpa folder](src/main/java/org/springframework/samples/petclinic/repository/jpa) |
| Spring Data JPA | [springdatajpa folder](src/main/java/org/springframework/samples/petclinic/repository/springdatajpa) |
| Tests | [AbstractClinicServiceTests.java](src/test/java/org/springframework/samples/petclinic/service/AbstractClinicServiceTests.java) |
| Postman Tests | [postman_collection.json](postman_collection.json) |

## Interesting Spring Petclinic forks

The Spring Petclinic master branch in the main [spring-projects](https://github.com/spring-projects/spring-petclinic)
GitHub org is the "canonical" implementation, currently based on Spring Boot and Thymeleaf.

This [spring-petclinic-rest](https://github.com/UserViktor/WPM_WISE21-22_spring-petclinic-rest) project is an fork of the [spring-petclinic-rest](https://github.com/spring-petclinic/spring-petclinic-rest/) whereas the spring-petclinic-rest is one of the [several forks](https://spring-petclinic.github.io/docs/forks.html) 
hosted in a special GitHub org: [spring-petclinic](https://github.com/spring-petclinic).
If you have a special interest in a different technology stack that could be used to implement the Pet Clinic then please join the community there.
