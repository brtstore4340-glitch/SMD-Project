# Project Plan (WBS)

## Stage 0: Setup (Current)
- [x] S0.1: Scan Repository & Collect Evidence (A3).
- [x] S0.2: Define Standard Pack & Agents (A1).
- [ ] S0.3: Create Service Layer Structure (A1).
- [ ] S0.4: Initialize Supabase Client (A4).

## Stage 1: Auth Migration
- [ ] S1.1: Create `AuthService` (Effect Layer) (A4).
- [ ] S1.2: Refactor `SignIn` / `SignUp` forms to use `AuthService` (A2).
- [ ] S1.3: Update `AuthContext` (State Layer) to sync with Supabase Auth (A2).
- [ ] S1.4: Validate Auth Flows (A3).

## Stage 2: Data Integration (Products/Dashboard)
- [ ] S2.1: Define Database Schema (Products, Sales) (A4).
- [ ] S2.2: Create `DataService` for fetching/mutating data (A4).
- [ ] S2.3: Refactor `Dashboard/Home` to use `DataService` (A2).
- [ ] S2.4: Validate Data Loading & Error States (A3).

## Stage 3: Hardening
- [ ] S3.1: Full Hotspot Scan (A3).
- [ ] S3.2: Security Review (RLS Policies) (A4).

## GATES & STOP CRITERIA
1.  **Derived Purity Gate**: Fails if any derived logic contains IO.
2.  **Effect Boundary Gate**: Fails if UI imports `supabase` directly (must import from `@/services`).
3.  **Loop Safety Gate**: Fails if `useEffect` writes state without dependency guards.
