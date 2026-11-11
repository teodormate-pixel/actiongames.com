# ActionGames

a site for our game collection.

## Supabase admin setup

The standalone admin dashboard is `admin.html`. It lets an authenticated administrator create, edit, and delete game and article records in Supabase.

1. Create a Supabase project.
2. In **Authentication → Users**, create the admin user with an email and password. Disable public sign-ups in the Auth settings if you do not need them.
3. In `supabase/schema.sql`, replace both occurrences of `admin@example.com` with the admin user's exact email, then run the SQL in **SQL Editor**.
4. In `admin.html`, set `SUPABASE_URL` and `SUPABASE_ANON_KEY` to the project URL and public anon/publishable key from **Project Settings → API**.
5. Publish the site and open `/admin.html` to sign in.

The anon key is intended for browser use; Row Level Security in the schema limits writes to the configured admin email. **Never put a Supabase service-role/secret key in this site.** The current public `index.html` still uses browser-local storage; this dashboard and schema are ready for Supabase but do not yet synchronize the public page with the Supabase tables.
