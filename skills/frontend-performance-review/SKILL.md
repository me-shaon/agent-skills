---
name: frontend-performance-review
description: Review Laravel frontend performance, responsiveness, and Lighthouse-impacting best practices.
license: MIT
tags:
  - laravel
  - php
version: 0.1.0
compatible_agents:
  - laravel/boost
---

# Frontend Performance Review

## When to use

Use this skill when reviewing a Laravel project's frontend for slow page loads, weak Lighthouse scores, layout instability, mobile responsiveness issues, or generally inefficient UI implementation. It is most useful for Blade, Livewire, Inertia, Vue, React, Alpine, and Vite-based Laravel apps.

## Input parameters

- The frontend area, route, or page flow to inspect.
- Relevant Blade, Livewire, Inertia, Vue, React, Tailwind, or Vite files.
- Known performance complaints such as slow first load, poor mobile UX, or weak Lighthouse scores.
- Constraints such as SEO goals, mobile-first requirements, or Core Web Vitals targets.
- Whether images, third-party scripts, charts, maps, or heavy UI libraries are involved.

## Procedure

1. Identify the frontend stack and rendering path. Inspect Blade views, Livewire components, Inertia pages, frontend components, `vite.config.*`, asset entrypoints, Tailwind usage, and any CDN, cache, or image pipeline configuration.
2. Review the critical rendering path. Look for oversized JS or CSS bundles, blocking scripts, unused assets, poor code splitting, large images, webfont issues, layout shifts, missing lazy loading, and expensive above-the-fold components.
3. Review responsiveness and runtime UX. Check mobile breakpoints, overflow issues, cumulative layout shift, interaction latency, heavy DOM trees, unnecessary re-renders, chatty Livewire updates, and components that degrade badly on smaller screens.
4. Focus on Laravel-specific frontend tradeoffs. Review Vite entrypoints, dynamic imports, Blade partial reuse, Livewire request frequency, Inertia page payloads, asset versioning, cache headers, image storage patterns, and how third-party scripts are loaded.
5. If Lighthouse concerns are part of the request, focus recommendations on likely wins for Performance, Accessibility, Best Practices, and SEO without padding the response with generic score advice.
6. Return findings under `Critical issues`, `Performance improvements`, `Responsive UX issues`, `Lighthouse opportunities`, and `Validation steps`. Point each recommendation to the relevant file, component, asset, or rendering layer.
7. Keep the answer practical and prioritized. Favor the smallest high-impact changes first, and avoid generic frontend advice that is not grounded in the actual Laravel app structure.

Output expectations: return the highest-impact performance and responsiveness issues first, then concrete Laravel-appropriate fixes and the validation steps needed to confirm improvement.

## Examples

Prompt 1:

```text
Use frontend-performance-review on this Laravel + Livewire app. Focus on slow mobile load times, layout shifts, and anything hurting Lighthouse performance.
```

Prompt 2:

```text
Review this Laravel Inertia + Vue frontend for responsiveness and performance. Prioritize bundle size, image handling, route-level code splitting, and Core Web Vitals.
```

JSON:

```json
{
  "skill": "frontend-performance-review",
  "context": {
    "stack": ["laravel", "vite", "inertia", "vue", "tailwind"],
    "focus": ["lighthouse", "responsiveness", "bundle_size", "images", "core_web_vitals"],
    "files": ["resources/js", "resources/views", "vite.config.js"],
    "targets": ["mobile_homepage", "dashboard"]
  }
}
```

Code example:

```js
const AnalyticsPage = defineAsyncComponent(() =>
    import('./Pages/AnalyticsPage.vue')
);
```

## Smoke test

Run the skill on a Laravel frontend that uses large images, shared JS entrypoints, and mobile-heavy layouts. Verify that the response flags concrete performance bottlenecks, responsive UX issues, and Laravel-specific improvements such as Vite code splitting, lazy loading, or Livewire/Inertia payload reductions.
