#!/bin/bash

# Script de test pour vérifier le token SonarQube
# Usage: ./test-sonar-token.sh YOUR_SONAR_HOST_URL YOUR_SONAR_TOKEN

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <SONAR_HOST_URL> <SONAR_TOKEN>"
    echo "Exemple: $0 http://localhost:3004 sqp_abc123..."
    echo "Exemple: $0 https://your-sonarqube.com sqp_abc123..."
    exit 1
fi

SONAR_HOST_URL=$1
SONAR_TOKEN=$2

echo "🔍 Test de connexion à SonarQube..."
echo "URL: $SONAR_HOST_URL"

# Test de l'API SonarQube
response=$(curl -s -w "%{http_code}" -u "$SONAR_TOKEN:" \
    "$SONAR_HOST_URL/api/authentication/validate")

http_code="${response: -3}"
response_body="${response%???}"

if [ "$http_code" = "200" ]; then
    echo "✅ Token valide ! Connexion réussie à SonarQube"
    echo "Response: $response_body"
else
    echo "❌ Erreur $http_code - Token invalide ou problème de connexion"
    echo "Response: $response_body"
fi

echo ""
echo "📋 Vérifiez également :"
echo "- Que SonarQube est accessible à $SONAR_HOST_URL"
echo "- Que le projet 'DEVOPS' existe dans SonarQube"
echo "- Que le token a les permissions d'analyse" 