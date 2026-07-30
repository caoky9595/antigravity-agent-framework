#!/bin/bash
# Bootstrap script for antigravity-agent-framework.
#
# Usage:
#   ./machine-setup.sh             One-time per machine: wires the global layer
#                                   (Claude Code + best-effort Antigravity) so
#                                   every project gets Iron Laws / skills / cost-aware
#                                   delegation with zero per-project setup. Standalone
#                                   file so it's tab-completable — thin wrapper that
#                                   just calls `init.sh --machine-setup` (kept here so
#                                   there's still only one copy of the actual logic).
#   ./init.sh                      No path? Opens a native folder-picker dialog
#                                   (macOS/Linux) and inits whatever you choose.
#   ./init.sh <target-project-path> Per project, safe to re-run: symlinks the
#                                   shared/static parts of this framework into the
#                                   target project, and generates (never overwrites)
#                                   the parts that hold per-project state.
set -euo pipefail

FRAMEWORK_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
SKILLS="fix_bug new_feature quick_fix refactor update_docs new_role"
DO_CLAUDE=1
DO_GEMINI=1

# Colors — only emitted when stdout is an actual terminal, so piped/redirected
# output (logs, CI) stays plain text with no stray escape codes.
if [ -t 1 ]; then
    C_RESET=$'\033[0m'; C_BOLD=$'\033[1m'; C_DIM=$'\033[2m'
    C_GREEN=$'\033[32m'; C_YELLOW=$'\033[33m'; C_CYAN=$'\033[36m'; C_RED=$'\033[31m'
else
    C_RESET=''; C_BOLD=''; C_DIM=''; C_GREEN=''; C_YELLOW=''; C_CYAN=''; C_RED=''
fi

section() { echo; echo "${C_BOLD}${C_CYAN}▸ $1${C_RESET}"; }
ok()      { echo "  ${C_GREEN}✓${C_RESET} $1"; }
warn()    { echo "  ${C_YELLOW}⚠${C_RESET} $1"; }
info()    { echo "  ${C_DIM}·${C_RESET} $1"; }
err()     { echo "${C_RED}✗ $1${C_RESET}" >&2; }

usage() {
    echo "Usage:"
    echo "  ./init.sh                             (opens a folder-picker dialog)"
    echo "  ./init.sh <target-project-path>"
    echo "  ./machine-setup.sh                    (opens a tool-picker dialog)"
    echo "  ./machine-setup.sh --claude-only       (skip the dialog: Claude Code + Cursor only)"
    echo "  ./machine-setup.sh --antigravity-only  (skip the dialog: Antigravity only)"
    echo "  ./machine-setup.sh --all               (skip the dialog: both)"
    exit 1
}

