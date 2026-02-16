# Task.md — Task Template (copy to tasks/task_<id>.md)

## Header
- Task ID: task_<YYYYMMDD>_<NNN>
- Title: <short>
- Owner: Orchestrator / Planner / Coder / Tester / Reviewer
- Stage: Scan / Plan / Patch / Validate / Report
- Priority: P0 / P1 / P2
- Depends on: <task ids or "none">

## Context
- Why this matters: 🎯 Deliver MVP that ingests Excel/CSV at scale, scrapes/API-collects priority sites (selective real-time), and reports on 50k+ SKUs with role-aware visibility.
- Constraints:
  - Simplicity First / Minimal Impact
  - No Laziness (root cause)
  - Verification Before Done (evidence required)
  - Self-Improvement Loop (update lessons after corrections)
  - 🏗️ Zero-budget stack: Firebase Hosting/GitHub Pages + Supabase free tier (DB/Auth), limited jobs
  - 👉 APIs preferred; headless scraping only for critical dynamic sources; Gmail OAuth with multi-account mapping for non-admin roles

## Plan (Checklist)
- [ ] Step 1:
- [ ] Step 2:
- [ ] Step 3:

## Patch Summary
- Files changed:
- What changed (high-level):
- Why (root cause):

## Verification (Reproducible)
Commands run:
- `<command 1>`
- `<command 2>`

Results:
- ExitCodes:
- Notes:

## Evidence (Required)
- Logs: `tools/logs/<...>.log`
- Diff/Commit: `<hash>` or file list
- Artifacts/Screens: `tasks/evidence/<...>`

## Definition of Done (DoD)
- [ ] Acceptance criteria met
- [ ] Verification passed (tests/logs)
- [ ] Evidence linked
- [ ] Minimal impact confirmed (only necessary files touched)
- [ ] Lessons updated (if user corrected anything)

## Report (Final)
- Summary:
- Proof it works:
- Risks/edge cases:
- Next suggested task (5-line format):
  - Context:
  - Stage:
  - Task:
  - Evidence required:
  - Definition of Done:
