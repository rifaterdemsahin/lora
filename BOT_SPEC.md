# Delivery Pilot Bot Spec (Google Chat)

## Purpose
Post delivery status for the LoRA Lab site (build, deploy, failures) to a Google Chat space, and answer a few slash commands.

## Scope
- Notify: deploy started, deploy succeeded (with URL), deploy failed (with log link).
- Commands: `/status` (current Fly app state), `/deploy` (trigger deploy, restricted to named users), `/help`.
- Out of scope: training models, handling user prompts, storing chat content.

## Architecture
```
GitHub Actions / deploy.sh ──► Delivery Pilot service ──► Google Chat API (space)
                                   ▲   │
              Chat events (HTTPS) ─┘   └─► Fly.io API (status, deploy)
Secrets: Azure Key Vault (read at start-up, never in the repo)
```

## Secrets (all in Azure Key Vault; names are defaults, confirm with owner)
| Secret name | Used for |
|---|---|
| `fly-api-token` | Fly.io deploys and status |
| `gchat-delivery-pilot-sa-key` | Google service account JSON for the Chat app, or |
| `gchat-delivery-pilot-webhook-url` | Incoming webhook URL for one-way posts |
| `gchat-verification-audience` | Audience used to verify inbound Chat events |

Rules: read via `az keyvault secret show` or managed identity; never log or commit values; rotate on exposure.

## Message format
Card with: app name, environment, status (✅ / ❌), commit SHA, URL, timestamp, owner.

## Security
- Verify the bearer token on every inbound Chat event (issuer `chat@system.gserviceaccount.com`, audience from Key Vault).
- `/deploy` allow-list of user emails; all other users read-only.
- Least-privilege Key Vault access (get on named secrets only).

## Acceptance criteria
1. A deploy produces one start message and one result message in the space.
2. `/status` replies within 3 seconds with the Fly app state.
3. A non-allow-listed user running `/deploy` is refused.
4. No secret value appears in logs, the repo, or Chat messages.

## Open items
- Key Vault name and exact secret names.
- Target Chat space ID.
- Webhook (one-way) or Chat app (two-way, needed for slash commands).
