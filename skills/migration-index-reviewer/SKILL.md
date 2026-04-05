---
name: migration-index-reviewer
description: Inspect Laravel migrations and query patterns for missing, redundant, or risky database indexes before they hit production.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

## When to use

Use this skill when reviewing Laravel migrations, schema changes, slow-query fixes, or pull requests that introduce new tables, foreign keys, filters, sorting paths, or reporting endpoints. It is especially useful before merging migrations that will run on large production tables.

## Input parameters

- The migration files or pull request to inspect.
- Known hot paths, large tables, or slow queries.
- Target database engine such as MySQL or PostgreSQL.
- Any constraints around zero-downtime migrations.
- Optional Eloquent models, scopes, controllers, jobs, or reports that reveal the actual query patterns.

## Procedure

1. Read the migration files in `database/migrations` and note every new table, altered column, foreign key, unique constraint, `softDeletes()`, polymorphic relation, and JSON/search field.
2. Cross-check how those tables are queried in Laravel code. Inspect Eloquent models, relationships, local/global scopes, repository classes, controllers, jobs, Filament or Nova resources, policies, and reporting queries for `where`, `orderBy`, `latest`, `firstOrCreate`, `updateOrCreate`, and eager-loading patterns.
3. Evaluate index coverage from a Laravel usage perspective. Look for missing foreign key indexes, tenant scoping columns such as `account_id` or `team_id`, compound indexes that match common filter-plus-sort patterns, uniqueness guarantees enforced only in validation, and lookup paths affected by `deleted_at`.
4. Flag Laravel-specific anti-patterns such as relying on `constrained()` without verifying index usefulness, adding redundant single-column indexes that are already covered by a better composite index, or creating schema changes that make queue jobs and background reports slower.
5. Review migration safety for production. Call out table rewrites, backfills inside migrations, renames that can lock hot tables, index creation strategy, and whether the migration is safe for blue/green or rolling deploys.
6. Return recommendations as concrete migration edits. When helpful, show the exact `Schema::table()` or `$table->index([...])` shape to add, remove, or rename.
7. End with a short summary containing `Missing indexes`, `Potentially redundant indexes`, `Rollout risks`, and `Recommended migration changes`.

## Examples

Prompt 1:

```text
Use migration-index-reviewer on the new order and order_items migrations. We expect heavy filtering by account_id, status, and created_at.
```

Prompt 2:

```text
Review these Laravel migrations for index quality and zero-downtime risks on MySQL 8. Highlight redundant indexes too.
```

JSON:

```json
{
  "skill": "migration-index-reviewer",
  "context": {
    "database": "mysql",
    "tables": ["orders", "order_items"],
    "query_patterns": ["account_id+status", "account_id+created_at desc"],
    "zero_downtime": true,
    "laravel_artifacts": ["Order model", "OrderController", "OrderReportJob"]
  }
}
```

## Smoke test

Provide a Laravel migration that adds foreign keys and frequent filter columns without useful indexes, plus an Eloquent model or controller that queries those columns. Verify that the response ties index advice back to actual query patterns and includes rollout risks for production migrations.
