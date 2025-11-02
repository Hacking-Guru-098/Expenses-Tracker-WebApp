# stage 1 (BUILD JAR USING MAVEN)
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests=true

# stage 2 (EXECUTE JAR GENERATED ABOVE WITH SMALLER IMAGE)
FROM openjdk:17-alpine

COPY --from=builder /app/target/*.jar /app/expensesapp.jar

CMD ["java","-jar","expensesapp.jar"]
