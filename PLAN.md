# Locked Leaf — Plan

A private, security-hardened desktop journal. Forked from StoryPad, with encryption, no tracking, and sync only when you say so.

## Why
- Personal use only. I'm the first (and only) user.
- Portfolio showcase: shows I can build on top of an existing open-source tool, make good calls, and explain the trade-offs.
- Not for sale.

## Decisions
- **Base:** fork of [theachoem/storypad](https://github.com/theachoem/storypad) (Flutter, MVVM, ObjectBox).
- **License:** GPL-3.0 stays. Keep credit to the original.
- **Platform:** macOS desktop first.
- **Auth:** no accounts, no server. Login = device biometrics + passphrase. Nothing online to breach.
- **Sync:** manual only. A "Sync now" button. Backup is encrypted on the Mac before upload. Auto-backup off.
- **Showcase:** public page with screenshots, a screen recording using fake entries, and a "what I changed and why" write-up. Real journal never leaves the Mac.

## What StoryPad already has vs. gaps
- Has: app lock (PIN / Face ID / fingerprint), flutter_secure_storage.
- Gap: Firebase Analytics + Crashlytics send data to Google.
- Gap: local ObjectBox database looks unencrypted at rest.
- Gap: Google Drive backups likely not encrypted before upload (to confirm).
- Gap: RevenueCat in-app purchases (not needed). → removed in M1
- Gap: still downloads config/templates/sounds from static.storypad.me, Google Fonts, map tiles (reveals IP, no entries sent). Cut or replace in M2/M5.
- Gap: Location + microphone entitlements still on. Trim in M5.

## Milestones (one at a time)

### M1 — Fork running on my Mac ✅
1. Fork + clone into side-hustles/locked-leaf. ✅
2. Run the macOS build: `bin/dev --community-macos` ✅
   - Check: app opens and I can write an entry.
3. Remove Firebase Analytics, Crashlytics, and in-app purchases. ✅
   - Check: app still runs, and no network calls go to Firebase.
   - Done in 3 commits: disable Firebase → remove Firebase (analytics, crashlytics, firestore, config) → remove RevenueCat (all features unlocked locally).
   - Android Firebase Gradle plugins left in place (Android out of scope).
4. Quick win: make a "Daily" template with my habits as a checklist. Start using it.
   - Check: I can fill it in for today in under a minute.
5. Build a release .app for daily use (fast launch), keep bin/dev for development. ✅
   - Build: `flutter build macos --release --flavor community -t lib/main_community.dart --dart-define=CUPERTINO=yes --dart-define-from-file=bin/.tmp/private_keys/dart_defines/community.json`
   - Install: `rm -rf "/Applications/Locked Leaf.app" && cp -R build/macos/Build/Products/Release-community/LockedLeaf.app "/Applications/Locked Leaf.app"` (app file is LockedLeaf.app since M1.5)
   - Debug and release share one database (same bundle ID) — don't run both at once.

## Setup fixes so far (M1)
- Signing: Team = my Personal Team (4ZD6MH342Y), bundle ID com.aditiabhang.lockedleaf (community configs).
- Removed iCloud capability (personal teams can't use it) and FlutterFire build scripts (needed flutterfire CLI, uploaded crash symbols).
- ObjectBox needs a macOS App Group prefixed with my Team ID → set to 4ZD6MH342Y in base_box.dart + community entitlements.
- Impeller crashed on window resize → disabled via FLTEnableImpeller=false in macos/Runner/Info.plist.

### M1.5 — Quick rebrand: name + icon  ← next
- Why: official StoryPad and Locked Leaf look the same in Cmd+Tab, menu bar, Spotlight.
- Set app display name to "Locked Leaf" (menu bar, Cmd+Tab, Spotlight) and give it its own icon.
- Icon chosen: "Journal + leaf", Sage variant. Source: `design/locked-leaf-icon-sage.svg` → export macOS AppIcon sizes (16–1024).
- Palette: tile #DCE8DE, cover #24362C, leaf #7CC48F, clasp #E0A04A, pages #F7F3EA.
- Check: Cmd+Tab shows "Locked Leaf" with the new icon; official StoryPad still shows "StoryPad".
- Full rebrand (theme, in-app text) stays in M6.

### M2 — Encrypt data at rest
- First step: upgrade to latest Flutter on its own. Rebuild, check, commit.

### M3 — Habit tracker (new feature, built MVVM-style like the rest of StoryPad)
- Habits: workout, bath before noon, 30 min study, 30 min self-reflect, 30 min learning, violin practice, no sugar.
- Daily check-offs, streaks, calendar view.
- Maybe: log minutes for the 30-min habits (partial days); time check for "bath before noon".
- Decide details after 1–2 weeks of using the M1 template.

### M4 — Manual encrypted sync button
### M5 — Tighter lock: auto-lock on background, block screenshots, hide in app switcher
### M6 — Rebrand + make it shinier (name, icon, theme, personalization)
### M7 — Public showcase page

## Setup notes
- Tool versions (from .tool-versions): Flutter 3.47.4-stable, Java 21, Ruby 3.3.5.
- README still says Flutter 3.29.0; .tool-versions is the current one.
