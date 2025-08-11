import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;
  const BottomNav({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 0,
      backgroundColor: Colors.transparent,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Audio'),
        BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Video'),
        BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Images'),
      ],
    );
  }
}
