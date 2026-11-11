-- ActionGames admin database setup
-- Run this in Supabase Dashboard → SQL Editor.
-- Change admin@example.com below to the exact email used for the admin Auth user.

create table if not exists public.games (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  genre text,
  platform text,
  description text,
  symbol text,
  colors text,
  download_url text,
  download_label text,
  created_at timestamptz not null default now()
);

create table if not exists public.articles (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  game text,
  author text,
  excerpt text,
  body text,
  published_at date not null default current_date,
  created_at timestamptz not null default now()
);

alter table public.games enable row level security;
alter table public.articles enable row level security;

-- Public can read published site content. Only the specified signed-in admin can change it.
drop policy if exists "Public can read games" on public.games;
create policy "Public can read games" on public.games for select to anon, authenticated using (true);
drop policy if exists "Admin manages games" on public.games;
create policy "Admin manages games" on public.games for all to authenticated
  using ((auth.jwt() ->> 'email') = 'admin@example.com')
  with check ((auth.jwt() ->> 'email') = 'admin@example.com');

drop policy if exists "Public can read articles" on public.articles;
create policy "Public can read articles" on public.articles for select to anon, authenticated using (true);
drop policy if exists "Admin manages articles" on public.articles;
create policy "Admin manages articles" on public.articles for all to authenticated
  using ((auth.jwt() ->> 'email') = 'admin@example.com')
  with check ((auth.jwt() ->> 'email') = 'admin@example.com');
