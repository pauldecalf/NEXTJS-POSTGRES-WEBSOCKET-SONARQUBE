# NextJS + PostgreSQL + WebSocket + SonarQube

Un projet Next.js moderne avec intégration PostgreSQL, WebSocket et analyse de code SonarQube.

## Technologies utilisées

- **Next.js 15.3.2** avec React 19
- **TypeScript** pour la sécurité des types
- **PostgreSQL** pour la base de données
- **Docker & Docker Compose** pour la containerisation
- **SonarQube/SonarCloud** pour l'analyse de qualité du code
- **Tailwind CSS** pour le styling

## Démarrage rapide

### Avec Docker (Recommandé)

```bash
# Démarrer tous les services
docker-compose up -d

# Accès aux services :
# - Application Next.js : http://localhost:3001
# - PostgreSQL : localhost:3002
# - pgAdmin : http://localhost:3003
# - SonarQube : http://localhost:3004
```

### Développement local

```bash
# Installer les dépendances
npm install

# Démarrer le serveur de développement
npm run dev
```

Ouvrez [http://localhost:3000](http://localhost:3000) dans votre navigateur.

## Configuration SonarQube

### SonarQube auto-hébergé

Le projet est configuré avec **SonarQube** pour l'analyse automatique sur GitHub Actions.

#### Configuration des secrets GitHub

Configurez ces secrets dans votre repository GitHub (**Settings** → **Secrets and variables** → **Actions**) :

- **`SONAR_TOKEN`** : Token d'authentification SonarQube
- **`SONAR_HOST_URL`** : URL de votre instance SonarQube (ex: `http://localhost:3004` ou `https://your-sonarqube.com`)

#### Configuration SonarQube local

1. **Démarrez SonarQube** avec Docker :
   ```bash
   docker-compose up sonarqube
   ```

2. **Accédez à SonarQube** : http://localhost:3004

3. **Connectez-vous** (admin/admin par défaut)

4. **Créez le projet** :
   - Nom : `NEXTJS-POSTGRES-WEBSOCKET-SONARQUBE`
   - Clé : `DEVOPS`

5. **Générez un token** :
   - **Administration** → **Security** → **Users**
   - Cliquez sur votre utilisateur → **Tokens**
   - Générez un nouveau token

6. **Testez la connexion** (optionnel) :
   ```bash
   bash test-sonar-token.sh http://localhost:3004 YOUR_TOKEN
   ```

#### GitHub Actions

Le workflow `build.yml` s'exécute automatiquement et utilise votre instance SonarQube.

## Scripts disponibles

```bash
npm run dev      # Serveur de développement avec Turbopack
npm run build    # Build de production
npm run start    # Serveur de production
npm run lint     # Vérification ESLint
```

## Workflows disponibles

- **`build.yml`** : Analyse avec SonarQube auto-hébergé

## Structure du projet

```
├── app/                 # Pages et composants Next.js (App Router)
├── public/             # Fichiers statiques
├── .github/workflows/  # Workflows GitHub Actions
├── docker-compose.yml  # Configuration Docker
├── sonar-project.properties  # Configuration SonarQube/SonarCloud
└── package.json       # Dépendances et scripts
```

## Déploiement

Le moyen le plus simple de déployer votre application Next.js est d'utiliser la [plateforme Vercel](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme).

Consultez la [documentation de déploiement Next.js](https://nextjs.org/docs/app/building-your-application/deploying) pour plus de détails.
