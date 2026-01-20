---
name: clone-ref
description: Clone a repository as reference and generate a simple architecture document
arguments:
  - name: url
    description: The GitHub repository URL to clone
    required: true
  - name: folder
    description: "Whether to put in separate folder: '放进文件夹' (default) or '不放进文件夹'"
    required: false
---

# Clone Reference Repository

Clone a repository for reference and create architecture documentation.

## Parameters

- **URL**: $1
- **Folder option**: $2 (default: 放进文件夹)

## Execution Steps

### Step 1: Parse Repository Info

Extract the repository name from the URL. The folder name should be: `{repo-name}-ref`

### Step 2: Clone

```bash
# If folder option is "不放进文件夹" or empty URL
# Clone directly to current directory (be careful with conflicts)

# Otherwise (default: 放进文件夹)
# Create folder named {repo-name}-ref and clone into it
```

Execute the appropriate git clone command based on the folder option.

### Step 3: Explore and Understand

After cloning, thoroughly explore the repository:

1. **Project structure** - List all directories and key files
2. **Entry points** - Find main files, index files, CLI entry points
3. **Core modules** - Identify the main functional components
4. **Configuration** - Check package.json, pyproject.toml, Cargo.toml, etc.
5. **Dependencies** - What libraries/frameworks does it use?

### Step 4: Generate Documentation

Create a file named `{repo-name}-ref.md` in the **parent directory** (outside the cloned folder).

The document should be **simple and concise** with this structure:

```markdown
# {Repo Name} 参考文档

> 来源: {url}
> 克隆时间: {date}

## 简要架构概览

[2-3 sentences describing what this project does and its high-level architecture]

## 目录结构

```
{tree structure of main directories}
```

## 核心模块

### {Module 1 Name}
- **位置**: {path}
- **功能**: {brief description}
- **观察**: {your insights about how it works}

### {Module 2 Name}
...

## 关键文件

| 文件 | 用途 |
|------|------|
| ... | ... |

## 使用方式

[How to use this project, based on README or your analysis]

## 值得注意的实现

[Any interesting patterns, techniques, or code worth learning from]
```

## Important Notes

- Keep documentation **simple** - architecture overview + module observations
- Documentation file goes **outside** the cloned folder, at the same level
- Folder naming: `{repo-name}-ref` (add `-ref` suffix)
- If "不放进文件夹" is specified, clone contents directly but still create the doc file
