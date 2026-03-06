#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_FILE="$ROOT_DIR/expected/test-output.runtime.txt"

cd "$ROOT_DIR"

./scripts/run-demo.sh "how did i fix that docker port conflict" >"$OUTPUT_FILE"

assert_contains() {
  local pattern="$1"
  if ! rg -q "$pattern" "$OUTPUT_FILE"; then
    echo "[terminal-memory-demo:test] expected pattern not found: $pattern" >&2
    echo "--- output ---" >&2
    cat "$OUTPUT_FILE" >&2
    exit 1
  fi
}

assert_contains "ingested entries: 20"
assert_contains "== Semantic recall query =="
assert_contains "lsof -i :3000"
assert_contains "docker compose down"
assert_contains "docker stop local-postgres"

echo "[terminal-memory-demo:test] pass"
