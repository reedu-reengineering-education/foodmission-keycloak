# Stage 1: Download the theme
FROM alpine:3.24 AS loader
RUN apk add --no-cache curl
RUN curl -L -f -o /kc-foodmission-theme.jar \
    "https://github.com/reedu-reengineering-education/foodmission-keycloak/releases/latest/download/keycloak-theme-for-kc-all-other-versions.jar" \
    && ls -lh /kc-foodmission-theme.jar

# Stage 2: Final Keycloak image
# Base image runs as user "keycloak" (uid/gid 2000 since 26.6, was 1000:0 before)
FROM quay.io/phasetwo/phasetwo-keycloak:26.6.6
COPY --from=loader --chown=keycloak:keycloak /kc-foodmission-theme.jar /opt/keycloak/providers/
USER keycloak
