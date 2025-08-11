import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/folder_list_tile.dart';
import 'images_viewmodel.dart';

class ImagesView extends StackedView<ImagesViewModel> {
  const ImagesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ImagesViewModel viewModel,
    Widget? child,
  ) {
    final filteredFolders = viewModel.imageFolders.entries
        .where((entry) => entry.key != "Recent") // ⛔ Skip "Recent"
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
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  color: Theme.of(context).colorScheme.primary,
                  child: ListView.builder(
                    itemCount: filteredFolders.length,
                    itemBuilder: (context, index) {
                      final folderName = filteredFolders[index].key;
                      final images = filteredFolders[index].value;

                      return FolderListTile(
                        folderName: folderName,
                        viewName: 'image',
                        count: images.length,
                        images: images,
                      );
                    },
                  ),
                ),
    );
  }

  @override
  void onViewModelReady(ImagesViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  ImagesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ImagesViewModel();
}
