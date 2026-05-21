# Changelog

All notable changes to FlyTravelTimes will be documented in this file.

## [1.1.6] - 2026-05-22

### Changed
- 💬 **Improved chat message format** - The automatic flight notification now shows only the estimated flight time (e.g. `FlyTravelTimes: Estimated flight time: 6:57`), keeping it clean and simple.
- 📢 **Shift + Left Click to share ETA** - Clicking the progress bar while holding Shift now inserts a shareable message into your active chat box: `[FlyTravelTimes] <Orgrimmar > Gadgetzan>  ETA: 6:57`. Works with any chat channel (Say, Party, Guild, etc.).

---

## [1.1.5] - 2026-05-15

### Added
- 🐼 **Mists of Pandaria Classic support** - Added `FlyTravelTimes_Mop.toc` for MoP Classic (patch 5.5.3).

### Fixed
- Fixed a crash (`attempt to index field 'text' (a nil value)`) caused by `ApplyFontSize` being called before the bar frame was fully initialized.
- Updated TOC interface versions for all Classic clients:
  - Burning Crusade Classic: `20504` → `20505` (patch 2.5.5)
  - Wrath of the Lich King Classic: `30403` → `30405` (patch 3.4.5)
  - Cataclysm Classic: `40400` → `40402` (patch 4.4.2)
  - WoW Classic Era: `11505` → `11508` (patch 1.15.8)

---

## [1.1.4] - 2026-05-09

### Added
- 🔒 **Bar lock command** - `/ftt lock` toggles the bar between locked and unlocked. When locked, the bar cannot be accidentally dragged to a new position. The lock state is saved across sessions.
- 🔤 **Font size control** - `/ftt fontsize <size>` sets the text size on the progress bar (valid range: 6–32). The route label scales proportionally. The chosen size is saved across sessions.

### New Commands
- `/ftt lock` - Lock/unlock the bar position
- `/ftt fontsize <6-32>` - Set the font size of bar text

---

## [1.1.3] - 2026-04-25

### Added
- 🌍 **Chinese language support** - Added Simplified Chinese (zhCN) and Traditional Chinese (zhTW) translations. The addon now supports 8 languages: English, German, French, Spanish, Russian, Simplified Chinese, Traditional Chinese, Greek.

### Improvements
- 🔧 Updated TOC interface version to `120005` (Midnight 12.0.5)

### Fixed
- 🐛 **Improved faction detection** - `UnitFactionGroup()` can return `"Neutral"` in rare cases (e.g. unaligned Pandaren). The addon now gracefully handles this instead of failing to find the flight path in the database.
- 🔧 **Better "not in database" error message** - Now shows the detected version, faction, and exact node names (e.g. `[CLASSIC/Horde]: Nighthaven, Moonglade -> Everlook, Winterspring`) to help diagnose missing routes more easily.

---

## [1.1.2] - 2026-03-28

### Fixed
- 🐛 **Fixed flight path lookup for BfA and other Retail zones** - Improved the flight data parser to correctly handle all node formats in the database. Previously, some nodes (e.g. "The Great Seal", "Port of Zandalar") were missing from the Retail lookup table due to single-line entries being skipped. All 390 Horde and 394 Alliance Retail nodes are now correctly loaded.

---

## [1.1.1] - 2026-03-27

### Fixed
- 🐛 **"Flight path not in database" error on Retail/Midnight** - Retail WoW returns taxi node names with a zone suffix (e.g. "Thrallmar, Hellfire Peninsula"). The lookup now automatically strips the suffix before searching the database, fixing flight time detection across all Retail zones.
- 🔧 Updated TOC interface version to `120001` (Midnight)

---

## [1.1.0] - 2026-03-22

### New Features
- ✨ **10 Customizable Bar Styles!**
  - Neon - Glowing cyberpunk style
  - Classic - Traditional WoW interface
  - Minimalist - Clean and simple
  - Dragon Ball - Golden energy like Super Saiyan
  - Glowing - Bright glowing effect
  - Glass - Transparent glass effect
  - Retro - Old-school pixel gaming
  - Cyberpunk - Purple and pink vibes
  - Fantasy - Magical arcane energy
  - Modern - Clean modern UI

### New Commands
- `/ftt style <n>` - Change bar style
- `/ftt style list` - Show all available styles

### Improvements
- Bar style preference is saved
- Each style has unique colors, glows, and effects
- Styles work across all WoW versions

---

## [1.0.0] - 2026-03-16

### Initial Release
- ✨ Flight timer progress bar with countdown
- ✨ Support for all WoW versions (Classic, TBC, WotLK, Cata, MoP, Retail/Midnight)
- ✨ Complete flight path database with 51,563+ routes
- ✨ Horde and Alliance faction support
- ✨ **Multi-language support** (English, German, French, Spanish, Russian, Greek)
- ✨ Movable and customizable UI
- ✨ Slash commands for easy configuration
- ✨ Automatic flight detection
- ✨ Real-time remaining time display
- ✨ Percentage progress indicator
- ✨ Animated spark effect on progress bar
- ✨ Position memory (saves your UI placement)
- ✨ Route label above progress bar
- ✨ Tooltip shows flight time on taxi map
