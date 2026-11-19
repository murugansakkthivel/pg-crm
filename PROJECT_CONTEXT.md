# PG CRM — Project Context

Read this first. It sums up every decision made so far for the PG CRM app, so any developer or AI assistant can pick up the work.

---

## 1. What we are building

A **simple PG (paying guest) management app for PG owners in Bengaluru**. Owners register their property, set up rooms and beds, and track tenants and rent.

Two products from **one codebase**:
1. **PG CRM app (multi-tenant SaaS):** any owner, any number of PGs.
2. **Dedicated PG app or site (white-label):** one PG's own name, logo and colours (first one: the owner's own PG, *Annapurna Homes*, a ladies' PG in Horamavu). Same backend and data model, with per-PG settings deciding branding and features. **Never fork the code for one PG; add a setting instead.**

### Who it's for
- Bengaluru PG owners, many of whom **read little English** and use **one cheap Android phone**.
- Most still run the PG from a **notebook + WhatsApp**. Some already use apps (RentOk, Crib and others) but find them complex.

### How we win
Existing apps all offer the same basics (beds, tenants, rent reminders). We win on:
1. **Simplicity.** Tap-only setup, one question per screen, voice, big buttons. The owner should **never have to type** (except the phone number and OTP).
2. **A local language.** English by default, Kannada first among the others, more later.
3. **Bengaluru compliance built in.** Licence, CCTV, police verification, 70 sq ft rule.
4. **Lower price and hands-on onboarding.** We set the owner up in person or on the phone.

Pitch to "notebook is fine" owners: *"Keep your notebook. The app chases rent on WhatsApp and tells you who hasn't paid."* Planned killer import: **photograph a notebook page and the app reads tenants, rooms and amounts.**

---

## 2. Research summary (Nov 2026)

### Market
- Bengaluru has an estimated **12,000 to 20,000+ PGs**. Only about **2,500 are registered**.
- **Greater Bengaluru Authority (GBA)** (which replaced BBMP for trade licences) audited **5,480 PGs and found 3,597 unauthorised**.
- In **September 2026 the Karnataka High Court** issued city-wide PG safety guidelines and asked authorities to consider a **unified digital database of PGs**.
- The East Zone and Mahadevapura have the most unauthorised PGs, so Horamavu (east) is a good first market.
- PG owner associations exist (one claims 2,000+ members). Partner with them for distribution.

### Competitors
| App | Notes | Price |
|---|---|---|
| RentOk (EazyPG) | Market leader; rent, KYC, police verification, e-sign, WhatsApp reminders; English and Hindi | Free basics, premium on quote |
| Crib | UPI "RentQR", 2,500+ landlords | On request |
| Kipinn | UPI, eKYC | ₹30 per bed per month |
| TrackMyPG | Razorpay, SMS and email reminders | From ₹299/month |
| StayPe / QuickStay | Beds, rent, complaints | Free |
| My PG Manager | Mess, staff attendance; English and Hindi | Free (Android) |
| HarGharPG | Mess menus, KYC, tenant microsites | — |

Table stakes: **UPI QR payment** and **WhatsApp reminders**. Gap: none are Kannada-first, voice-first or compliance-first, and owners say they're too complex.

### Rules the app should support (Bengaluru)
- **Trade licence** from GBA. Renewals open 1 Feb; **a 100% penalty applies after 1 April**. We need licence expiry plus reminders.
- **70 sq ft per resident.** We need room size × beds checks.
- **CCTV** at entrances, exits and corridors, with **90 days of footage**, and **never in bedrooms or bathrooms**.
- 135 L of water per person, 24/7 guard, helpline board, first-aid kit, waste segregation, FSSAI licence if serving food, fire clearance.
- **Staff police verification.** **Tenant verification** through the KSP portal, Suraksha app or Bangalore One. **Form C** is required for foreign residents.
- **GST:** none if the stay is **90+ days and ₹20,000 or less per person per month**; otherwise GST applies.
- *(General info, not legal advice.)*

### Costs
- WhatsApp Business API utility messages cost about **₹0.115 each** in India (plus GST and any provider fee).
- Standard UPI merchant payments carry **zero MDR**. A payment gateway may add fees.
- Firebase phone auth needs the **Blaze (pay-as-you-go) plan**, and each SMS is charged (about $0.06 per verification in India). Indian SMS providers (MSG91 and others) cost about ₹0.40–0.60 but need **DLT registration**. Plan: start on Firebase, switch to an Indian provider at scale.

