# 🐘 Créer Postgres avec Neon sur Vercel

Vercel utilise maintenant le Marketplace pour Postgres. **Neon** est le meilleur choix!

---

## Étapes pour créer Postgres avec Neon

### 1. Depuis la page Marketplace
Vous êtes déjà sur la bonne page! Cliquez sur **"Neon"** (Serverless Postgres)

### 2. Installation
1. Cliquer sur **"Neon"** dans la liste
2. Cliquer sur **"Add Integration"** ou **"Install"**
3. Suivre les instructions (ça va créer un compte Neon si vous n'en avez pas)
4. Autoriser la connexion entre Vercel et Neon

### 3. Créer la base de données
1. Choisir un nom : `spark-db` (ou n'importe quel nom)
2. Région : **US East** (même région que Redis!)
3. Cliquer **"Create Database"**

### 4. Connecter à votre projet
1. Sélectionner votre projet Vercel (si vous en avez un)
2. Ou vous le ferez plus tard lors du déploiement

### 5. Récupérer l'URL de connexion
Après création, vous verrez l'URL de connexion. Elle ressemble à :

```
postgresql://user:password@ep-cool-name.us-east-1.aws.neon.tech/neondb?sslmode=require
```

**Copiez cette URL complète!**

---

## Alternative : Si Neon ne fonctionne pas

Vous pouvez aussi utiliser :
- **Supabase** (excellent aussi)
- **Prisma Postgres** (très rapide à setup)
- **Turso** (SQLite serverless)

Tous fonctionnent bien avec Vercel!

---

## Une fois que vous avez l'URL Postgres

**Donnez-moi l'URL** et je vais :
1. La sauvegarder dans `.env`
2. Lancer le déploiement!

---

## Note importante

L'URL Postgres peut être dans plusieurs variables :
- `DATABASE_URL`
- `POSTGRES_URL`
- `POSTGRES_PRISMA_URL`

**Prenez celle qui dit "pooling" ou "pooled" si disponible** (c'est mieux pour la performance)

Sinon, prenez la `DATABASE_URL` standard.

---

🚀 **Prêt à créer Postgres avec Neon!**

