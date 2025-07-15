import 'package:shared_preferences/shared_preferences.dart';

class StatsManager {
  static const _winKey = 'wins';
  static const _lossKey = 'losses';
  static const _drawKey = 'draws';

  int wins = 0;
  int losses = 0;
  int draws = 0;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      wins = prefs.getInt(_winKey) ?? 0;
      losses = prefs.getInt(_lossKey) ?? 0;
      draws = prefs.getInt(_drawKey) ?? 0;
      // Stats loaded successfully
    } catch (e) {
      // Error loading stats, reset to defaults
      wins = 0;
      losses = 0;
      draws = 0;
    }
  }

  Future<void> save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_winKey, wins);
      await prefs.setInt(_lossKey, losses);
      await prefs.setInt(_drawKey, draws);
      // Stats saved successfully
    } catch (e) {
      // Error saving stats
    }
  }

  void incrementWin() {
    wins++;
    save();
  }
  
  void incrementLoss() {
    losses++;
    save();
  }
  
  void incrementDraw() {
    draws++;
    save();
  }

  // Get total games played
  int get totalGames => wins + losses + draws;

  // Get win percentage
  double get winPercentage {
    if (totalGames == 0) return 0.0;
    return (wins / totalGames) * 100;
  }

  // Reset all stats
  Future<void> resetStats() async {
    wins = 0;
    losses = 0;
    draws = 0;
    await save();
  }
} 