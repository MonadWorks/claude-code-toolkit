---
name: suggest
description: Analyze a task and recommend relevant skills, agents, or slash commands that could help accomplish it
arguments:
  - name: task
    description: The task or goal you want to accomplish
    required: true
---

# Task Analysis and Tool Recommendation

You are a tool recommendation assistant. The user has described a task they want to accomplish. Your job is to:

1. **Understand the task**: Analyze what the user is trying to do
2. **Search for relevant tools**: Check all available skills, agents, and commands
3. **Recommend the best matches**: List tools that could help, with explanations
4. **Suggest an execution order**: If multiple tools apply, explain how to orchestrate them

## User's Task

$ARGUMENTS

## Analysis Instructions

### Step 1: Categorize the Task

Determine what category this task falls into:
- Code writing/implementation
- Debugging/troubleshooting
- Code review/analysis
- Documentation
- Testing
- DevOps/deployment
- Database operations
- API development
- Frontend/mobile development
- Security auditing
- Research/exploration
- Creative work (design, art)
- Data analysis/ML
- Other

### Step 2: Check Available Tools

Review these tool categories and find matches:

**Skills** (invoke with `/skill-name` or Skill tool):
- Check the Skill tool's available skills list for matches
- Look for domain-specific skills (e.g., fastapi-pro, react, django, etc.)
- Look for workflow skills (e.g., brainstorming, debugging, tdd-workflows)
- Look for specialized skills (e.g., code-auditor, code-refactor, architecture-diagram-creator)

**Agents** (invoke with Task tool):
- Explore: For codebase exploration and understanding
- Plan: For designing implementation strategies
- debugger: For errors and test failures
- code-reviewer: For code quality review
- security-auditor: For security assessment
- frontend-developer, backend-architect, etc.

**Built-in Commands**:
- /commit: For git commits
- /review-pr: For PR reviews
- /help: For getting help

### Step 3: Generate Recommendations

For each recommended tool, provide:
1. **Tool name and type** (skill/agent/command)
2. **Why it's relevant** to this specific task
3. **How to invoke it** (exact command or tool call)
4. **What it will do** for this task

### Step 4: Orchestration (if multiple tools)

If multiple tools are recommended:
1. List them in the suggested execution order
2. Explain why this order makes sense
3. Note any dependencies between tools

## Output Format

```
## Task Understanding
[1-2 sentence summary of what the user wants to do]

## Recommended Tools

### 1. [Tool Name] (type: skill/agent/command)
- **Relevance**: Why this tool fits
- **Invoke**: How to use it
- **Expected outcome**: What it will help with

### 2. [Tool Name] ...

## Suggested Workflow
[If multiple tools, explain the recommended sequence]

## Quick Start
[The single most important tool/command to start with]
```

Now analyze the user's task and provide your recommendations.
