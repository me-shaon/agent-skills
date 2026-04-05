---
name: upgrade-assistant
description: Guide a Laravel or PHP upgrade by identifying breaking changes, dependency risks, code hotspots, and a safe execution order.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

# Upgrade Assistant

## When to use

Use this skill when preparing for or actively executing a Laravel framework, first-party package, PHP runtime, or ecosystem upgrade and you want a staged plan with risk awareness. It is most valuable when the app has custom authentication, queues, broadcasting, Horizon, Octane, Livewire, Inertia, Filament, or a large test suite.

## Input parameters

- Current and target Laravel or PHP versions.
- `composer.json`, lockfile status, and key packages.
- Any upgrade guide links, changelog snippets, or failing tests.
- Constraints such as freeze windows or required backward compatibility.
- Whether the project uses common Laravel ecosystem packages such as Sanctum, Passport, Cashier, Scout, Horizon, Reverb, Jetstream, Livewire, or Pest.

## Procedure

1. Determine the exact upgrade path from the current Laravel and PHP versions to the target versions. Prefer incremental major-version jumps when the codebase or dependency tree is large.
2. Inspect `composer.json`, `composer.lock`, `phpunit.xml`, `bootstrap/app.php`, `config/*.php`, custom service providers, middleware registration, exception handling, and any package-specific config files. Identify first-party and third-party packages that could block the upgrade.
3. Cross-check the codebase for Laravel-specific hotspots: authentication guards, custom casts, route model binding, queued jobs, broadcasting, notifications, console commands, test helpers, macros, published config, and any overridden framework internals.
4. Separate issues into `Dependency blockers`, `Framework-level code changes`, `Config/bootstrap changes`, and `Test/runtime validation`. Be explicit about what should happen before `composer update`, what should happen immediately after, and what should be validated before deployment.
5. Prefer upgrade guidance that maps to Laravel conventions: follow the official upgrade guide, update published config carefully, review deprecations, and call out where framework defaults changed rather than telling the user to rewrite working code unnecessarily.
6. If the app uses Livewire, Inertia, Filament, Horizon, Reverb, Octane, or Pest, include those packages in the risk summary and mention likely coupling points with the framework upgrade.
7. End with a phased execution plan: `Preparation`, `Dependency changes`, `Code updates`, `Test pass`, and `Deployment checks`. Each phase should include concrete validation steps such as targeted PHPUnit or Pest suites, Artisan commands, and smoke-test routes.

## Examples

Prompt 1:

```text
Use upgrade-assistant to plan a Laravel 11 to 12 upgrade with PHP 8.3. Review Composer constraints and likely breaking changes first.
```

Prompt 2:

```text
Help me upgrade this app from PHP 8.2 to 8.3 and Laravel 10 to 12. I want the safest sequence of changes and test checkpoints.
```

JSON:

```json
{
  "skill": "upgrade-assistant",
  "context": {
    "current": {
      "laravel": "10.x",
      "php": "8.2"
    },
    "target": {
      "laravel": "12.x",
      "php": "8.3"
    },
    "focus": ["composer", "breaking_changes", "test_plan"],
    "packages": ["sanctum", "horizon", "pest"]
  }
}
```

## Smoke test

Feed the skill a Laravel app with an older `composer.json`, published config, and a few first-party packages. Verify that the response identifies dependency blockers, Laravel-specific code hotspots, and a sensible phased upgrade sequence instead of a generic package-update checklist.
