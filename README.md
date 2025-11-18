How to run:
1. Install Flutter SDK.
2. In project root run: flutter pub get
3. Run on device: flutter run --release
4. To build APK: flutter build apk --release
APK will be at: build/app/outputs/flutter-apk/app-release.apk
5. Install via adb: adb install -r build/app/outputs/flutter-apk/app-release.apk


Notes:
- Uses sqflite for local SQLite storage.
- Database file located in app documents directory.