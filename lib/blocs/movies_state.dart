import '../models/data_state.dart';
import '../models/movie.dart';

class MoviesState {
  DataState dataState;
  List<Movie> popular;
  List<Movie> topRated;

  MoviesState(this.dataState, [this.popular = const [], this.topRated = const []]);

  factory MoviesState.loading() => MoviesState(DataState.loading);

  factory MoviesState.loaded(List<Movie> popular, List<Movie> topRated) =>
      MoviesState(DataState.loaded, popular, topRated);

  factory MoviesState.error() => MoviesState(DataState.error);
}