### Pricing idea (to test)
- **Free:** up to 10 beds.
- **Standard:** ₹15–20 per bed per month, or ₹299/month flat.
- **Dedicated app or site:** a one-time setup fee plus Standard.

---

## 3. Design rules (agreed with the owner of this project)

- **One question per screen. Tap to answer. No forms. The owner never types** (except phone and OTP).
- **One language at a time.** The **default is English**. A small **language chip** (globe + "English") in the top bar switches language any time. **Never show two languages on the same screen** (the only exception is the language-picker screen, which lists each language in its own script).
  - Supported now: English, Kannada. Hindi, Tamil and Telugu show "Coming soon".
- **Smart defaults:** pre-select the most common answer, and allow skipping where possible.
- **Voice:** a **small mic button** (44 px) next to Next on every screen, plus a **read-aloud (speaker)** button in the top bar.
- **No "Need help? Call us" line on screens.** Contact info will live in a **separate tab** later.
- **Two colours only (Sky blue plus amber), with neutrals:**
  | Token | Hex | Use |
  |---|---|---|
  | `--p` primary | `#3D86D9` | selected borders, icons, progress bar, empty-bed dots |
  | `--pl` tint | `#EAF4FF` | selected option background, icon circles |
  | `--btn` button | `#9CCBFF` | main Next button (light) |
  | `--btnt` button text | `#0F2A44` | dark text on the light button |
  | `--a` amber | `#E08A2E` | **"Rent due"** only |
  | `--ink` text | `#1A1F2B` | body text |
  | `--q` grey text | `#5A6272` | secondary text |
  | `--bd` border | `#D7DCE4` | borders |
- Touch targets of at least 44 px; option buttons about 64 px tall; font Inter (+ Noto Sans Kannada).
- Room numbering: floor × 100 + room index (101, 102 … 201 …).
- Accessibility: real `<button>` elements, `aria-label` on icon buttons, contrast ≥ 4.5:1.

---

## 4. Owner setup flow (built: `public/index.html`)

| # | Screen | Answer type |
|---|---|---|
| 1 | Choose language | English (default) · ಕನ್ನಡ · हिंदी/தமிழ்/తెలుగు (coming soon) |
| 2 | Mobile number → OTP | Number pad, "Send OTP", then 6-digit OTP (autofill) |
| 3 | Who is your PG for? | Ladies · Gents · Both (co-living) |
| 4 | Where is your PG? | "Use my current location" (GPS) · Skip |
| 5 | How many floors? | 1–6 chips (count the ground floor) |
| 6 | Rooms on each floor | − / + stepper; "Same on every floor?" Yes / No → per-floor steppers |
| 7 | **Room type per room** | Pick a type (Single / 2 / 3 / 4 share), then tap rooms; floors shown together; "Copy Floor 1 to all". **Room types vary by floor.** |
| 8 | Rent per bed | **Asked once per room type that exists**; preset chips + "Other" (number pad) |
| 9 | Food | 3 meals · Breakfast + dinner · No food |
| 10 | Deposit & notice | Deposit: 1 month rent / ₹2,000 / ₹5,000 / none; Notice: 15 days / 1 month / 2 months |
| 11 | Rent due day | 1st / 5th / 10th / joining date |
| 12 | PG ready → bed board | Floors × rooms with bed dots; tap a room to change its type; "Add tenants" (notebook photo / WhatsApp link / say it). Change answers, Log out |

Design mockups of these screens: Claude Design canvas "PG Manager — Owner Setup Screens" (12 artboards plus a colour options board).

---

## 5. Tech decisions (current)

- **Phase 1: a mobile web app (PWA-style), one file:** `public/index.html` — **vanilla JS, no build step**, all CSS and JS inline.
  - Why: the founder is not an Android developer; fastest to put in front of owners via a link; "Add to Home screen". Store apps come later (Flutter or React Native can reuse the same backend).
- **Backend: Firebase.**
  - **Auth:** Firebase Phone Auth (SMS OTP, invisible reCAPTCHA). Needs the Blaze plan.
  - **DB:** Cloud Firestore (region `asia-south1`, Mumbai), offline persistence on.
  - **Hosting:** Firebase Hosting (`firebase deploy`), with `public/` as the root.
