import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// About page that displays information about the app and its developer
/// 
/// This page includes:
/// - App description and credits
/// - Developer information
/// - Link to the GitHub repository
class AboutPage extends StatelessWidget {
  /// Creates an about page
  const AboutPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About / Credits')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Tic Tac Toe\n',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Developed by Tejas in 2023.\n\n'
              'Tejas is a 3rd year Computer Science undergrad at the University of Cincinnati.\n\n'
              'Inspired by the classic game, with a modern twist!\n\n'
              'Built with Flutter.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  const url = 'https://github.com/ghodketejas/advanced_tic_tac_toe';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('View on GitHub'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23252B),
                  foregroundColor: const Color(0xFF00FFF7),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 