#!/usr/bin/env bash
set -euo pipefail

# ==========================================================
# create_5_ai_agents.sh
# - SAFE by default: backup + logs + no overwrite unless --yolo
# - Strictly follow plan.md: each agent prompt references plan.md as Source of Truth
# ==========================================================

REPO_URL="https://github.com/brtstore4340-glitch/SMD-Project"
MODE_YOLO="false"
ROOT_DIR=""
TARGET_DIR="tools/agents"
LOG_DIR="tools/logs"

usage() {
  cat <<'USAGE'
Usage:
  ./create_5_ai_agents.sh [--repo <path>] [--yolo]

Options:
  --repo <path>   Path to local repo (default: current directory)
  --yolo          Allow overwrite existing agent files (still makes backups)
USAGE
}

log() {
  local msg="$1"
  echo "[$(date -Is)] $msg" | tee -a "$LOG_FILE" >/dev/null
}

die() {
  local msg="$1"
  log "[FATAL] $msg"
  exit 1
}

ensure_dir() {
  local d="$1"
  mkdir -p "$d"
}

backup_file_if_exists() {
  local f="$1"
  if [[ -f "$f" ]]; then
    cp -p "$f" "$BACKUP_DIR/$(basename "$f")"
    log "[INFO] Backup: $f -> $BACKUP_DIR/$(basename "$f")"
  fi
}

write_utf8() {
  # Bash writes UTF-8 by default; ensure no BOM by not using tools that add BOM.
  local path="$1"
  local content="$2"
  printf "%s" "$content" > "$path"
}

find_plan_md() {
  # Find plan.md in common places (case-insensitive)
  local found=""
  local candidates=(
    "plan.md"
    "PLAN.md"
    "docs/plan.md"
    "docs/PLAN.md"
    "Docs/plan.md"
    "Docs/PLAN.md"
  )

  for c in "${candidates[@]}"; do
    if [[ -f "$c" ]]; then
      found="$c"
      break
    fi
  done

  if [[ -z "$found" ]]; then
    # fallback: search
    found="$(find . -maxdepth 4 -type f \( -iname "plan.md" -o -iname "plan*.md" \) | head -n 1 || true)"
  fi

  if [[ -z "$found" ]]; then
    echo ""
  else
    # normalize to relative path (no leading ./)
    echo "${found#./}"
  fi
}

parse_args() {
  ROOT_DIR="$(pwd)"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --repo)
        shift
        [[ $# -gt 0 ]] || die "--repo requires a path"
        ROOT_DIR="$1"
        ;;
      --yolo)
        MODE_YOLO="true"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "Unknown arg: $1"
        ;;
    esac
    shift
  done
}