- **Demo mode:** if `var FIREBASE_CONFIG = null;`, the app runs with no SMS (any 6-digit OTP) and keeps data in `localStorage`. Paste the Firebase web config to go live (see `README.md`).
- **Data model**
  ```
  owners/{uid}            phone, lang, lastLogin
  owners/{uid}/pgs/main   lang, phone, pgFor, loc{lat,lng}, floors, same, rpf[],
                          types (JSON string: {floor: [beds per room]}),
                          rent (JSON string: {bedsPerRoom: amount}), rentOther,
                          food, deposit, notice, due, done, step, updatedAt
  ```
  Later: `pgs/{pgId}` for multiple PGs; `tenants`, `payments`, `complaints`, `expenses` sub-collections; every record scoped by owner/PG.
- **Security rules** (`firestore.rules`): an owner can read and write only `owners/{their uid}/**`; everything else is denied.
- Saving: answers save to Firestore about 0.7 s after each change (debounced). On login, the app loads saved answers. If setup is done, it opens the bed board; otherwise it resumes after the phone step.
- i18n: an object `T = { en: {...}, kn: {...} }` with keys and `{placeholder}` substitution; other languages fall back to English.
- Voice: Web Speech API (`SpeechRecognition` to fill answers, `speechSynthesis` to read questions aloud) in `en-IN` / `kn-IN`. It doesn't work inside the claude.ai preview; it should work on the deployed site in Chrome but is untested.

### Code conventions
- Keep the single file until it hurts; then split into `public/js/*.js` modules **without** adding a build step unless needed.
- UI is rendered from state (`S`) via `render()`; clicks are handled by one delegated listener on `data-act` / `data-val`.
- Every user-facing string goes into `T.en` **and** `T.kn`.
- Stick to the colour tokens above; don't add new colours.
- Commit small, with clear messages; push to `main` on `github.com/murugansakkthivel/pg-crm`.

---

## 6. Roadmap

**MVP (version 1)**
- [x] Owner setup flow (12 screens)
- [x] Phone OTP login + saving (Firebase; needs project config)
- [ ] Deploy to Firebase Hosting with real config
- [ ] Add tenant: tenant fills their own details from a **WhatsApp link** (name, phone, ID photo, emergency contact, deposit); owner taps Approve
- [ ] Bed board states: empty / occupied / rent due (amber) / notice given
- [ ] Monthly rent list; mark cash paid in one tap; **UPI QR / payment link** that marks paid automatically
- [ ] **WhatsApp reminders** (before due, on due date, overdue) + receipts
- [ ] Move-out: notice date, deposit minus dues, final receipt
- [ ] Owner home with bottom tabs (Rooms · Money · People · More), where **More** holds contact/help info

**Version 2**
- [ ] Compliance checklist (licence, CCTV, fire, FSSAI, staff and tenant verification) with renewal reminders and photo proof
- [ ] Expenses and monthly profit
- [ ] Tenant complaints with photo and status
- [ ] Food menu and meal opt-out
- [ ] Public PG page / branded app with an enquiry button (white-label product)
- [ ] Notebook-photo import (OCR)

**Later**
- [ ] UPI AutoPay for rent (₹15,000 standard limit per debit)
- [ ] Electricity sub-meter billing
- [ ] Multiple PGs, staff roles, reports
- [ ] Hindi, Tamil, Telugu
- [ ] Cheaper Indian SMS provider (DLT)

---

## 7. Validation plan
- Interview 10–15 owners around Horamavu: how they track rent, language, phone, what they'd pay.
- Talk to three groups: current app users, people who tried an app and quit, and notebook users.
- Good sign: 4–5 of 15 say "I'd use this if it did X."
- Test every screen with 5 real owners before building the next one.
- Have a native speaker check the Kannada copy.

---

## 8. Links
- Repo: https://github.com/murugansakkthivel/pg-crm
- Firebase setup steps: `README.md`
- Key sources: GBA audit (OneIndia), Karnataka HC PG guidelines (LiveLaw, Sept 2026), BBMP PG rules (Deccan Herald, Aug 2024), GST on PG (ClearTax), WhatsApp API India pricing (Monty Mobile), Firebase Auth pricing (Logto blog, 2026).
