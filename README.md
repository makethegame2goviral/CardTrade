# Carddex

Responsive Sammelkarten-Spiel mit React, Vite, TypeScript und Supabase.

## Lokal starten

```bash
npm install
npm run dev
```

Supabase ist in `src/lib/supabase.ts` konfiguriert. Für die Admin-Freischaltung: erst registrieren, dann im Supabase SQL Editor `insert into public.admin_users(user_id) select id from auth.users where email = 'DEINE-LOGIN-EMAIL';` ausführen. Danach neu anmelden.

RLS schützt alle Tabellen. Kartenverwaltung ist Admins vorbehalten. Niemals einen service-role/secret key im Browser verwenden.

## Veröffentlichung

Die Website wird über den GitHub Actions Workflow in `.github/workflows/deploy.yml` gebaut und veröffentlicht.
