import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:stacked/stacked.dart';
import 'image_viewer_viewmodel.dart';

class ImageViewerView extends StackedView<ImageViewerViewModel> {
  final List<String> imagePaths;
  final int initialIndex;

  const ImageViewerView({
    super.key,
    required this.imagePaths,
    required this.initialIndex,
  });

  @override
  Widget builder(
    BuildContext context,
    ImageViewerViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: viewModel.imagePaths.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(File(viewModel.imagePaths[index])),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: viewModel.imagePaths[index]),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: viewModel.pageController,
            onPageChanged: viewModel.onPageChanged,
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: viewModel.closeViewer,
                ),
                Text(
                  '${viewModel.currentIndex + 1} / ${viewModel.imagePaths.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  ImageViewerViewModel viewModelBuilder(BuildContext context) =>
      ImageViewerViewModel(
        imagePaths: imagePaths,
        initialIndex: initialIndex,
      );
}
