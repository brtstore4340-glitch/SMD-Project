# Atomic Tasks

| ID | Title | Agent | Status | DoD (Definition of Done) |
|----|-------|-------|--------|--------------------------|
| **001** | **Scaffold Service Layer** | A1 | **To Do** | Create `src/services/` and `src/state/`. Define types for Supabase Client. |
| **002** | **Init Supabase Client** | A4 | **Done** | Create `src/services/supabase.ts`. Ensure singleton instance. Environment variables config. |
| **003** | **Create AuthService** | A4 | **Done** | Implement `signIn`, `signUp`, `signOut` in `src/services/auth.ts`. **NO UI CODE**. |
| **004** | **Connect Auth UI** | A2 | **To Do** | Update `SignIn.tsx` to call `AuthService`. Remove mock logic. |
| **005** | **Verify Auth Flow** | A3 | **To Do** | Log evidence of successful login and session persistence. |

## Status Legend
- **To Do**: Ready for assignment.
- **In Progress**: Agent currently working.
- **Review**: Evidence submitted, waiting for Orchestrator.
- **Done**: Verified and Merged.
