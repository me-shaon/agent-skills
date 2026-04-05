# Laravel Boost Skills Skeleton

This repository is a starter layout for publishing reusable Laravel/PHP skills that can be installed with Laravel Boost and Agent Skills-compatible clients.

## Included Skills

- `deployment-readiness`
- `migration-index-reviewer`
- `api-hardening-patterns`
- `upgrade-assistant`
- `resilient-check`

## Repository Structure

The repository follows the common multi-skill layout:

```text
skills/
  <skill-slug>/
    SKILL.md
```

Each skill directory contains a `SKILL.md` file with YAML frontmatter and Markdown instructions.

## Install Instructions

### Agent Skills / npx

Install all skills:

```bash
npx skills add <owner/repo>
```

Install a specific skill:

```bash
npx skills add <owner/repo> --skill deployment-readiness
```

### Laravel Boost

Install all skills from the repository:

```bash
php artisan boost:add-skill <owner/repo>
```

Install a specific skill:

```bash
php artisan boost:add-skill <owner/repo> --skill deployment-readiness
```

## Edit Instructions

1. Update `skills-manifest.json` if you add, rename, or remove a skill.
2. Edit each skill in `skills/<slug>/SKILL.md`.
3. Replace `UNSPECIFIED` in `scripts/install-and-test.sh` with your real GitHub `owner/repo`.
4. Keep the YAML frontmatter valid and the section headings consistent so Boost can discover the skill cleanly.

## Test Instructions

Run the markdown lint workflow locally before pushing:

```bash
npm install
npx markdownlint-cli README.md skills/**/*.md
```

You can also run the install smoke test helper:

```bash
bash scripts/install-and-test.sh
```

That script prints the expected `php artisan boost:add-skill` commands for each skill and shows the expected success output shape.

## CI

GitHub Actions runs Markdown linting on every push and pull request via `.github/workflows/ci.yml`.

## License

MIT
