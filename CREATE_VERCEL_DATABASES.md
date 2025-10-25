# 🗄️ Create Vercel Databases - Step by Step

## ⚠️ Important: You Need 2 Different Services

You're currently looking at **Edge Config**, but you need:
1. ✅ **Postgres** - For your database (users, matches, etc.)
2. ✅ **KV (Redis)** - For caching and rate limiting

---

## Step 1: Create Postgres Database (2 minutes)

### Go to the Storage Tab:
1. Open: https://vercel.com/dashboard/stores
2. Click the big **"Create Database"** button
3. You'll see 4 options:
   - **Postgres** ← Choose this one! ✅
   - KV
   - Blob
   - Edge Config

### Create Postgres:
1. Click **Postgres**
2. Name: `spark-db` (or any name you like)
3. Region: Choose closest to you
4. Click **"Create"**

### Get the Connection String:
1. After creation, go to the **".env.local"** tab
2. Look for: `POSTGRES_URL_NON_POOLING` or `POSTGRES_URL`
3. **IMPORTANT**: Use the **POOLED** version if available
4. Copy the entire URL (starts with `postgresql://`)

**Example format:**
```
postgresql://default:abc123...@ep-cool-name.us-east-1.postgres.vercel-storage.com:5432/verceldb?sslmode=require
```

**Save this URL - you'll need it for deployment!** 📝

---

## Step 2: Create KV Store (Redis) (2 minutes)

### Go Back to Storage:
1. Still at: https://vercel.com/dashboard/stores
2. Click **"Create Database"** again
3. This time choose: **KV** ✅

### Create KV:
1. Click **KV**
2. Name: `spark-redis` (or any name)
3. Region: **Same as Postgres** (important!)
4. Click **"Create"**

### Get the Connection String:
1. After creation, go to the **".env.local"** tab
2. Look for: `KV_REST_API_URL` or `KV_URL`
3. Copy the entire URL (starts with `redis://` or `https://`)

**Example format:**
```
redis://default:abc123...@relaxed-narwhal-12345.upstash.io:6379
```

**Save this URL too!** 📝

---

## What You Should Have Now:

- [x] ✅ Alchemy API Key (already set in .env)
- [x] ✅ WalletConnect Project ID (already set in .env)
- [ ] 📝 Postgres URL (copy from Vercel)
- [ ] 📝 Redis/KV URL (copy from Vercel)

---

## Next Step: Deploy!

Once you have both URLs, run:

```bash
./setup-vercel.sh
```

The script will ask you for:
1. **DATABASE_URL** ← Paste your Postgres URL
2. **REDIS_URL** ← Paste your KV URL

And that's it! 🚀

---

## Visual Guide

```
Vercel Dashboard
    ↓
Storage Tab (https://vercel.com/dashboard/stores)
    ↓
Create Database
    ↓
    ├─→ [Postgres] ← Create this first
    │     └─→ Name: spark-db
    │     └─→ Get: POSTGRES_URL
    │
    └─→ [KV] ← Create this second
          └─→ Name: spark-redis
          └─→ Get: KV_URL or KV_REST_API_URL
```

---

## Troubleshooting

### "I only see Edge Config"
- You're in the wrong tab
- Go to: https://vercel.com/dashboard/stores
- Look for the "Create Database" button at the top

### "I don't see the connection string"
- After creating the database, click on it
- Go to the ".env.local" or "Quickstart" tab
- The connection string will be there

### "Which URL should I use for Postgres?"
- Use the **POOLED** version if available
- It will say "POSTGRES_URL" or "POSTGRES_URL_POOLING"
- **NOT** "POSTGRES_URL_NON_POOLING" (unless pooled isn't available)

### "What about Edge Config?"
- You don't need it for this project
- Edge Config is for different use cases

---

## Ready?

1. Create Postgres at: https://vercel.com/dashboard/stores
2. Create KV at: https://vercel.com/dashboard/stores
3. Copy both URLs
4. Run: `./setup-vercel.sh`

**You're almost there! 🎉**

