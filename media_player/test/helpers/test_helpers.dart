import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:media_player/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:media_player/services/permission_service.dart';
import 'package:media_player/services/theme_service.dart';
import 'package:media_player/services/audio_player_service.dart';
import 'package:media_player/services/image_viewer_service.dart';
import 'package:media_player/services/video_player_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<PermissionService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ThemeService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AudioPlayerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ImageViewerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<VideoPlayerService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
  ],
)
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterPermissionService();
  getAndRegisterThemeService();
  getAndRegisterAudioPlayerService();
  getAndRegisterImageViewerService();
  getAndRegisterVideoPlayerService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(
    service.showCustomSheet<T, T>(
      enableDrag: anyNamed('enableDrag'),
      enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
      exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
      ignoreSafeArea: anyNamed('ignoreSafeArea'),
      isScrollControlled: anyNamed('isScrollControlled'),
      barrierDismissible: anyNamed('barrierDismissible'),
      additionalButtonTitle: anyNamed('additionalButtonTitle'),
      variant: anyNamed('variant'),
      title: anyNamed('title'),
      hasImage: anyNamed('hasImage'),
      imageUrl: anyNamed('imageUrl'),
      showIconInMainButton: anyNamed('showIconInMainButton'),
      mainButtonTitle: anyNamed('mainButtonTitle'),
      showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
      secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
      showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
      takesInput: anyNamed('takesInput'),
      barrierColor: anyNamed('barrierColor'),
      barrierLabel: anyNamed('barrierLabel'),
      customData: anyNamed('customData'),
      data: anyNamed('data'),
      description: anyNamed('description'),
    ),
  ).thenAnswer(
    (realInvocation) =>
        Future.value(showCustomSheetResponse ?? SheetResponse<T>()),
  );

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockPermissionService getAndRegisterPermissionService() {
  _removeRegistrationIfExists<PermissionService>();
  final service = MockPermissionService();
  locator.registerSingleton<PermissionService>(service);
  return service;
}

MockThemeService getAndRegisterThemeService() {
  _removeRegistrationIfExists<ThemeService>();
  final service = MockThemeService();
  locator.registerSingleton<ThemeService>(service);
  return service;
}

MockAudioPlayerService getAndRegisterAudioPlayerService() {
  _removeRegistrationIfExists<AudioPlayerService>();
  final service = MockAudioPlayerService();
  locator.registerSingleton<AudioPlayerService>(service);
  return service;
}

MockImageViewerService getAndRegisterImageViewerService() {
  _removeRegistrationIfExists<ImageViewerService>();
  final service = MockImageViewerService();
  locator.registerSingleton<ImageViewerService>(service);
  return service;
}

MockVideoPlayerService getAndRegisterVideoPlayerService() {
  _removeRegistrationIfExists<VideoPlayerService>();
  final service = MockVideoPlayerService();
  locator.registerSingleton<VideoPlayerService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
