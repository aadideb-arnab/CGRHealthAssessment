# CSDH Staff Health & Well-being Programme

Public code on GitHub Pages, **private data** in a Supabase (Postgres) database behind login.
The repository holds only the app — no staff data is ever committed.

## One-time setup (~15 min)

### 1. Create the database (free tier is enough)
1. Sign up at supabase.com → **New project** (choose region *Mumbai / ap-south-1*; set a strong DB password).
2. **SQL Editor** → paste all of `supabase/schema.sql` → **Run**.
3. **Authentication → Providers → Email**: turn **OFF "Allow new users to sign up"** (important – only you add users).
4. **Authentication → Users → Add user**: create your email + password (tick *Auto Confirm*).
5. **SQL Editor** → run (change the email):
   ```sql
   insert into public.app_users (user_id, note)
   select id, 'Nodal officer' from auth.users where email = 'you@example.com';
   ```
   Repeat steps 4–5 for every committee member who should have access.
6. **Project Settings → API**: copy the **Project URL** and the **anon public** key into `config.js`.
   (The anon key is meant to be public. Never use the `service_role` key.)

### 2. Publish on GitHub
1. Create a repository (public is fine), upload everything in this folder (`index.html`, `config.js`, `supabase/`, `.github/`, `README.md`, `.gitignore`).
2. **Settings → Pages → Build and deployment → Source: GitHub Actions**.
3. Push to `main`; the workflow deploys. Site URL: `https://<user>.github.io/<repo>/`.
4. Supabase → **Authentication → URL Configuration**: set Site URL to that address.

### 3. Move your existing data
Open your **old** `index_12.html` in the same browser you used before → Settings → **Download JSON Backup**.
Then sign in to the new site → Settings → **Restore JSON**. (Or: if the old data is still in that browser, the new site offers to import it at first login.)
Keep the JSON file off GitHub (`.gitignore` blocks `*.json`).

## How privacy works
- Anyone can open the page and see the code, but all data requests need a logged-in user listed in `app_users`; Postgres row-level security rejects everyone else.
- Sessions live in `sessionStorage` (closing the tab signs out) and auto sign-out after 30 min idle.
- Staff health data is sensitive: use strong unique passwords, create accounts only for people who need access, and consider enabling MFA in Supabase.
- Supabase free projects pause after ~1 week of inactivity (data kept; click *Restore* in the dashboard). Download JSON backups regularly.
