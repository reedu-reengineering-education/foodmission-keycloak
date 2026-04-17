# Stage 1: Download the theme
FROM alpine:latest AS loader
RUN apk add --no-cache curl
RUN curl -L -f -o /kc-foodmission-theme.jar \
    "https://github.com/reedu-reengineering-education/foodmission-keycloak/releases/latest/download/keycloak-theme-for-kc-all-other-versions.jar" \
    && ls -lh /kc-foodmission-theme.jar

# Stage 2: Final Keycloak image
FROM quay.io/keycloak/keycloak:26.3
COPY --from=loader /kc-foodmission-theme.jar /opt/keycloak/providers/
USER root
RUN chown 1000:0 /opt/keycloak/providers/kc-foodmission-theme.jar
USER 1000