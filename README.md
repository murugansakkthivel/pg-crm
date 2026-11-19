# PG Manager — owner setup with real login

What this does: an owner logs in with their mobile number + SMS OTP, answers the setup questions, and their PG is saved online. They can log in again on any phone and see the same PG.

Files:
- `public/index.html` — the whole app (one file)
- `firestore.rules` — each owner can only see their own data
- `firebase.json` — hosting + database settings

Until you paste a Firebase config, the app runs in **demo mode** (no real SMS, data stays on that phone).

## One-time setup (about 20 minutes)

1. **Create a Firebase project**
   Go to https://console.firebase.google.com → Add project → name it (e.g. `pg-manager`). Google Analytics is optional.

2. **Turn on billing (Blaze plan)**
   Phone login needs the pay-as-you-go plan. Set a small budget alert (e.g. ₹500/month) under Billing so there are no surprises. Each login SMS is charged; an owner who stays logged in doesn't use more SMS.

3. **Turn on phone login**
   Build → Authentication → Get started → Sign-in method → Phone → Enable.
   Optional for testing: under Phone, add a test number (e.g. +91 99999 00000, code 123456) so you can test without real SMS.

4. **Create the database**
   Build → Firestore Database → Create database → choose region `asia-south1 (Mumbai)` → Start in production mode.

5. **Get the web config**
   Project settings (gear icon) → General → Your apps → Web (`</>`) → register app → copy the `firebaseConfig` object.

6. **Paste the config**
   In `public/index.html`, find `var FIREBASE_CONFIG = null;` and replace `null` with the object, e.g.
   ```js
   var FIREBASE_CONFIG = {
     apiKey: "...",
     authDomain: "pg-manager-xxxx.firebaseapp.com",
     projectId: "pg-manager-xxxx",
     appId: "..."
   };
   ```
   (These keys are meant to be public; the security comes from `firestore.rules`.)

7. **Publish it**
   On a laptop with Node.js installed:
   ```
   npm install -g firebase-tools
   firebase login
   firebase use --add          (pick your project)
   firebase deploy
   ```
   You get a link like `https://pg-manager-xxxx.web.app`. Open it on your phone → menu → "Add to Home screen".

8. **Allow your domain for login**
   Authentication → Settings → Authorized domains: make sure your `.web.app` domain is listed (it is by default).

## How data is stored

```
owners/{ownerId}            phone, language, last login
owners/{ownerId}/pgs/main   all setup answers (floors, rooms, room types, rent, food, deposit, notice, due day)
```

## Later
- Cheaper SMS at scale: switch to an Indian SMS provider (needs DLT registration).
- More PGs per owner: add more documents under `pgs/`.
