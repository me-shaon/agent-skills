---
name: resilient-check
description: Review Laravel workflows for retries, timeouts, idempotency, and graceful failure under partial outages.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

# Resilient Check

## When to use

Use this skill for Laravel jobs, integrations, webhooks, scheduled tasks, listeners, notifications, or user-facing flows that must stay reliable when dependencies are slow, unavailable, or inconsistent. It is most useful when queues, Redis, Horizon, external APIs, or payment/provider callbacks are involved.

## Input parameters

- The workflow or subsystem to assess.
- External services, queues, or webhooks involved.
- Existing retry, timeout, circuit-breaker, or deduplication behavior.
- Known incidents, flaky tests, or production failure modes.
- Relevant jobs, listeners, commands, controllers, events, notifications, or queue config files.

## Procedure

1. Trace the Laravel execution path for the workflow. Inspect controllers, dispatched jobs, listeners, commands, notifications, service classes, and relevant config such as `config/queue.php`, `config/services.php`, and Horizon settings.
2. Identify where the workflow can fail or partially succeed: external HTTP calls, payment providers, webhooks, database writes, cache writes, file storage, notifications, and chained or batched jobs.
3. Review retry behavior in Laravel terms. Check `tries`, `backoff`, `retryUntil`, job timeouts, Horizon worker configuration, queue visibility/timeout alignment, and whether failures land in `failed_jobs` with useful context.
4. Review idempotency and duplicate-delivery safety. Look for webhook deduplication, cache locks, unique jobs, database uniqueness guarantees, `firstOrCreate` race conditions, unsafe side effects before persistence, and handlers that are not safe to replay.
5. Flag high-risk patterns such as synchronous third-party API calls inside controllers, jobs that both mutate state and call external APIs without compensation, unbounded retries, missing dead-letter handling, and scheduled tasks that can overlap without `withoutOverlapping()` or locks.
6. Return findings under `High-risk failure modes`, `Code changes`, and `Operational safeguards`. Prefer concrete Laravel fixes such as queue settings, locks, unique jobs, timeout changes, retry tuning, `ThrottlesExceptions`, or graceful fallback responses.
7. Keep the answer practical and prioritized. Focus on the smallest changes that reduce operational risk fastest.

## Examples

Prompt 1:

```text
Use resilient-check on our payment webhook processing flow. Focus on duplicate deliveries, idempotency, timeouts, retry storms, and safe recovery.
```

Prompt 2:

```text
Review this Laravel job pipeline for resilience. We call two external APIs and workers sometimes retry the same job for hours. Prioritize the highest-risk failure modes first.
```

JSON:

```json
{
  "skill": "resilient-check",
  "context": {
    "workflow": "payment_webhook_processing",
    "dependencies": ["stripe", "erp_api", "redis_queue"],
    "focus": ["idempotency", "timeouts", "retries", "fallbacks"],
    "files": ["app/Jobs", "app/Listeners", "config/queue.php"],
    "concerns": ["duplicate_delivery", "retry_storms", "timeout_alignment"]
  }
}
```

## Smoke test

Use the skill on a Laravel queue-driven integration flow with synchronous API calls, naive retries, and no deduplication. Verify that the response references job-level settings like `tries`, `backoff`, and timeouts, flags idempotency gaps, and recommends concrete Laravel resilience fixes instead of general reliability advice.
