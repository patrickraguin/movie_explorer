import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/movies_state.dart';
import 'package:movie_explorer/repositories/tmdb_repository.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.tmdbRepository) : super(MoviesState.loading());

  final TmdbRepository tmdbRepository;

  Future<void> loadMovies() async {
    try {
      emit(MoviesState.loading());
      final popular = await tmdbRepository.fetchPopularMovies();
      final topRated = await tmdbRepository.fetchTopRated();
      emit(MoviesState.loaded(popular, topRated));
    } catch (e) {
      log(e.toString());
      emit(MoviesState.error());
    }
  }
}
