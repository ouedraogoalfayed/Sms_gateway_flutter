import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late final SharedPreferences _prefs;

  // Initialisation (à appeler une fois au démarrage de l'app)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // === METHODS SIMPLES ===

  // SAUVEGARDER des valeurs
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  // LIRE des valeurs (avec valeur par défaut)
  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  // SUPPRIMER une valeur
  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // VIDER tout le stockage
  static Future<void> clear() async {
    await _prefs.clear();
  }
}

// bool_preferences_service.dart


class BoolPreferencesService {
  // Méthode pour sauvegarder un booléen
  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Méthode pour récupérer un booléen (avec valeur par défaut)
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  // Méthode pour supprimer un booléen
  static Future<void> removeBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Méthode pour vérifier si une clé existe
  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Méthode pour basculer (toggle) un booléen
  static Future<void> toggleBool(String key) async {
    final currentValue = await getBool(key);
    await saveBool(key, !currentValue);
  }
}