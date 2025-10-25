# 🚀 DÉPLOYER MAINTENANT - Guide Simplifié

**Tout est configuré!** Suivez ces étapes exactement:

---

## ÉTAPE 1: Déployer l'API (Backend)

### A. Aller dans le dossier API
```bash
cd "/Users/valentin/SPARK APP/Spark_Base/apps/api"
```

### B. Se connecter à Vercel (si pas déjà fait)
```bash
vercel login
```
Suivez les instructions pour vous connecter.

### C. Lier/créer le projet API
```bash
vercel link
```

Répondez aux questions:
- **Set up project?** → Yes
- **Which scope?** → Choisir votre compte
- **Link to existing project?** → No (ou Yes si vous en avez un)
- **Project name?** → `spark-api` (ou ce que vous voulez)
- **Directory?** → . (point - c'est le répertoire actuel)

### D. Configurer les variables d'environnement pour PRODUCTION

**Copiez-collez ces commandes UNE PAR UNE:**

```bash
echo "postgresql://neondb_owner:npg_sxo5L0CQyfhO@ep-red-wind-a4t3a5fb-pooler.us-east-1.aws.neon.tech/neondb?sslmode=require" | vercel env add DATABASE_URL production
```

```bash
echo "redis://default:QO7v94Lt9abw5gEv96pluKLjU6uRJZMH@redis-18352.c261.us-east-1-4.ec2.redns.redis-cloud.com:18352" | vercel env add REDIS_URL production
```

```bash
echo "https://base-sepolia.g.alchemy.com/v2/6SjWPHTigzdmD1FHZjyEC" | vercel env add BASE_RPC_URL production
```

```bash
echo "84532" | vercel env add BASE_CHAIN_ID production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add ARK_ADDRESS production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add XPREGISTRY_ADDRESS production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add BADGE_ADDRESS production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add ESCROW_ADDRESS production
```

```bash
echo "1000000000000000000" | vercel env add FAUCET_AMOUNT_WEI production
```

```bash
echo "86400" | vercel env add FAUCET_COOLDOWN_SEC production
```

### E. Déployer en production!
```bash
vercel --prod
```

**Attendez que le déploiement se termine...**

✅ **Copiez l'URL de l'API** qui s'affiche (quelque chose comme `https://spark-api-xxx.vercel.app`)

**IMPORTANT: Sauvegardez cette URL, vous en aurez besoin pour le Web!**

---

## ÉTAPE 2: Déployer le Web (Frontend)

### A. Retourner à la racine et aller dans web
```bash
cd "/Users/valentin/SPARK APP/Spark_Base/apps/web"
```

### B. Lier/créer le projet Web
```bash
vercel link
```

Répondez:
- **Set up project?** → Yes
- **Project name?** → `spark-web` (ou ce que vous voulez)
- **Directory?** → . (point)

### C. Configurer les variables d'environnement

**IMPORTANT: Remplacez `https://VOTRE-API-URL.vercel.app` par l'URL de l'API de l'étape 1!**

```bash
echo "https://VOTRE-API-URL.vercel.app" | vercel env add VITE_API_URL production
```

```bash
echo "1e45a83fc2d0bd03d1b879590322bd87" | vercel env add VITE_WC_PROJECT_ID production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add VITE_ARK_ADDRESS production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add VITE_XPREGISTRY_ADDRESS production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add VITE_BADGE_ADDRESS production
```

```bash
echo "0x155037a9854cefb83c7b90dd0499b7b64c1a120c" | vercel env add VITE_ESCROW_ADDRESS production
```

```bash
echo "84532" | vercel env add VITE_BASE_CHAIN_ID production
```

```bash
echo "https://base-sepolia.g.alchemy.com/v2/6SjWPHTigzdmD1FHZjyEC" | vercel env add VITE_BASE_RPC_URL production
```

### D. Déployer en production!
```bash
vercel --prod
```

**Attendez que le déploiement se termine...**

✅ **Copiez l'URL du Web** qui s'affiche (quelque chose comme `https://spark-web-xxx.vercel.app`)

---

## ÉTAPE 3: Migrer la Base de Données

### A. Retourner dans le dossier API
```bash
cd "/Users/valentin/SPARK APP/Spark_Base/apps/api"
```

### B. Télécharger les variables d'environnement
```bash
vercel env pull .env.production.local
```

### C. Exécuter les migrations Prisma
```bash
DATABASE_URL="postgresql://neondb_owner:npg_sxo5L0CQyfhO@ep-red-wind-a4t3a5fb-pooler.us-east-1.aws.neon.tech/neondb?sslmode=require" pnpm prisma migrate deploy
```

---

## ✅ C'EST DÉPLOYÉ!

### Tester votre API:
```bash
curl https://VOTRE-API-URL.vercel.app/health
```

Devrait retourner: `{"status":"ok"}`

### Tester votre Web:
Ouvrez dans votre navigateur: `https://VOTRE-WEB-URL.vercel.app`

---

## 🎉 FÉLICITATIONS!

Votre application SPARK est maintenant déployée et en ligne! 🚀

**URLs à retenir:**
- API: https://votre-api.vercel.app
- Web: https://votre-web.vercel.app

**Prochaines étapes:**
1. Testez l'application dans votre navigateur
2. Connectez votre wallet
3. Essayez les jeux!
4. Plus tard: Déployez les contracts manquants si besoin

---

## ⚠️ Note sur les WebSockets

Si le matchmaking en temps réel ne fonctionne pas, c'est parce que Vercel gratuit ne supporte pas les WebSockets.

**Solutions:**
- Upgrader vers Vercel Pro ($20/mois)
- Déployer l'API sur Railway ou Render (gratuit)
- Continuer avec polling (plus lent mais fonctionne)

