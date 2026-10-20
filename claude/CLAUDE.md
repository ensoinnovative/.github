# Enso Innovative: Claude Code rules

Applies to every Enso Innovative repo (GitHub org `ensoinnovative`). A repo's own CLAUDE.md adds stack-specific rules on top, and wins where they conflict.

This file is public. Never add secrets, credentials, client names, machine details or anything internal to it.

## Workflow
- Every change starts as an issue. Repo-specific work goes in that repo. Enso-wide work goes in `enso-hq`.
- GitHub Flow: branch `type/<issue#>-short-description` off `main`, open a PR, squash-merge. Never commit or push to `main`.
- An owner reviews and merges every PR. Don't merge PRs yourself.
- Lint, tests and the build must pass locally before opening a PR. CI runs the same checks.

## Commits and PRs
- Conventional Commits (see CONTRIBUTING.md). Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore. Lowercase summary, no trailing period, a scope by default, `!` for breaking changes.
- The PR title becomes the squash commit, so it follows the same rules. The PR title check enforces them.
- The PR body follows the PR template. Link the issue with `Closes #n`, or `Closes ensoinnovative/enso-hq#n` across repos. Use `Part of …` for partial work.
- The squash commit body keeps only "What changed" and "Why".

## Releases
- SemVer with annotated `vX.Y.Z` tags and GitHub Releases.
- `gh release create vX.Y.Z --generate-notes`. A repo's first release gets hand-written notes.

## Issues and labels
- Type and priority use GitHub's native issue types and the Priority field, not labels.
- Labels are synced org-wide from `labels.json`: `status: blocked`, `status: needs info`, `resolution: duplicate`, `resolution: won't fix`, `dependencies`. Don't create others.
- Dependabot entries always set `labels: ["dependencies"]`.
- On the free plan, don't create rulesets or branch protection on private repos. They aren't enforced.

## Working with the owners
- When there are several reasonable ways to do something, lay out the options and tradeoffs and let the owner choose before starting.
- For an issue or PR the owner will create, give every field ready to paste: title, each form field or template section, and sidebar settings (type, priority, project, labels).
- Flag any credential that should go in the password manager, with a suggested item name and notes.
- Ask before anything destructive or irreversible.
- Never commit secrets or `.env` files. A pre-commit secret scan runs on every commit.

## Working with Claude chat
Dustin uses two places: Claude Code (Ubuntu sessions) for code work, Claude chat for planning, research, logged-in websites and decisions.
- No AI attribution anywhere: no "Co-Authored-By: Claude" trailers, no "Generated with Claude Code" lines, no AI or Claude mentions in commits, PR titles or bodies, issues, comments, release notes, code comments or docs.
- Document your own work: when a task changes how Enso works (new tool, setup step, standard or gotcha), update the Engineering Handbook or Workstation Setup SOP yourself before calling the task done. Use the claude CLI in an Ubuntu terminal (Desktop-app WSL sessions have no Claude Docs connector). Add a decision-log row for any decision.
- File flags as Ideas: anything that could become an SOP, handbook section, skill, agent, dashboard, artifact, Grok Bot or Claude project goes into ensoinnovative/enso-hq as an Idea issue, with Idea kind and Scope set. Mention each one in your reply.
- Handoff summary: when Dustin asks for one, give a short block he can paste into chat: what was done (PRs and issues with links), decisions made and why, docs updated, Ideas filed, and open questions for chat.
