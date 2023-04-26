import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repositories/preferences_repository.dart';

class FavoriteCubit extends Cubit<List<int>> {
  FavoriteCubit(this.preferencesRepository) : super([]);

  final PreferencesRepository preferencesRepository;

  void addFavorite(int movieId) {
    emit([...state, movieId]);
    preferencesRepository.saveFavorites(state);
  }

  void removeFavorite(int movieId) {
    state.removeWhere((element) => element == movieId);
    emit([...state]);
    preferencesRepository.saveFavorites(state);
  }

  Future<void> loadFavorites() async {
    emit(await preferencesRepository.loadFavorites());
  }
}
