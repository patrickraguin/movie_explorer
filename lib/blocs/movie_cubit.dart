import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repositories/tmdb_repository.dart';

import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.tmdbRepository) : super(MovieState.loading());

  final TmdbRepository tmdbRepository;

  Future<void> loadMovie(int movieId) async {
    try {
      emit(MovieState.loading());
      final movie = await tmdbRepository.fetchMovie(movieId);
      emit(MovieState.loaded(movie));
    } catch (e) {
      log(e.toString());
      emit(MovieState.error());
    }
  }
}
