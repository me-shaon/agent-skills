---
name: api-hardening-patterns
description: Review Laravel API endpoints for validation, authorization, abuse resistance, and safer defaults.
license: MIT
tags:
  - laravel
  - php
version: 0.1.1
compatible_agents:
  - laravel/boost
---

# API Hardening Patterns

## When to use

Use this skill when building or reviewing Laravel APIs that need stronger security, safer defaults, and better abuse resistance. It is most useful for public APIs, partner integrations, mobile backends, webhook endpoints, or any route group under `routes/api.php`.

## Input parameters

- API routes, controllers, request classes, and policies to inspect.
- Authentication model such as Sanctum, Passport, or token-based custom auth.
- Known abuse cases, compliance requirements, or public endpoint exposure.
- Desired response format and error handling conventions.
- Whether the API uses resources, spatie/laravel-query-builder, file uploads, signed URLs, or webhooks.

## Procedure

1. Inspect the API surface from `routes/api.php`, route groups, middleware, controllers, form requests, resources, policies, guards, and exception handling. Note which endpoints are public, authenticated, tenant-scoped, admin-only, or webhook-driven.
2. Check validation and authorization in Laravel-native locations first. Prefer `FormRequest` classes, policy methods, gates, route model binding constraints, signed routes, and explicit authorization checks over ad-hoc controller logic.
3. Focus on common Laravel API risks: inline validation, mass-assignment exposure, unsafe `$fillable` or `$guarded`, over-broad API resources, user-controlled filters and sorts, weak pagination defaults, unconstrained uploads, and inconsistent exception rendering.
4. Review abuse controls and data exposure. Check throttling, token issuance, pagination caps, webhook signature verification, replay protection, rate-limited jobs, and whether hidden or sensitive attributes leak through serialization or `toArray()`.
5. If the API uses Sanctum or Passport, review token ability checks, stateful vs stateless assumptions, CSRF/session crossover risks, and revocation or rotation handling. If it handles webhooks, explicitly review signature verification and idempotency.
6. Return findings under `Critical issues`, `Hardening improvements`, and `Tests to add`. Point each recommendation to the Laravel file or layer where the fix belongs, and prefer concrete changes such as `FormRequest`, policy, middleware, resource, cast, or hidden-attribute updates.
7. Keep the answer practical and prioritized. Do not give generic API security advice that is not tied to the actual Laravel implementation.

## Examples

Prompt 1:

```text
Use api-hardening-patterns on our public Laravel API. Focus on validation, authorization, throttling, and resource/data exposure.
```

Prompt 2:

```text
Review these Sanctum-protected endpoints for abuse resistance and safer error handling. Suggest concrete Laravel fixes, not just generic advice.
```

JSON:

```json
{
  "skill": "api-hardening-patterns",
  "context": {
    "auth": "sanctum",
    "exposure": "public",
    "focus": ["validation", "authorization", "rate_limiting", "error_contracts"],
    "files": ["routes/api.php", "app/Http/Controllers/Api", "app/Http/Requests"],
    "concerns": ["resource_exposure", "pagination_limits", "token_abilities"]
  }
}
```

## Smoke test

Run the skill on a Laravel API controller with inline validation, missing policy checks, unsafe resource serialization, and unlimited pagination. Verify that the response returns concrete Laravel fixes such as `FormRequest`, policy, middleware, resource, or model-visibility changes instead of generic security advice.
