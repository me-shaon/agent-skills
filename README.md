# Agent Skills

[![CI](https://github.com/me-shaon/agent-skills/actions/workflows/ci.yml/badge.svg)](https://github.com/me-shaon/agent-skills/actions/workflows/ci.yml) ![Release](https://img.shields.io/github/v/release/me-shaon/agent-skills?style=flat-square) ![Stars](https://img.shields.io/github/stars/me-shaon/agent-skills?style=flat-square) ![License](https://img.shields.io/github/license/me-shaon/agent-skills?style=flat-square)

Laravel-focused agent skills for code review, upgrades, API hardening, deployment checks, frontend performance reviews, data migration planning, and resilience reviews.

This repository is organized as a multi-skill collection that can be consumed by Agent Skills-compatible clients and Laravel Boost.

## Skills

### `deployment-readiness`

Reviews a Laravel application for production deployment risks across config, queues, caching, scheduler setup, operational services, and rollback readiness.

### `migration-index-reviewer`

Inspects Laravel migrations and related query paths to identify missing, redundant, or risky indexes before schema changes reach production.

### `api-hardening-patterns`

Audits Laravel API endpoints for validation, authorization, rate limiting, serialization safety, upload constraints, and abuse resistance.

### `upgrade-assistant`

Helps plan and execute Laravel and PHP upgrades by identifying dependency blockers, framework-level code hotspots, and phased rollout steps.

### `resilient-check`

Reviews Laravel jobs, webhooks, integrations, and user flows for retries, timeouts, idempotency, and graceful failure handling.

### `frontend-performance-review`

Reviews Laravel frontend performance, responsiveness, asset loading, and Lighthouse-impacting implementation choices across Blade, Livewire, Inertia, and Vite-based apps.

### `data-migration-strategy`

Helps plan safe Laravel data migrations with phased rollout, double writes, queued backfills, verification, rollback, and cleanup of stale code paths.

## Installation

### Agent Skills / `npx`

Install the full repository:

```bash
npx skills add me-shaon/agent-skills
```

Install a single skill:

```bash
npx skills add me-shaon/agent-skills --skill deployment-readiness
```

### Laravel Boost

Install the full repository:

```bash
php artisan boost:add-skill me-shaon/agent-skills
```

Install a single skill:

```bash
php artisan boost:add-skill me-shaon/agent-skills --skill deployment-readiness
```

## Repository Layout

```text
skills/
  api-hardening-patterns/
    SKILL.md
  data-migration-strategy/
    SKILL.md
  deployment-readiness/
    SKILL.md
  frontend-performance-review/
    SKILL.md
  migration-index-reviewer/
    SKILL.md
  resilient-check/
    SKILL.md
  upgrade-assistant/
    SKILL.md
```

Each skill lives in `skills/<slug>/SKILL.md` and includes YAML frontmatter plus usage guidance, examples, and a smoke test section.

## Development

Install local tooling:

```bash
npm install
```

Run Markdown lint:

```bash
npx markdownlint-cli README.md "skills/**/*.md" AGENTS.md
```

Run the install smoke-test helper:

```bash
bash scripts/install-and-test.sh
```

When adding or updating skills:

1. Keep the directory name lowercase and hyphenated.
2. Set the frontmatter `name` to exactly match the directory slug.
3. Update `skills-manifest.json`.
4. Update `scripts/install-and-test.sh` if a new skill should be included in install examples.

## Compatibility

This repository is intended to work with:

- Agent Skills-compatible repository installers
- Laravel Boost skill installation via `php artisan boost:add-skill`

## License

[MIT](LICENSE)
