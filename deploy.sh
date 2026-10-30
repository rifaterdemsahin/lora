#!/usr/bin/env bash
# Deploy to Fly.io using the Fly token stored in Azure Key Vault.
# Usage: AZ_KEYVAULT_NAME=<vault> [FLY_SECRET_NAME=fly-api-token] ./deploy.sh
set -euo pipefail

: "${AZ_KEYVAULT_NAME:?set AZ_KEYVAULT_NAME to your Key Vault name}"
SECRET="${FLY_SECRET_NAME:-fly-api-token}"

az account show >/dev/null 2>&1 || { echo "Run 'az login' first (or use a service principal)." >&2; exit 1; }

FLY_API_TOKEN="$(az keyvault secret show --vault-name "$AZ_KEYVAULT_NAME" --name "$SECRET" --query value -o tsv)"
export FLY_API_TOKEN

APP="$(sed -n 's/^app *= *"\(.*\)"/\1/p' fly.toml)"
flyctl apps list 2>/dev/null | awk '{print $1}' | grep -qx "$APP" || flyctl apps create "$APP"
flyctl deploy --remote-only
echo "Deployed: https://$APP.fly.dev"
