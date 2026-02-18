# Runbook.md — How this project is run (Deterministic + Evidence-based)

## 0) Rule of the game (always)
- **Plan Mode Default**: enter plan mode for ANY non-trivial task (3+ steps or architectural decisions).
- If something goes sideways: **STOP and re-plan immediately** (don’t keep pushing).
- Use plan mode for **verification steps**, not just building.
- Write detailed specs upfront to reduce ambiguity.
- **Subagent Strategy**: use subagents liberally to keep main context clean; one task per subagent.
- **Verification Before Done**: never mark complete without proof (tests/logs/diff).
- **Demand Elegance (Balanced)**: for non-trivial changes, ask “is there a more elegant way?” Avoid hacky fixes. Skip for simple obvious fixes.
- **Autonomous Bug Fixing**: bug report → find evidence → fix → verify. No hand-holding.
- **Self-Improvement Loop**: after ANY correction from the user, update `tasks/lessons.md`.
- **Core Principles**: Simplicity First, No Laziness (root cause), Minimal Impact.

---

## 1) Daily Start Checklist (Review before doing work)
1) Read `Plan.md` (context / constraints / stage gates)
2) Read `PRD.md` (latest spec)
3) Read `tasks/todo.md` (Provision/Active/Done)
4) Read `tasks/lessons.md` (rules to prevent repeat mistakes)
5) Confirm current **Stage**: Scan / Plan / Patch / Validate / Report

---

## 2) Standard Execution Flow (Calm Coder + Guardrails)
**Calm Coder = main flow**  
**Workflow Orchestration = guardrails**

1) **PRD/Spec first** (`PRD.md`) — make requirements explicit, reduce guessing.
2) **Plan checklist** in `tasks/todo.md` (and/or a task file from `Task.md` template).
3) Execute **ONE task only** (Active must be single).
4) **Capture evidence** (required):
   - Logs: `tools/logs/*`
   - Test output / command output
   - Diff summary / commit hash / file list
   - Artifacts/screens: `tasks/evidence/*`
5) **Report** what changed + what proves it works.
6) **Lessons**: if user corrected anything, append to `tasks/lessons.md`.

---

## 3) Evidence Standards (Required for Done)
Each Done item must include:
- Evidence path(s) (logs/tests/diff)
- Definition of Done satisfied
- Before vs after behavior notes when relevant

Naming guidance:
- `tools/logs/<topic>_<yyyymmdd_hhmmss>.log`
- `tasks/evidence/<taskId>_<artifact>.<ext>`

### Canonical build/test/lint commands (capture output with `Tee-Object`)
- Lint: `npm run lint 2>&1 | Tee-Object -FilePath tools/logs/validate_<timestamp>.log`
- Build: `npm run build 2>&1 | Tee-Object -FilePath tools/logs/validate_<timestamp>.log -Append`
- Tests: _none defined yet; add when test suite exists._
- Timestamp format: `yyyyMMdd_HHmmss` (matches prior evidence files, e.g., `validate_25690216_200930.log`).

---

## 4) Safe Operations Policy (Autonomy with a single guardrail)
No “allow” needed for:
- Normal code/doc changes per plan
- Adding files for tasks/evidence/logs
- Refactors only when explicitly necessary and minimal-impact

**STOP and warn before**:
- Mass deletion / irreversible cleanup
- Reset DB / rotate keys / infra changes
- Large rewrites / architecture flips

---

## 5) Deterministic “Task Close” Rule (Self-driving)
When agent finishes the Active task:
1) Update results + evidence **first** (per DoD)
2) Move task from **Provision → Done** and mark `[x]` + link evidence
3) From remaining Provision, choose **ONE next task** by rules (Section 6)
4) Suggest next task using 5-line format:

Context: <repo + goal + constraints>  
Stage: Scan / Plan / Patch / Validate / Report  
Task: <one clear task>  
Evidence required: <log/test/diff>  
Definition of Done: <pass criteria>  

---

## 6) Next Task Selection Rules (avoid randomness)
1) Pick tasks that **unblock other work** (highest dependency leverage)
2) Then tasks that **reduce risk** (e.g., validation pipeline, tests, CI)
3) If risk equal: pick **small/clear quick wins**
4) If Provision is prioritized with P0/P1/P2, always pull **P0 first**

---

## 7) Subagent Roles (Operational)
- **Orchestrator**: controls flow, stage gates, assigns tasks, enforces evidence and lessons.
- **Planner**: designs + breaks down, updates PRD and todo board.
- **Coder**: minimal-impact patching, no unrelated refactors.
- **Tester/Runner**: runs commands, collects logs/evidence, summarizes pass/fail.
- **Reviewer**: staff-level review, edge cases, approves-ready checklist, triggers lessons update.
