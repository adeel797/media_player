import 'package:flutter/material.dart';
import 'package:media_player/app/app.locator.dart';
import 'package:media_player/app/app.router.dart';
import 'package:media_player/services/image_viewer_service.dart';
import 'package:media_player/ui/components/enlist_tile.dart';
import 'package:media_player/ui/views/image_viewer/image_viewer_view.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stacked_services/stacked_services.dart';

class ImagesListScreen extends StatelessWidget {
  final String folderName;
  final List<AssetEntity>? images;

  const ImagesListScreen({super.key, required this.folderName, this.images});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          folderName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
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
      body: images == null || images!.isEmpty
          ? const Center(child: Text('No images found'))
          : ListView.builder(
              itemCount: images!.length,
              itemBuilder: (context, index) {
                final image = images![index];
                return EnlistTile(
                  viewModel: 'image',
                  images: image,
                  onTap: () async {
                    final paths =
                        await ImageViewerService.getImageFilePaths(images!);
                    if (paths.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageViewerView(
                            imagePaths: paths,
                            initialIndex: index,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to load images')),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}
