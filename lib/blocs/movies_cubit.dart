import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/models/movie.dart';
import 'package:movie_explorer/repositories/tmdb_repository.dart';

class MoviesCubit extends Cubit<List<Movie>> {
  MoviesCubit(this.tmdbRepository) : super([]);

  final TmdbRepository tmdbRepository;

  Future<void> loadMovies() async {
    final movies = await tmdbRepository.fetchPopularMovies();
    emit(movies);
  }
}
