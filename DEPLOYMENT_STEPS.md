# 🚀 SPARK BASE - Step-by-Step Deployment Guide

This guide will walk you through deploying your SPARK app to Vercel.

## Prerequisites Checklist

- [x] ✅ Vercel CLI installed
- [x] ✅ pnpm lockfile generated
- [x] ✅ Build configuration fixed
- [ ] 🔲 Environment variables configured
- [ ] 🔲 Database set up (Vercel Postgres)
- [ ] 🔲 Redis set up (Vercel KV or Upstash)
- [ ] 🔲 Smart contracts deployed
- [ ] 🔲 Alchemy RPC key obtained
- [ ] 🔲 WalletConnect project created

---

## Option A: Automated Setup (Recommended)

### Step 1: Create Environment Variables

```bash
./setup-env.sh
```

This will create a `.env` file with all required variables.

### Step 2: Fill in Your Values

Open the `.env` file and fill in:

1. **Get Alchemy API Key**: https://www.alchemy.com/
   - Create account → New App → Base Sepolia
   - Copy API key and paste into `BASE_RPC_URL` and `VITE_BASE_RPC_URL`

2. **Get WalletConnect Project ID**: https://cloud.walletconnect.com/
   - Create project → Copy Project ID
   - Paste into `VITE_WC_PROJECT_ID`

3. **Smart Contract Addresses**:
   - Check `packages/contracts/broadcast/` for deployed addresses
   - Or deploy contracts: `cd packages/contracts && forge script script/Deploy.s.sol --rpc-url $BASE_RPC_URL --broadcast`
   - Update: `XPREGISTRY_ADDRESS`, `BADGE_ADDRESS`, `ESCROW_ADDRESS`

### Step 3: Set Up Vercel Services

Before deploying, set up these services in Vercel:

#### 3a. Create Postgres Database
1. Go to https://vercel.com/storage
2. Click "Create Database" → "Postgres"
3. Copy the `DATABASE_URL` (pooled connection)
4. You'll add this during deployment

#### 3b. Create Redis/KV Store
1. Go to https://vercel.com/storage
2. Click "Create Database" → "KV" (Redis)
3. Copy the connection URL
4. You'll add this during deployment

### Step 4: Deploy to Vercel

```bash
./setup-vercel.sh
```

Follow the prompts to deploy:
- Choose option 3 (Deploy both) or deploy individually
- The script will guide you through setting environment variables
- It will automatically deploy to Vercel

---

## Option B: Manual Deployment

### Step 1: Prepare Environment Variables

Create a `.env` file manually with these values:

```bash
# Backend Variables
PORT=8787
DATABASE_URL=<your-vercel-postgres-url>
REDIS_URL=<your-vercel-kv-url>
BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/<your-key>
BASE_CHAIN_ID=84532
ARK_ADDRESS=0x155037a9854cefb83c7b90dd0499b7b64c1a120c
XPREGISTRY_ADDRESS=<your-address>
BADGE_ADDRESS=<your-address>
ESCROW_ADDRESS=<your-address>
FAUCET_AMOUNT_WEI=1000000000000000000
FAUCET_COOLDOWN_SEC=86400

# Frontend Variables
VITE_API_URL=<your-api-url>
VITE_WC_PROJECT_ID=<your-walletconnect-id>
VITE_ARK_ADDRESS=0x155037a9854cefb83c7b90dd0499b7b64c1a120c
VITE_XPREGISTRY_ADDRESS=<your-address>
VITE_BADGE_ADDRESS=<your-address>
VITE_ESCROW_ADDRESS=<your-address>
VITE_BASE_CHAIN_ID=84532
VITE_BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/<your-key>
```

### Step 2: Deploy API

```bash
cd apps/api
vercel link
vercel env add DATABASE_URL production
vercel env add REDIS_URL production
vercel env add BASE_RPC_URL production
vercel env add BASE_CHAIN_ID production
vercel env add ARK_ADDRESS production
vercel env add XPREGISTRY_ADDRESS production
vercel env add BADGE_ADDRESS production
vercel env add ESCROW_ADDRESS production
vercel env add FAUCET_AMOUNT_WEI production
vercel env add FAUCET_COOLDOWN_SEC production
vercel --prod
cd ../..
```

**Important**: Save the API URL from the deployment output!

### Step 3: Deploy Web

```bash
cd apps/web
vercel link
vercel env add VITE_API_URL production  # Use API URL from Step 2
vercel env add VITE_WC_PROJECT_ID production
vercel env add VITE_ARK_ADDRESS production
vercel env add VITE_XPREGISTRY_ADDRESS production
vercel env add VITE_BADGE_ADDRESS production
vercel env add VITE_ESCROW_ADDRESS production
vercel env add VITE_BASE_CHAIN_ID production
vercel env add VITE_BASE_RPC_URL production
vercel --prod
cd ../..
```

### Step 4: Run Database Migrations

```bash
cd apps/api
vercel env pull .env.production.local
DATABASE_URL=$(cat .env.production.local | grep DATABASE_URL | cut -d '=' -f2-) pnpm prisma migrate deploy
cd ../..
```

---

## Post-Deployment Steps

### 1. Verify API is Running

