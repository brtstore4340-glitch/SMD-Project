# Calm Coder Runbook

## Workflow Steps

### 1. START
- Orchestrator selects next task from `docs/TASKS.md`.
- Assigns to appropriate Agent (A1/A2/A4).

### 2. EXECUTE (A2/A4)
- **Backup**: Run `cp -r src src_backup_<timestamp>`.
- **Implement**: Write code.
    - *Constraint*: Follow PRD SDE logic.
- **Verify Local**: Run lint/build.

### 3. VALIDATE (A3)
- **Evidence Collection**:
    - Run `tools/scan_hotspots.ps1` (if exists) or manual grep.
    - Check for forbidden imports in UI (`supabase-js` direct usage).
    - Check for IO in derived selectors.
- **Log**: Save output to `tools/logs/task_<id>_evidence.log`.

### 4. REVIEW (Orchestrator)
- Check `tools/logs`.
- Check diffs against "Gates".
- **PASS**: Mark Task DONE.
- **FAIL**: Revert or Fix.

## Disaster Recovery
- If build fails or critical bug:
- Run: `Copy-Item -Recurse -Force src_backup_<timestamp> src`
- Log incident in `docs/INCIDENTS.md`.

## Hotspot Scans (Manual)
**Derived Purity Check**:
```powershell
grep -r "fetch" src/selectors
grep -r "supabase" src/selectors
```

**Effect Boundary Check**:
```powershell
grep -r "supabase.from" src/components
```
