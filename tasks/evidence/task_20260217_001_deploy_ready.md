# Deploy-Ready Evidence — task_20260217_001

## What changed
- Added Vercel SPA rewrite config for react-router refreshes (`vercel.json`).
- Added fail-fast Supabase env validation in `src/services/supabase.ts`.
- Documented required Vite env vars in `README.md`.
- Added Auth Requirements Lock section and deploy-prep task tracking in `docs/PLAN.md` and `docs/tasks/todo.md`.

## Commands run
- npm ci
- npm run build

## Evidence paths
- tools/logs/deploy_prep_25690217_165905.log

## Ready for Vercel checklist
- [x] Build output is `dist` (Vite) and Vercel config set.
- [x] SPA rewrite present to avoid 404 on refresh.
- [x] Supabase env vars required and fail fast if missing.
- [x] `.env.local` is gitignored.
- [x] Auth Requirements Lock preserved (email+password only; session persistence requirement unchanged; multi-profile per email; profile PIN/user ID step; multi-role).

## Local route refresh check strategy
- Run `npm run dev`, visit a nested route (e.g., `/sales`), then hard refresh in the browser.
- For Vercel, confirm the rewrite routes any path to `/index.html`.