Visit your API URL and check:
```bash
curl https://your-api.vercel.app/health
```

Expected response: `{"status":"ok"}`

### 2. Check Database Connection

```bash
curl https://your-api.vercel.app/api/metrics
```

Should return metrics without errors.

### 3. Test Web App

1. Visit your Web URL
2. Connect wallet
3. Try to claim faucet tokens
4. Check if contracts load correctly

### 4. Test WebSocket (Important!)

**Note**: WebSockets require Vercel Pro or Enterprise plan.

If you're on Hobby plan, you'll need to deploy the API elsewhere:
- **Railway**: https://railway.app/
- **Render**: https://render.com/
- **Fly.io**: https://fly.io/

---

## Troubleshooting

### Build Fails: "Cannot find module '@spark/shared'"
- **Cause**: Shared package not built
- **Fix**: Already fixed in `vercel.json` - ensure you're using latest config
- **Verify**: Check `.vercelignore` doesn't block `packages/`

### Build Fails: "Prisma Client not generated"
- **Cause**: Missing Prisma generation step
- **Fix**: Already fixed in `apps/api/vercel.json`
- **Verify**: `DATABASE_URL` is set in Vercel environment variables

### Runtime Error: "Cannot connect to database"
- **Cause**: Wrong `DATABASE_URL` or network issue
- **Fix**: 
  1. Use Vercel Postgres pooled connection string
  2. Ensure database allows connections from Vercel
  3. Check environment variable is set correctly

### WebSocket Connection Fails
- **Cause**: Vercel Hobby plan doesn't support WebSockets
- **Solutions**:
  1. Upgrade to Vercel Pro ($20/month)
  2. Deploy API to Railway/Render (free tier available)
  3. Use polling instead of WebSockets (not recommended)

### Contract Interaction Fails
- **Cause**: Wrong RPC URL or contract addresses
- **Fix**:
  1. Verify all addresses in environment variables
  2. Check RPC URL is correct for Base Sepolia
  3. Ensure wallet is connected to Base Sepolia network

---

## Environment Variables Reference

### API (Backend)

| Variable | Required | Example | Where to Get |
|----------|----------|---------|--------------|
| `DATABASE_URL` | ✅ | `postgresql://...` | Vercel Postgres |
| `REDIS_URL` | ✅ | `redis://...` | Vercel KV or Upstash |
| `BASE_RPC_URL` | ✅ | `https://base-sepolia.g.alchemy.com/v2/...` | Alchemy |
| `BASE_CHAIN_ID` | ✅ | `84532` | Fixed (Base Sepolia) |
| `ARK_ADDRESS` | ✅ | `0x155...` | Contract deployment |
| `XPREGISTRY_ADDRESS` | ✅ | `0x...` | Contract deployment |
| `BADGE_ADDRESS` | ✅ | `0x...` | Contract deployment |
| `ESCROW_ADDRESS` | ✅ | `0x...` | Contract deployment |
| `FAUCET_AMOUNT_WEI` | ❌ | `1000000000000000000` | Your choice (1 token) |
| `FAUCET_COOLDOWN_SEC` | ❌ | `86400` | Your choice (24h) |

### Web (Frontend)

| Variable | Required | Example | Where to Get |
|----------|----------|---------|--------------|
| `VITE_API_URL` | ✅ | `https://your-api.vercel.app` | API deployment |
| `VITE_WC_PROJECT_ID` | ✅ | `abc123...` | WalletConnect Cloud |
| `VITE_ARK_ADDRESS` | ✅ | `0x155...` | Same as API |
| `VITE_XPREGISTRY_ADDRESS` | ✅ | `0x...` | Same as API |
| `VITE_BADGE_ADDRESS` | ✅ | `0x...` | Same as API |
| `VITE_ESCROW_ADDRESS` | ✅ | `0x...` | Same as API |
| `VITE_BASE_CHAIN_ID` | ✅ | `84532` | Fixed (Base Sepolia) |
| `VITE_BASE_RPC_URL` | ✅ | `https://base-sepolia.g.alchemy.com/v2/...` | Alchemy |

---

## Quick Command Reference

```bash
# Create local environment file
./setup-env.sh

# Deploy everything
./setup-vercel.sh

# Deploy API only
cd apps/api && vercel --prod

# Deploy Web only
cd apps/web && vercel --prod

# View logs
vercel logs <deployment-url>

# Pull environment variables locally
cd apps/api && vercel env pull
cd apps/web && vercel env pull

# Run migrations
cd apps/api && pnpm prisma migrate deploy

# Check deployment status
vercel ls
```

---

## Need Help?

1. Check `VERCEL_DEPLOYMENT.md` for technical details
2. Review logs: `vercel logs`
3. Check Vercel dashboard for build/runtime errors
4. Verify all environment variables are set correctly

---

## Success Checklist

After deployment, verify:

- [ ] API health endpoint responds: `/health`
- [ ] Web app loads without errors
- [ ] Wallet can connect
- [ ] Contract addresses are correct
- [ ] Faucet works
- [ ] Game matchmaking connects (if using WebSockets)
- [ ] Database stores user data
- [ ] Leaderboard shows data

🎉 **Congratulations! Your SPARK app is deployed!**

