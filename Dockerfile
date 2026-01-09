FROM quay.io/keycloak/keycloak:26.3

USER root
RUN apk add --no-cache curl \
  && curl -L -o /opt/keycloak/providers/kc-foodmission-theme.jar \
       "https://github.com/reedu-reengineering-education/foodmission-keycloak/releases/latest/download/keycloak-theme-for-kc-all-other-versions.jar" \
  && chown -R 1000:0 /opt/keycloak/providers
USER 1000
