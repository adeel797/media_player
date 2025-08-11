import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../components/bottom_nav.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Media Player",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
              onPressed: viewModel.navigateToSettings,
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: viewModel.currentView,
      bottomNavigationBar: BottomNav(
        onTap: viewModel.setIndex,
        currentIndex: viewModel.currentIndex,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
