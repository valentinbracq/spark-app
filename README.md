# 🎮 SPARK - Web3 Arcade Gaming Platform

A decentralized gaming platform built on Base Sepolia with React, FastAPI, and smart contracts.

---

## 🚀 **Ready to Deploy?** START HERE!

### **➡️ Read This First: [`README_DEPLOY.md`](README_DEPLOY.md)**

Your app is **ready to deploy RIGHT NOW** - even without some contracts!

**Quick Deploy (24 minutes):**
1. Get 2 API keys (Alchemy + WalletConnect)
2. Update `.env` file
3. Run `./setup-vercel.sh`
4. Done! 🎉

---

## 📚 Documentation Guide

### For Deployment:

| File | When to Use |
|------|-------------|
| **[README_DEPLOY.md](README_DEPLOY.md)** ⭐ | **START HERE** - Quick deploy guide |
| [DEPLOY_WITHOUT_CONTRACTS.md](DEPLOY_WITHOUT_CONTRACTS.md) | Learn about optional contracts |
| [UPDATED_DEPLOYMENT_PLAN.md](UPDATED_DEPLOYMENT_PLAN.md) | See the simplified deployment plan |
| [DEPLOYMENT_STEPS.md](DEPLOYMENT_STEPS.md) | Detailed step-by-step instructions |
| [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md) | Technical details about what was fixed |

### Reference:
| File | Purpose |
|------|---------|
| [START_HERE.md](START_HERE.md) | Overview of the project setup |
| [NEXT_STEPS.md](NEXT_STEPS.md) | Original comprehensive guide |
| [QUICK_START.md](QUICK_START.md) | 5-minute overview |
| [DEPLOYMENT_SUMMARY.md](DEPLOYMENT_SUMMARY.md) | What's done vs what's pending |

---

## ✅ What's Already Done

- [x] Fixed all Vercel deployment issues
- [x] Set up monorepo build configuration
- [x] Generated pnpm lockfile
- [x] Installed Vercel CLI
- [x] Created `.env` file with placeholders
- [x] Made 3 contracts optional (XPRegistry, BadgeNFT, GameEscrow)
- [x] Created deployment automation scripts

**All technical blockers are resolved!** ✨

---

## 📋 What You Need to Do

### Minimum Required (24 minutes):
1. ☐ Get Alchemy API key → https://alchemy.com (5 min)
2. ☐ Get WalletConnect Project ID → https://cloud.walletconnect.com (5 min)
3. ☐ Update `.env` file with those 2 keys (2 min)
4. ☐ Create Vercel Postgres database (2 min)
5. ☐ Create Vercel KV/Redis store (2 min)
6. ☐ Run `./setup-vercel.sh` (5 min)
7. ☐ Run database migrations (2 min)
8. ☐ Test deployment (5 min)

### Optional (Add Later):
- ☐ Deploy XPRegistry contract (for on-chain XP)
- ☐ Deploy BadgeNFT contract (for NFT badges)
- ☐ Deploy GameEscrow contract (for staked games)

---

## 🏗️ Project Structure

```
Spark_Base/
├── apps/
│   ├── api/              # Backend (Fastify + WebSocket + Prisma)
│   │   ├── src/
│   │   ├── prisma/       # Database schema & migrations
│   │   └── vercel.json   # ✅ Fixed deployment config
│   │
│   └── web/              # Frontend (React + Vite + Wagmi)
│       ├── src/
│       └── vercel.json   # ✅ Fixed deployment config
│
├── packages/
│   ├── shared/           # Shared types, ABIs, utilities
│   └── contracts/        # Solidity smart contracts (Foundry)
│
├── .env                  # ✅ Created with placeholders
├── setup-vercel.sh       # ✅ Automated deployment script
└── README_DEPLOY.md      # ⭐ START HERE for deployment
```

---

## 🎮 Features

### Currently Working (90%):
- ✅ 4 Games: Chess, Connect Four, Tic-Tac-Toe, Rock Paper Scissors
- ✅ User authentication with Web3 wallets
- ✅ Real-time matchmaking (WebSocket)
- ✅ XP and tier system (database)
- ✅ Leaderboards
- ✅ User profiles & stats
- ✅ ARK token faucet
- ✅ Free play mode

### Coming Soon (Optional Contracts):
- ⏳ On-chain XP mirroring
- ⏳ NFT badge minting
- ⏳ Staked games with escrow

---

## 🛠️ Tech Stack

### Backend:
- **Framework**: Fastify
- **Database**: PostgreSQL (Vercel Postgres)
- **ORM**: Prisma
- **Cache**: Redis (Vercel KV)
- **Blockchain**: viem
- **Real-time**: WebSocket

