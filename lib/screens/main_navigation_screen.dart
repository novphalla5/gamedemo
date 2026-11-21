import 'package:flutter/material.dart';

import '../services/giveaway_repository.dart';
import 'game_grid_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
    required this.repository,
    required this.isDarkMode,
    required this.selectedColor,
    required this.onDarkModeChanged,
    required this.onColorChanged,
  });

  final GiveawayRepository repository;
  final bool isDarkMode;
  final Color selectedColor;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<Color> onColorChanged;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          GameGridScreen(repository: widget.repository),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            selectedColor: widget.selectedColor,
            onDarkModeChanged: widget.onDarkModeChanged,
            onColorChanged: widget.onColorChanged,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
            label: 'Games',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
