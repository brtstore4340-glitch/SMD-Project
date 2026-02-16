# tasks/lessons.md — Self-Improvement Loop (rules to prevent repeat mistakes)

## How to use (mandatory)
After ANY correction from the user:
1) Write what went wrong (short, factual)
2) Add a rule that prevents the same mistake
3) Add a quick check to run before finalizing
4) Keep iterating until mistake rate drops

---

## Baseline Rules (always on)

### 1) Plan Mode Default
- Rule: Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions).
- Check: If task spans multiple files or changes architecture, write plan checklist first.

### 2) Stop & Re-plan if Sideways
- Rule: If assumptions break or errors multiply, STOP and re-plan immediately.
- Check: After first unexpected failure, update plan before continuing.

### 3) Verification Before Done
- Rule: Never mark complete without proof (tests/logs/diff).
- Check: DoD must link evidence paths; no evidence means task stays incomplete.

### 4) Subagent Strategy
- Rule: Use subagents liberally; ONE task per subagent; keep main context clean.
- Check: If problem is complex, split into Planner/Coder/Tester/Reviewer jobs.

### 5) Demand Elegance (Balanced)
- Rule: For non-trivial work, challenge hacky fixes and implement elegant solution.
- Check: If fix feels hacky, redesign; skip this for simple/obvious fixes.

### 6) Autonomous Bug Fixing
- Rule: Bug report → identify evidence (error/log/test) → fix → verify → close with proof.
- Check: Always cite the failing line/test and show it is resolved.

### 7) Minimal Impact / Simplicity First
- Rule: Touch only what’s necessary; avoid unrelated refactors.
- Check: List changed files and justify each.

### 8) No Laziness (Root Cause)
- Rule: Fix root cause, not symptoms. Temporary workaround must be clearly labeled.
- Check: Write “why it failed” + “why this fix is correct”.

---

## Corrections Log (append-only)
- YYYY-MM-DD: <mistake> → <new rule/check added> → <impact>

