import 'package:photo_manager/photo_manager.dart';

class ImageViewerService {
  /// Converts AssetEntity list to local file paths.
  static Future<List<String>> getImageFilePaths(
      List<AssetEntity> assets) async {
    List<String> filePaths = [];
    for (var asset in assets) {
      final file = await asset.file;
      if (file != null && file.existsSync()) {
        filePaths.add(file.path);
      }
    }
    return filePaths;
  }
}
