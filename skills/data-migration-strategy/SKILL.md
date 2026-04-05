---
name: data-migration-strategy
description: Plan safe Laravel data migrations with phased rollout, backfills, double writes, verification, and rollback.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

# Data Migration Strategy

## When to use

Use this skill when a Laravel project needs a schema or data-shape change that cannot be done safely in one step. It is most useful for table splits, column renames, type changes, new canonical data structures, dual-write rollouts, backfills, phased cutovers, and cleanup of stale read/write paths.

## Input parameters

- The current and target data model or schema shape.
- Relevant migrations, models, repositories, services, jobs, commands, and controllers.
- Table size, write volume, downtime tolerance, and rollback constraints.
- Whether double writes, dual reads, backfills, or feature flags are acceptable.
- Any consistency requirements, external dependencies, or compliance constraints.

## Procedure

1. Identify the migration type and risk level. Clarify whether this is a pure schema change, a large data backfill, a write-path migration, a read-path migration, or a full expand-contract rollout.
2. Inspect the current read and write paths in Laravel code. Review migrations, Eloquent models, casts, observers, jobs, commands, queue workers, APIs, admin tooling, and reporting queries to see where old and new data structures are touched.
3. Choose the safest strategy for the scenario. Prefer:
   - direct migration only for small, low-risk, reversible changes
   - expand-contract for production schema evolution
   - double writes when old and new structures must stay in sync during rollout
   - dual reads or read fallbacks during cutover when consumers switch gradually
   - chunked queued backfills for large datasets
4. Design the rollout in phases. Usually this means `Preparation`, `Schema expansion`, `Write compatibility`, `Backfill`, `Verification`, `Read cutover`, `Cleanup`, and `Old path removal`.
5. Build safety controls into the plan. Call out feature flags, idempotent jobs, chunking with `chunkById`, `upsert` or `updateOrInsert`, queue isolation, progress tracking, canary rollout, metrics, row-count or checksum validation, and operator-visible rollback checkpoints.
6. Review rollback and failure handling explicitly. Identify which phases are reversible, when double writes can be disabled, how stale reads are prevented, how failed backfills are retried, and what should happen if old and new data diverge.
7. Return a scenario-specific recommendation under `Recommended strategy`, `Phase plan`, `Verification steps`, `Rollback plan`, and `Cleanup plan`. Keep the answer practical, conservative, and grounded in the actual Laravel codebase.

Output expectations: return the safest migration strategy for the scenario, a phased rollout plan, verification steps, rollback guidance, and the final cleanup sequence.

## Examples

Prompt 1:

```text
Use data-migration-strategy for a Laravel app where we need to move invoice line items into a new normalized table without losing writes during rollout. Suggest whether we need double writes, backfills, and read cutover steps.
```

Prompt 2:

```text
Review this Laravel data migration plan for moving user profile data from a JSON column into dedicated columns. We need low risk, rollback safety, and staged cleanup of the old read path.
```

JSON:

```json
{
  "skill": "data-migration-strategy",
  "context": {
    "scenario": "move denormalized order metadata into normalized tables",
    "constraints": ["zero_downtime", "high_write_volume", "rollback_required"],
    "techniques": ["double_write", "queued_backfill", "read_fallback"],
    "files": ["database/migrations", "app/Models", "app/Jobs", "app/Services"]
  }
}
```

Code example:

```php
DB::transaction(function () use ($user, $payload): void {
    // Write the new structure first and keep the legacy path in sync until cutover.
    UserProfile::updateOrCreate(
        ['user_id' => $user->id],
        [
            'timezone' => $payload['timezone'],
            'locale' => $payload['locale'],
        ]
    );

    if (config('data_migrations.keep_legacy_profile_json_in_sync')) {
        $user->forceFill([
            'profile' => array_merge($user->profile ?? [], [
                'timezone' => $payload['timezone'],
                'locale' => $payload['locale'],
            ]),
        ])->save();
    }
});
```

## Smoke test

Run the skill on a Laravel migration scenario that requires a new table, a large backfill, and staged cutover from old reads and writes to new ones. Verify that the response recommends an appropriate expand-contract or double-write strategy, includes verification and rollback steps, and delays destructive cleanup until after validation.
