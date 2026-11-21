# GamerPower Giveaways

A Flutter assignment app that reads active giveaways from the
[GamerPower API](https://www.gamerpower.com/api/giveaways) and displays them in
a responsive grid.

## Assignment features

- Material 3 bottom navigation bar
- Responsive game giveaway `GridView`
- Pull-to-refresh, loading, empty, and error states
- Detail screen with image, value, type, platform, end date, description, and
  claim instructions
- Copy-to-clipboard action for the giveaway link
- Settings screen with dark-mode switching
- Six selectable color themes
- Android, iOS, web, Windows, macOS, and Linux project targets

## Project structure

```text
lib/
  models/giveaway.dart
  screens/
  services/giveaway_repository.dart
  widgets/giveaway_card.dart
  app.dart
  main.dart
```

## Run locally

Use Flutter 3.47 or newer with Dart 3.13 or newer.

```bash
flutter pub get
flutter run
```

Useful verification commands:

```bash
flutter analyze
flutter test
flutter build web
flutter build apk --release
```

## Submission links

Publish the generated `build/web` folder to GitHub Pages, Firebase Hosting, or
Netlify, then replace these placeholders:

- Demo: `https://YOUR_DEMO_URL`
- Source code: `https://github.com/novphalla5/gamedemo`

## API

The app sends a `GET` request to:

```text
https://www.gamerpower.com/api/giveaways
```

No API key is required. Giveaway availability and content are controlled by
GamerPower.
