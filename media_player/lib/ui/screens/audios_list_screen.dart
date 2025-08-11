import 'package:flutter/material.dart';
import 'package:media_player/ui/components/enlist_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../app/app.locator.dart';
import '../../services/audio_player_service.dart';
import '../views/audio_player/audio_player_view.dart';

class AudiosListScreen extends StatelessWidget {
  final String folderName;
  final List<SongModel>? songs;
  const AudiosListScreen({super.key, required this.folderName, this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          folderName,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            )),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: songs!.length,
        itemBuilder: (context, index) {
          final song = songs![index];
          return EnlistTile(
            songs: song,
            viewModel: "audio",
            onTap: () {
              final allSongs = songs!;
              final tappedIndex = index;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AudioPlayerView(),
                ),
              );
              // Call the player service after navigation
              locator<AudioPlayerService>().playSong(allSongs, tappedIndex);
            },
          );
        },
      ),
    );
  }
}
