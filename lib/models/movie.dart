class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie(this.id, this.title, this.posterPath);

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(json['id'], json['title'], json['poster_path']);
}
