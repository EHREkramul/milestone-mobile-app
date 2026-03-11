<div align="center">

# 🚀 Milestone

### A 24-hour streak tracker with ranks, history, and offline-first local storage.

[![Flutter](https://img.shields.io/badge/Flutter-3.41.4-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)
[![Build](https://img.shields.io/badge/Build-Passing-brightgreen)](https://github.com/EHREkramul/milestone-mobile-app)

</div>

---

## 📖 Overview

**Milestone** is a minimalist streak tracker that helps you build and maintain daily habits. Set a 24-hour cycle, watch a beautiful circular progress timer count down, earn ranks as your streak grows, and review your full session history — all stored locally on-device with no account or internet required.

---

## ✨ Features

| Feature | Description |
|---|---|
| ⏱ **24h Circular Timer** | Real-time animated progress ring showing cycle completion |
| 📅 **Day Counter** | Continuous streak counter displayed at the centre of the timer |
| 🏆 **Rank System** | 10 unlockable ranks based on streak days |
| 🗄 **Offline Storage** | Full persistence via SQLite — survives app restarts and reboots |
| 📜 **Session History** | Detailed log of all past intervals with start/end timestamps |
| 🔄 **Safe Reset** | Confirmation dialog saves the completed interval before resetting |
| 🌙 **Dark Theme** | Deep dark UI with purple gradient accents |

---

## 🏆 Rank System

Progress through 10 ranks as your streak grows:

| Rank | Emoji | Days Required |
|---|:---:|---|
| Newcomer | 🌱 | Day 0 |
| Beginner | 🌿 | Days 1 – 6 |
| Apprentice | 🔥 | Days 7 – 13 |
| Committed | ⚡ | Days 14 – 20 |
| Advanced | 🏆 | Days 21 – 29 |
| Expert | 💎 | Days 30 – 59 |
| Master | 👑 | Days 60 – 89 |
| Legend | 🌟 | Days 90 – 179 |
| Immortal | ⭐ | Days 180 – 364 |
| Transcendent | 🚀 | Days 365+ |

---

## 🛠 Tech Stack

- **Framework:** Flutter 3.41.4 (Dart 3.x)
- **State Management:** Provider (`ChangeNotifier`)
- **Local Database:** SQLite via `sqflite`
- **Persistence:** `shared_preferences`
- **Internationalisation:** `intl`
- **Architecture:** Service-layer pattern (screens → services → database)

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point & Provider setup
├── models/
│   ├── milestone_session.dart         # Session data model + SQLite mapping
│   └── rank.dart                      # Rank definitions (10 ranks)
├── screens/
│   ├── home_screen.dart               # Main screen with circular timer
│   ├── rank_screen.dart               # Rank list screen
│   ├── history_screen.dart            # Past sessions history screen
│   └── settings_screen.dart          # App settings screen
├── services/
│   ├── database_service.dart          # SQLite CRUD via sqflite
│   └── timer_service.dart             # ChangeNotifier timer state
└── widgets/
    └── circular_timer_widget.dart     # Custom-painted circular progress timer
```

---

## 🚀 Getting Started

### Prerequisites

| Tool | Version | Install |
|---|---|---|
| Flutter SDK | ≥ 3.0.0 | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart SDK | ≥ 3.0.0 | Bundled with Flutter |
| Android SDK | API 21+ | [Android Studio](https://developer.android.com/studio) |
| Java (JDK) | 17 | Required for Android builds |

Verify your setup:

```bash
flutter doctor
```

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/EHREkramul/milestone-mobile-app.git
cd milestone-mobile-app

# 2. Fetch dependencies
flutter pub get

# 3. Run on a connected device or emulator
flutter run
```

---

## 📦 Building for Production

### Debug APK

```bash
flutter build apk --debug
```

### Release APK (sideloading)

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Release App Bundle (Google Play Store)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

> **Note:** Release builds require a signing keystore. See [Android release build setup](https://docs.flutter.dev/deployment/android) for instructions. Never commit `android/key.properties` or `*.jks` files to version control.

---

## 🔐 Signing Setup (Release Only)

1. Generate a keystore (one-time):
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. Create `android/key.properties` (already in `.gitignore`):
   ```properties
   storePassword=<your-store-password>
   keyPassword=<your-key-password>
   keyAlias=upload
   storeFile=<absolute-path-to>/upload-keystore.jks
   ```

3. Build – Gradle will pick up the config automatically.

---

## 🧪 Running Tests

```bash
# Unit & widget tests
flutter test

# With coverage report
flutter test --coverage
```

---

## 🤝 Contributing

Contributions are welcome. Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to your fork: `git push origin feature/your-feature-name`
5. Open a Pull Request against `master`

Please follow [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**EHR Ekramul**
- GitHub: [@EHREkramul](https://github.com/EHREkramul)
- Repository: [milestone-mobile-app](https://github.com/EHREkramul/milestone-mobile-app)

---

<div align="center">
Made with ❤️ using Flutter
</div>
