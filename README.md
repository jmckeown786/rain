# Varpa Match Journal

Varpa Match Journal is a standalone SwiftUI iPhone app for the Swedish precision sport varpa.

The app combines a polished sports interface with practical club tools:

- Dashboard for next match, match stats, and quick actions.
- Match planner with opponent, venue, date, format, surface, weather, target distance, and notes.
- Result journal with measured throw distances, best miss, average miss, and win state.
- Almanac covering Varpa history, core rules, unique sport traits, and glossary.
- Kit screen for varpa material, weight, diameter, notes, and favorite match equipment.
- Local profile with player/club identity, readiness achievements, reset, and onboarding replay.
- Persistent offline data using UserDefaults and Codable JSON.
- Privacy manifest and App Store metadata notes.
- Firebase Cloud Messaging push notification plumbing.
- Firebase Analytics for basic launch and section diagnostics.
- TestFlight publishing workflow is configured in `codemagic.yaml` for App Store app id `6772720475`.
- `GoogleService-Info.plist` is included in the app target resources so Codemagic can build directly from Git.

Open `RBTVarpaRain.xcodeproj` and run the `RBTVarpaRain` target on an iPhone or iPad simulator.
