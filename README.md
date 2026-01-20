# Claude Code Toolkit

Automation tools and custom commands for Claude Code CLI, including migration archiving, auto-commit hooks, and productivity slash commands.

## Tech Stack

[![Shell](https://img.shields.io/badge/Shell-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Markdown](https://img.shields.io/badge/Markdown-000000?logo=markdown&logoColor=white)](https://daringfireball.net/projects/markdown/)
[![Claude Code](https://img.shields.io/badge/Claude_Code-CC785C?logo=anthropic&logoColor=white)](https://docs.anthropic.com/en/docs/claude-code)

## Slash Commands

| Command | Description |
|---------|-------------|
| `/suggest <task>` | Analyze a task and recommend suitable skills/agents/commands |
| `/clone-ref <url> [folder]` | Clone a repository as reference and generate architecture docs |
| `/publish <path or description>` | Create a GitHub repo with auto-naming and tech stack badges |

## Hooks

### Migration Auto-Archive
- **Trigger**: After Bash/Write tool execution
- **Behavior**: Detects `*migration*` directories and copies them to `~/Desktop/迁移包层`
- **Naming**: `{content}-migration-{YYYYMMDDHHmm}`

### Good Feedback Auto-Commit
- **Trigger words**: "这很好", "目前很好", "不错", "可以", "OK", etc.
- **Behavior**: Auto git init (if needed) + git commit
- **Committer**: shuaizhicheng336@gmail.com

## Installation

```bash
cp -r commands/ ~/.claude/commands/
cp -r scripts/ ~/.claude/scripts/
# Merge settings.local.json into your .claude/settings.local.json
```

## File Structure

```
commands/
├── suggest.md        # Tool recommendation command
├── clone-ref.md      # Clone reference repo command
└── publish.md        # GitHub publish command

scripts/
├── archive-migration.sh           # Archive migration packages
├── check-and-archive-migration.sh # Hook: detect and archive
├── check-good-commit.sh           # Hook: auto-commit on positive feedback
└── detect-migration.sh            # Backup detection script

settings.local.json   # Hook configuration example
```

## License

MIT
