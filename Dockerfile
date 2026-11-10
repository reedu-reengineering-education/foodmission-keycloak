# Stage 1: Build the theme JAR from this commit's sources.
# keycloakify packages the JAR with `mvn clean install`, so the builder needs a JDK and Maven.
# The JAR is platform-independent, so build it on the native build platform.
FROM --platform=$BUILDPLATFORM node:22-alpine3.24 AS builder
RUN apk add --no-cache openjdk21-jdk maven
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY . .
RUN npm run build:keycloak \
    && ls -lh dist_keycloak/keycloak-theme-for-kc-all-other-versions.jar

# Stage 2: Final Keycloak image
# Base image runs as user "keycloak" (uid/gid 2000 since 26.6, was 1000:0 before)
FROM quay.io/phasetwo/phasetwo-keycloak:26.8.2
COPY --from=builder --chown=keycloak:keycloak \
    /app/dist_keycloak/keycloak-theme-for-kc-all-other-versions.jar \
    /opt/keycloak/providers/kc-foodmission-theme.jar
USER keycloak
