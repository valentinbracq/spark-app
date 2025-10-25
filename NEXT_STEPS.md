# 🎯 Your Next Steps - Deploy SPARK to Vercel

## Current Status: ✅ Ready for Configuration

All technical deployment issues have been fixed. You now need to:
1. Gather required information (API keys, contract addresses)
2. Configure services
3. Deploy!

---

## Step 1: Gather Required Information (15 minutes)

### A. Create Alchemy Account (RPC Provider)
1. Go to https://www.alchemy.com/
2. Sign up for free account
3. Click "Create new app"
   - Chain: Base
   - Network: Base Sepolia
4. Copy your API Key
5. Your RPC URL will be: `https://base-sepolia.g.alchemy.com/v2/YOUR_API_KEY`

**Save this URL - you'll need it for both API and Web!**

---

### B. Create WalletConnect Project
1. Go to https://cloud.walletconnect.com/
2. Sign up for free account
3. Click "Create Project"
4. Give it a name: "SPARK Game"
5. Copy the **Project ID**

**Save this ID - you'll need it for the Web app!**

---

### C. Check Smart Contract Addresses

We found one deployed contract:
- ✅ **ARK Token**: `0x155037a9854cefb83c7b90dd0499b7b64c1a120c` (Base Sepolia)

**Check if you have these contracts deployed:**
- ❓ **XPRegistry**: `0x...?`
- ❓ **BadgeNFT**: `0x...?`
- ❓ **GameEscrow**: `0x...?`

#### Option 1: You Have Them
If you already deployed these contracts, find the addresses in:
- Your deployment logs
- `packages/contracts/broadcast/Deploy.s.sol/84532/run-latest.json`
- BaseScan: https://sepolia.basescan.org/

#### Option 2: You Need to Deploy
If you haven't deployed them yet:

```bash
cd packages/contracts

# Create .env for contracts (if not exists)
cat > .env << EOF
PRIVATE_KEY=your_private_key_here
DEPLOYER_ADDRESS=your_wallet_address_here
BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_KEY
BADGE_BASE_URI=https://spark-base.vercel.app/api/badges/
EOF

# Deploy all contracts
forge script script/Deploy.s.sol --rpc-url $BASE_RPC_URL --broadcast --verify

# Save the output addresses!
cd ../..
```

**Save all 4 contract addresses!**

---

## Step 2: Update .env File (5 minutes)

✅ We already created `.env` file for you!

Now open it and fill in the values:

```bash
# Open in your editor
nano .env
# or
code .env
# or
open -e .env
```

**Fill in these values:**
1. Replace `YOUR_ALCHEMY_KEY_HERE` with your Alchemy API key (in both places)
2. Replace `YOUR_WALLETCONNECT_PROJECT_ID_HERE` with your WalletConnect Project ID
3. Replace `0xYOUR_XPREGISTRY_ADDRESS_HERE` with your XPRegistry address (4 places)
4. Replace `0xYOUR_BADGE_ADDRESS_HERE` with your Badge address (4 places)
5. Replace `0xYOUR_ESCROW_ADDRESS_HERE` with your Escrow address (4 places)

**Leave these as-is for now:**
- `DATABASE_URL` - Will get from Vercel
- `REDIS_URL` - Will get from Vercel
- `VITE_API_URL` - Will get after API deployment

---

## Step 3: Set Up Vercel Services (10 minutes)

### A. Create Vercel Account
1. Go to https://vercel.com/
2. Sign up with GitHub (recommended)

### B. Create Postgres Database
1. Go to https://vercel.com/dashboard/stores
2. Click "Create Database"
3. Select "Postgres"
4. Name it: `spark-db`
5. Choose region closest to you
6. Click "Create"
7. Go to "Quickstart" tab
8. Copy the **Postgres Pooled URL** (important: use POOLED!)
9. Save this - you'll need it during deployment

### C. Create Redis/KV Store
1. Still on https://vercel.com/dashboard/stores
2. Click "Create Database"
3. Select "KV" (Redis)
4. Name it: `spark-redis`
5. Choose same region as database
6. Click "Create"
7. Copy the `KV_REST_API_URL`
8. Save this - you'll need it during deployment

