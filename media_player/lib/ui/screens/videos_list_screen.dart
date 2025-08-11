import 'package:flutter/material.dart';
import 'package:media_player/ui/components/enlist_tile.dart';
import 'package:media_player/ui/screens/video_player_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosListScreen extends StatelessWidget {
  final String folderName;
  final List<AssetEntity>? videos;

  const VideosListScreen({
    super.key,
    required this.folderName,
    this.videos,
  });

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
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: videos?.length ?? 0,
        itemBuilder: (context, index) {
          final video = videos![index];
          return EnlistTile(
            viewModel: 'video',
            videos: video,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPlayerScreen(
                    videos: videos!,
                    initialIndex: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
