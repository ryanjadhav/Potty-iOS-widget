# Potty

A simple iOS app and home screen widget for tracking your toddler's potty training. Log pee and poop events with one tap, view a timer since the last event, and get reminders — all from the home screen widget or the app.

## Features

- One-tap logging for pee and poop events
- Home screen widgets (small and medium) showing time since last event
- Quick-log directly from the widget via App Intents
- Event history view
- Notification reminders

## Requirements

- macOS with **Xcode 15.0** or later
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (generates the `.xcodeproj` from `project.yml`)
- An Apple Developer account (free or paid)
- An iPhone running **iOS 17.0** or later

## Building and Running

### 1. Install XcodeGen

```bash
brew install xcodegen
```

### 2. Generate the Xcode project

```bash
cd Potty-iOS-widget
xcodegen generate
```

This reads `project.yml` and creates `Potty.xcodeproj`.

### 3. Open in Xcode

```bash
open Potty.xcodeproj
```

### 4. Configure signing

1. Select the **Potty** project in the navigator.
2. For each target (**Potty** and **PottyWidgetExtension**):
   - Go to **Signing & Capabilities**.
   - Check **Automatically manage signing**.
   - Select your **Team** (your Apple Developer account).
   - Xcode will create provisioning profiles automatically.

### 5. Install on your iPhone

1. Connect your iPhone via USB (or set up wireless debugging under **Window > Devices and Simulators**).
2. Select your iPhone from the device dropdown in the Xcode toolbar.
3. Press **Cmd + R** to build and run.
4. On first install, your iPhone may ask you to trust the developer certificate:
   - Go to **Settings > General > VPN & Device Management**, tap your developer profile, and tap **Trust**.

### 6. Add the widget

1. Long-press on your home screen and tap **+** in the top-left corner.
2. Search for **Potty**.
3. Choose the small or medium widget and tap **Add Widget**.

## Project Structure

```
Potty/              Main app target
  App/              App entry point
  Views/            SwiftUI views
  Components/       Reusable UI components
  Theme/            Colors and styling
PottyWidget/        Widget extension target
  Views/            Small and medium widget views
Shared/             Code shared between app and widget
  Models/           PottyEvent data model
  Services/         PottyStore (persistence) and NotificationManager
  Intents/          App Intents for widget actions
```

## License

See [LICENSE](LICENSE) for details.
