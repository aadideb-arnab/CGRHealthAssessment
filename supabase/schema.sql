-- Run once in Supabase Dashboard > SQL Editor.
-- Private storage for the Staff Health Programme. Only logged-in users listed in app_users can read/write.

create table if not exists public.app_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  note    text
);
alter table public.app_users enable row level security;   -- no policies = invisible to the browser

create or replace function public.is_member() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.app_users where user_id = auth.uid());
$$;
revoke all on function public.is_member() from public, anon;
grant execute on function public.is_member() to authenticated;

create or replace function public.touch_updated_at() returns trigger language plpgsql as $$
begin new.updated_at = now(); new.updated_by = auth.uid(); return new; end $$;

do $$
declare t text;
begin
  foreach t in array array['staff_employees','staff_assessments','staff_exposures','staff_referrals','staff_wellness','staff_settings'] loop
    execute format('create table if not exists public.%I (
        id text primary key,
        data jsonb not null,
        updated_at timestamptz not null default now(),
        updated_by uuid default auth.uid())', t);
    execute format('alter table public.%I enable row level security', t);
    execute format('revoke all on public.%I from anon', t);
    execute format('drop policy if exists members_all on public.%I', t);
    execute format('create policy members_all on public.%I for all to authenticated using (public.is_member()) with check (public.is_member())', t);
    execute format('drop trigger if exists trg_touch on public.%I', t);
    execute format('create trigger trg_touch before insert or update on public.%I for each row execute function public.touch_updated_at()', t);
  end loop;
end $$;

-- After creating your user in Authentication > Users, authorise them (replace the email):
-- insert into public.app_users (user_id, note)
-- select id, 'Nodal officer' from auth.users where email = 'you@example.com';
