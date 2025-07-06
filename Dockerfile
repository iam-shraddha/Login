# Dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/simple-login-1.0.0.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]

