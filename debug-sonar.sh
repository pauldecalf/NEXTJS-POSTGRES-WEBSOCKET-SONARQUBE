#!/bin/bash

# Script de diagnostic SonarQube complet
SONAR_URL="http://168.231.87.2:3004"
PROJECT_KEY="NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE"
TOKEN="sqp_c6e2da62ccfa50599cbb064ffe3f62c5c5e18848"

echo "🔍 Diagnostic SonarQube complet"
echo "================================"
echo "URL: $SONAR_URL"
echo "Projet: $PROJECT_KEY"
echo "Token: ${TOKEN:0:10}..."
echo ""

# Test 1: Connexion de base
echo "1️⃣ Test de connexion SonarQube..."
response=$(curl -s -w "%{http_code}" -u "$TOKEN:" "$SONAR_URL/api/system/status")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    echo "✅ SonarQube accessible"
else
    echo "❌ Erreur $http_code - SonarQube non accessible"
    exit 1
fi

# Test 2: Validation du token
echo -e "\n2️⃣ Test de validation du token..."
response=$(curl -s -w "%{http_code}" -u "$TOKEN:" "$SONAR_URL/api/authentication/validate")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    echo "✅ Token valide"
else
    echo "❌ Erreur $http_code - Token invalide"
    echo "Response: ${response%???}"
fi

# Test 3: Recherche du projet
echo -e "\n3️⃣ Test d'existence du projet..."
response=$(curl -s -w "%{http_code}" -u "$TOKEN:" "$SONAR_URL/api/projects/search?projects=$PROJECT_KEY")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    echo "✅ Projet accessible"
    echo "Response: ${response%???}"
else
    echo "❌ Erreur $http_code - Projet non accessible"
    echo "Response: ${response%???}"
fi

# Test 4: Permissions utilisateur sur le projet
echo -e "\n4️⃣ Test des permissions sur le projet..."
response=$(curl -s -w "%{http_code}" -u "$TOKEN:" "$SONAR_URL/api/permissions/users?projectKey=$PROJECT_KEY")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    echo "✅ Permissions lisibles"
    echo "Response: ${response%???}"
else
    echo "❌ Erreur $http_code - Permissions non lisibles"
    echo "Response: ${response%???}"
fi

# Test 5: Permissions globales
echo -e "\n5️⃣ Test des permissions globales..."
response=$(curl -s -w "%{http_code}" -u "$TOKEN:" "$SONAR_URL/api/permissions/search_global_permissions")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    echo "✅ Permissions globales lisibles"
    echo "Response: ${response%???}"
else
    echo "❌ Erreur $http_code - Permissions globales non lisibles"
    echo "Response: ${response%???}"
fi

# Test 6: Info utilisateur
echo -e "\n6️⃣ Test des informations utilisateur..."
response=$(curl -s -w "%{http_code}" -u "$TOKEN:" "$SONAR_URL/api/users/current")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    echo "✅ Informations utilisateur accessibles"
    echo "Response: ${response%???}"
else
    echo "❌ Erreur $http_code - Informations utilisateur non accessibles"
    echo "Response: ${response%???}"
fi

echo -e "\n🎯 Résumé:"
echo "- Si tous les tests passent ✅, le problème peut venir de GitHub Secrets"
echo "- Si test 2 échoue ❌, régénérez le token"
echo "- Si test 3 échoue ❌, vérifiez le nom du projet"
echo "- Si test 4/5 échouent ❌, ajustez les permissions" 