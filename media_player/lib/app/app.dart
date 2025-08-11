import 'package:media_player/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:media_player/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:media_player/ui/views/home/home_view.dart';
import 'package:media_player/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:media_player/ui/views/audios/audios_view.dart';
import 'package:media_player/ui/views/videos/videos_view.dart';
import 'package:media_player/ui/views/images/images_view.dart';
import 'package:media_player/services/permission_service.dart';
import 'package:media_player/ui/views/settings/settings_view.dart';
import 'package:media_player/services/theme_service.dart';
import 'package:media_player/ui/views/audio_player/audio_player_view.dart';
import 'package:media_player/services/audio_player_service.dart';
import 'package:media_player/services/image_viewer_service.dart';
import 'package:media_player/ui/views/image_viewer/image_viewer_view.dart';
import 'package:media_player/services/video_player_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AudiosView),
    MaterialRoute(page: VideosView),
    MaterialRoute(page: ImagesView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: AudioPlayerView),
    MaterialRoute(page: ImageViewerView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: PermissionService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: AudioPlayerService),
    LazySingleton(classType: ImageViewerService),
    LazySingleton(classType: VideoPlayerService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
