# Contributing to Enso Innovative projects

## Workflow
1. Every piece of work starts as an issue, using the bug, feature or task form.
2. Make your changes and commit using the standard below.
3. Open a pull request and link the issue with `Closes #<number>`.

## Commit messages
Enso uses [Conventional Commits](https://www.conventionalcommits.org).

```
type(scope): short summary in imperative mood

Optional body explaining why, trade-offs, or gotchas.
```

Types: feat, fix, docs, style, refactor, perf, test, build, chore.

- Imperative mood, lowercase, no trailing period, 50 characters max
- Use a scope by default (auth, db, docker, ui)
- Add a body whenever there's detail worth documenting
- One logical change per commit

## Security
Never commit secrets, passwords, API keys or `.env` files.
