---
name: api-hardening-patterns
description: Audit and improve Laravel API endpoints for validation, authorization, rate limiting, error handling, and abuse resistance.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

## When to use

Use this skill when building or reviewing Laravel APIs that need stronger security, safer defaults, more predictable errors, and better protection against abuse or accidental misuse. Prefer it for public APIs, partner integrations, mobile backends, webhook endpoints, or any route group under `routes/api.php`.

## Input parameters

- API routes, controllers, request classes, and policies to inspect.
- Authentication model such as Sanctum, Passport, or token-based custom auth.
- Known abuse cases, compliance requirements, or public endpoint exposure.
- Desired response format and error handling conventions.
- Whether the API uses resources, spatie/laravel-query-builder, file uploads, signed URLs, or webhooks.

## Procedure

1. Inventory the API surface from `routes/api.php`, route groups, middleware, controllers, form requests, resources, policies, guards, and exception handling. Note which endpoints are public, authenticated, tenant-scoped, admin-only, or webhook-driven.
2. Inspect validation and authorization in Laravel-native locations first. Prefer `FormRequest` classes, policy methods, gates, route model binding constraints, signed routes, and explicit authorization checks over ad-hoc controller logic.
3. Review common Laravel API risks: inline validation, mass-assignment exposure on models, missing `$fillable` or unsafe `$guarded`, broad eager-loaded relationships in API resources, user-controlled filters/sorts, weak pagination defaults, unconstrained uploads, and inconsistent exception rendering.
4. Check abuse controls and platform protections. Review throttling middleware, login/token issuance flows, webhook signature verification, pagination caps, file upload validation, rate-limited jobs, and whether sensitive fields leak through serialization or `toArray()`.
5. Recommend concrete Laravel changes using middleware aliases, named rate limiters, `FormRequest` classes, API resources, policies, casts, hidden attributes, and explicit DTO/resource boundaries where needed.
6. If the API uses Sanctum or Passport, verify token ability checks, stateful vs stateless assumptions, CSRF/session crossover risks, and revocation/rotation handling. If it is a webhook endpoint, explicitly cover signature verification, replay protection, and idempotency.
7. Return a prioritized response with `Critical issues`, `Hardening improvements`, and `Tests to add`. Each recommendation should point to the Laravel file or layer where the fix belongs.

## Examples

Prompt 1:

```text
Use api-hardening-patterns on our public Laravel API. Focus on validation, authorization, throttling, and overexposed resources.
```

Prompt 2:

```text
Review these Sanctum-protected endpoints for abuse resistance and safer error handling. Suggest concrete middleware or request-class changes.
```

JSON:

```json
{
  "skill": "api-hardening-patterns",
  "context": {
    "auth": "sanctum",
    "exposure": "public",
    "focus": ["validation", "authorization", "rate_limiting", "error_contracts"],
    "files": ["routes/api.php", "app/Http/Controllers/Api", "app/Http/Requests"]
  }
}
```

## Smoke test

Run the skill on a Laravel API controller with inline validation, missing policy checks, unsafe resource serialization, and unlimited pagination. Verify that the response suggests `FormRequest`, policy, middleware, and resource-layer fixes instead of only generic security advice.
