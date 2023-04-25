import 'package:shared_preferences/shared_preferences.dart';

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
}
