import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_player/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'audio_player_viewmodel.dart';

class AudioPlayerView extends StackedView<AudioPlayerViewModel> {
  const AudioPlayerView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AudioPlayerViewModel viewModel, Widget? child) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Album Art
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.music_note,
                    size: 150, color: Colors.white),
              ),
              verticalSpaceMassive,
              Column(
                children: [
                  // Song Title
                  Text(
                    viewModel.currentSong?.title ?? "No Song",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceMedium,

                  // Seek Bar
                  StreamBuilder<Duration?>(
                    stream: viewModel.durationStream,
                    builder: (context, durationSnapshot) {
                      final duration = durationSnapshot.data ?? Duration.zero;
                      return StreamBuilder<Duration>(
                        stream: viewModel.positionStream,
                        builder: (context, positionSnapshot) {
                          var position = positionSnapshot.data ?? Duration.zero;
                          if (position > duration) position = duration;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(position),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Expanded(
                                child: Slider(
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  inactiveColor: Colors.grey,
                                  min: 0.0,
                                  max: duration.inMilliseconds.toDouble(),
                                  value: position.inMilliseconds.toDouble(),
                                  onChanged: (value) {
                                    viewModel.seek(
                                        Duration(milliseconds: value.toInt()));
                                  },
                                ),
                              ),
                              Text(
                                _formatDuration(duration),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  verticalSpaceMedium,

                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous,
                            color: Theme.of(context).colorScheme.primary),
                        iconSize: 40,
                        onPressed: viewModel.previousSong,
                      ),
                      StreamBuilder<PlayerState>(
                        stream: viewModel.playerStateStream,
                        builder: (context, snapshot) {
                          final isPlaying = snapshot.data?.playing ?? false;
                          return IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            iconSize: 64,
                            onPressed: () {
                              if (isPlaying) {
                                viewModel.pauseSong();
                              } else {
                                if (viewModel.currentSong != null) {
                                  viewModel.playSong([viewModel.currentSong!],
                                      viewModel.currentIndex);
                                }
                              }
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next,
                            color: Theme.of(context).colorScheme.primary),
                        iconSize: 40,
                        onPressed: viewModel.nextSong,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  AudioPlayerViewModel viewModelBuilder(BuildContext context) =>
      AudioPlayerViewModel();

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
