import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_player/app/app.locator.dart';
import 'package:media_player/app/app.router.dart';
import 'package:media_player/services/theme_service.dart';
import 'package:media_player/themes/dark_mode.dart';
import 'package:media_player/themes/light_mode.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up dependency injection
  await setupLocator();
  // Load theme
  final themeService = locator<ThemeService>();
  await themeService.loadTheme();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(MainApp(
    themeService: themeService,
  ));
}

class MainApp extends StatelessWidget {
  final ThemeService themeService;
  const MainApp({super.key, required this.themeService});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService.themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: mode,
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [StackedService.routeObserver],
        );
      },
    );
  }
}
