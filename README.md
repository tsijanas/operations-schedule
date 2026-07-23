# Rota

A team scheduling tool: assign people to tasks across the week, track who's eligible for what,
manage time off, and keep everyone's workload balanced. Built as a small internal tool for one
team, not a commercial product.

## How it's built

There's no build step — `index.html` and `login.html` are plain HTML/CSS/JavaScript, no
npm/webpack/React. The browser loads them directly and talks to **Firebase** (Google's hosted
backend) for two things:

- **Firebase Authentication** — handles sign-up/sign-in (email + password)
- **Firestore** — the database (people, teams, schedules, holidays, etc.)

Everything about *who's allowed to do what* is enforced by `firestore.rules` — that file is the
real security boundary for this app, not the JavaScript. See `DEPLOYMENT.md` for what that
means in practice and what needs to be configured in the Firebase project.

## Files

| File | What it is |
|---|---|
| `index.html` | The app itself — schedule, teams, tasks, holidays, everything after login |
| `login.html` | Sign-in / sign-up page |
| `firestore.rules` | Database security rules — deployed to Firebase separately from the site itself |
| `firebase.json`, `.firebaserc` | Config so the Firebase CLI knows which project to deploy rules to |
| `Dockerfile`, `nginx.conf` | Packages the static files behind a small web server, for self-hosting |
| `docker-compose.yml` | Local one-command way to run the container and check it works |

## Running it locally

```
docker compose up --build
```

Then open `http://localhost:8080`. This serves the exact same files that would run in
production — there's no separate "dev mode."

## Deploying

See `DEPLOYMENT.md` — there are two parts to deploying this: hosting the files (which is what
the Docker setup here is for) and configuring the Firebase project (which is separate, and has
to be done once regardless of where the files are hosted).
