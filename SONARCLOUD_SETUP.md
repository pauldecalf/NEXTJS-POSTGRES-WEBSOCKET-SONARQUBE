# Guide de configuration SonarCloud

## 🎯 Étapes pour configurer SonarCloud

### 1. Créer un compte SonarCloud

1. Allez sur [SonarCloud.io](https://sonarcloud.io)
2. Cliquez sur **"Log in"**
3. Connectez-vous avec votre compte **GitHub**
4. Autorisez SonarCloud à accéder à votre compte GitHub

### 2. Créer le projet

1. Une fois connecté, cliquez sur **"+"** en haut à droite
2. Sélectionnez **"Analyze new project"**
3. Choisissez votre repository **"NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE"**
4. Cliquez sur **"Set up"**

### 3. Obtenir votre organisation

- Votre **organization key** est visible dans l'URL ou dans les paramètres
- C'est généralement votre nom d'utilisateur GitHub
- Exemple : si votre GitHub est `github.com/johndoe`, alors `organization=johndoe`

### 4. Générer le token

1. Dans SonarCloud, allez dans **"My Account"** → **"Security"**
2. Dans la section **"Generate Tokens"** :
   - Name: `github-actions`
   - Type: `User Token`
   - Expires: `90 days` (ou plus)
3. Cliquez sur **"Generate"**
4. **COPIEZ LE TOKEN** (il ne sera plus visible après)

### 5. Configurer GitHub Secrets

1. Dans votre repository GitHub, allez dans **Settings** → **Secrets and variables** → **Actions**
2. Cliquez sur **"New repository secret"**
3. Ajoutez :
   - **Name**: `SONAR_TOKEN`
   - **Value**: Le token que vous avez copié

### 6. Mettre à jour sonar-project.properties

Dans le fichier `sonar-project.properties`, remplacez :
```properties
sonar.organization=your-github-username  # ⬅️ Remplacez par votre vraie organisation
sonar.projectKey=your-github-username_NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE  # ⬅️ Optionnel
```

### 7. Tester

1. Committez vos changements
2. Pushez vers la branche `main`
3. Le workflow GitHub Actions devrait se déclencher automatiquement
4. Vérifiez les résultats sur SonarCloud

## ❗ Problèmes courants

### Erreur 403 Forbidden
- ✅ Vérifiez que le token est bien configuré dans GitHub Secrets
- ✅ Vérifiez que l'organisation est correcte
- ✅ Assurez-vous que le projet existe sur SonarCloud

### Token expiré
- Générez un nouveau token avec une durée plus longue
- Mettez à jour le secret GitHub

### Organisation introuvable
- Vérifiez l'orthographe de votre nom d'utilisateur GitHub
- L'organisation doit correspondre exactement à votre compte GitHub

## 🎉 Succès

Une fois configuré correctement, vous verrez :
- ✅ Le workflow GitHub Actions se termine avec succès
- ✅ L'analyse apparaît sur SonarCloud
- ✅ Les métriques de qualité du code sont visibles 