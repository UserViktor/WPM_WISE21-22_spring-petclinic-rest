#### Stage 1: Build the application
FROM openjdk:11 as build

# Set the current working directory inside the image
WORKDIR /app

# Copy maven executable to the image
COPY mvnw .
COPY .mvn .mvn

# Copy the pom.xml file
COPY pom.xml .

# Build all the dependencies in preparation to go offline.
# This is a separate step so the dependencies will be cached unless
# the pom.xml file has changed.
RUN ./mvnw dependency:go-offline -B

# Copy the project source
COPY . src

# Package the application
WORKDIR /app/src
RUN ./mvnw package -DskipTests

# Start application
CMD java -jar /app/src/target/*.jar

## Expose port 9966 to the Docker host, so we can access it
## from the outside.
EXPOSE 9966
