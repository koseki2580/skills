# Koseki's Skills

This repository is a collection of "Skills" that contains system prompts and workflow instructions tailored for AI development agents.
It acts as a safety mechanism to prevent sloppy implementations, encouraging the AI to verify, debug systematically, plan, and leave a trail of evidence.

## Install

1. Copy or symlink `CLAUDE.md` to your workspace root (or `~/.claude/CLAUDE.md`).
2. Copy or symlink selected skills into `~/.claude/skills/`.
3. Bootstrap the prerequisite directory structure in your target repository:

   ```bash
   bash scripts/init.sh /path/to/your/repo
   ```

   This creates `agents/tasks/{lessons.md,lessons.template.md,active/}`, `docs/README.md`, and the necessary `.gitignore` entries — all referenced by `CLAUDE.md` and various skills. The script is idempotent and never overwrites existing files.

## Philosophy

- `CLAUDE.md` contains **always-on**, lightweight project behavior and minimum rules.
- `skills/` contains optional workflows loaded **only when relevant** (using progressive disclosure).

## Skills Directory

| Category       | Skill                            | Use when                                              |
|----------------|----------------------------------|-------------------------------------------------------|
| **debugging**  | `systematic-debugging`           | bug, test failure, unexpected behavior                |
| **implementation** | `test-driven-development`    | before writing implementation code                    |
|                | `writing-plans`                  | multi-step implementation planning                    |
|                | `executing-plans`                | executing a written implementation plan               |
|                | `verification-before-completion` | before claiming work is complete                      |
|                | `brainstorming`                  | ambiguous, structural, or multi-component design      |
| **review**     | `requesting-code-review`         | before merging to verify work meets requirements       |
|                | `receiving-code-review`          | processing review feedback                            |
| **repo-ops**   | `commit-message-convention`      | creating commits                                      |
|                | `finishing-a-development-branch` | integrating completed work                            |
|                | `using-git-worktrees`            | starting isolated feature work                        |
| **meta**       | `writing-skills`                 | creating or editing skills                            |
|                | `using-skills`                   | determining when to invoke a skill                    |

*See individual directories in `skills/` for more specialized workflows.*

## References
- [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)
- [mattpocock/skills](https://github.com/mattpocock/skills)
- [obra/superpowers](https://github.com/obra/superpowers)
- [awslabs/aidlc-workflows](https://github.com/awslabs/aidlc-workflows)
