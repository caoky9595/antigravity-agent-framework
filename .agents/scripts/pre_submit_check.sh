#!/bin/bash
# Pre-submit quality check — TEMPLATE
# Usage: bash .agents/scripts/pre_submit_check.sh
#
# TODO: Customize this script for your specific project!
# This is a universal template. Uncomment and adapt the blocks you need.

ERRORS=0
WARNINGS=0

echo "============================================="
echo "  🔍 Pre-Submit Quality Check (TEMPLATE)"
echo "============================================="

# --- CHECK 1: Hardcoded secrets (Universal) ---
echo "🔐 [1/x] Hardcoded secrets..."
SECRET_HITS=$(grep -rnE "(api_key|password|secret|token)\s*=\s*['\"]" . --include="*.py" --include="*.ts" --include="*.js" --include="*.go" 2>/dev/null | grep -v "node_modules" | grep -v "venv" | grep -v "SKILL.md" || true)
if [ -n "$SECRET_HITS" ]; then
    echo "$SECRET_HITS"
    echo "  ❌ FAIL: Hardcoded secrets found"
    ERRORS=$((ERRORS + 1))
else
    echo "  ✅ PASS"
fi

# --- CHECK 2: Logging / Debug prints (Customize) ---
# echo "🖨️  [2/x] Checking for debug prints..."
# PRINT_HITS=$(grep -rn "console.log" . --include="*.ts" | grep -v "node_modules")
# if [ -n "$PRINT_HITS" ]; then ... fi

# --- CHECK 3: Linting (Customize) ---
# echo "🧹 [3/x] Linting..."
# if ! npm run lint; then ERRORS=$((ERRORS + 1)); fi
# if ! flake8 .; then ERRORS=$((ERRORS + 1)); fi

# --- CHECK 4: Tests (Customize) ---
# echo "🧪 [4/x] Running tests..."
# if ! npm test; then ERRORS=$((ERRORS + 1)); fi
# if ! pytest; then ERRORS=$((ERRORS + 1)); fi

echo "============================================="
if [ $ERRORS -eq 0 ]; then
    echo "  ✅ ALL CHECKS PASSED (Note: Configure this template!)"
else
    echo "  ❌ FAILED — fix $ERRORS error(s)"
fi
echo "============================================="

exit $ERRORS