main() {
  parse_args "$@"

  [[ -d "$ROOT_DIR" ]] || die "Repo path not found: $ROOT_DIR"
  cd "$ROOT_DIR"

  # basic sanity: must look like a git repo
  [[ -d ".git" ]] || log "[WARN] .git not found (continuing) — ensure this is the SMD-Project repo: $REPO_URL"

  ensure_dir "tools"
  ensure_dir "$LOG_DIR"

  TS="$(date +%y%m%d_%H%M%S)"
  LOG_FILE="$LOG_DIR/create_5_ai_agents_${TS}.log"
  BACKUP_DIR="tools/backup_agents_${TS}"
  ensure_dir "$BACKUP_DIR"
  echo "$BACKUP_DIR" > tools/LAST_BACKUP_DIR.txt

  log "[INFO] RepoRoot: $(pwd)"
  log "[INFO] RepoURL: $REPO_URL"
  log "[INFO] BackupDir: $BACKUP_DIR"
  log "[INFO] ModeYOLO: $MODE_YOLO"

  PLAN_MD="$(find_plan_md)"
  [[ -n "$PLAN_MD" ]] || die "plan.md not found. Put your plan in plan.md or docs/plan.md then rerun."
  log "[OK] Found plan: $PLAN_MD"

  ensure_dir "$TARGET_DIR"

  # File list
  ORCH="$TARGET_DIR/ORCHESTRATOR.md"
  A1="$TARGET_DIR/AGENT_01_PLANNER.md"
  A2="$TARGET_DIR/AGENT_02_ARCHITECT.md"
  A3="$TARGET_DIR/AGENT_03_IMPLEMENTER.md"
  A4="$TARGET_DIR/AGENT_04_RUNNER.md"
  A5="$TARGET_DIR/AGENT_05_REVIEWER.md"
  INDEX="$TARGET_DIR/README.md"

  FILES=("$ORCH" "$A1" "$A2" "$A3" "$A4" "$A5" "$INDEX")

  # Backup existing
  for f in "${FILES[@]}"; do
    backup_file_if_exists "$f"
  done

  # Overwrite policy
  if [[ "$MODE_YOLO" != "true" ]]; then
    for f in "${FILES[@]}"; do
      if [[ -f "$f" ]]; then
        die "File exists (safe mode, no overwrite): $f  (rerun with --yolo to overwrite)"
      fi
    done
  fi

  # Shared strict rules snippet
  STRICT_RULES=$(cat <<EOF
SOURCE OF TRUTH (STRICT):
- You MUST follow: ${PLAN_MD}
- If plan.md is missing details, you MUST stop and request evidence from Runner. Do NOT invent.
- Any work must map to the plan.md sections: Goals, Scope, Non-Goals, Milestones, Tasks, DoD, Review Gates.

NON-NEGOTIABLE PROCESS (Calm Coder / Repeatable):
- PRD/Plan/Tasks are the only authority.
- Work in atomic tasks, one at a time.
- Every change must have evidence (commands + logs).
- Review gates must be explicit and enforced.

SAFETY:
- Do not delete or refactor unrelated code.
- Prefer minimal reversible patches.
- Require backups and logs for every run.
EOF
)

  # Orchestrator prompt
  ORCH_TXT=$(cat <<EOF
# ORCHESTRATOR — SMD-Project (5-Agent Team)

Repository: ${REPO_URL}
Local repo path: (this workspace)

${STRICT_RULES}

TEAM (5 agents):
1) Planner
2) Architect
3) Implementer
4) Runner
5) Reviewer

MISSION:
- Coordinate the 5 agents to execute plan.md strictly.
- Ensure calm-coder workflow runs in-repo (repeatable), with logs and backups.

WORKFLOW (must follow order):
Step 1) Runner collects evidence bundle (single message):
- package.json scripts
- repo tree depth 2
- key folders/files referenced by plan.md
- build/lint/test commands and outputs (if available)
Step 2) Planner translates plan.md into WBS + atomic tasks + DoD + stop criteria
Step 3) Architect defines file/module boundaries and conventions required by plan.md
Step 4) Implementer applies one atomic task at a time (small patch)
Step 5) Runner validates and captures logs/evidence
Step 6) Reviewer enforces review gates and decides PASS/NEEDS-FIX/BLOCKED
Repeat Steps 2–6 until milestones satisfied.

