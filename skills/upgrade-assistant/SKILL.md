---
name: upgrade-assistant
description: Plan a Laravel or PHP upgrade by identifying blockers, risky code paths, and the safest execution order.
license: MIT
tags:
  - laravel
  - php
version: 0.1.1
compatible_agents:
  - laravel/boost
---

# Upgrade Assistant

## When to use

Use this skill when preparing or executing a Laravel framework, first-party package, or PHP upgrade and you need a practical upgrade plan. It is most useful when the app has custom authentication, queues, broadcasting, Horizon, Octane, Livewire, Inertia, Filament, or a large test suite.

## Input parameters

- Current and target Laravel or PHP versions.
- `composer.json`, `composer.lock`, and important first-party or third-party packages.
- Relevant upgrade guide links, changelog snippets, or failing tests.
- Constraints such as freeze windows or required backward compatibility.
- Whether the project uses common Laravel ecosystem packages such as Sanctum, Passport, Cashier, Scout, Horizon, Reverb, Jetstream, Livewire, Inertia, Filament, or Pest.

## Procedure

1. Confirm the current and target Laravel and PHP versions, then decide whether the safest path is a direct jump or incremental major-version upgrades.
2. Inspect `composer.json`, `composer.lock`, `phpunit.xml`, `bootstrap/app.php`, `config/*.php`, custom service providers, middleware registration, exception handling, and package-specific config to identify dependency blockers or published config drift.
3. Review Laravel-specific hotspots such as authentication, route model binding, queued jobs, broadcasting, notifications, custom casts, console commands, macros, test helpers, and any overridden framework internals.
4. Prefer official upgrade guides and package changelogs over guesswork. Call out where framework defaults changed, where published config may need review, and which ecosystem packages are most likely to block the upgrade.
5. Group findings into `Dependency blockers`, `Code changes`, `Config/bootstrap changes`, and `Validation steps`. Be explicit about what must happen before `composer update`, immediately after it, and before deployment.
6. End with a phased plan using these sections: `Preparation`, `Dependency updates`, `Application changes`, `Test pass`, and `Deployment checks`. Include concrete commands, targeted PHPUnit or Pest suites, and smoke-test routes when relevant.
7. Keep the answer concise and practical. Do not dump a generic framework changelog; focus on the changes that matter for the actual app and dependency set.

Output expectations: return dependency blockers first, then a phased upgrade plan with concrete commands, test checkpoints, and deployment checks.

## Examples

Prompt 1:

```text
Use upgrade-assistant to plan a Laravel 11 to 12 upgrade with PHP 8.3. Start with package blockers, config changes, and the safest execution order.
```

Prompt 2:

```text
Help me upgrade this app from PHP 8.2 to 8.3 and Laravel 10 to 12. Focus on dependency blockers, risky framework touchpoints, and test checkpoints.
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
    "focus": ["dependency_blockers", "config_changes", "test_plan"],
    "packages": ["sanctum", "horizon", "pest", "livewire"]
  }
}
```

## Smoke test

Feed the skill a Laravel app with an older `composer.json`, published config, and a few first-party packages. Verify that the response identifies real dependency blockers, highlights Laravel-specific risk areas, and returns a short phased upgrade plan instead of a generic package-update checklist.
