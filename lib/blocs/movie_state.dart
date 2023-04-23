import '../models/data_state.dart';
import '../models/movie.dart';

class MovieState {
  DataState dataState;
  Movie? movie;

  MovieState(this.dataState, [this.movie]);

  factory MovieState.loading() => MovieState(DataState.loading);

  factory MovieState.loaded(Movie movie) => MovieState(DataState.loaded, movie);

  factory MovieState.error() => MovieState(DataState.error);
}
