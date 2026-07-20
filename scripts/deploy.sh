#!/usr/bin/env bash
# scripts/deploy.sh — Simulated deploy script
# In real life this would push to AWS, Heroku, Railway, etc.
# Here it checks for secrets and either dry-runs or "deploys."

set -euo pipefail

DRY_RUN="${DRY_RUN:-false}"
DEPLOY_ENV="${DEPLOY_ENV:-staging}"
APP_VERSION="${APP_VERSION:-unknown}"

echo ""
echo "========================================="
echo "  🚀  Deploy Script"
echo "  Environment : $DEPLOY_ENV"
echo "  Version     : $APP_VERSION"
echo "  Dry Run     : $DRY_RUN"
echo "========================================="
echo ""

# ── Step 1: Auth check ────────────────────────────────────────────────────────
echo "▶ Step 1/4 — Checking auth credentials..."

if [[ "$DRY_RUN" == "true" ]]; then
  echo "  [DRY RUN] Skipping real auth check. Would have used DEPLOY_API_KEY."
else
  # In real mode we require the secret to exist.
  if [[ -z "${DEPLOY_API_KEY:-}" ]]; then
    echo ""
    echo "  ❌ AUTH FAILED: DEPLOY_API_KEY secret is not set."
    echo "     ─────────────────────────────────────────────"
    echo "     Fix: Go to your repo → Settings → Secrets and variables"
    echo "          → Actions → New repository secret"
    echo "          Name: DEPLOY_API_KEY   Value: <your key>"
    echo "     ─────────────────────────────────────────────"
    exit 1
  fi
  echo "  ✅ Auth OK (key found, length=${#DEPLOY_API_KEY})"
fi

# ── Step 2: Build artifact ────────────────────────────────────────────────────
echo ""
echo "▶ Step 2/4 — Building artifact..."
sleep 1  # simulate build time
echo "  ✅ Artifact built → dist/app-${APP_VERSION}.tar.gz (simulated)"

# ── Step 3: Push to environment ───────────────────────────────────────────────
echo ""
echo "▶ Step 3/4 — Pushing to $DEPLOY_ENV..."
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  [DRY RUN] Would push to $DEPLOY_ENV platform endpoint."
  echo "  [DRY RUN] No real network call made."
else
  sleep 2  # simulate upload time
  echo "  ✅ Pushed to $DEPLOY_ENV successfully."
fi

# ── Step 4: Verify ────────────────────────────────────────────────────────────
echo ""
echo "▶ Step 4/4 — Verifying deployment..."
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  [DRY RUN] Would run health check against $DEPLOY_ENV endpoint."
else
  echo "  ✅ Health check passed."
fi

echo ""
echo "========================================="
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  ✅  Dry run complete — no real changes made."
else
  echo "  🎉  Deployment to $DEPLOY_ENV complete!"
fi
echo "========================================="
echo ""
