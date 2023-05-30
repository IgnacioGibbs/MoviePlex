class Movie {
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // Named Constructor.
  Movie.empty()
      : adult = false,
        backdropPath = '',
        genreIds = [],
        id = 0,
        originalLanguage = '',
        originalTitle = '',
        overview = '',
        popularity = 0.0,
        posterPath = '',
        releaseDate = DateTime.now(),
        title = '',
        video = false,
        voteAverage = 0.0,
        voteCount = 0 {}

  // Factory Constructor
  factory Movie.withTitle(String title) {
    return Movie(
      adult: false,
      backdropPath: '',
      genreIds: [],
      id: 0,
      originalLanguage: '',
      originalTitle: title,
      overview: '',
      popularity: 0.0,
      posterPath: '',
      releaseDate: DateTime.now(),
      title: title,
      video: false,
      voteAverage: 0.0,
      voteCount: 0,
    );
  }

  // Initialization list.
  Movie.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = List<String>.from(json['genre_ids'] ?? []),
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        releaseDate = DateTime.tryParse(json['release_date']) ?? DateTime.now(),
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}
