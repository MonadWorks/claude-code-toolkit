---
name: publish
description: Create a GitHub repository with proper naming, README with clickable tech stack badges
arguments:
  - name: path_or_desc
    description: Folder path or description of what to upload
    required: true
---

# Publish to GitHub

Create a new GitHub repository with automatic setup.

## Input

- **Path or Description**: $ARGUMENTS

## Execution Steps

### Step 1: Determine Target Directory

If the input is a file path, use that directory.
If it's a description, use the current working directory.

### Step 2: Analyze Project

Scan the directory to detect:
- **Project type**: web app, CLI tool, library, scripts, etc.
- **Tech stack**: Look for package.json, requirements.txt, Cargo.toml, go.mod, etc.
- **Main language**: Based on file extensions

### Step 3: Generate Repository Name

Create a concise, descriptive English name:
- Use kebab-case (lowercase with hyphens)
- Max 30 characters
- Reflect the project's purpose
- Examples: `react-dashboard`, `python-cli-tools`, `api-gateway`

### Step 4: Detect Tech Stack and Create Badges

For each detected technology, create a clickable badge using shields.io format:

```markdown
[![Tech](https://img.shields.io/badge/Tech-Version-color?logo=tech)](https://tech-website.com)
```

Common badge mappings:

| Tech | Badge | Link |
|------|-------|------|
| JavaScript | `[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)` |
| TypeScript | `[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)` |
| Python | `[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)` |
| React | `[![React](https://img.shields.io/badge/React-61DAFB?logo=react&logoColor=black)](https://react.dev/)` |
| Vue | `[![Vue](https://img.shields.io/badge/Vue.js-4FC08D?logo=vue.js&logoColor=white)](https://vuejs.org/)` |
| Node.js | `[![Node.js](https://img.shields.io/badge/Node.js-339933?logo=node.js&logoColor=white)](https://nodejs.org/)` |
| Rust | `[![Rust](https://img.shields.io/badge/Rust-000000?logo=rust&logoColor=white)](https://www.rust-lang.org/)` |
| Go | `[![Go](https://img.shields.io/badge/Go-00ADD8?logo=go&logoColor=white)](https://go.dev/)` |
| Docker | `[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)` |
| PostgreSQL | `[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)` |
| MongoDB | `[![MongoDB](https://img.shields.io/badge/MongoDB-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)` |
| Redis | `[![Redis](https://img.shields.io/badge/Redis-DC382D?logo=redis&logoColor=white)](https://redis.io/)` |
| AWS | `[![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)` |
| FastAPI | `[![FastAPI](https://img.shields.io/badge/FastAPI-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)` |
| Django | `[![Django](https://img.shields.io/badge/Django-092E20?logo=django&logoColor=white)](https://www.djangoproject.com/)` |
| Next.js | `[![Next.js](https://img.shields.io/badge/Next.js-000000?logo=next.js&logoColor=white)](https://nextjs.org/)` |
| Tailwind | `[![Tailwind](https://img.shields.io/badge/Tailwind_CSS-38B2AC?logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)` |
| Swift | `[![Swift](https://img.shields.io/badge/Swift-FA7343?logo=swift&logoColor=white)](https://swift.org/)` |
| Kotlin | `[![Kotlin](https://img.shields.io/badge/Kotlin-7F52FF?logo=kotlin&logoColor=white)](https://kotlinlang.org/)` |

### Step 5: Create/Update README.md

Generate README with this structure:

```markdown
# Project Name

Brief description of what this project does.

## Tech Stack

[Clickable badges here]

## Getting Started

[Basic setup instructions based on detected tech]

## License

MIT
```

### Step 6: Initialize Git (if needed)

```bash
git init
git config user.email "shuaizhicheng336@gmail.com"
git config user.name "shuaizhi"
```

### Step 7: Create GitHub Repository

```bash
gh repo create <repo-name> --public --source=. --remote=origin --push
```

Or if repo exists locally:
```bash
gh repo create <repo-name> --public --source=. --push
```

### Step 8: Confirm Success

Output:
- Repository URL
- Tech stack detected
- README created/updated

## Important Notes

- Always use `--public` unless user specifies private
- Ensure .gitignore exists for the detected tech stack
- Don't commit sensitive files (.env, credentials, etc.)
- Use English for all repository metadata