# Native checklist dialog for which tool(s) to wire up. Sets DO_CLAUDE / DO_GEMINI.
# Cursor has no config of its own — it piggybacks on ~/.claude — so it's presented
# as one option together with Claude Code, not a separate one.
pick_targets() {
    local claude_label="Claude Code + Cursor (~/.claude)"
    local gemini_label="Google Antigravity (~/.gemini) — best-effort"
    local sel

    if command -v osascript >/dev/null 2>&1; then
        sel="$(osascript -e "
set sel to choose from list {\"$claude_label\", \"$gemini_label\"} with title \"antigravity-agent-framework\" with prompt \"Cài cho tool nào?\" default items {\"$claude_label\", \"$gemini_label\"} with multiple selections allowed
if sel is false then
    return \"CANCELED\"
else
    return sel as string
end if" 2>/dev/null)" || { err "canceled — nothing was changed."; exit 1; }
    elif command -v zenity >/dev/null 2>&1; then
        sel="$(zenity --list --checklist --separator="|" --column="" --column="Tool" \
            TRUE "$claude_label" TRUE "$gemini_label" \
            --title="antigravity-agent-framework" --text="Cài cho tool nào?" 2>/dev/null)" \
            || { err "canceled — nothing was changed."; exit 1; }
    elif command -v kdialog >/dev/null 2>&1; then
        sel="$(kdialog --checklist "Cài cho tool nào?" claude "$claude_label" on gemini "$gemini_label" on 2>/dev/null)" \
            || { err "canceled — nothing was changed."; exit 1; }
    else
        warn "no picker tool found (osascript/zenity/kdialog) — falling back to text prompts."
        local a1 a2
        read -r -p "Cài cho Claude Code + Cursor (~/.claude)? [Y/n] " a1 || true
        read -r -p "Cài cho Google Antigravity (~/.gemini)? [Y/n] " a2 || true
        [[ "$a1" =~ ^[Nn] ]] && DO_CLAUDE=0
        [[ "$a2" =~ ^[Nn] ]] && DO_GEMINI=0
        return
    fi

    [ "$sel" = "CANCELED" ] && { err "canceled — nothing was changed."; exit 1; }
    echo "$sel" | grep -q "Claude" && DO_CLAUDE=1 || DO_CLAUDE=0
    echo "$sel" | grep -q "Antigravity" && DO_GEMINI=1 || DO_GEMINI=0
}

# Open a native "choose folder" dialog. Prints the chosen absolute path on
# stdout and returns 0, or returns 1 (nothing printed) if canceled/unavailable.
pick_folder() {
    if command -v osascript >/dev/null 2>&1; then
        osascript -e 'POSIX path of (choose folder with prompt "Chọn project để cài antigravity-agent-framework:")' 2>/dev/null
        return $?
    elif command -v zenity >/dev/null 2>&1; then
        zenity --file-selection --directory --title="Chọn project để cài antigravity-agent-framework" 2>/dev/null
        return $?
    elif command -v kdialog >/dev/null 2>&1; then
        kdialog --getexistingdirectory ~ --title "Chọn project để cài antigravity-agent-framework" 2>/dev/null
        return $?
    fi
    return 2
}

# Symlink dst -> src. Skips (without touching anything) if dst already exists
# as a real file — that's treated as an intentional local override.
# Relinks unconditionally if dst is already a symlink (safe to repoint).
safe_link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -L "$dst" ]; then
        ln -sf "$src" "$dst"
        ok "linked   ${dst/#$HOME/~}"
    elif [ -e "$dst" ]; then
        warn "skip     ${dst/#$HOME/~} (real file, not touching it — remove it and re-run to link)"
    else
        ln -s "$src" "$dst"
        ok "linked   ${dst/#$HOME/~}"
    fi
}

# Copy src -> dst only if dst is absent. Never overwrites — dst is meant to
# hold per-project state (filled-in AGENTS.md, customized pre_submit_check.sh, ...).
gen_copy() {
    local src="$1" dst="$2"
    if [ -f "$dst" ]; then
        info "keep     ${dst/#$HOME/~} (already exists)"
    else
        mkdir -p "$(dirname "$dst")"
        cp "$src" "$dst"
        [ -x "$src" ] && chmod +x "$dst"
        ok "created  ${dst/#$HOME/~}"
    fi
}

