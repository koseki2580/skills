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

| Category               | Skill                                   | Use when                                              |
|------------------------|-----------------------------------------|-------------------------------------------------------|
| **debugging**          | `systematic-debugging`                  | bug, test failure, unexpected behavior                |
| **implementation**     | `test-driven-development`               | before writing implementation code                    |
|                        | `writing-plans`                         | multi-step implementation planning                    |
|                        | `executing-plans`                       | executing a written implementation plan               |
|                        | `verification-before-completion`        | before claiming work is complete                      |
|                        | `brainstorming`                         | ambiguous, structural, or multi-component design      |
| **review**             | `requesting-code-review`                | before merging to verify work meets requirements      |
|                        | `receiving-code-review`                 | processing review feedback                            |
| **multi-agent review** | `review-orchestration`                  | orchestrating PR review across specialist subagents   |
|                        | `implementation-review-orchestration`   | orchestrating in-progress code review                 |
|                        | `create-pr-comment`                     | posting PR comments (GitHub / Bitbucket)              |
|                        | `review-dynamic-validation`             | executing tests/lint/typecheck during review          |
|                        | `review-learning-loop`                  | learning from past comment outcomes                   |
|                        | `interactive-review-dialogue`           | re-evaluating after author replies                    |
|                        | `review-reference-creation`             | creating team-specific review references              |
|                        | `review-reference-maintenance`          | maintaining team-specific review references           |
| **repo-ops**           | `commit-message-convention`             | creating commits                                      |
|                        | `finishing-a-development-branch`        | integrating completed work                            |
|                        | `using-git-worktrees`                   | starting isolated feature work                        |
| **meta**               | `writing-skills`                        | creating or editing skills                            |
|                        | `using-skills`                          | determining when to invoke a skill                    |

*See individual directories in `skills/` for more specialized workflows.*

## Multi-Agent Review System

This repository includes a multi-agent code review orchestration system that provides Senior-level review depth across many perspectives, with Staff-level meta-supervision over the orchestration itself.

### Components

- **`agents/pr-review/`** — 25 specialist subagents for completed-PR review (correctness, tests, security, architecture, performance, migration safety, accessibility, etc.).
- **`agents/implementation-review/`** — 17 specialist subagents for in-progress code review. They return next-action feedback only; they never post PR comments.
- **`skills/review-orchestration/`** — PR review orchestrator. Selects subagents, distributes context, aggregates results, decides overall risk, posts a single final summary comment.
- **`skills/implementation-review-orchestration/`** — In-progress review orchestrator. Returns internal feedback to the coding flow.
- **`skills/create-pr-comment/`** — Provider-independent comment creation. GitHub / Bitbucket payload differences are isolated here.
- **`skills/review-dynamic-validation/`** — Run safe, read-only validation commands (tests, lint, typecheck, coverage) and feed results back into the review.
- **`skills/review-learning-loop/`** — Learn from comment outcomes (resolved / dismissed / accepted) and feed signals back into agent calibration.
- **`skills/interactive-review-dialogue/`** — Re-evaluate findings after author / implementer replies (keep / soften / withdraw / clarify / escalate).
- **`skills/review-reference-{creation,maintenance}/`** — Curate team-specific review knowledge (lessons, applicability, deprecations).
- **`review-references/`** — Persistent team-specific review reference data.
- **`REVIEW_SYSTEM_GUARDRAILS.md`** — Operating principles for extending the system (Symmetry, Main Agent Accountability, No Silent Unknowns, Capability Mapping, Documentation Consistency).
- **`REVIEW_SYSTEM_MATURITY.md`** — Capability maturity notes.

### Design Principles

- PR review and implementation-time review are completely separate tracks with different evaluation criteria, but their orchestration capabilities are kept symmetric.
- Each specialist subagent owns a single perspective; the orchestrator does selection, aggregation, risk reconciliation, and the final summary.
- Provider-specific (GitHub / Bitbucket) details stay isolated in `create-pr-comment`; reviewer agents remain provider-independent.
- Dynamic validation, the learning loop, and interactive follow-up are first-class components, not after-the-fact extensions.
- Project rules from `CLAUDE.md` are wired directly to the relevant agents as `project_rules`, not only via team references.
- Any new capability added on one side must be mirrored on the other side, or the one-sided exception must be documented.

## References
- [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)
- [mattpocock/skills](https://github.com/mattpocock/skills)
- [obra/superpowers](https://github.com/obra/superpowers)
- [awslabs/aidlc-workflows](https://github.com/awslabs/aidlc-workflows)
