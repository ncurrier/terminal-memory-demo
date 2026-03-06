#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERMINAL_MEMORY_REPO="${TERMINAL_MEMORY_REPO:-$ROOT_DIR/../terminal-memory}"
TERMINAL_MEMORY_BIN="${TERMINAL_MEMORY_BIN:-$TERMINAL_MEMORY_REPO/target/release/terminal-memory}"
INDEX_PATH="$ROOT_DIR/.terminal-memory/index.json"
QUERY="${1:-how did i fix that docker port conflict}"

if [[ ! -x "$TERMINAL_MEMORY_BIN" ]]; then
  echo "Building terminal-memory binary..."
  cargo build --release --manifest-path "$TERMINAL_MEMORY_REPO/Cargo.toml" >/dev/null
fi

echo "== Ingest sample history =="
"$TERMINAL_MEMORY_BIN" ingest "$ROOT_DIR/sample-history/zsh_history.txt" --index "$INDEX_PATH"

echo
echo "== Semantic recall query =="
"$TERMINAL_MEMORY_BIN" search "$QUERY" --index "$INDEX_PATH" --top-k 5 --context-window 2