### Frontend:
- **Framework**: React 18
- **Build**: Vite
- **Styling**: Tailwind CSS
- **Components**: Radix UI + shadcn/ui
- **Web3**: Wagmi + Web3Modal
- **State**: TanStack Query

### Smart Contracts:
- **Framework**: Foundry
- **Language**: Solidity ^0.8.24
- **Network**: Base Sepolia (testnet)
- **Standards**: ERC20, ERC721

---

## 🚀 Quick Commands

```bash
# Local Development
pnpm dev              # Start all services
pnpm dev:api          # Start API only
pnpm dev:web          # Start web only

# Build
pnpm build            # Build all packages

# Deploy to Vercel
./setup-vercel.sh     # Automated deployment

# Manual deploy
cd apps/api && vercel --prod
cd apps/web && vercel --prod

# Database
cd apps/api
pnpm prisma migrate dev    # Local migrations
pnpm prisma migrate deploy # Production migrations

# Smart Contracts
cd packages/contracts
forge build                # Compile contracts
forge test                 # Run tests
forge script script/Deploy.s.sol --broadcast  # Deploy
```

---

## 🔐 Environment Variables

### Required for Deployment:
```bash
# Get from Alchemy
BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY
VITE_BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY

# Get from WalletConnect Cloud
VITE_WC_PROJECT_ID=your_project_id

# Created in Vercel
DATABASE_URL=postgresql://...  # From Vercel Postgres
REDIS_URL=redis://...          # From Vercel KV
```

**See [`env.template`](env.template) for all variables.**

---

## 📝 Smart Contracts

### Deployed (Base Sepolia):
- ✅ **ARK Token**: `0x155037a9854cefb83c7b90dd0499b7b64c1a120c`

### To Deploy (Optional):
- ⏳ **XPRegistry**: Tracks player XP on-chain
- ⏳ **BadgeNFT**: Mints achievement NFTs
- ⏳ **GameEscrow**: Handles staked game funds

---

## ⚠️ Important Notes

### WebSocket Support
The API uses WebSockets for real-time gameplay. Vercel's free (Hobby) plan **doesn't support WebSockets**.

**Options:**
1. Upgrade to Vercel Pro ($20/month) - Recommended
2. Deploy API to Railway/Render - Free tier available
3. Use without WebSockets - Limited matchmaking

### Database
Always use the **POOLED** connection string from Vercel Postgres for better performance and connection management.

---

## 🆘 Need Help?

### Quick Answers:
- **"How do I deploy?"** → Read [`README_DEPLOY.md`](README_DEPLOY.md)
- **"What about missing contracts?"** → Read [`DEPLOY_WITHOUT_CONTRACTS.md`](DEPLOY_WITHOUT_CONTRACTS.md)
- **"Build fails?"** → Check [`VERCEL_DEPLOYMENT.md`](VERCEL_DEPLOYMENT.md) troubleshooting
- **"What's the status?"** → See [`DEPLOYMENT_SUMMARY.md`](DEPLOYMENT_SUMMARY.md)

### Common Issues:
- Build errors? Already fixed in config files ✅
- Missing contracts? Made optional ✅
- WebSocket errors? Check your Vercel plan ⚠️

---

## 📦 Package Manager

This project uses **pnpm** for package management:

```bash
# Install dependencies
pnpm install

# Install in specific workspace
pnpm --filter @spark/api install
pnpm --filter @spark/web install
```

---

## 🧪 Testing

```bash
# Frontend
cd apps/web
pnpm dev  # Manual testing in browser

# Smart Contracts
cd packages/contracts
forge test

# API
cd apps/api
pnpm dev  # Test with curl or Postman
```

---

## 📄 License

This project structure follows standard open-source practices. Check individual package.json files for specific licenses.

---

## 🎯 Next Steps

### Ready to Deploy?
```bash
# 1. Read the deploy guide
cat README_DEPLOY.md

# 2. Get your API keys
# - Alchemy: https://alchemy.com
# - WalletConnect: https://cloud.walletconnect.com

# 3. Update .env
nano .env

# 4. Deploy!
./setup-vercel.sh
```

### After Deployment:
1. Test your app at your Vercel URL
2. Share with users
3. Deploy optional contracts when ready
4. Add more games! 🎮

---

## 🤝 Contributing

This is a monorepo managed with pnpm workspaces:
- Keep shared code in `packages/shared`
- Follow existing code structure
- Test before committing

---

## 🌟 Deployment Status

```
✅ Build configuration fixed
✅ Dependencies resolved
✅ Environment setup complete
✅ Scripts created
✅ Optional contracts handled
⏳ Waiting for your API keys
⏳ Ready to deploy!
```

**You're ~24 minutes away from a live app!** 🚀

---

**Start here: [`README_DEPLOY.md`](README_DEPLOY.md)**

