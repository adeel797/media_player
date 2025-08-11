# 🎵📽️ Media Player App (Android)

## 🌟 Introduction

Welcome to the **Media Player App** — your all-in-one Android solution to enjoy music, videos, and images right from your device! 🎶🎬🖼️ Built with **Flutter** and powered by plugins like **just\_audio**, **on\_audio\_query**, **video\_player**, **chewie**, and **photo\_manager**, this app provides a smooth, intuitive, and responsive media experience. 📱

The Media Player App organizes your device’s audio, video, and image files into easy-to-browse folders. It allows you to play songs, watch videos, view photos, and even switch between light and dark themes via the settings. With robust permission handling and persistent theme storage, it’s designed for both usability and performance. 🚀

## ✅ Requirements Fulfilled

The Media Player App includes the following key features:

* 🎵 **Audio Playback**: Play, pause, seek, skip forward/backward with song position saving.
* 📽️ **Video Playback**: Smooth playback with full-screen support and playback speed control using Chewie.
* 🖼️ **Image Viewing**: Browse images directly from your gallery folders.
* 📂 **Folder-Based Browsing**: Organize and view media by folders for easy access.
* 🌗 **Theme Customization**: Light, dark, and system mode switching with preferences saved using SharedPreferences.
* 🔒 **Permissions Management**: Request audio, image, and video permissions at runtime.
* 📱 **Android Only**: Developed and optimized exclusively for Android devices.

## 🛠 Tech Stack & Dependencies

This app is built using Flutter with the **Stacked Architecture** for clean code structure and maintainability.

**Framework & Architecture**

* Flutter
* Stacked Architecture (`stacked`, `stacked_services`)

**Plugins & Packages**

* `stacked` – MVVM architecture support
* `stacked_services` – Navigation & dialog services
* `on_audio_query` – Query audio files from device storage
* `on_audio_query_android_v1_8` – Android-specific audio query implementation
* `photo_manager` – Manage and fetch media (images/videos) from the device
* `shared_preferences` – Store theme mode and small persistent settings
* `just_audio` – Audio playback
* `photo_view` – Zoomable image viewer
* `video_player` – Video playback
* `chewie` – Video player controls and UI wrapper for `video_player`

## ✨ App Features

### 🎵 Audio Player

* Play songs from your device’s local storage.
* Resume playback from the last paused position.
* Auto-play the next song when one finishes.
* Seek within tracks with precise control.

### 📽️ Video Player

* Play videos from local storage.
* Full-screen mode, looping, and adjustable playback speed.
* Auto-play the next video in the playlist.

### 🖼️ Image Viewer

* Browse photos from device folders.
* Open full-size images with zoom support.

### 📂 Folder Navigation

* Organized folder-based navigation for audio, video, and images.
* Tap a folder to see its contents instantly.

### 🌗 Theme Switching

* Toggle between light, dark, or system themes from the settings screen.
* Preferences stored for persistent sessions.

### 🔒 Permission Handling

* Request media access permissions before loading content.
* Option to open device settings if permissions are denied.

## 📸 App Images

*(Replace placeholders with actual screenshots from your app)*

### Home Screen with Bottom Navigation

| Light Mode                                   | Dark Mode                                  |
| -------------------------------------------- | ------------------------------------------ |
| ![Light Mode Home](your-light-mode-home.png) | ![Dark Mode Home](your-dark-mode-home.png) |
| -------------------------------------------- | ------------------------------------------ |
| ![Light Mode Home](your-light-mode-home.png) | ![Dark Mode Home](your-dark-mode-home.png) |
| -------------------------------------------- | ------------------------------------------ |
| ![Light Mode Home](your-light-mode-home.png) | ![Dark Mode Home](your-dark-mode-home.png) |

## 📲 Download the App

The Media Player App is open-source and ready for you to explore, modify, and improve. Perfect for learning Flutter multimedia integration or as a base for a personal project.
**[Download for Android](your-download-link)** 📱🎵📽️

## 🤝 Contribute

We welcome contributions to make the Media Player App even better! Whether it’s adding features, fixing bugs, or improving performance, your help is appreciated.

* 🐛 Submit Issues: Report bugs or suggest enhancements.
* 🔧 Pull Requests: Send improvements with detailed descriptions.
* 💡 Feature Ideas: Suggest new features like playlists, equalizers, or image slideshows.
* 📝 Documentation: Improve or add to the existing documentation.
