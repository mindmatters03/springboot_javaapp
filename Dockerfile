# Use an official Maven image as the base image
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Use an OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/spring-boot-web.jar app.jar

# Command to run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]

EXPOSE 8080
