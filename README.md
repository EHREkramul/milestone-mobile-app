# Milestone – Flutter Streak Tracker

A 24-hour countdown streak tracker with ranks, history, and local SQLite storage.

---

## 📁 Folder Structure

```
lib/
├── main.dart                          # App entry point + Provider setup
├── models/
│   ├── milestone_session.dart         # Session data model + SQLite mapping
│   └── rank.dart                      # Rank definitions (10 ranks)
├── screens/
│   ├── home_screen.dart               # Main screen with circular timer
│   ├── rank_screen.dart               # All ranks list screen
│   └── history_screen.dart            # Past sessions history screen
├── services/
│   ├── database_service.dart          # SQLite CRUD via sqflite
│   └── timer_service.dart             # ChangeNotifier timer state
└── widgets/
    └── circular_timer_widget.dart     # Custom painted circular progress timer
```

---

## 🚀 Setup

### 1. Copy files to your project

Place all files into:
```
/home/ekramul/MY FILES/SIDE_PROJECT/Flutter/milestone/lib/
```

### 2. Update pubspec.yaml

Add these dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  sqflite: ^2.3.0
  path: ^1.8.3
  shared_preferences: ^2.2.2
  intl: ^0.19.0
  cupertino_icons: ^1.0.6
```

### 3. Install packages
```bash
flutter pub get
```

### 4. Run
```bash
flutter run
```

---

## 🏆 Rank System

| Rank        | Emoji | Days       |
|-------------|-------|------------|
| Newcomer    | 🌱    | 0          |
| Beginner    | 🌿    | 1–6        |
| Apprentice  | 🔥    | 7–13       |
| Committed   | ⚡    | 14–20      |
| Advanced    | 🏆    | 21–29      |
| Expert      | 💎    | 30–59      |
| Master      | 👑    | 60–89      |
| Legend      | 🌟    | 90–179     |
| Immortal    | ⭐    | 180–364    |
| Transcendent| 🚀    | 365+       |

---

## ✨ Features

- **24h circular progress bar** – shows current cycle completion
- **Day counter** in the centre of the circle
- **Rank system** – 10 levels unlocked by day count
- **Persistent storage** via SQLite (sqflite) – survives app restarts
- **History screen** – all past intervals with start/end time
- **Reset** – confirmation dialog, stores completed interval in history
- **Dark theme** with gradient accents