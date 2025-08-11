import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final ValueNotifier<ThemeMode> _themeModeNotifier =
      ValueNotifier(ThemeMode.system);

  ThemeMode get themeMode => _themeModeNotifier.value;
  ValueNotifier<ThemeMode> get themeNotifier => _themeModeNotifier;

  ThemeService() {
    // Load theme on initialization
    loadTheme();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString('themeMode');

    switch (mode) {
      case 'light':
        _themeModeNotifier.value = ThemeMode.light;
        break;
      case 'dark':
        _themeModeNotifier.value = ThemeMode.dark;
        break;
      default:
        _themeModeNotifier.value = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeModeNotifier.value = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (mode == ThemeMode.system) {
      await prefs.remove('themeMode');
    } else {
      await prefs.setString('themeMode', mode.name);
    }
  }

  bool get isDarkMode => _themeModeNotifier.value == ThemeMode.dark;
}
