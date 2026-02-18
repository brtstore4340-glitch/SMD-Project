# Supabase Backend Setup

This project uses Supabase Auth. Apply the migration in `supabase/migrations/20260218_000001_auth_profiles.sql` to create profile/role tables and PIN verification.

## What it creates
- `user_profiles`: multiple profiles per email (auth user), with 7-digit `user_id` and hashed PIN.
- `roles` and `profile_roles`: multi-role support per profile.
- `verify_profile_pin(user_id, pin)`: server-side PIN verification for the profile owned by the current auth user.
- RLS policies to restrict access to the owning auth user.

## Apply
1) Open Supabase SQL editor
2) Run the migration SQL

## Notes
- PIN is stored hashed using `pgcrypto` and `crypt()`.
- The frontend should call the RPC `verify_profile_pin` after login to confirm profile selection.