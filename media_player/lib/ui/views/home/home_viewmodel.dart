import 'package:flutter/material.dart';
import 'package:media_player/app/app.locator.dart';
import 'package:media_player/app/app.router.dart';
import 'package:media_player/ui/views/audios/audios_view.dart';
import 'package:media_player/ui/views/images/images_view.dart';
import 'package:media_player/ui/views/videos/videos_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  int _currentIndex = 0;

  final List<Widget> _views = [
    const AudiosView(),
    const VideosView(),
    const ImagesView(),
  ];

  Widget get currentView => _views[_currentIndex];

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToSettings() {
    _navigationService.navigateToSettingsView();
  }
}
