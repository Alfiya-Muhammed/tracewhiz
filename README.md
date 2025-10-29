<h1 align="center">Tracewhiz 🎨✨</h1>

<p align="center">
  AI-powered Drawing & Camera Overlay Tool built with Flutter
  <br>
  Turn your screen into a tracing projector for perfect sketches!
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35+-blue.svg" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20Windows-success" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
</p>

---

## 📌 Overview

**Tracewhiz** allows users to select an image and overlay it on a live camera preview.  
This helps artists accurately trace drawings by adjusting:

✔ Opacity  
✔ Position  
✔ Size  

A perfect tool for learners, designers, and hobby sketchers! ✍️

---

## ✨ Features

| Feature | Status |
|--------|:-----:|
| Open reference image from gallery | ✅ |
| Live camera view with image overlay | ✅ |
| Opacity slider for tracing | ✅ |
| Drag & resize overlay image | ✅ |

---

## 📂 Project Structure

```
lib/
 ├── main.dart
 ├── home_screen.dart
 └── camera_drawing.dart
assets/
 └── (future images)
```

---

## 🚀 Getting Started

### ✅ Prerequisites
Make sure you have installed:
- Flutter SDK (3.3+. Recommended latest stable)
- Android Studio / VS Code
- Android Emulator or physical device

### 🔧 Installation & Run
```sh
git clone https://github.com/Alfiya-Muhammed/tracewhiz.git
cd tracewhiz
flutter pub get
flutter run

To run on a specific device:
flutter devices
flutter run -d <device_id>

## 🛠️ Tech Stack

| Technology     | Purpose                    |
|----------------|----------------------------|
| Flutter + Dart | App Development            |
| camera plugin  | Live camera feed           |
| image_picker   | Pick images from gallery   |

