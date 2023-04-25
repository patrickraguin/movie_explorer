import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repositories/preferences_repository.dart';

class FavoriteCubit extends Cubit<List<int>> {
  FavoriteCubit(this.preferencesRepository) : super([]);

  final PreferencesRepository preferencesRepository;

  void addFavorite(int movieId) {
    // Ajout de l'id dans le state

    // Sauvegarde du state des les SharedPreferences
  }

  void removeFavorite(int movieId) {
    // Suppression de l'id dans le state

    // Sauvegarde du state des les SharedPreferences
  }

  Future<void> loadFavorites() async {
    // Chargement des données depuis les SharedPreferences
  }
}
