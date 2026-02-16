# SMD-Project — PRD

## Problem Statement
Development changes can drift in scope and break reproducibility without a strict plan/evidence workflow.

## Goals
- Deliver changes in small increments with clear stage gates
- Require evidence for every completed task
- Keep repo maintainable with minimal-impact patches

## Non-Goals
- Large refactors not explicitly planned
- Changing architecture without explicit PRD update
- “It seems to work” completions without proof

## Users
- Maintainers and contributors working on SMD-Project
- AI agents operating under Orchestrator

## Success Metrics
- Every task completion includes logs/tests/diff evidence
- Reduced rework caused by ambiguous scope or missing validation
- Faster onboarding via Runbook + repeatable validation

## Constraints
- One active task at a time
- Evidence required before done
- Prefer deterministic, repeatable commands

## Requirements
1) Standard workflow: Scan -> Plan -> Patch -> Validate -> Report
2) Plan.md must track Provision/Active/Done
3) Runbook.md must provide exact commands for setup and validation
4) Task.md must capture per-task execution and evidence
5) Agent.md defines roles and rules to prevent drift

## Acceptance Criteria (Project-Level)
- Repo contains Plan.md, PRD.md, Runbook.md, Task.md, Agent.md
- Plan.md includes Provision/Active/Done sections
- Orchestrator always dispatches tasks using the standard template
- Completed tasks always reference evidence (logs/tests)

## Risks
- Over-process can slow progress: mitigate by keeping tasks small
- Missing evidence discipline: mitigate via Reviewer blocking completion
