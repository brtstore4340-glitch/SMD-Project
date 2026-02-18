-- Auth + Profile + Role schema for multi-profile per email
-- Requires pgcrypto for PIN hashing
create extension if not exists pgcrypto;

-- Profiles owned by a single auth user (one email can own multiple profiles)
create table if not exists public.user_profiles (
  id uuid primary key default gen_random_uuid(),
  owner_auth_user_id uuid not null references auth.users(id) on delete cascade,
  user_id char(7) not null,
  pin_hash text not null,
  display_name text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint user_profiles_user_id_format check (user_id ~ '^[0-9]{7}$')
);

create unique index if not exists user_profiles_owner_user_id_idx
  on public.user_profiles(owner_auth_user_id, user_id);

-- Roles
create table if not exists public.roles (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  description text
);

create table if not exists public.profile_roles (
  profile_id uuid not null references public.user_profiles(id) on delete cascade,
  role_id uuid not null references public.roles(id) on delete cascade,
  assigned_at timestamptz not null default now(),
  primary key (profile_id, role_id)
);

-- Update updated_at on profiles
create or replace function public.set_profile_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trg_user_profiles_updated_at
before update on public.user_profiles
for each row execute function public.set_profile_updated_at();

-- Verify PIN for a profile owned by current auth user
create or replace function public.verify_profile_pin(p_user_id text, p_pin text)
returns uuid
language plpgsql
security definer
as $$
declare
  v_profile_id uuid;
begin
  select id into v_profile_id
  from public.user_profiles
  where owner_auth_user_id = auth.uid()
    and user_id = p_user_id
    and pin_hash = crypt(p_pin, pin_hash);

  return v_profile_id;
end;
$$;

-- RLS
alter table public.user_profiles enable row level security;
alter table public.profile_roles enable row level security;
alter table public.roles enable row level security;

-- Profiles: owners only
create policy if not exists user_profiles_select_own
  on public.user_profiles
  for select
  using (owner_auth_user_id = auth.uid());

create policy if not exists user_profiles_insert_own
  on public.user_profiles
  for insert
  with check (owner_auth_user_id = auth.uid());

create policy if not exists user_profiles_update_own
  on public.user_profiles
  for update
  using (owner_auth_user_id = auth.uid());

-- Roles: read-only to authenticated users
create policy if not exists roles_select_authenticated
  on public.roles
  for select
  to authenticated
  using (true);

-- Profile roles: owners only
create policy if not exists profile_roles_select_own
  on public.profile_roles
  for select
  using (
    exists (
      select 1
      from public.user_profiles up
      where up.id = profile_roles.profile_id
        and up.owner_auth_user_id = auth.uid()
    )
  );

create policy if not exists profile_roles_insert_own
  on public.profile_roles
  for insert
  with check (
    exists (
      select 1
      from public.user_profiles up
      where up.id = profile_roles.profile_id
        and up.owner_auth_user_id = auth.uid()
    )
  );

create policy if not exists profile_roles_delete_own
  on public.profile_roles
  for delete
  using (
    exists (
      select 1
      from public.user_profiles up
      where up.id = profile_roles.profile_id
        and up.owner_auth_user_id = auth.uid()
    )
  );