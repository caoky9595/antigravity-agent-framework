#!/bin/bash
# One-time-per-machine setup — a standalone file so it's tab-completable
# (no flag to remember, just type `./m` + Tab). Delegates to init.sh, which
# stays the single source of truth for the actual symlinking logic.
#
# Usage:
#   ./machine-setup.sh                    Opens a tool-picker dialog (Claude Code + Cursor / Antigravity)
#   ./machine-setup.sh --claude-only       Skip the dialog, only wire Claude Code + Cursor
#   ./machine-setup.sh --antigravity-only  Skip the dialog, only wire Antigravity
#   ./machine-setup.sh --all               Skip the dialog, wire both
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
exec "$DIR/init.sh" --machine-setup "$@"
