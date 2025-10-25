import { createPublicClient, createWalletClient, http, parseAbi, type Address } from "viem";
import { privateKeyToAccount } from "viem/accounts";
import { env } from "./env.js";
import ARK from "../../../packages/shared/abi/ARKToken.json" with { type: "json" };
import XP from "../../../packages/shared/abi/XPRegistry.json" with { type: "json" };
import BADGE from "../../../packages/shared/abi/BadgeNFT.json" with { type: "json" };
import ESCROW from "../../../packages/shared/abi/GameEscrow.json" with { type: "json" };

const chain = { id: env.BASE_CHAIN_ID, name: "base-sepolia", nativeCurrency:{name:"ETH",symbol:"ETH",decimals:18}, rpcUrls:{default:{ http:[env.BASE_RPC_URL] } } };

export const publicClient = createPublicClient({ chain, transport: http() });
export const walletClient = createWalletClient({
  account: privateKeyToAccount(process.env.SERVER_PRIVATE_KEY as `0x${string}`),
  chain,
  transport: http()
});

export const addr = {
  ARK: env.ARK_ADDRESS as Address,
  XP: env.XPREGISTRY_ADDRESS as Address | undefined,
  BADGE: env.BADGE_ADDRESS as Address | undefined,
  ESCROW: env.ESCROW_ADDRESS as Address | undefined
};

export const ark = { address: addr.ARK, abi: ARK as any };
export const xp  = addr.XP ? { address: addr.XP, abi: XP as any } : null;
export const badge = addr.BADGE ? { address: addr.BADGE, abi: BADGE as any } : null;
export const escrow = addr.ESCROW ? { address: addr.ESCROW, abi: ESCROW as any } : null;
