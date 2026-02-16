# tasks/evidence/README.md — Evidence Rules & Storage

## Purpose
Evidence makes “done” deterministic:
- Proves correctness (not vibes)
- Enables rollback/audit
- Prevents regressions and repeat mistakes

## What counts as evidence
At least one of:
- Test output (local/CI)
- Log file showing pass/fail with timestamps
- Diff summary / commit hash
- Screenshot or exported artifact

## Where to store
- Logs: `tools/logs/<topic>_<yyyymmdd_hhmmss>.log`
- Artifacts: `tasks/evidence/<taskId>_<artifact>.<ext>`

## Required metadata per Done task
In `tasks/todo.md` Done entry or task file:
- Evidence path(s)
- DoD checkmarks satisfied
- Before vs after behavior notes (when relevant)

## Minimal standard checklist
- [ ] Verification steps are reproducible
- [ ] Evidence stored in correct folder
- [ ] Task moved to Done only after evidence exists
- [ ] Lessons updated if user corrected anything

