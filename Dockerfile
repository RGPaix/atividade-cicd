# --- Estágio 1: Build ---
    FROM eclipse-temurin:17-jdk-jammy as builder
    WORKDIR /app
    COPY . .
    # Instala Maven
    RUN apt-get update && apt-get install -y maven
    RUN mvn -B package -DskipTests

# --- Estágio 2: Runtime ---
    FROM eclipse-temurin:17-jre-jammy
    WORKDIR /app
    COPY --from=builder /app/target/*.jar app.jar
    EXPOSE 8080
    ENTRYPOINT ["java", "-jar", "app.jar"]