/* Public values — safe to commit. The anon key only works for people who are
   logged in AND listed in the app_users table (enforced by Postgres row-level security).
   NEVER put the "service_role" key here. */
window.APP_CONFIG = {
  SUPABASE_URL: "https://tvzkxyuxzhmztiinwdtm.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR2emt4eXV4emhtenRpaW53ZHRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTI4MTI0MzgsImV4cCI6MjEwODM4ODQzOH0.1teIZD_01UmdEX-3YOqY7JcVAITmLBthzxXmR_3sfCw"
};
