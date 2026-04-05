# AGENTS.md

Guidelines for agents working in this repository.

This repository is a multi-skill collection for Laravel-oriented agent skills. It does not contain a runnable Laravel application. The main job here is to maintain installable, well-structured skill packages that work with Agent Skills-compatible clients and Laravel Boost.

## 1. Repository Purpose

- Store reusable skills under `skills/<slug>/SKILL.md`.
- Keep each skill installable by slug from the repository root.
- Preserve compatibility with both:
  - `npx skills add <owner/repo> --skill <slug>`
  - `php artisan boost:add-skill <owner/repo> --skill <slug>`

## 2. Required Structure

Every skill must live in this exact structure:

```text
skills/
  <skill-slug>/
    SKILL.md
```

Repository-level supporting files currently expected:

- `README.md`
- `LICENSE`
- `AGENTS.md`
- `skills-manifest.json`
- `.github/workflows/ci.yml`
- `scripts/install-and-test.sh`

Do not move skills out of `skills/` and do not rename `SKILL.md`.

## 3. Skill Authoring Rules

When creating or editing a skill:

- Keep the folder name lowercase and hyphenated.
- Set the frontmatter `name` to exactly match the folder slug.
- Keep the frontmatter valid YAML.
- Keep the content practical, opinionated, and Laravel-specific where appropriate.
- Prefer concrete Laravel references such as `routes/api.php`, `config/queue.php`, `database/migrations`, `FormRequest`, policies, Horizon, scheduler, queues, Eloquent, and Artisan commands.
- Avoid generic advice that is not actionable in a Laravel codebase.
- Preserve the section structure used in this repository:
  - `When to use`
  - `Input parameters`
  - `Procedure`
  - `Examples`
  - `Smoke test`

## 4. Compatibility Expectations

Skills in this repository should remain compatible with repository-based skill installers.

When editing frontmatter:

- Keep `name` and `description` present.
- Keep `license: MIT`.
- Keep Laravel/PHP-oriented metadata aligned with the rest of the repo.
- Do not introduce custom structure changes that would break repository discovery.

If adding a new skill:

1. Create `skills/<slug>/SKILL.md`.
2. Add the skill to `skills-manifest.json`.
3. Update `README.md` if the listed skills change.
4. Update `scripts/install-and-test.sh` if the install examples should include the new slug.

## 5. Editing Guidance

- Prefer small, reviewable edits.
- Do not add generated noise or placeholder boilerplate.
- Do not add tool-specific files such as `CLAUDE.md`, `GEMINI.md`, or other agent-specific docs unless explicitly requested.
- Keep repo-wide guidance in this file and skill-specific guidance in each `SKILL.md`.

## 6. Validation Commands

Use these commands after making changes:

```bash
npx markdownlint-cli README.md "skills/**/*.md" AGENTS.md
bash scripts/install-and-test.sh
```

If `package.json` changes or markdown tooling is missing:

```bash
npm install
```

## 7. What Not to Do

- Do not assume this repository contains a Laravel app to run.
- Do not add application-specific setup steps that do not apply to a skills-only repository.
- Do not change the repository layout in ways that would make skill installation ambiguous.
- Do not rename slugs casually; installer commands depend on them.

## 8. Output Quality Bar

Good changes in this repository should:

- improve skill usefulness,
- preserve installation compatibility,
- keep documentation consistent,
- and make the repo easier for humans and agents to maintain.
