import 'dart:io';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/permission_service.dart';

class AudiosViewModel extends BaseViewModel {
  final _permissionService = locator<PermissionService>();
  final OnAudioQuery _audioQuery = OnAudioQuery();

  final Map<String, List<SongModel>> _audioFolders = {};
  Map<String, List<SongModel>> get audioFolders => _audioFolders;

  Future<void> init() async {
    setBusy(true);

    final hasPermission = await _permissionService.requestAudioPermission();
    if (hasPermission) {
      await fetchAudioFolders();
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchAudioFolders() async {
    List<SongModel> allSongs = await _audioQuery.querySongs(
      uriType: UriType.EXTERNAL,
      sortType: SongSortType.DISPLAY_NAME,
      ignoreCase: true,
    );

    final audioExtensions = ['mp3', 'wav', 'aac', 'ogg', 'm4a'];

    _audioFolders.clear();

    for (final song in allSongs) {
      if (song.data.isEmpty) continue;

      final path = File(song.data);
      final extension = path.path.split('.').last.toLowerCase();

      if (!audioExtensions.contains(extension)) continue;

      final folderPath = path.parent.path;

      if (!_audioFolders.containsKey(folderPath)) {
        _audioFolders[folderPath] = [];
      }
      _audioFolders[folderPath]!.add(song);
    }

    print("📁 Found ${_audioFolders.length} folders with audio files.");
  }

  Future<void> onRefresh() async {
    setBusy(true);
    await fetchAudioFolders();
    setBusy(false);
    notifyListeners();
  }
}
