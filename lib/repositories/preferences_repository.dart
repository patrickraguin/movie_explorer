import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/token.dart';

class PreferencesRepository {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveFavorites(List<int> movies) async {
    // Stockage liste string
    await storage.write(key: 'movies', value: jsonEncode(movies));
  }

  Future<List<int>> loadFavorites() async {
    final String? json = await storage.read(key: 'movies');
    if (json == null) {
      return [];
    } else {
      return jsonDecode(json).cast<int>();
    }
  }

  Future<void> saveToken(Token token) async {
    await storage.write(key: 'token', value: jsonEncode(token.toJson()));
  }

  Future<void> removeToken() async {
    await storage.delete(key: 'token');
  }

  Future<Token?> loadToken() async {
    final String? json = await storage.read(key: 'token');
    if (json == null) {
      return null;
    } else {
      return Token.fromJson(jsonDecode(json));
    }
  }
}
