import 'package:on_audio_query/on_audio_query.dart';
import 'package:photo_manager/photo_manager.dart';

class PermissionService {
  final _audioQuery = OnAudioQuery();

  // Audio
  Future<bool> requestAudioPermission() async {
    return await _audioQuery.permissionsStatus() ||
        await _audioQuery.permissionsRequest();
  }

  // Image / Video (using photo_manager)
  Future<bool> requestMediaPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();
    return permission.isAuth;
  }

  // Optional: Open device settings if media permission is denied
  void openAppSettings() {
    PhotoManager.openSetting();
  }
}
