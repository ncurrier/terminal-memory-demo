# Expected behavior: docker port conflict query

Query:

```text
how did i fix that docker port conflict
```

Expected high-ranking commands:

1. `lsof -i :3000`
2. `kill -9 24541`
3. `docker stop local-postgres`
4. `docker rm local-postgres`
5. `docker run --name local-postgres -p 5432:5432 ...`

Expected property:

- results should return related command sequences with surrounding context,
  not just one isolated command.
