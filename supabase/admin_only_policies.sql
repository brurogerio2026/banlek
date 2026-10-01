-- Reforce o acesso administrativo após executar schema.sql.
-- Antes, atribua app_metadata.role = "admin" ao usuário administrador
-- usando o painel/servidor seguro do Supabase (nunca pelo frontend).
drop policy if exists "Authenticated manage photos" on public.photos;
drop policy if exists "Authenticated manage categories" on public.categories;
drop policy if exists "Authenticated manage settings" on public.site_settings;
drop policy if exists "Authenticated upload portfolio images" on storage.objects;
drop policy if exists "Authenticated update portfolio images" on storage.objects;
drop policy if exists "Authenticated delete portfolio images" on storage.objects;

create policy "Admins manage photos" on public.photos for all to authenticated
using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins manage categories" on public.categories for all to authenticated
using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins manage settings" on public.site_settings for all to authenticated
using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins upload portfolio images" on storage.objects for insert to authenticated
with check (bucket_id = 'portfolio' and (auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins update portfolio images" on storage.objects for update to authenticated
using (bucket_id = 'portfolio' and (auth.jwt()->'app_metadata'->>'role') = 'admin')
with check (bucket_id = 'portfolio' and (auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins delete portfolio images" on storage.objects for delete to authenticated
using (bucket_id = 'portfolio' and (auth.jwt()->'app_metadata'->>'role') = 'admin');
