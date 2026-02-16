# PR Checklist — Calm Coder (00orchestrator)

## Summary
- [ ] Purpose of change (link issue/task):
- [ ] Scope of slice (what changed, what did NOT):

## Evidence
- [ ] Logs attached (paths):
  - Scan: tools/logs/scan-*.log
  - Validate: tools/logs/validate-*.log
  - Other: 
- [ ] Backup path recorded in tools/LAST_BACKUP_DIR.txt

## Gates (must all PASS)
- [ ] Derived Purity Gate — no IO/state writes inside selectors/derived. Evidence: scan result/code refs.
- [ ] Effect Boundary Gate — UI/components free of Supabase/IO; all IO in `src/services/` or guarded effects.
- [ ] Loop Safety Gate — effects that set state are idempotent + guarded (compare-before-set / abort / request key).

## Security / Supabase
- [ ] No secrets committed; env vars only (`VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`).
- [ ] Supabase access only via `src/services/supabase.ts` (or service wrappers).
- [ ] Contracts documented in RUNBOOK/TASKS if updated.

## Validation
- [ ] `npm run lint`
- [ ] `npm run build`
- [ ] Smoke checklist run (note what you exercised):

## Notes / Risks
- Residual risks:
- Follow-up tasks:
