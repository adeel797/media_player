import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/permission_service.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagesViewModel extends BaseViewModel {
  final _permissionService = locator<PermissionService>();
  final Map<String, List<AssetEntity>> _imageFolders = {};
  Map<String, List<AssetEntity>> get imageFolders => _imageFolders;
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

    await fetchImageFolders();
    sortFolders(ascending: true); // Optional: default sort A-Z
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchImageFolders() async {
    _imageFolders.clear();

    List<AssetPathEntity> imageAlbums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    for (final album in imageAlbums) {
      final images = await album.getAssetListPaged(page: 0, size: 100);
      if (images.isNotEmpty) {
        // Show "Recent" or "All" folder first
        final key = album.isAll ? "Recent" : album.name;
        _imageFolders[key] = images;
      }
    }

    print("🖼️ Found ${_imageFolders.length} image folders.");
  }

  void sortFolders({bool ascending = true}) {
    final entries = _imageFolders.entries.toList();

    entries.sort((a, b) => ascending
        ? a.key.toLowerCase().compareTo(b.key.toLowerCase())
        : b.key.toLowerCase().compareTo(a.key.toLowerCase()));

    _imageFolders
      ..clear()
      ..addEntries(entries);

    notifyListeners();
  }

  Future<void> onRefresh() async {
    setBusy(true);
    await fetchImageFolders();
    setBusy(false);
    notifyListeners();
  }
}
