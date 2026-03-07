# terminal-memory-demo

Companion fixture repo for `terminal-memory`.

This demo validates an AI-enabling retrieval workflow for practical incident-memory recall, not AI-everything terminal automation.

This demo shows how problem-intent queries retrieve command history even when exact phrasing differs from the original commands.

## Run

```bash
./scripts/run-demo.sh
```

Custom query:

```bash
./scripts/run-demo.sh "how did i resolve local postgres port collision"
```

## Corpus

- `sample-history/zsh_history.txt`
- includes Docker, Kubernetes, git, and local dev workflows across multiple sessions

## What to look for

For query `how did i fix that docker port conflict` top matches should include command sequences around:

- `lsof -i :3000`
- `kill -9 ...`
- `docker stop ...`
- `docker rm ...`
- `docker run ... -p 5432:5432 ...`

This demonstrates memory by problem, not literal command recall.

## Canonical assertions

`scripts/test.sh` validates baseline output invariants:

- ingest count remains `20`
- top result includes `seq=6 session=1`
- key recovery context appears (`lsof`, `docker compose down`, `docker stop local-postgres`)


## Test

```bash
./scripts/test.sh
```
