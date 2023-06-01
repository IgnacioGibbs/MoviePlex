import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {
  static Movie theMovieDbToEntity(MovieTheMovieDB themoviedb) => Movie(
      adult: themoviedb.adult,
      backdropPath: (themoviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w300${themoviedb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w300/keep-calm-poster-not-found.png',
      genreIds: themoviedb.genreIds.map((e) => e.toString()).toList(),
      id: themoviedb.id,
      originalLanguage: themoviedb.originalLanguage,
      originalTitle: themoviedb.originalTitle,
      overview: themoviedb.overview,
      popularity: themoviedb.popularity,
      posterPath: (themoviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w300${themoviedb.posterPath}'
          : 'not_found',
      releaseDate: themoviedb.releaseDate,
      title: themoviedb.title,
      video: themoviedb.video,
      voteAverage: themoviedb.voteAverage,
      voteCount: themoviedb.voteCount);
}
