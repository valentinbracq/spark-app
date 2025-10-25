#!/bin/bash

# ============================================================================
# SPARK BASE - Vercel Deployment Setup Script
# ============================================================================
# This script helps you deploy to Vercel and set up environment variables
# ============================================================================

set -e

echo "🚀 SPARK BASE - Vercel Deployment Setup"
echo "========================================"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "Run ./setup-env.sh first to create your .env file"
    exit 1
fi

# Source .env
set -a
source .env
set +a

echo "This script will help you deploy to Vercel."
echo ""
echo "You have two deployment options:"
echo ""
echo "1. Deploy API only (Backend)"
echo "2. Deploy Web only (Frontend)"
echo "3. Deploy both (Recommended)"
echo ""

read -p "Choose option (1/2/3): " choice

deploy_api() {
    echo ""
    echo "📦 Deploying API to Vercel..."
    echo ""
    
    cd apps/api
    
    echo "Linking to Vercel project..."
    vercel link
    
    echo ""
    echo "Setting environment variables..."
    echo ""
    
    # Required environment variables for API
    vercel env add DATABASE_URL production
    echo "Enter your DATABASE_URL (e.g., from Vercel Postgres)"
    
    vercel env add REDIS_URL production
    echo "Enter your REDIS_URL (e.g., from Vercel KV or Upstash)"
    
    echo "$BASE_RPC_URL" | vercel env add BASE_RPC_URL production
    echo "✅ Set BASE_RPC_URL"
    
    echo "$BASE_CHAIN_ID" | vercel env add BASE_CHAIN_ID production
    echo "✅ Set BASE_CHAIN_ID"
    
    echo "$ARK_ADDRESS" | vercel env add ARK_ADDRESS production
    echo "✅ Set ARK_ADDRESS"
    
    echo "$XPREGISTRY_ADDRESS" | vercel env add XPREGISTRY_ADDRESS production
    echo "✅ Set XPREGISTRY_ADDRESS"
    
    echo "$BADGE_ADDRESS" | vercel env add BADGE_ADDRESS production
    echo "✅ Set BADGE_ADDRESS"
    
    echo "$ESCROW_ADDRESS" | vercel env add ESCROW_ADDRESS production
    echo "✅ Set ESCROW_ADDRESS"
    
    echo "$FAUCET_AMOUNT_WEI" | vercel env add FAUCET_AMOUNT_WEI production
    echo "✅ Set FAUCET_AMOUNT_WEI"
    
    echo "$FAUCET_COOLDOWN_SEC" | vercel env add FAUCET_COOLDOWN_SEC production
    echo "✅ Set FAUCET_COOLDOWN_SEC"
    
    echo ""
    echo "🚀 Deploying to production..."
    vercel --prod
    
    echo ""
    echo "✅ API deployed successfully!"
    echo "📝 Save your API URL - you'll need it for the Web deployment"
    echo ""
    
    cd ../..
}

deploy_web() {
    echo ""
    echo "📦 Deploying Web to Vercel..."
    echo ""
    
    cd apps/web
    
    echo "Linking to Vercel project..."
    vercel link
    
    echo ""
    echo "Setting environment variables..."
    echo ""
    
    # If VITE_API_URL is still localhost, ask for the production API URL
    if [[ "$VITE_API_URL" == *"localhost"* ]]; then
        read -p "Enter your API URL (from API deployment): " api_url
        VITE_API_URL="$api_url"
    fi
    
    echo "$VITE_API_URL" | vercel env add VITE_API_URL production
    echo "✅ Set VITE_API_URL"
    
    echo "$VITE_WC_PROJECT_ID" | vercel env add VITE_WC_PROJECT_ID production
    echo "✅ Set VITE_WC_PROJECT_ID"
    
    echo "$VITE_ARK_ADDRESS" | vercel env add VITE_ARK_ADDRESS production
    echo "✅ Set VITE_ARK_ADDRESS"
    
    echo "$VITE_XPREGISTRY_ADDRESS" | vercel env add VITE_XPREGISTRY_ADDRESS production
    echo "✅ Set VITE_XPREGISTRY_ADDRESS"
    
    echo "$VITE_BADGE_ADDRESS" | vercel env add VITE_BADGE_ADDRESS production
    echo "✅ Set VITE_BADGE_ADDRESS"
    
    echo "$VITE_ESCROW_ADDRESS" | vercel env add VITE_ESCROW_ADDRESS production
    echo "✅ Set VITE_ESCROW_ADDRESS"
    
    echo "$VITE_BASE_CHAIN_ID" | vercel env add VITE_BASE_CHAIN_ID production
    echo "✅ Set VITE_BASE_CHAIN_ID"
    
    echo "$VITE_BASE_RPC_URL" | vercel env add VITE_BASE_RPC_URL production
    echo "✅ Set VITE_BASE_RPC_URL"
    
    echo ""
    echo "🚀 Deploying to production..."
    vercel --prod
    
    echo ""
    echo "✅ Web deployed successfully!"
    echo ""
    
    cd ../..
}

case $choice in
    1)
        deploy_api
        ;;
    2)
        deploy_web
        ;;
    3)
        deploy_api
        deploy_web
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "🎉 Deployment complete!"
echo ""
echo "Next steps:"
echo "1. Run database migrations: vercel env pull && cd apps/api && pnpm prisma migrate deploy"
echo "2. Test your deployment"
echo "3. Check logs: vercel logs"
echo ""

