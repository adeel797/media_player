import 'package:flutter/material.dart';
import 'package:media_player/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ImageViewerViewModel extends BaseViewModel {
  final List<String> imagePaths;
  final int initialIndex;
  final _navigationService = locator<NavigationService>();
  late PageController pageController;
  int currentIndex = 0;

  ImageViewerViewModel({
    required this.imagePaths,
    required this.initialIndex,
  }) {
    init();
  }

  void init() {
    currentIndex =
        initialIndex.clamp(0, imagePaths.isEmpty ? 0 : imagePaths.length - 1);
    pageController = PageController(initialPage: currentIndex);
  }

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void closeViewer() {
    _navigationService.back();
  }
}