---

## Step 4: Deploy! (5 minutes)

Now you're ready to deploy! You have two options:

### Option A: Automated Script (Recommended)

```bash
./setup-vercel.sh
```

The script will:
1. Ask you to choose: API, Web, or Both
2. Guide you through Vercel project linking
3. Prompt for DATABASE_URL and REDIS_URL
4. Automatically set all environment variables
5. Deploy everything!

**Choose option 3** to deploy both at once.

---

### Option B: Manual via Vercel CLI

#### Deploy API:
```bash
cd apps/api
vercel link  # Follow prompts to create/link project
vercel env add DATABASE_URL production
# Paste the Postgres URL you saved
vercel env add REDIS_URL production
# Paste the Redis URL you saved
vercel --prod
# Save the API URL!
cd ../..
```

#### Deploy Web:
```bash
cd apps/web
vercel link  # Follow prompts to create/link project
vercel env add VITE_API_URL production
# Paste your API URL from above
vercel --prod
cd ../..
```

The script will automatically set all other environment variables from your `.env` file!

---

## Step 5: Run Database Migrations (2 minutes)

After API is deployed:

```bash
cd apps/api
vercel env pull .env.production.local
DATABASE_URL=$(cat .env.production.local | grep DATABASE_URL | cut -d '=' -f2-) pnpm prisma migrate deploy
cd ../..
```

This creates the database tables needed for your app.

---

## Step 6: Test Your Deployment (5 minutes)

### Test API:
```bash
curl https://your-api-url.vercel.app/health
# Should return: {"status":"ok"}
```

### Test Web:
1. Open your web URL in browser
2. Click "Connect Wallet"
3. Connect with MetaMask/other wallet
4. Switch to Base Sepolia network
5. Try claiming faucet tokens
6. Check leaderboard

---

## Summary Checklist

Before running `./setup-vercel.sh`, make sure you have:

- [ ] ✅ Alchemy API Key
- [ ] ✅ WalletConnect Project ID
- [ ] ✅ All 4 smart contract addresses (ARK, XPRegistry, Badge, Escrow)
- [ ] ✅ Vercel account created
- [ ] ✅ Vercel Postgres database URL (POOLED)
- [ ] ✅ Vercel KV/Redis URL
- [ ] ✅ `.env` file filled out with all values

Once you have all of these, run:
```bash
./setup-vercel.sh
```

And follow the prompts!

---

## Time Estimate

- Gathering information: ~15 minutes
- Setting up services: ~15 minutes
- Deploying: ~5 minutes
- **Total: ~35 minutes**

---

## Important Notes

### WebSocket Limitation
Your API uses WebSockets for real-time game functionality. Vercel's **free (Hobby) plan does NOT support WebSockets**.

**Your options:**
1. **Upgrade to Vercel Pro** ($20/month) - Simplest
2. **Deploy API elsewhere** (Railway, Render, Fly.io) - Free tier available
3. **Use free tier without WebSockets** - Matchmaking won't work, but rest of app will

### Database Connection Pooling
**IMPORTANT**: Always use the **POOLED** connection string from Vercel Postgres, not the direct connection. The pooled version prevents connection limit issues.

---

## What We Already Fixed For You

✅ Build configuration for monorepo  
✅ Shared package dependency handling  
✅ Prisma client generation  
✅ pnpm lockfile creation  
✅ Vercel CLI installation  
✅ Environment file template  
✅ Deployment scripts  

All the hard technical work is done! Now you just need to configure your services.

---

## Need Help?

- **Quick overview**: See `QUICK_START.md`
- **Detailed steps**: See `DEPLOYMENT_STEPS.md`
- **Technical info**: See `VERCEL_DEPLOYMENT.md`

---

## Ready?

1. Gather your API keys and contract addresses
2. Fill out the `.env` file
3. Create Vercel database and Redis
4. Run `./setup-vercel.sh`
5. Celebrate! 🎉

**You got this!** 🚀

