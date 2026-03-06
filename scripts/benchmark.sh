#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERMINAL_MEMORY_REPO="${TERMINAL_MEMORY_REPO:-$ROOT_DIR/../terminal-memory}"
TERMINAL_MEMORY_BIN="${TERMINAL_MEMORY_BIN:-$TERMINAL_MEMORY_REPO/target/release/terminal-memory}"
INDEX_PATH="$ROOT_DIR/.terminal-memory/index.json"

if [[ ! -x "$TERMINAL_MEMORY_BIN" ]]; then
  cargo build --release --manifest-path "$TERMINAL_MEMORY_REPO/Cargo.toml" >/dev/null
fi

echo "Benchmarking ingest"
time "$TERMINAL_MEMORY_BIN" ingest "$ROOT_DIR/sample-history/zsh_history.txt" --index "$INDEX_PATH" >/dev/null

echo "Benchmarking recall (5 runs)"
for _ in {1..5}; do
  time "$TERMINAL_MEMORY_BIN" search "how did i fix that docker port conflict" --index "$INDEX_PATH" --top-k 3 >/dev/null
done
