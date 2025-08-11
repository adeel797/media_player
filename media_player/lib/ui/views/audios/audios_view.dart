import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../components/folder_list_tile.dart';
import 'audios_viewmodel.dart';

class AudiosView extends StackedView<AudiosViewModel> {
  const AudiosView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AudiosViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: viewModel.isBusy
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : viewModel.audioFolders.isEmpty
              ? Center(
                  child: Text(
                    "No audio folders found",
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
                    itemCount: viewModel.audioFolders.length,
                    itemBuilder: (context, index) {
                      final folderPath =
                          viewModel.audioFolders.keys.elementAt(index);
                      final folderName = folderPath.split('/').last;
                      final songCount =
                          viewModel.audioFolders[folderPath]!.length;

                      return FolderListTile(
                          folderName: folderName,
                          viewName: 'audio',
                          count: songCount,
                          songs: viewModel.audioFolders[folderPath]!);
                    },
                  ),
                ),
    );
  }

  @override
  void onViewModelReady(AudiosViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  AudiosViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AudiosViewModel();
}