machine_setup() {
    local mode="${1:-}"
    case "$mode" in
        --claude-only)      DO_CLAUDE=1; DO_GEMINI=0 ;;
        --antigravity-only) DO_CLAUDE=0; DO_GEMINI=1 ;;
        --all)               DO_CLAUDE=1; DO_GEMINI=1 ;;
        "")                  pick_targets ;;
        *)                    err "unknown mode: $mode"; usage ;;
    esac

    echo "${C_BOLD}=== Machine-wide setup ===${C_RESET}"

    if [ "$DO_CLAUDE" -eq 1 ]; then
        section "Claude Code + Cursor (~/.claude)"
        safe_link "$FRAMEWORK_HOME/claude-global-config/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
        safe_link "$FRAMEWORK_HOME/claude-global-config/agents/quick-worker.md" "$HOME/.claude/agents/quick-worker.md"
        safe_link "$FRAMEWORK_HOME/claude-global-config/agents/deep-reasoner.md" "$HOME/.claude/agents/deep-reasoner.md"
        for s in $SKILLS; do
            safe_link "$FRAMEWORK_HOME/.agents/skills/$s/SKILL.md" "$HOME/.claude/skills/$s/SKILL.md"
        done

        section "Framework indirection symlink"
        safe_link "$FRAMEWORK_HOME" "$HOME/.antigravity-agent-framework"
    else
        section "Claude Code + Cursor (~/.claude)"
        info "skipped (not selected)"
    fi

    if [ "$DO_GEMINI" -eq 1 ]; then
        section "Google Antigravity (~/.gemini) — best-effort"
        info "Antigravity's global config path/format is still in flux across its"
        info "own docs; only the plain-prose GEMINI.md baseline block is wired here."
        safe_link "$FRAMEWORK_HOME/claude-global-config/GEMINI.md" "$HOME/.gemini/GEMINI.md"
    else
        section "Google Antigravity (~/.gemini)"
        info "skipped (not selected)"
    fi

    echo
    echo "${C_BOLD}${C_GREEN}Done.${C_RESET}"
    [ "$DO_CLAUDE" -eq 1 ] && echo "Claude Code (+ Cursor if it reads ~/.claude/skills): baseline discipline, cost-aware delegation, 6 workflow skills."
    [ "$DO_GEMINI" -eq 1 ] && echo "Google Antigravity: baseline discipline (best-effort)."
}

init_project() {
    local target="$1"
    [ -d "$target" ] || { err "target directory does not exist: $target"; exit 1; }
    target="$(cd "$target" && pwd -P)"
    if [ "$target" = "$FRAMEWORK_HOME" ]; then
        err "refusing to init the framework repo onto itself."
        exit 1
    fi

    echo "${C_BOLD}=== Initializing $target ===${C_RESET}"

    section "Shared/static (symlinked to framework repo — edit the canonical copy)"
    for s in $SKILLS; do
        safe_link "$FRAMEWORK_HOME/.agents/skills/$s/SKILL.md" "$target/.agents/skills/$s/SKILL.md"
        safe_link "$FRAMEWORK_HOME/.agents/workflows/$s.md" "$target/.agents/workflows/$s.md"
    done
    safe_link "$FRAMEWORK_HOME/.agents/scripts/generate_repomap.sh" "$target/.agents/scripts/generate_repomap.sh"

    section "Per-project state (generated once — yours to customize, never overwritten)"
    gen_copy "$FRAMEWORK_HOME/AGENTS.md" "$target/AGENTS.md"
    gen_copy "$FRAMEWORK_HOME/.agents/scripts/pre_submit_check.sh" "$target/.agents/scripts/pre_submit_check.sh"
    gen_copy "$FRAMEWORK_HOME/docs/ai/KNOWLEDGE.md" "$target/docs/ai/KNOWLEDGE.md"
    gen_copy "$FRAMEWORK_HOME/docs/ai/repomap.txt" "$target/docs/ai/repomap.txt"
    mkdir -p "$target/docs/ai/requirements" "$target/docs/ai/planning" "$target/docs/ai/design"

    echo
    echo "${C_BOLD}${C_GREEN}Done.${C_RESET} Next steps:"
    echo "  1. Fill in AGENTS.md section 1 (project name, purpose, stack) in $target"
    echo "  2. Customize $target/.agents/scripts/pre_submit_check.sh for your lint/test commands"
}

if [ $# -eq 0 ]; then
    echo "${C_BOLD}No path given — opening folder picker...${C_RESET}"
    if picked="$(pick_folder)"; then
        [ -n "$picked" ] || { err "no folder selected."; exit 1; }
        init_project "$picked"
    else
        status=$?
        if [ "$status" -eq 2 ]; then
            err "no folder-picker tool found (osascript/zenity/kdialog)."
            echo "Pass the path directly instead: $0 <target-project-path>"
        else
            err "canceled — nothing was changed."
        fi
        exit 1
    fi
elif [ "$1" = "--machine-setup" ]; then
    [ $# -le 2 ] || usage
    machine_setup "${2:-}"
else
    [ $# -eq 1 ] || usage
    init_project "$1"
fi
