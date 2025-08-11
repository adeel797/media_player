import 'package:flutter/material.dart';
import 'package:media_player/ui/components/folder_list_tile.dart';
import 'package:stacked/stacked.dart';

import 'videos_viewmodel.dart';

class VideosView extends StackedView<VideosViewModel> {
  const VideosView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    VideosViewModel viewModel,
    Widget? child,
  ) {
    final filteredFolders = viewModel.videoFolders.entries
        .where((entry) => entry.key != "Recent")
        .toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: viewModel.isBusy
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : filteredFolders.isEmpty
              ? Center(
                  child: Text(
                    "No video folders found",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: viewModel.onRefresh,
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: ListView.builder(
                    itemCount: filteredFolders.length,
                    itemBuilder: (context, index) {
                      final folderName = filteredFolders[index].key;
                      final videos = filteredFolders[index].value;

                      return FolderListTile(
                        folderName: folderName,
                        viewName: 'video',
                        count: videos.length,
                        videos: videos,
                      );
                    },
                  ),
                ),
    );
  }

  @override
  void onViewModelReady(VideosViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  VideosViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VideosViewModel();
}
