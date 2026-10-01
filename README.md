# Bruno Emiliano Fotografia

Projeto React + Vite preparado para importar no Lovable e publicar. Inclui portfólio responsivo e painel administrativo em `/admin`.

## Rodar localmente
```bash
npm install
npm run dev
```

## Configurar o Supabase
1. Crie um projeto no Supabase.
2. No SQL Editor, execute o conteúdo de `supabase/schema.sql`.
3. Crie um usuário administrador em Authentication > Users (não há senha fixa no código).
4. Configure as variáveis de ambiente:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
5. Reinicie o projeto. Acesse `/admin` para entrar e gerenciar fotos e informações.

O painel usa autenticação do Supabase e as políticas RLS do schema. Para produção, restrinja a autorização a usuários administradores específicos: as políticas de exemplo permitem escrita a qualquer usuário autenticado no projeto. Não exponha a chave service_role no frontend.

As imagens e textos de exemplo servem como conteúdo demonstrativo. Substitua-os pelo material e pelos dados reais antes de publicar.
