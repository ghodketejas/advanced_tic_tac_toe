import 'package:flutter/material.dart';

/// Settings page for the Advanced Tic Tac Toe app
///
/// Currently displays a placeholder message as no settings are implemented.
/// This page can be extended in the future to include game preferences,
/// theme options, or other configuration settings.
class SettingsPage extends StatelessWidget {
  /// Creates a settings page
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text(
          'No settings available.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
