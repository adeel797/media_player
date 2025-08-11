import 'package:flutter/material.dart';
import 'package:media_player/ui/common/ui_helpers.dart';
import 'package:media_player/ui/screens/audios_list_screen.dart';
import 'package:media_player/ui/screens/images_list_screen.dart';
import 'package:media_player/ui/screens/videos_list_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:photo_manager/photo_manager.dart';

class FolderListTile extends StatelessWidget {
  final String folderName;
  final String viewName;
  final List<SongModel>? songs;
  final int count;
  final List<AssetEntity>? videos;
  final List<AssetEntity>? images;

  const FolderListTile({
    super.key,
    required this.folderName,
    required this.viewName,
    required this.count,
    this.songs,
    this.videos,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    String itemType;
    if (viewName == 'audio') {
      itemType = count == 1 ? 'Song' : 'Songs';
    } else if (viewName == 'video') {
      itemType = count == 1 ? 'Video' : 'Videos';
    } else {
      itemType = count == 1 ? 'Image' : 'Images';
    }

    Widget screen;
    if (viewName == 'audio') {
      screen = AudiosListScreen(
        folderName: folderName,
        songs: songs,
      );
    } else if (viewName == 'video') {
      screen = VideosListScreen(
        folderName: folderName,
        videos: videos,
      );
    } else {
      screen = ImagesListScreen(
        folderName: folderName,
        images: images,
      );
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => screen,
        ),
      ),
      child: Card(
        color: Colors.grey.shade300,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.folder,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              horizontalSpaceMedium,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      folderName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpaceTiny,
                    Text(
                      "$count $itemType",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
