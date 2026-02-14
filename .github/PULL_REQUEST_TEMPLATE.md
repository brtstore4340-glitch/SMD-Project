# Pull Request Template

## Task ID: [e.g. 001]

## Summary
Briefly describe the changes.

## SDE Gates Checklist (Mandatory)
- [ ] **Derived Purity**: No IO (fetch/supabase) in derived variables or `useMemo`.
- [ ] **Effect Boundary**: No direct `supabase` calls in UI components (only via `src/services`).
- [ ] **Loop Safety**: All `useEffect` hooks have dependency arrays and cleanup/abort logic if async.

## Evidence (Verifier A3)
- [ ] Build passes (`npm run build`).
- [ ] Lint passes (`npm run lint`).
- [ ] Hotspot Scan Results attached.

## Type of Change
- [ ] Refactor (No logic change)
- [ ] Feature (New capability)
- [ ] Fix (Bug repair)
- [ ] Chore (Docs/Setup)
