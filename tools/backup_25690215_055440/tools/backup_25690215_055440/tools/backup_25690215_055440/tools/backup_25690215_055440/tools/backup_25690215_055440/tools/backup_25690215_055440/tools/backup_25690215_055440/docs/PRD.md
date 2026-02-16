# Project Requirements Document (PRD)

**Project**: Calm Coder Implementation - POS System Integration
**Date**: 2026-02-15
**Status**: Draft

## 1. Goal
Refactor and extend the existing `free-react-tailwind-admin-dashboard-main` to serve as a robust, Supabase-backed Point of Sale (POS) and Admin system.
**Key Objective**: Reduce failure by enforcing strict architecture gates (SDE: State/Derived/Effect).

## 2. Architecture Principles (Svelte 5 Runes Logic)
To ensure stability and debuggability, we enforce "Svelte 5 Runes" logic patterns, even in React:

1.  **STATE (Mutable Source of Truth)**
    -   Minimal.
    -   React: `useState`, Context Providers.
    -   *Rule*: Only update via specific actions/setters.
2.  **DERIVED (Pure Computed)**
    -   Pure functions of State.
    -   React: `useMemo`, variables in render.
    -   *Rule*: **ZERO IO**. No `fetch`, no `supabase`, no `localStorage`, no `Date.now()` (unless passed as arg).
3.  **EFFECT (Side Effects)**
    -   IO, Mutations, Subscriptions.
    -   React: `useEffect`, Event Handlers.
    -   *Rule*: Must contain all async logic. Must be guarded (abort controllers, flags).

## 3. Scope
-   **Phase 1: Foundation**: Setup Calm Coder workflow, Tools, and Supabase Client Wrapper.
-   **Phase 2: Auth**: Replace mock auth with Supabase Auth.
-   **Phase 3: Data**: Connect "Products" and "Orders" to Supabase tables (replacing JSON mocks).

## 4. Technical Constraints
-   **Frontend**: React + Vite + TypeScript + Tailwind (Existing).
-   **Backend**: Supabase (Auth, Postgres, Realtime).
-   **Security**: RLS enabled on all tables. No direct DB access from UI components (use Service Layer).

## 5. Success Metrics
-   **Derived Purity**: 0 violations in scan.
-   **Effect Boundary**: 0 direct `supabase.from` calls in UI components.
-   **Loop Safety**: All `useEffect` with state writes have abort/cleanup.
