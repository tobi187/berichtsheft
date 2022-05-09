import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey("theme")) {
      String chosenTheme = _prefs.getString("theme")!;
      switch (chosenTheme) {
        case "dark":
          return ThemeMode.dark;
        case "light":
          return ThemeMode.light;
        case "system":
          return ThemeMode.system;
      }
      return ThemeMode.system;
    } else {
      return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch (theme) {
      case ThemeMode.dark:
        _prefs.setString("theme", "dark");
        break;
      case ThemeMode.light:
        _prefs.setString("theme", "light");
        break;
      case ThemeMode.system:
        _prefs.setString("theme", "system");
        break;
    }
  }
}
