/* Public values — safe to commit. The anon key only works for people who are
   logged in AND listed in the app_users table (enforced by Postgres row-level security).
   NEVER put the "service_role" key here. */
window.APP_CONFIG = {
  SUPABASE_URL: "https://YOUR-PROJECT.supabase.co",
  SUPABASE_ANON_KEY: "YOUR-ANON-PUBLIC-KEY"
};
