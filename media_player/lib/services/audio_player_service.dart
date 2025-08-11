import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();
  List<SongModel> _playlist = [];
  int _currentIndex = 0;
  Duration _pausedPosition = Duration.zero; // store last position

  // Streams
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;

  int get currentIndex => _currentIndex;
  SongModel? get currentSong =>
      _playlist.isNotEmpty ? _playlist[_currentIndex] : null;

  /// Load and play song
  Future<void> playSong(List<SongModel> songs, int index) async {
    bool sameSong =
        _playlist.isNotEmpty && _playlist[_currentIndex].id == songs[index].id;

    _playlist = songs;
    _currentIndex = index;

    // Only reload if it's a new song
    if (!sameSong) {
      await _player.setAudioSource(
        AudioSource.uri(Uri.file(songs[index].data)),
      );
    }

    // If resuming, seek to last paused position
    if (sameSong && _pausedPosition > Duration.zero) {
      await _player.seek(_pausedPosition);
    }

    await _player.play();

    // Auto play next song when finished
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        nextSong();
      }
    });
  }

  /// Pause song without resetting position
  Future<void> pauseSong() async {
    _pausedPosition = _player.position;
    await _player.pause();
  }

  /// Next song
  Future<void> nextSong() async {
    if (_playlist.isEmpty) return;
    _pausedPosition = Duration.zero;
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await playSong(_playlist, _currentIndex);
  }

  /// Previous song
  Future<void> previousSong() async {
    if (_playlist.isEmpty) return;
    _pausedPosition = Duration.zero;
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSong(_playlist, _currentIndex);
  }

  Future<void> seek(Duration position) async {
    _pausedPosition = position;
    await _player.seek(position);
  }

  void dispose() {
    _player.dispose();
  }
}
