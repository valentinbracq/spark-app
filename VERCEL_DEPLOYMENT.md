# Vercel Deployment Guide

## Issues Fixed

The following issues were preventing successful deployment:

### 1. ✅ Contradictory Build Flags (API)
**Problem**: `apps/api/vercel.json` had both `--frozen-lockfile` and `--no-frozen-lockfile`  
**Fix**: Removed contradictory flags and simplified build command

### 2. ✅ Missing Prisma Client Generation (API)
**Problem**: Build was failing because Prisma client wasn't generated before TypeScript compilation  
**Fix**: Added `pnpm prisma generate` to the build command

### 3. ✅ Blocked Shared Package
**Problem**: `.vercelignore` was blocking `packages/**`, preventing `@spark/shared` from being available  
**Impact**: Web app imports ABIs and types from `@spark/shared` (see `apps/web/src/lib/contracts.ts`)  
**Fix**: Changed to only ignore `packages/*/node_modules` instead of all packages

### 4. ✅ Missing Shared Package Build
**Problem**: `@spark/shared` needs to be compiled before building apps that depend on it  
**Fix**: Added shared package build step to both API and Web build commands

### 5. ✅ No pnpm Lockfile
**Problem**: `--frozen-lockfile` flag was used but no `pnpm-lock.yaml` exists  
**Fix**: Removed the flag and simplified install commands

---

## Deploying to Vercel

### For API (`apps/api`)

1. **Create new Vercel project** or link existing:
   ```bash
   cd apps/api
   vercel
   ```

2. **Set Root Directory**: `apps/api`

3. **Required Environment Variables**:
   ```
   DATABASE_URL=postgresql://user:pass@host:5432/dbname
   REDIS_URL=redis://host:6379
   BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY
   BASE_CHAIN_ID=84532
   ESCROW_ADDRESS=0x...
   XPREGISTRY_ADDRESS=0x...
   BADGE_ADDRESS=0x...
   ARK_ADDRESS=0x...
   FAUCET_AMOUNT_WEI=1000000000000000000
   FAUCET_COOLDOWN_SEC=86400
   ```

4. **Database Setup**:
   - Run migrations: `pnpm prisma migrate deploy`
   - Or set up via Vercel Postgres
   - Configure connection pooling if needed

5. **Redis Setup**:
   - Use Vercel KV or Upstash Redis
   - Set `REDIS_URL` environment variable

### For Web (`apps/web`)

1. **Create new Vercel project** or link existing:
   ```bash
   cd apps/web
   vercel
   ```

2. **Set Root Directory**: `apps/web`

3. **Required Environment Variables**:
   ```
   VITE_API_URL=https://your-api.vercel.app
   VITE_WC_PROJECT_ID=your_walletconnect_project_id
   VITE_ARK_ADDRESS=0x...
   VITE_XPREGISTRY_ADDRESS=0x...
   VITE_BADGE_ADDRESS=0x...
   VITE_ESCROW_ADDRESS=0x...
   VITE_BASE_CHAIN_ID=84532
   VITE_BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY
   ```

---

## Important Notes

### Monorepo Structure
This is a pnpm workspace monorepo with the following structure:
```
Spark_Base/
├── apps/
│   ├── api/          # Backend API (Fastify + WebSocket)
│   └── web/          # Frontend (React + Vite)
└── packages/
    ├── shared/       # Shared types, ABIs, utilities
    └── contracts/    # Solidity smart contracts
```

### Build Order
The build process must follow this order:
1. Install dependencies at root
2. Build `@spark/shared` first (contains ABIs and types)
3. Build `apps/api` or `apps/web` (depends on shared)

### WebSocket Considerations
- The API uses WebSocket for real-time game communication
- Vercel supports WebSockets on Pro and Enterprise plans
- For Hobby plan, consider deploying API separately (Railway, Render, etc.)

### Database Migrations
- Always run `prisma migrate deploy` after deployment
- Do NOT use `prisma migrate dev` in production
- Consider setting up preview environments for testing migrations

---

## Troubleshooting

### Build fails with "Cannot find module '@spark/shared'"
- Ensure `.vercelignore` is not blocking the packages directory
- Check that shared package is built before the app

### Build fails with "Prisma Client not generated"
- Ensure `pnpm prisma generate` is in the build command
- Check that `DATABASE_URL` environment variable is set

### Runtime error: "Cannot connect to database"
- Verify `DATABASE_URL` is set correctly
- For Vercel Postgres, use the pooled connection string
- Check that database allows connections from Vercel IPs

### WebSocket connection fails
- Check if your Vercel plan supports WebSockets
- Verify CORS settings in API
- Ensure `VITE_API_URL` in web app points to correct API URL

---

## Next Steps

1. **Generate pnpm lockfile** (recommended):
   ```bash
   pnpm install
   ```
   This will create `pnpm-lock.yaml` for reproducible builds

2. **Set up environment variables** in Vercel dashboard

3. **Deploy**:
   ```bash
   # From root directory
   vercel --prod
   ```

4. **Test deployment**:
   - Check API health endpoint
   - Verify web app loads
   - Test WebSocket connections
   - Verify smart contract interactions

---

## Configuration Files Summary

### `.vercelignore`
```
node_modules
.pnpm-store
# Only ignore packages node_modules, not the packages themselves
packages/*/node_modules
```

### `apps/api/vercel.json`
```json
{
  "buildCommand": "cd ../.. && pnpm install && pnpm --filter @spark/shared build && cd apps/api && pnpm prisma generate && pnpm build",
  "outputDirectory": "apps/api/dist"
}
```

### `apps/web/vercel.json`
```json
{
  "framework": "vite",
  "installCommand": "cd ../.. && pnpm install",
  "buildCommand": "cd ../.. && pnpm --filter @spark/shared build && pnpm --filter @spark/web build",
  "outputDirectory": "build",
  "cleanUrls": true
}
```

