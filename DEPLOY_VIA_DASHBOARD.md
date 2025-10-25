# 🚀 Déploiement Rapide via Dashboard Vercel

Le build en ligne de commande est trop long (20+ minutes). **Utilisons le dashboard Vercel** à la place - c'est plus rapide et plus visuel! ⚡

---

## ✅ Ce qui est déjà fait:

- [x] Projet API créé sur Vercel: `api`
- [x] Vous êtes connecté à Vercel
- [x] Toutes les valeurs sont prêtes

---

## 🎯 SOLUTION RAPIDE (5-10 minutes)

### ÉTAPE 1: Configurer les Variables d'Environnement de l'API

**A. Aller sur le projet API:**
1. Ouvrir: https://vercel.com/valentinbracqs-projects/api
2. Cliquer sur **"Settings"** (en haut)
3. Cliquer sur **"Environment Variables"** (dans le menu à gauche)

**B. Ajouter ces variables une par une:**

Cliquer sur **"Add New"** pour chaque variable:

```
Nom: DATABASE_URL
Valeur: postgresql://neondb_owner:npg_sxo5L0CQyfhO@ep-red-wind-a4t3a5fb-pooler.us-east-1.aws.neon.tech/neondb?sslmode=require
Environment: Production ✓
```

```
Nom: REDIS_URL
Valeur: redis://default:QO7v94Lt9abw5gEv96pluKLjU6uRJZMH@redis-18352.c261.us-east-1-4.ec2.redns.redis-cloud.com:18352
Environment: Production ✓
```

```
Nom: BASE_RPC_URL
Valeur: https://base-sepolia.g.alchemy.com/v2/6SjWPHTigzdmD1FHZjyEC
Environment: Production ✓
```

```
Nom: BASE_CHAIN_ID
Valeur: 84532
Environment: Production ✓
```

```
Nom: ARK_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: XPREGISTRY_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: BADGE_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: ESCROW_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: FAUCET_AMOUNT_WEI
Valeur: 1000000000000000000
Environment: Production ✓
```

```
Nom: FAUCET_COOLDOWN_SEC
Valeur: 86400
Environment: Production ✓
```

**C. Sauvegarder**
Cliquer **"Save"** après chaque variable.

---

### ÉTAPE 2: Redéployer l'API

**A. Retourner aux déploiements:**
1. Cliquer sur **"Deployments"** (en haut)
2. Trouver le dernier déploiement (celui qui a été annulé)
3. Cliquer sur les **3 points (...)** à droite
4. Cliquer sur **"Redeploy"**
5. Cocher **"Use existing Build Cache"** si disponible
6. Cliquer **"Redeploy"**

**OU simplement:**

Retourner dans le terminal et relancer:
```bash
cd "/Users/valentin/SPARK APP/Spark_Base/apps/api"
vercel --prod
```

**Attendez 5-10 minutes** (cette fois ça devrait être plus rapide car les dépendances sont en cache)

✅ **Notez l'URL de l'API** qui s'affiche à la fin!

---

### ÉTAPE 3: Déployer le Web

**A. Déployer le Web:**
```bash
cd "/Users/valentin/SPARK APP/Spark_Base/apps/web"
vercel
```

**B. Aller configurer les variables du Web:**
1. Ouvrir le projet Web sur Vercel (l'URL sera affichée après le déploiement)
2. Aller dans **Settings** → **Environment Variables**

**C. Ajouter ces variables:**

⚠️ **IMPORTANT: Remplacez `https://VOTRE-API-URL.vercel.app` par la vraie URL de votre API!**

```
Nom: VITE_API_URL
Valeur: https://VOTRE-API-URL.vercel.app
Environment: Production ✓
```

```
Nom: VITE_WC_PROJECT_ID
Valeur: 1e45a83fc2d0bd03d1b879590322bd87
Environment: Production ✓
```

```
Nom: VITE_ARK_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: VITE_XPREGISTRY_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: VITE_BADGE_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: VITE_ESCROW_ADDRESS
Valeur: 0x155037a9854cefb83c7b90dd0499b7b64c1a120c
Environment: Production ✓
```

```
Nom: VITE_BASE_CHAIN_ID
Valeur: 84532
Environment: Production ✓
```

```
Nom: VITE_BASE_RPC_URL
Valeur: https://base-sepolia.g.alchemy.com/v2/6SjWPHTigzdmD1FHZjyEC
Environment: Production ✓
```

**D. Redéployer le Web:**

Retourner dans **Deployments** → **Redeploy** ou:
```bash
vercel --prod
```

---

### ÉTAPE 4: Migrer la Base de Données

Une fois que l'API est déployée avec succès:

```bash
cd "/Users/valentin/SPARK APP/Spark_Base/apps/api"
DATABASE_URL="postgresql://neondb_owner:npg_sxo5L0CQyfhO@ep-red-wind-a4t3a5fb-pooler.us-east-1.aws.neon.tech/neondb?sslmode=require" pnpm prisma migrate deploy
```

---

## 🎉 C'EST DÉPLOYÉ!

### Vos URLs:
- **API**: https://api-valentinbracqs-projects.vercel.app (ou similaire)
- **Web**: https://web-[votre-url].vercel.app

### Tester:

**API:**
```bash
curl https://api-valentinbracqs-projects.vercel.app/health
```

**Web:**
Ouvrir dans le navigateur et connecter votre wallet!

---

## 💡 Pourquoi c'est plus rapide?

Le dashboard Vercel:
- Cache mieux les builds
- Optimise automatiquement
- Interface plus claire
- Pas de timeout en ligne de commande

---

## ⚠️ Si le build est encore lent

Le monorepo peut être lent à build. Si ça prend trop de temps:

1. **Annuler le build** dans le dashboard
2. **Optimiser le vercel.json** (je peux le faire)
3. **Ou déployer depuis Git** (connecter le repo GitHub)

---

## 🚀 COMMENCEZ MAINTENANT

1. **Ouvrir:** https://vercel.com/valentinbracqs-projects/api/settings/environment-variables
2. **Ajouter les 10 variables** listées ci-dessus
3. **Redéployer**
4. **Configurer le Web** de la même manière
5. **Migrer la DB**
6. **Tester!**

C'est parti! 🎉

