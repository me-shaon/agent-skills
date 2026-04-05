---
name: deployment-readiness
description: Review a Laravel application for production deployment gaps across config, queues, caching, observability, and rollback readiness.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

# Deployment Readiness

## When to use

Use this skill before a release, during a production readiness review, or when a team wants a Laravel-specific checklist of deployment blockers and follow-up actions. Prefer it when the app uses queues, Horizon, the scheduler, Redis, Octane, S3, Vapor, Forge, Docker, or any non-trivial CI/CD path.

## Input parameters

- Target Laravel version and hosting model.
- Deployment strategy such as containers, Forge, Vapor, or custom CI/CD.
- Relevant files or folders to inspect.
- Any known production incidents or current release concerns.
- Whether zero-downtime deploys, Horizon, Octane, or maintenance windows are required.

## Procedure

1. Start by identifying the runtime shape of the Laravel app. Check `composer.json`, `.env.example`, `bootstrap/app.php`, `config/app.php`, `config/database.php`, `config/cache.php`, `config/queue.php`, `config/filesystems.php`, `config/session.php`, `config/logging.php`, and any deployment files such as `docker-compose.yml`, `Dockerfile`, Forge scripts, Vapor config, GitHub Actions, or Envoyer hooks.
2. Inspect whether the release process is compatible with Laravel production expectations. Verify config, route, event, and view caching strategy; asset build steps; migration timing; queue worker restart strategy; Horizon pause/terminate behavior; and whether `php artisan optimize` or equivalent cache warm-up is used safely.
3. Review production safety controls. Call out `APP_DEBUG`, `APP_ENV`, trusted proxies, HTTPS enforcement, queue connection mismatches, cache/session driver mismatches, missing `php artisan storage:link`, broken scheduler setup, missing health endpoints, weak log aggregation, or secrets management problems.
4. Check rollback and failure handling. Look for destructive migrations, missing backups, deploy scripts that are not idempotent, queue jobs that may execute against mixed code versions, and any release step that can leave the app half-updated.
5. If Horizon, Octane, Reverb, Scout, broadcasting, or websockets are present, explicitly review the operational requirements for those services instead of assuming the default web deploy covers them.
6. Return findings under `Blockers`, `Warnings`, and `Recommended follow-ups`. Each finding should reference the relevant Laravel file, config key, Artisan command, or infrastructure file.
7. End with a concise verdict: `Ready`, `Ready with conditions`, or `Not ready`, and list the exact pre-deploy commands or checks the team should run.

## Examples

Prompt 1:

```text
Use deployment-readiness on this Laravel 12 app before tomorrow's production deploy. Focus on queues, cache, Horizon, schedule, and health checks.
```

Prompt 2:

```text
Review this project for deployment readiness on Forge with Redis queues and S3 storage. Call out anything that would make rollback risky.
```

JSON:

```json
{
  "skill": "deployment-readiness",
  "context": {
    "laravel_version": "12.x",
    "platform": "Forge",
    "queue_driver": "redis",
    "focus": ["config", "queues", "cache", "rollback"],
    "services": ["horizon", "scheduler", "s3"]
  }
}
```

## Smoke test

Ask the agent to run the skill against a Laravel app that has Redis queues, a scheduler, and a deployment workflow. Verify that the response references specific Laravel config files, mentions required Artisan cache/warm-up behavior, identifies at least one operational risk, and ends with a deployment verdict plus pre-release checks.
