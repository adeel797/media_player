import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../app/app.locator.dart';
import '../../services/video_player_service.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<AssetEntity> videos;
  final int initialIndex;

  const VideoPlayerScreen({
    Key? key,
    required this.videos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final _videoService = locator<VideoPlayerService>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _videoService.playVideo(widget.videos, widget.initialIndex);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _videoService.pauseVideo();
    _videoService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chewieController = _videoService.chewieController;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Video Player"),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _videoService.videoController?.value.isPlaying ?? false
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
            onPressed: () async {
              final controller = _videoService.videoController;
              if (controller == null || !controller.value.isInitialized) {
                return;
              }
              if (controller.value.isPlaying) {
                await _videoService.pauseVideo();
              } else {
                await controller.play();
              }
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () async {
              await _videoService.nextVideo();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: () async {
              await _videoService.previousVideo();
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading ||
                    chewieController == null ||
                    !chewieController.videoPlayerController.value.isInitialized
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Loading video...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : Chewie(controller: chewieController),
          ),
        ],
      ),
    );
  }
}
