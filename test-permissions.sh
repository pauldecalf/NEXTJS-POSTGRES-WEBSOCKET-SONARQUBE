#!/bin/bash

# Script pour tester les permissions SonarQube
TOKEN="sqp_c6e2da62ccfa50599cbb064ffe3f62c5c5e18848"
SONAR_URL="http://168.231.87.2:3004"
PROJECT_KEY="NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE"

echo "🔍 Test des permissions SonarQube..."

echo "1. Test de connexion générale..."
curl -s -u "$TOKEN:" "$SONAR_URL/api/authentication/validate" | jq 2>/dev/null || echo "Réponse reçue"

echo -e "\n2. Test d'accès au projet..."
curl -s -u "$TOKEN:" "$SONAR_URL/api/projects/search?projects=$PROJECT_KEY" | jq 2>/dev/null || echo "Réponse reçue"

echo -e "\n3. Test des permissions utilisateur..."
curl -s -u "$TOKEN:" "$SONAR_URL/api/permissions/users?projectKey=$PROJECT_KEY" | jq 2>/dev/null || echo "Réponse reçue"

echo -e "\n4. Test de création d'analyse..."
curl -s -u "$TOKEN:" "$SONAR_URL/api/project_analyses/search?project=$PROJECT_KEY" | jq 2>/dev/null || echo "Réponse reçue"

echo -e "\n✅ Tests terminés. Si vous voyez des erreurs 401/403, le token n'a pas les bonnes permissions." 