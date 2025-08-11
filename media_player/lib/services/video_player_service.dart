import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerService {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  List<AssetEntity> _playlist = [];
  int _currentIndex = 0;
  Duration _pausedPosition = Duration.zero;

  // Getters
  int get currentIndex => _currentIndex;
  AssetEntity? get currentVideo =>
      _playlist.isNotEmpty ? _playlist[_currentIndex] : null;
  ChewieController? get chewieController => _chewieController;
  VideoPlayerController? get videoController => _videoController;

  /// Initialize and play video from AssetEntity list
  Future<void> playVideo(List<AssetEntity> videos, int index) async {
    if (videos.isEmpty || index < 0 || index >= videos.length) {
      print('Error: Invalid video list or index');
      return;
    }

    bool sameVideo = _playlist.isNotEmpty &&
        _currentIndex < _playlist.length &&
        _playlist[_currentIndex].id == videos[index].id;

    _playlist = videos;
    _currentIndex = index;

    final file = await videos[index].file;
    if (file == null) {
      print('Error: Video file is null for asset ${videos[index].id}');
      return;
    }

    // Dispose old controllers if switching videos or if controller is not initialized
    if (!sameVideo ||
        _videoController == null ||
        !_videoController!.value.isInitialized) {
      await _disposeControllers();

      _videoController = VideoPlayerController.file(file);
      try {
        await _videoController!.initialize();
      } catch (e) {
        print('Error initializing video controller: $e');
        await _disposeControllers();
        return;
      }

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: true,
        showControlsOnInitialize: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error loading video: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }

    // Play video if controller is initialized
    if (_videoController != null && _videoController!.value.isInitialized) {
      if (sameVideo && _pausedPosition > Duration.zero) {
        await _videoController!.seekTo(_pausedPosition);
      }
      await _videoController!.play();
    } else {
      print('Error: Video controller not initialized');
      return;
    }

    // Auto play next video when finished
    _videoController!.addListener(() {
      if (_videoController != null &&
          _videoController!.value.position >=
              _videoController!.value.duration &&
          !_videoController!.value.isPlaying) {
        nextVideo();
      }
    });
  }

  /// Pause video without resetting position
  Future<void> pauseVideo() async {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      print('Error: Cannot pause, video controller not initialized');
      return;
    }
    _pausedPosition = _videoController!.value.position;
    await _videoController!.pause();
  }

  /// Next video
  Future<void> nextVideo() async {
    if (_playlist.isEmpty) return;
    _pausedPosition = Duration.zero;
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await playVideo(_playlist, _currentIndex);
  }

  /// Previous video
  Future<void> previousVideo() async {
    if (_playlist.isEmpty) return;
    _pausedPosition = Duration.zero;
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playVideo(_playlist, _currentIndex);
  }

  /// Seek
  Future<void> seek(Duration position) async {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      print('Error: Cannot seek, video controller not initialized');
      return;
    }
    _pausedPosition = position;
    await _videoController!.seekTo(position);
  }

  /// Dispose controllers
  Future<void> dispose() async {
    await _disposeControllers();
  }

  /// Helper method to dispose controllers
  Future<void> _disposeControllers() async {
    if (_videoController != null) {
      await _videoController!.dispose();
      _videoController = null;
    }
    if (_chewieController != null) {
      _chewieController!.dispose();
      _chewieController = null;
    }
    _pausedPosition = Duration.zero;
  }
}
