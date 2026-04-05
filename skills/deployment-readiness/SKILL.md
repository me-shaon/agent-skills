---
name: deployment-readiness
description: Review a Laravel app for deployment blockers across config, queues, caching, operations, and rollback readiness.
license: MIT
tags:
  - laravel
  - php
version: 0.1.1
compatible_agents:
  - laravel/boost
---

# Deployment Readiness

## When to use

Use this skill before a release or during a production readiness review when you need a Laravel-specific check for deployment blockers. It is most useful when the app uses queues, Horizon, the scheduler, Redis, Octane, S3, Vapor, Forge, Docker, or a non-trivial CI/CD pipeline.

## Input parameters

- Target Laravel version and hosting model.
- Deployment strategy such as containers, Forge, Vapor, or custom CI/CD.
- Relevant files, folders, or workflows to inspect.
- Any known production incidents or current release concerns.
- Whether zero-downtime deploys, Horizon, Octane, or maintenance windows are required.

## Procedure

1. Identify the runtime and deployment shape of the app. Inspect `composer.json`, `.env.example`, `bootstrap/app.php`, `config/app.php`, `config/database.php`, `config/cache.php`, `config/queue.php`, `config/filesystems.php`, `config/session.php`, `config/logging.php`, and deployment files such as `Dockerfile`, `docker-compose.yml`, Forge scripts, Vapor config, GitHub Actions, or Envoyer hooks.
2. Review the release flow for Laravel-specific correctness. Check config, route, event, and view caching strategy; asset build and publish steps; migration timing; queue worker restart strategy; Horizon pause/terminate behavior; and whether `php artisan optimize` or other cache warm-up commands are used safely.
3. Review production safety controls. Call out risky settings or missing pieces such as `APP_DEBUG`, `APP_ENV`, trusted proxies, HTTPS enforcement, queue/cache/session driver mismatches, missing `php artisan storage:link`, broken scheduler setup, weak health checks, weak logging/monitoring, or poor secrets handling.
4. Review rollback and mixed-version risks. Look for destructive migrations, missing backups, non-idempotent deploy steps, jobs that may run across old and new code, and any step that can leave the app half-released.
5. If Horizon, Octane, Reverb, Scout, broadcasting, or websockets are present, explicitly review the extra operational requirements for those services instead of assuming the default web deploy is enough.
6. Return findings under `Blockers`, `Warnings`, `Pre-deploy checks`, and `Recommended follow-ups`. Each point should reference the relevant Laravel file, config key, Artisan command, or infrastructure file.
7. End with a clear verdict: `Ready`, `Ready with conditions`, or `Not ready`. Keep the answer focused on release-critical issues rather than a generic operations checklist.

## Examples

Prompt 1:

```text
Use deployment-readiness on this Laravel 12 app before tomorrow's production deploy. Focus on queues, cache warm-up, Horizon, the scheduler, and health checks.
```

Prompt 2:

```text
Review this project for deployment readiness on Forge with Redis queues and S3 storage. Prioritize rollout blockers and anything that would make rollback risky.
```

JSON:

```json
{
  "skill": "deployment-readiness",
  "context": {
    "laravel_version": "12.x",
    "platform": "Forge",
    "queue_driver": "redis",
    "focus": ["config", "queues", "cache_warmup", "rollback"],
    "services": ["horizon", "scheduler", "s3"],
    "constraints": ["zero_downtime"]
  }
}
```

## Smoke test

Ask the agent to run the skill against a Laravel app that has Redis queues, a scheduler, and a deployment workflow. Verify that the response references specific Laravel config files, identifies real release blockers or warnings, includes pre-deploy checks, and ends with a deployment verdict.
