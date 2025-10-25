#!/bin/bash

# ============================================================================
# SPARK BASE - Environment Setup Script
# ============================================================================
# This script helps you set up environment variables for local development
# ============================================================================

set -e

echo "🚀 SPARK BASE - Environment Setup"
echo "=================================="
echo ""

# Create .env file
cat > .env << 'EOF'
# ============================================================================
# SPARK BASE - Environment Variables
# ============================================================================
# For production deployment, set these in Vercel dashboard
# ============================================================================

# ============================================================================
# API (Backend) Environment Variables
# ============================================================================

# Server
PORT=8787

# Database (PostgreSQL)
# Local: postgresql://postgres:postgres@localhost:5432/spark
# Vercel: Will be provided by Vercel Postgres
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/spark

# Redis
# Local: redis://localhost:6379
# Vercel: Will be provided by Vercel KV or use Upstash
REDIS_URL=redis://localhost:6379

# Blockchain Configuration
# Base Sepolia RPC - Get your own key from https://www.alchemy.com/
BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_KEY_HERE
BASE_CHAIN_ID=84532

# Smart Contract Addresses (Base Sepolia)
# ARK Token found from broadcast
ARK_ADDRESS=0x155037a9854cefb83c7b90dd0499b7b64c1a120c
XPREGISTRY_ADDRESS=0xYOUR_XPREGISTRY_ADDRESS_HERE
BADGE_ADDRESS=0xYOUR_BADGE_ADDRESS_HERE
ESCROW_ADDRESS=0xYOUR_ESCROW_ADDRESS_HERE

# Faucet Configuration
FAUCET_AMOUNT_WEI=1000000000000000000
FAUCET_COOLDOWN_SEC=86400

# ============================================================================
# WEB (Frontend) Environment Variables
# ============================================================================

# API URL
# Local: http://localhost:8787
# Production: https://your-api.vercel.app (will be set after API deployment)
VITE_API_URL=http://localhost:8787

# WalletConnect Project ID
# Get one at https://cloud.walletconnect.com
VITE_WC_PROJECT_ID=YOUR_WALLETCONNECT_PROJECT_ID_HERE

# Smart Contract Addresses (must match backend)
VITE_ARK_ADDRESS=0x155037a9854cefb83c7b90dd0499b7b64c1a120c
VITE_XPREGISTRY_ADDRESS=0xYOUR_XPREGISTRY_ADDRESS_HERE
VITE_BADGE_ADDRESS=0xYOUR_BADGE_ADDRESS_HERE
VITE_ESCROW_ADDRESS=0xYOUR_ESCROW_ADDRESS_HERE

# Blockchain Configuration
VITE_BASE_CHAIN_ID=84532
VITE_BASE_RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_KEY_HERE
EOF

echo "✅ Created .env file"
echo ""
echo "⚠️  IMPORTANT: You need to fill in the following values in .env:"
echo ""
echo "1. BASE_RPC_URL - Get from https://www.alchemy.com/"
echo "2. VITE_BASE_RPC_URL - Same as BASE_RPC_URL"
echo "3. XPREGISTRY_ADDRESS - Your deployed XPRegistry contract"
echo "4. BADGE_ADDRESS - Your deployed BadgeNFT contract"
echo "5. ESCROW_ADDRESS - Your deployed GameEscrow contract"
echo "6. VITE_WC_PROJECT_ID - Get from https://cloud.walletconnect.com/"
echo ""
echo "For Vercel deployment, you'll also need:"
echo "7. DATABASE_URL - From Vercel Postgres"
echo "8. REDIS_URL - From Vercel KV or Upstash"
echo ""
echo "📝 Open .env file and update these values before proceeding."
echo ""

