#!/usr/bin/env bash
# Bootstrap script for the koseki/skills toolkit.
#
# Creates the prerequisite directory structure and template files
# referenced by CLAUDE.md and the skills/ workflows.
#
# Idempotent: existing files are NOT overwritten.
#
# Usage:
#   bash scripts/init.sh                # bootstrap current directory
#   bash scripts/init.sh /path/to/repo  # bootstrap target directory

set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

created=0
note() { echo "  + $1"; created=$((created + 1)); }

echo "Bootstrapping koseki/skills structure in: $(pwd)"
echo ""

# ----------------------------------------------------------------------------
# agents/tasks/  — task tracking + self-improvement loop
# ----------------------------------------------------------------------------
mkdir -p agents/tasks/active

if [[ ! -f agents/tasks/lessons.md ]]; then
  cat > agents/tasks/lessons.md <<'EOF'
# Lessons Learned

Append entries here when:
- The user corrects your approach
- A repeated mistake surfaces
- A surprising failure occurs
- A reusable insight emerges

Use the format in `lessons.template.md`. Keep each entry body ≤ 5 lines.

---
EOF
  note "agents/tasks/lessons.md"
fi

if [[ ! -f agents/tasks/lessons.template.md ]]; then
  cat > agents/tasks/lessons.template.md <<'EOF'
## <Short title>

- **What happened:** <1-line description of the situation>
- **Rule:** <the rule to follow next time>
- **Why:** <reason — past correction, incident, or surprising failure>
- **Apply when:** <conditions under which this rule kicks in>
EOF
  note "agents/tasks/lessons.template.md"
fi

if [[ ! -f agents/tasks/active/.gitkeep ]]; then
  touch agents/tasks/active/.gitkeep
  note "agents/tasks/active/.gitkeep"
fi

# ----------------------------------------------------------------------------
# docs/  — specifications and design docs
# ----------------------------------------------------------------------------
mkdir -p docs/skills/specs

if [[ ! -f docs/README.md ]]; then
  cat > docs/README.md <<'EOF'
# Documentation Index

Specifications, design docs, and architectural decisions live here.
**Always consult this index** before adding new documentation, and update it
when you add or restructure docs.

## Conventions

- **Design docs / specs:** `docs/skills/specs/YYYY-MM-DD-<topic>-design.md`
  - Produced by the `brainstorming` skill at the end of design exploration.
- **Architectural Decision Records (ADR):** `docs/adr/NNNN-<title>.md`
  - One file per decision. Use the standard ADR template.
- **Domain glossary / module map:** `CONTEXT.md` at repo root
  - Optional but recommended for the `improve-codebase-architecture` skill.

## Index

<!-- Update this section whenever you add or restructure docs. -->

### Specs

(empty)

### ADRs

(empty)
EOF
  note "docs/README.md"
fi

# ----------------------------------------------------------------------------
# .gitignore  — exclude in-progress task logs from version control
# ----------------------------------------------------------------------------
[[ -f .gitignore ]] || touch .gitignore

ensure_gitignore() {
  local entry="$1"
  if ! grep -qxF "$entry" .gitignore; then
    echo "$entry" >> .gitignore
    note ".gitignore += $entry"
  fi
}

ensure_gitignore "agents/tasks/active/*"
ensure_gitignore "!agents/tasks/active/.gitkeep"

# ----------------------------------------------------------------------------
echo ""
if [[ $created -eq 0 ]]; then
  echo "Already bootstrapped. Nothing to do."
else
  echo "Bootstrap complete ($created file(s) created)."
fi
