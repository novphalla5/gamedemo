import 'package:flutter/material.dart';

import 'screens/main_navigation_screen.dart';
import 'services/giveaway_repository.dart';

class GamerPowerApp extends StatefulWidget {
  const GamerPowerApp({super.key, this.repository});

  final GiveawayRepository? repository;

  @override
  State<GamerPowerApp> createState() => _GamerPowerAppState();
}

class _GamerPowerAppState extends State<GamerPowerApp> {
  bool _isDarkMode = false;
  Color _seedColor = const Color(0xFF6750A4);
  late final GiveawayRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? ApiGiveawayRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GamerPower Giveaways',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: MainNavigationScreen(
        repository: _repository,
        isDarkMode: _isDarkMode,
        selectedColor: _seedColor,
        onDarkModeChanged: (value) => setState(() => _isDarkMode = value),
        onColorChanged: (color) => setState(() => _seedColor = color),
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: const AppBarTheme(centerTitle: false),
      cardTheme: CardThemeData(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
