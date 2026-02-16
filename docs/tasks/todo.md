# tasks/todo.md — Project Board (Provision / Active / Done)

## Workflow: Calm Coder (flow) + Orchestration (guardrails)
- Calm Coder = **PRD clear → do one task → review**
- Orchestration = **plan mode → verify → evidence → lessons → minimal impact**

## Guardrails (always)
- Plan Mode Default for non-trivial tasks
- STOP & re-plan if sideways
- Verification Before Done (no evidence = not done)
- One task at a time (Active only ONE)
- Minimal Impact / Simplicity First
- No Laziness (root cause)
- Self-Improvement Loop (update `tasks/lessons.md` after corrections)
- Demand Elegance only for non-trivial changes

---

## Next Task Selection Rules (deterministic)
1) Unblock dependencies first
2) Reduce risk next (validation pipeline/tests/CI)
3) If equal: small/clear quick win
4) If prioritized with P0/P1/P2: pull P0 first

---

## Provision (Backlog)
> Keep this list prioritized. Orchestrator pulls ONE next task only.

- [ ] P0-02: Define build/test/lint commands + logging convention (tools/logs)
- [ ] P0-03: File ingestion MVP — Supabase schema + column/type validation + rejection logging (Excel/CSV, 100s→100k+ rows)
- [ ] P0-04: Scraping strategy — target list (e-commerce/marketplace/supplier/real-time), API-first matrix, headless plan for JS-heavy sites, Gmail OAuth mapping
- [ ] P0-05: Real-time scraping pilot for one critical source; document free-tier limits and fallback batching
- [ ] P0-06: Reporting baseline — metrics (revenue, units, avg price, inventory/margin opt.) with grouping (brand/category/supplier/channel/time) + Excel export path
- [ ] P1-01: Batch admin flows — multi-file uploads, period batches, reprocess/rollback, status tracking (success/failed/partial)
- [ ] P1-02: Role-based access control (Admin/Manager/Analyst/Staff) with brand/channel/scope filters; one Gmail → multiple non-admin accounts
- [ ] P1-03: Performance budget for 50k+ SKUs — index plan, query patterns, reporting pagination
- [ ] P1-04: Monitoring/logs — full batch logging + real-time scrape telemetry in Supabase
- [ ] P2-01: PDF export for reports (future)
- [ ] P2-02: Troubleshooting/playbook for scrape failures, auth issues, and ingestion rejects
- [ ] P2-03: CI parity plan (local vs GitHub Actions) within free-tier limits

---

## Active (ONLY ONE)
- In progress: P0-02 — Define build/test/lint commands + logging convention
  - Task ID: task_20260216_002
  - Stage: Scan → Plan
  - Evidence required: command list and sample outputs saved to `tools/logs/validate_<timestamp>.log`
  - Definition of Done: Commands documented; sample run log captured; paths recorded

---

## Done (must include evidence link)
- [x] Workflow docs bootstrap — Evidence: `tools/logs/init_workflow_docs_<timestamp>.log`
- [x] P0-01 Repo scan + baseline evidence — Evidence: `tools/logs/scan_25690216_122745.log`

---

## Suggest Next Task (format)
Context: <repo + goal + constraints>  
Stage: Scan / Plan / Patch / Validate / Report  
Task: <one clear task>  
Evidence required: <log/test/diff>  
Definition of Done: <pass criteria>  

