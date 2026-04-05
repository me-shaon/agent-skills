---
name: resilient-check
description: Review Laravel application flows for failure handling, retries, idempotency, timeout behavior, and graceful degradation under partial outages.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

## When to use

Use this skill for Laravel jobs, integrations, webhooks, scheduled tasks, listeners, notifications, or user-facing flows that must stay reliable when dependencies are slow, unavailable, or inconsistent. Prefer it when queues, Redis, Horizon, external APIs, or payment/provider callbacks are involved.

## Input parameters

- The workflow or subsystem to assess.
- External services, queues, or webhooks involved.
- Existing retry, timeout, circuit-breaker, or deduplication behavior.
- Known incidents, flaky tests, or production failure modes.
- Relevant jobs, listeners, commands, controllers, events, notifications, or queue configuration files.

## Procedure

1. Trace the full Laravel execution path for the workflow. Inspect controllers, dispatched jobs, listeners, commands, notifications, queued closures, middleware, service classes, and relevant config such as `config/queue.php`, `config/services.php`, and Horizon settings.
2. Identify every place the workflow can fail or partially succeed: external HTTP calls, payment providers, webhooks, database writes, cache writes, file storage, notifications, and chained or batched jobs.
3. Review retry behavior in Laravel terms. Check `tries`, `backoff`, `retryUntil`, job timeouts, Horizon worker configuration, queue visibility/timeout alignment, and whether failures land in `failed_jobs` with actionable context.
4. Review idempotency and duplicate-delivery safety. Look for webhook deduplication, cache locks, unique jobs, database uniqueness guarantees, `firstOrCreate` race conditions, unsafe side effects before persistence, and handlers that are not safe to replay.
5. Flag risky patterns such as synchronous third-party API calls inside controllers, jobs that both mutate state and call external APIs without compensation, unbounded retries, missing dead-letter handling, and scheduled tasks that can overlap without `withoutOverlapping()` or locks.
6. Recommend Laravel-native resilience improvements using queued jobs, middleware, `Http::retry()` with care, cache/database locks, unique jobs, batches/chains, `ThrottlesExceptions`, explicit timeout settings, and graceful user-facing fallback responses.
7. Return a prioritized summary under `High-risk failure modes`, `Recommended code changes`, and `Operational safeguards`. Include which files, jobs, or config entries should change.

## Examples

Prompt 1:

```text
Use resilient-check on our payment webhook processing flow. Focus on duplicate deliveries, timeouts, retry storms, and safe recovery.
```

Prompt 2:

```text
Review this Laravel job pipeline for resilience. We call two external APIs and sometimes workers retry the same job for hours.
```

JSON:

```json
{
  "skill": "resilient-check",
  "context": {
    "workflow": "payment_webhook_processing",
    "dependencies": ["stripe", "erp_api", "redis_queue"],
    "focus": ["idempotency", "timeouts", "retries", "fallbacks"],
    "files": ["app/Jobs", "app/Listeners", "config/queue.php"]
  }
}
```

## Smoke test

Use the skill on a Laravel queue-driven integration flow with synchronous API calls, naive retries, and no deduplication. Verify that the response references job-level settings like `tries`, `backoff`, and timeouts, flags idempotency gaps, and recommends concrete Laravel resilience patterns.
