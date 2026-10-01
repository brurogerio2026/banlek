-- Execute este arquivo no SQL Editor do Supabase.
create table if not exists public.photos (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Retratos',
  image_url text not null,
  featured boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  name text unique not null
);
create table if not exists public.site_settings (
  id integer primary key check (id = 1),
  name text not null default 'Bruno Emiliano',
  tagline text not null default 'Fotografia que conta histórias.',
  about text not null default '',
  instagram text not null default '',
  whatsapp text not null default '',
  email text not null default ''
);
insert into public.site_settings (id) values (1) on conflict (id) do nothing;
insert into public.categories(name) values ('Eventos'),('Retratos'),('Natureza') on conflict (name) do nothing;

alter table public.photos enable row level security;
alter table public.categories enable row level security;
alter table public.site_settings enable row level security;

-- Leitura pública; alterações exigem usuário autenticado.
create policy "Public can read photos" on public.photos for select using (true);
create policy "Authenticated manage photos" on public.photos for all to authenticated using (true) with check (true);
create policy "Public can read categories" on public.categories for select using (true);
create policy "Authenticated manage categories" on public.categories for all to authenticated using (true) with check (true);
create policy "Public can read settings" on public.site_settings for select using (true);
create policy "Authenticated manage settings" on public.site_settings for all to authenticated using (true) with check (true);

insert into storage.buckets(id,name,public) values ('portfolio','portfolio',true) on conflict (id) do nothing;
create policy "Public can view portfolio images" on storage.objects for select using (bucket_id = 'portfolio');
create policy "Authenticated upload portfolio images" on storage.objects for insert to authenticated with check (bucket_id = 'portfolio');
create policy "Authenticated update portfolio images" on storage.objects for update to authenticated using (bucket_id = 'portfolio') with check (bucket_id = 'portfolio');
create policy "Authenticated delete portfolio images" on storage.objects for delete to authenticated using (bucket_id = 'portfolio');