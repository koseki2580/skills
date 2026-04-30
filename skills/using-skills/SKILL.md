---
name: using-skills
description: Determines when and how to invoke Agent Skills
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

## Instruction Priority

User instructions always take precedence:

1. **User's explicit instructions** (CLAUDE.md, GEMINI.md, AGENTS.md, direct requests) — highest priority
2. **Skills instructions** — override default system behavior where they conflict
3. **Default system prompt** — lowest priority

If CLAUDE.md says "don't use TDD" and a skill says "always use TDD," follow the user's instructions. The user is in control.

## Using Skills

**For non-trivial tasks, check whether a skill applies before implementation.**
For trivial Q&A, formatting-only edits, and obvious one-line changes, do not invoke skills unless the user explicitly asks.

When you recognize that a skill matches the situation (e.g. debugging, planning, architectural changes):
1. Use the generic file reading tool to read the full `SKILL.md` instruction from the URI.
2. Read the skill documentation **before** executing steps or proposing a design.
3. If an invoked skill turns out to be wrong for the situation, you don't need to use it.

## Skill Types

**Rigid** (TDD, debugging): Follow exactly. Don't adapt away discipline.
**Flexible** (patterns): Adapt principles to context.
