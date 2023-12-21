FROM openjdk:17-oracle
EXPOSE 8080
ADD target/poc-demo-app.jar poc-demo-app.jar
ENTRYPOINT ["java", "-jar", "/poc-demo-app.jar"]
