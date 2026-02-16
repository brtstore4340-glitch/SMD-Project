# SMD-Project — Plan

## Context
- Repo: SMD-Project
- Goal: 🎯 Build a minimal, evidence-driven MVP that (1) ingests Excel/CSV at scale, (2) scrapes/API-collects priority sites with selective real-time capture, and (3) reports on 50k+ SKUs with role-based visibility.
- Constraints:
  - 🎯 Evidence required before marking done (logs/tests/diff)
  - 🎯 One task at a time; no scope creep
  - 🏗️ Zero-budget stack: Firebase Hosting or GitHub Pages (FE), Supabase free tier (DB/Auth), limited job automation
  - 👉 APIs preferred; scraping (incl. headless) only for critical sources; Gmail OAuth with multi-account mapping for non-admin roles
  - ✅ Minimal-impact changes; avoid refactors unless explicitly in plan

## Stage Gates
1) Scan
2) Plan
3) Patch
4) Validate
5) Report

## Evidence Rules (Non-Negotiable)
- Every completed task must include:
  - Commands executed (exact)
  - Output logs path(s)
  - Pass/fail statement
- Never mark complete without proof (tests/logs/diff).

## Output Contract (Hard)
- Every response MUST be one of:
  A) TASK-CLOSED (DoD met + evidence linked + moved Provision→Done + suggest next task)
  B) BLOCKED (explicit missing evidence + single next step to unblock)
- Do NOT output environment recaps or filler.

## Forbidden Filler
- Never say: "Based on the environment..." / "read skill and plan.md"
- Never state OS/platform facts (e.g., "The current operating system is Windows.") unless it changes a technical decision.
- If OS matters, use it implicitly (e.g., provide PowerShell steps) without announcing it.

## Provision (Backlog Queue)
> Pull exactly one task into Active. Prioritize P0, then unblock/risk-reduction items.

### P0 (Must)
- [ ] P0-02: Define build/test/lint commands + logging convention (tools/logs)
- [ ] P0-03: File ingestion MVP — Supabase schema + column/type validation + rejection logging (Excel/CSV, 100s→100k+ rows)
- [ ] P0-04: Scraping strategy — target list (e-commerce/marketplace/supplier/real-time), API-first matrix, headless plan for JS-heavy sites, Gmail OAuth mapping
- [ ] P0-05: Real-time scraping pilot for one critical source; document free-tier limits and fallback batching
- [ ] P0-06: Reporting baseline — metrics (revenue, units, avg price, inventory/margin opt.) with grouping (brand/category/supplier/channel/time) + Excel export path

### P1 (Should)
- [ ] P1-01: Batch admin flows — multi-file uploads, period batches (daily/weekly/monthly), reprocess/rollback, status tracking (success/failed/partial)
- [ ] P1-02: Role-based access control (Admin/Manager/Analyst/Staff) with brand/channel/scope filters; one Gmail → multiple non-admin accounts
- [ ] P1-03: Performance budget for 50k+ SKUs — index plan, query patterns, reporting pagination
- [ ] P1-04: Monitoring/logs — full batch logging + real-time scrape telemetry in Supabase

### P2 (Could)
- [ ] P2-01: PDF export for reports (future phase placeholder)
- [ ] P2-02: Troubleshooting/playbook for scrape failures, auth issues, and ingestion rejects
- [ ] P2-03: CI parity plan (local vs GitHub Actions) within free-tier limits

## Active (Only One)
> Exactly one active task at a time.

- In progress: P0-02 — Define build/test/lint commands + logging convention (task_20260216_002)

## Done (Completed with Evidence)
> Move items here only after validation. Each item must include evidence references.

- [x] P0-01 — Repo scan + baseline evidence (task_20260216_001) — Evidence: `tools/logs/scan_25690216_122745.log`

## Orchestrator Output Template (Every Task Dispatch)
- Context: repo + goal + constraints
- Stage: Scan / Plan / Patch / Validate / Report
- Task: one clear task only
- Evidence required: what logs/tests must exist
- Definition of Done: what must pass to finish

## Completion Protocol
When a task completes:
1) Add evidence in the task report (or link in Done)
2) Move task from Provision -> Done, mark [x]
3) Suggest exactly one next task from Provision using the output template
