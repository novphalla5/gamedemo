import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.selectedColor,
    required this.onDarkModeChanged,
    required this.onColorChanged,
  });

  final bool isDarkMode;
  final Color selectedColor;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<Color> onColorChanged;

  static const _themeColors = <Color>[
    Color(0xFF6750A4),
    Color(0xFF0061A4),
    Color(0xFF006C4C),
    Color(0xFF8B5000),
    Color(0xFFBA1A1A),
    Color(0xFF006A6A),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              secondary: Icon(
                isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
              ),
              title: const Text('Dark mode'),
              subtitle: Text(
                isDarkMode ? 'Dark theme is on' : 'Light theme is on',
              ),
              value: isDarkMode,
              onChanged: onDarkModeChanged,
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.palette_outlined),
                      SizedBox(width: 12),
                      Text(
                        'Color theme',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose the accent color used throughout the app.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: _themeColors.map((color) {
                      final selected = color == selectedColor;
                      return Tooltip(
                        message: selected ? 'Selected color' : 'Select color',
                        child: Semantics(
                          button: true,
                          selected: selected,
                          label: 'Theme color',
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => onColorChanged(color),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: selected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Center(child: Text('Giveaway data provided by GamerPower')),
        ],
      ),
    );
  }
}
