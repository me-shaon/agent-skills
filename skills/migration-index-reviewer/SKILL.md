---
name: migration-index-reviewer
description: Review Laravel migrations and query paths for missing, redundant, or risky indexes before production.
license: MIT
tags:
  - laravel
  - php
version: 0.1.1
compatible_agents:
  - laravel/boost
---

# Migration Index Reviewer

## When to use

Use this skill when reviewing Laravel migrations, schema changes, or slow-query fixes that add tables, foreign keys, filters, sorts, tenant scopes, or reporting queries. It is most useful before merging migrations that will run on large production tables.

## Input parameters

- The migration files or pull request to inspect.
- Known hot paths, large tables, or slow queries.
- Target database engine such as MySQL or PostgreSQL.
- Any constraints around zero-downtime migrations.
- Relevant Eloquent models, scopes, controllers, jobs, or reports that show the real query patterns.

## Procedure

1. Inspect the migration files in `database/migrations` and note new tables, altered columns, foreign keys, unique constraints, `softDeletes()`, polymorphic relations, and any columns likely to be filtered, sorted, joined, or backfilled.
2. Cross-check how the affected tables are used in Laravel code. Look at Eloquent models, relationships, scopes, controllers, jobs, reports, and admin resources for common `where`, `orderBy`, `latest`, `firstOrCreate`, `updateOrCreate`, and eager-loading patterns.
3. Evaluate index coverage from actual usage. Focus on foreign keys, tenant columns such as `account_id` or `team_id`, compound filter-plus-sort patterns, uniqueness enforced only in validation, and common lookups involving `deleted_at`.
4. Flag bad tradeoffs, especially redundant single-column indexes, composite indexes in the wrong order, reliance on `constrained()` without checking real query needs, or schema changes that can slow queues and reporting jobs.
5. Review rollout safety for production. Call out table rewrites, large backfills inside migrations, column or index renames on hot tables, and any index creation approach that is risky for blue/green or rolling deploys.
6. Return concrete migration changes, using `Schema::table()` or `$table->index([...])` examples when helpful. End with these sections: `Missing indexes`, `Redundant or weak indexes`, `Rollout risks`, and `Recommended migration changes`.
7. Keep the answer focused on actionable index decisions. Do not speculate about indexes that are not supported by observed query patterns.

## Examples

Prompt 1:

```text
Use migration-index-reviewer on the new order and order_items migrations. Focus on account_id, status, created_at, foreign keys, and rollout safety.
```

Prompt 2:

```text
Review these Laravel migrations for missing or redundant indexes on MySQL 8. Tie recommendations back to the actual Laravel query paths.
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
    "laravel_artifacts": ["Order model", "OrderController", "OrderReportJob"],
    "focus": ["foreign_keys", "compound_indexes", "rollout_risks"]
  }
}
```

## Smoke test

Provide a Laravel migration that adds foreign keys and common filter columns without useful indexes, plus a model or controller that queries them. Verify that the response ties every recommendation to a real query pattern and returns a short, concrete set of migration changes.
