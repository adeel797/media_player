import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../app/app.locator.dart';
import '../../../services/audio_player_service.dart';

class AudioPlayerViewModel extends BaseViewModel {
  final _audioService = locator<AudioPlayerService>();

  SongModel? get currentSong => _audioService.currentSong;
  Stream<PlayerState> get playerStateStream => _audioService.playerStateStream;
  Stream<Duration?> get durationStream => _audioService.durationStream;
  Stream<Duration> get positionStream => _audioService.positionStream;
  int get currentIndex => _audioService.currentIndex;

  void playSong(List<SongModel> songs, int index) {
    _audioService.playSong(songs, index);
    notifyListeners();
  }

  void pauseSong() {
    _audioService.pauseSong();
    notifyListeners();
  }

  void nextSong() {
    _audioService.nextSong();
    notifyListeners();
  }

  void previousSong() {
    _audioService.previousSong();
    notifyListeners();
  }

  void seek(Duration position) {
    _audioService.seek(position);
  }
}
