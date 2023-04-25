import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/token.dart';

class PreferencesRepository {
  Future<void> saveFavorites(List<int> movies) async {
    // Récupération instance sharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Transformation d'une liste de int en liste de String
    final List<String> list = movies.map((id) => id.toString()).toList();

    // Stockage liste string
    prefs.setStringList('movies', list);
  }

  Future<List<int>> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('movies') ?? [];
    return list.map((e) => int.parse(e)).toList();
  }

  Future<void> saveToken(Token token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', jsonEncode(token.toJson()));
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<Token?> loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('token');
    if (json == null) {
      return null;
    } else {
      return Token.fromJson(jsonDecode(json));
    }
  }
}
