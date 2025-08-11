import 'package:flutter/material.dart';
import 'package:media_player/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _themeService = locator<ThemeService>();

  get themeService => _themeService;

  SettingsViewModel() {
    _themeService.themeNotifier.addListener(notifyListeners);
  }

  void setThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode != null) {
      _themeService.setThemeMode(newThemeMode);
    }
  }

  void goBack() {
    _navigationService.back();
  }
}
