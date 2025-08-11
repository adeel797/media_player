import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:media_player/ui/common/ui_helpers.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';

class EnlistTile extends StatelessWidget {
  final String viewModel;
  final SongModel? songs;
  final AssetEntity? videos;
  final AssetEntity? images;
  void Function()? onTap;

  EnlistTile({
    super.key,
    this.songs,
    this.videos,
    this.images,
    this.onTap,
    required this.viewModel,
  });

  String getTitle() {
    switch (viewModel) {
      case 'audio':
        return songs?.title ?? 'Unknown Audio';
      case 'video':
        return videos?.title ?? 'Unknown Video';
      case 'image':
        return images?.title ?? 'Unknown Image';
      default:
        return 'Unknown';
    }
  }

  Duration? getDuration() {
    if (viewModel == 'audio') {
      return Duration(milliseconds: songs?.duration ?? 0);
    } else if (viewModel == 'video') {
      return Duration(seconds: videos?.duration ?? 0);
    }
    return null; // Images have no duration
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString();
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  IconData getIcon() {
    switch (viewModel) {
      case 'audio':
        return Icons.music_note;
      case 'video':
        return Icons.videocam;
      case 'image':
        return Icons.image;
      default:
        return Icons.folder;
    }
  }

  Future<String?> getImageSize() async {
    if (viewModel != 'image' || images == null) return null;
    final file = await images!.file;
    if (file == null) return null;

    final bytes = await file.length();
    return formatBytes(bytes);
  }

  String formatBytes(int bytes) {
    const kb = 1024;
    const mb = kb * 1024;
    const gb = mb * 1024;

    if (bytes >= gb) {
      return '${(bytes / gb).toStringAsFixed(1)} GB';
    } else if (bytes >= mb) {
      return '${(bytes / mb).toStringAsFixed(1)} MB';
    } else if (bytes >= kb) {
      return '${(bytes / kb).toStringAsFixed(1)} KB';
    } else {
      return '$bytes B';
    }
  }

  // New method to get the thumbnail widget
  Widget _buildThumbnailOrIcon() {
    if (viewModel == 'image' && images != null) {
      return FutureBuilder<Uint8List?>(
        future: images!.thumbnailData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            // Display thumbnail if available
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                snapshot.data!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if thumbnail fails to load
                  return _buildIconContainer();
                },
              ),
            );
          } else {
            // Fallback to icon if thumbnail is not available
            return _buildIconContainer();
          }
        },
      );
    } else if (viewModel == 'video' && videos != null) {
      return FutureBuilder<Uint8List?>(
        future: videos!.thumbnailData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            // Display video thumbnail if available
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                snapshot.data!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if thumbnail fails to load
                  return _buildIconContainer();
                },
              ),
            );
          } else {
            // Fallback to icon if thumbnail is not available
            return _buildIconContainer();
          }
        },
      );
    }
    // Default to icon for audio or other cases
    return _buildIconContainer();
  }

  // Helper method to build the icon container
  Widget _buildIconContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        getIcon(),
        color: Colors.white,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = getTitle();
    final duration = getDuration();

    return FutureBuilder<String?>(
      future: viewModel == 'image' ? getImageSize() : Future.value(null),
      builder: (context, snapshot) {
        final imageSize = snapshot.data;

        return GestureDetector(
          onTap: onTap,
          child: Card(
            color: Colors.grey.shade300,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildThumbnailOrIcon(), // Use the new thumbnail/icon logic
                  horizontalSpaceMedium,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpaceTiny,
                        if (viewModel == 'image' && imageSize != null)
                          Text(
                            imageSize,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          )
                        else if (duration != null)
                          Text(
                            formatDuration(duration),
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
