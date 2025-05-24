# Guide de configuration SonarQube

## 🎯 Résolution du problème d'autorisation

### Erreur rencontrée
```
ERROR You're not authorized to analyze this project or the project doesn't exist on SonarQube and you're not authorized to create it.
```

## 🔧 Solutions

### Solution 1 : Créer le projet manuellement

1. **Accédez à SonarQube** : http://168.231.87.2:3004
2. **Connectez-vous** avec admin/admin
3. **Créez un nouveau projet** :
   - Cliquez sur **"Create Project"**
   - **Project Key** : `NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE`
   - **Display Name** : `NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE`
   - Cliquez sur **"Set Up"**

### Solution 2 : Autoriser la création automatique de projets

1. **Dans SonarQube** → **Administration** → **Configuration** → **General Settings**
2. **Security** → **Force user authentication** : `false` (optionnel)
3. **Administration** → **Security** → **Global Permissions**
4. **Accordez la permission "Create Projects"** à votre utilisateur/token

### Solution 3 : Vérifier les permissions du token

1. **Administration** → **Security** → **Users**
2. **Cliquez sur votre utilisateur** → **Tokens**
3. **Vérifiez que le token a les permissions** :
   - `Administer Projects`
   - `Create Projects` 
   - `Browse`

### Solution 4 : Utiliser un token d'administrateur

1. **Connectez-vous comme admin**
2. **Administration** → **Security** → **Users** → **admin**
3. **Générez un nouveau token** pour l'utilisateur admin
4. **Utilisez ce token** dans GitHub Secrets

## 🧪 Test de configuration

### Créer et tester le projet

```bash
# Test de création de projet via API
curl -u YOUR_TOKEN: -X POST \
  "http://168.231.87.2:3004/api/projects/create" \
  -d "project=NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE&name=NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE"

# Test de permissions
curl -u YOUR_TOKEN: \
  "http://168.231.87.2:3004/api/permissions/users?projectKey=NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE"
```

### Tester avec le script

```bash
bash test-sonar-token.sh http://168.231.87.2:3004 YOUR_TOKEN
```

## 📋 Configuration recommandée

### Permissions minimales requises

Pour que le workflow GitHub Actions fonctionne, le token doit avoir :

- ✅ **Execute Analysis** 
- ✅ **Browse**
- ✅ **Create Projects** (si auto-création souhaitée)

### Variables d'environnement GitHub

```
SONAR_TOKEN=sqp_c6e2da62ccfa50599cbb064ffe3f62c5c5e18848
SONAR_HOST_URL=http://168.231.87.2:3004
```

## 🎉 Vérification du succès

Une fois configuré, vous devriez voir :

1. ✅ **Le projet créé** dans SonarQube
2. ✅ **L'analyse complète** sans erreur d'autorisation
3. ✅ **Les métriques visibles** dans l'interface SonarQube

## 🔧 Dépannage

### Erreur 401 Unauthorized
- Vérifiez que le token est correct
- Vérifiez que l'utilisateur existe

### Erreur 403 Forbidden  
- Vérifiez les permissions du token
- Créez le projet manuellement
- Utilisez un token admin

### Projet non trouvé
- Créez le projet avec la clé exacte `NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE`
- Vérifiez que la clé correspond au `sonar-project.properties` 