#!/bin/bash
# One-time-per-machine setup — a standalone file so it's tab-completable
# (no flag to remember, just type `./m` + Tab). Delegates to init.sh, which
# stays the single source of truth for the actual symlinking logic.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
exec "$DIR/init.sh" --machine-setup
