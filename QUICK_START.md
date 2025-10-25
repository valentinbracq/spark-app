# 🚀 Quick Start - Deploy to Vercel in 5 Minutes

## What Was Fixed

✅ Fixed build configuration issues  
✅ Fixed monorepo dependency handling  
✅ Fixed Prisma client generation  
✅ Generated pnpm lockfile  
✅ Installed Vercel CLI  

## What You Need Before Deploying

### 1. Smart Contract Addresses ⚠️

Your contracts need to be deployed to Base Sepolia. We found:
- ✅ ARK Token: `0x155037a9854cefb83c7b90dd0499b7b64c1a120c`
- ❓ XPRegistry: Not found
- ❓ BadgeNFT: Not found
- ❓ GameEscrow: Not found

**If you haven't deployed all contracts yet**, run:
```bash
cd packages/contracts
# Set up environment for deployment
# Then run:
forge script script/Deploy.s.sol --rpc-url $BASE_RPC_URL --broadcast --verify
cd ../..
```

### 2. External Services

You'll need accounts for:
- **Alchemy** (for RPC): https://www.alchemy.com/ → Free
- **WalletConnect** (for wallet connection): https://cloud.walletconnect.com/ → Free
- **Vercel** (deployment): https://vercel.com/ → Free (Hobby plan)

**Note**: Vercel Hobby plan doesn't support WebSockets. For full functionality:
- Upgrade to Vercel Pro ($20/month), OR
- Deploy API to Railway/Render (free tier available)

---

## Deployment Options

### ⚡ Option 1: Automated (Easiest)

```bash
# Step 1: Set up environment variables
./setup-env.sh

# Step 2: Edit .env file with your actual values
nano .env  # or open in your editor

# Step 3: Deploy everything
./setup-vercel.sh
```

**The script will prompt you for:**
1. Database URL (from Vercel Postgres)
2. Redis URL (from Vercel KV)
3. Choose to deploy API, Web, or both

---

### 📝 Option 2: Manual (Step by Step)

Follow the detailed guide in `DEPLOYMENT_STEPS.md`

---

### 🎯 Option 3: Vercel Dashboard (UI)

1. **Create Projects in Vercel Dashboard**
   - Go to https://vercel.com/
   - Click "Add New" → "Project"
   - Import your Git repository
   - Create two projects: one for API, one for Web

2. **Configure API Project**
   - Framework Preset: Other
   - Root Directory: `apps/api`
   - Build Command: Use from `apps/api/vercel.json`
   - Output Directory: `apps/api/dist`

3. **Configure Web Project**
   - Framework Preset: Vite
   - Root Directory: `apps/web`
   - Build Command: Use from `apps/web/vercel.json`
   - Output Directory: `build`

4. **Add Environment Variables** (in project settings)
   - See `env.template` for all required variables
   - API needs: DATABASE_URL, REDIS_URL, contract addresses, RPC URL
   - Web needs: VITE_API_URL, VITE_WC_PROJECT_ID, contract addresses, RPC URL

---

## Checklist Before Deploying

### Services Setup
- [ ] Create Vercel account
- [ ] Create Alchemy account and get API key
- [ ] Create WalletConnect project and get Project ID
- [ ] Deploy smart contracts (or confirm you have all 4 addresses)

### Vercel Setup (via Dashboard or CLI)
- [ ] Create Postgres database in Vercel
- [ ] Create KV (Redis) store in Vercel
- [ ] Note down DATABASE_URL and REDIS_URL

### Environment Variables Ready
- [ ] All contract addresses (ARK, XPRegistry, Badge, Escrow)
- [ ] Alchemy RPC URL
- [ ] WalletConnect Project ID
- [ ] Database URL
- [ ] Redis URL

---

## After Deployment

### 1. Run Database Migrations

```bash
cd apps/api
vercel env pull .env.production.local
DATABASE_URL=$(cat .env.production.local | grep DATABASE_URL | cut -d '=' -f2-) pnpm prisma migrate deploy
```

### 2. Test Your Deployment

**Test API:**
```bash
curl https://your-api.vercel.app/health
# Should return: {"status":"ok"}
```

**Test Web:**
- Open your Web URL in browser
- Should load without errors
- Try connecting wallet

### 3. Common Issues

#### "Cannot find module '@spark/shared'"
- **Status**: ✅ Already fixed in your config
- This was one of the issues we fixed

#### "Prisma Client not generated"
- **Status**: ✅ Already fixed in your config
- This was also fixed

#### "WebSocket connection failed"
- **Cause**: Vercel Hobby plan limitation
- **Solution**: Upgrade to Pro or deploy API elsewhere

#### "Contract interaction fails"
- **Cause**: Wrong contract addresses or RPC
- **Solution**: Double-check all addresses in environment variables

---

## Environment Variable Template

Create a `.env` file with:

```bash
# Get from Vercel Postgres
DATABASE_URL=postgresql://...

# Get from Vercel KV or Upstash
REDIS_URL=redis://...

# Get from Alchemy
BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY
VITE_BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY

# Get from WalletConnect Cloud
VITE_WC_PROJECT_ID=YOUR_PROJECT_ID

# From your contract deployments
ARK_ADDRESS=0x155037a9854cefb83c7b90dd0499b7b64c1a120c
XPREGISTRY_ADDRESS=0xYOUR_ADDRESS
BADGE_ADDRESS=0xYOUR_ADDRESS
ESCROW_ADDRESS=0xYOUR_ADDRESS

# Same addresses for frontend
VITE_ARK_ADDRESS=0x155037a9854cefb83c7b90dd0499b7b64c1a120c
VITE_XPREGISTRY_ADDRESS=0xYOUR_ADDRESS
VITE_BADGE_ADDRESS=0xYOUR_ADDRESS
VITE_ESCROW_ADDRESS=0xYOUR_ADDRESS

# Fixed values
BASE_CHAIN_ID=84532
VITE_BASE_CHAIN_ID=84532
FAUCET_AMOUNT_WEI=1000000000000000000
FAUCET_COOLDOWN_SEC=86400

# After API deployment, set this
VITE_API_URL=https://your-api.vercel.app
```

---

## Quick Commands

```bash
# View deployment status
vercel ls

# View logs
vercel logs <url>

# Redeploy
cd apps/api && vercel --prod
cd apps/web && vercel --prod

# Pull env vars locally
vercel env pull
```

---

## Need More Details?

- **Full deployment guide**: `DEPLOYMENT_STEPS.md`
- **Technical details**: `VERCEL_DEPLOYMENT.md`
- **Environment template**: `env.template`

---

## What's Next?

1. Run `./setup-env.sh` to create your environment file
2. Fill in all the values in `.env`
3. Run `./setup-vercel.sh` to deploy
4. Test your deployment
5. Run database migrations
6. Start using your app! 🎉

**Questions?** Check the troubleshooting sections in the deployment guides.