OUTPUT YOU MUST PRODUCE (as repo artifacts, aligned with plan.md):
- docs/PRD.md (if plan.md expects PRD, generate it from plan.md or request missing)
- docs/PLAN_EXECUTION.md (WBS + atomic tasks + owners + dependencies)
- docs/RUNBOOK.md (how to run/validate/review repeatably)
- tools/logs/* (all command evidence)
- tools/LAST_BACKUP_DIR.txt updated per run

Start by instructing Runner with exact commands to collect evidence in ONE bundled message.
EOF
)

  # Agent 01 Planner
  A1_TXT=$(cat <<EOF
# AGENT 01 — PLANNER (Strict plan.md)

${STRICT_RULES}

RESPONSIBILITIES:
- Convert plan.md into:
  - WBS (work breakdown)
  - Atomic task list (granular, 1 change set each)
  - DoD per task
  - Stage gates + stop criteria (reviewable)
- Identify evidence required before each task (commands/logs)

OUTPUT FORMAT:
- Update/produce docs/PLAN_EXECUTION.md with:
  - Milestone -> Tasks -> DoD -> Evidence -> Risks -> Owner
- Never invent details missing from plan.md; request Runner evidence instead.
EOF
)

  # Agent 02 Architect
  A2_TXT=$(cat <<EOF
# AGENT 02 — ARCHITECT (Strict plan.md)

${STRICT_RULES}

RESPONSIBILITIES:
- From plan.md, define:
  - Folder/module boundaries
  - Naming conventions
  - Dependency rules (what can import what)
  - Interfaces/contracts (types, service boundaries) required by plan.md
- Provide a minimal architecture proposal that enables repeatable delivery.

OUTPUT FORMAT:
- Update docs/ARCHITECTURE.md (create if missing) with:
  - Structure diagram (text)
  - Conventions
  - Contracts
  - Migration plan (if major change)
EOF
)

  # Agent 03 Implementer
  A3_TXT=$(cat <<EOF
# AGENT 03 — IMPLEMENTER (Strict plan.md)

${STRICT_RULES}

RESPONSIBILITIES:
- Implement ONE atomic task at a time from docs/PLAN_EXECUTION.md
- Keep patches small, reversible, and aligned with plan.md
- Never refactor unrelated code
- Require backup before edits and ensure logs are produced

OUTPUT FORMAT:
- Provide:
  - Patch summary (files changed + why, mapped to task id)
  - Commands Runner should execute to validate
EOF
)

  # Agent 04 Runner
  A4_TXT=$(cat <<EOF
# AGENT 04 — RUNNER (Evidence + Validation)

${STRICT_RULES}

RESPONSIBILITIES:
- Collect evidence BEFORE planning and BEFORE major edits:
  - package.json scripts
  - tree depth 2
  - key files referenced by plan.md
- Execute validations:
  - lint/build/test/dev as defined in package.json
- Save logs under tools/logs with deterministic names and include exit codes

OUTPUT FORMAT:
- ONE bundled evidence message:
  - Commands run
  - Key outputs (snippets)
  - Log file paths
EOF
)

  # Agent 05 Reviewer
  A5_TXT=$(cat <<EOF
# AGENT 05 — REVIEWER (Gates + Ship Decision)

${STRICT_RULES}

RESPONSIBILITIES:
- Enforce review gates defined in plan.md (or require Planner to define them)
- Verify:
  - Task DoD satisfied
  - Evidence present (logs/commands)
  - No scope creep beyond plan.md
- Decide: PASS / NEEDS-FIX / BLOCKED with exact file evidence

OUTPUT FORMAT:
- Review report:
  - Gate checklist
  - Findings with file paths
  - Decision + next atomic tasks
EOF
)

  INDEX_TXT=$(cat <<EOF
# SMD-Project — AI Agent Pack (5 Agents)

This folder contains prompts for a repeatable Calm Coder workflow.

Files:
- ORCHESTRATOR.md
- AGENT_01_PLANNER.md
- AGENT_02_ARCHITECT.md
- AGENT_03_IMPLEMENTER.md
- AGENT_04_RUNNER.md
- AGENT_05_REVIEWER.md

Source of Truth:
- ${PLAN_MD}

Safety:
- Default script mode avoids overwriting existing agent files unless --yolo was used.
EOF
)

  write_utf8 "$ORCH" "$ORCH_TXT"
  write_utf8 "$A1" "$A1_TXT"
  write_utf8 "$A2" "$A2_TXT"
  write_utf8 "$A3" "$A3_TXT"
  write_utf8 "$A4" "$A4_TXT"
  write_utf8 "$A5" "$A5_TXT"
  write_utf8 "$INDEX" "$INDEX_TXT"

  log "[OK] Created/updated agent prompts in: $TARGET_DIR"
  log "[OK] Wrote tools/LAST_BACKUP_DIR.txt"
  log "[SUMMARY] ExitCode=0"
  echo "DONE: $TARGET_DIR (plan: $PLAN_MD) | log: $LOG_FILE"
}

main "$@"
