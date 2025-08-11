import 'package:photo_manager/photo_manager.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/permission_service.dart';

class VideosViewModel extends BaseViewModel {
  final _permissionService = locator<PermissionService>();
  final Map<String, List<AssetEntity>> _videoFolders = {};
  Map<String, List<AssetEntity>> get videoFolders => _videoFolders;
  String text = "";

  Future<void> init() async {
    setBusy(true);

    final isGranted = await _permissionService.requestMediaPermission();
    if (!isGranted) {
      text = "NOT GRANTED";
      setBusy(false);
      notifyListeners();
      _permissionService.openAppSettings();
      return;
    }

    await fetchVideoFolders();
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchVideoFolders() async {
    _videoFolders.clear();

    List<AssetPathEntity> videoAlbums = await PhotoManager.getAssetPathList(
      type: RequestType.video,
    );

    for (final album in videoAlbums) {
      final videos = await album.getAssetListPaged(page: 0, size: 100);
      if (videos.isNotEmpty) {
        // Show "Recent" or "All" folder first
        final key = album.isAll ? "Recent" : album.name;
        _videoFolders[key] = videos;
      }
    }

    print("🎬 Found ${_videoFolders.length} video folders.");
  }

  void sortFolders({bool ascending = true}) {
    final entries = _videoFolders.entries.toList();

    entries.sort((a, b) => ascending
        ? a.key.toLowerCase().compareTo(b.key.toLowerCase())
        : b.key.toLowerCase().compareTo(a.key.toLowerCase()));

    _videoFolders
      ..clear()
      ..addEntries(entries);

    notifyListeners();
  }

  Future<void> onRefresh() async {
    setBusy(true);
    await fetchVideoFolders();
    setBusy(false);
    notifyListeners();
  }
}
