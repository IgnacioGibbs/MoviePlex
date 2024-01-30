import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/infrastructure/models/themoviedb/movie_details.dart';
import 'package:movieplex/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {
  static Movie theMovieDbToEntity(MovieTheMovieDB themoviedb) => Movie(
      adult: themoviedb.adult,
      backdropPath: (themoviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w300${themoviedb.backdropPath}'
          : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      genreIds: themoviedb.genreIds.map((e) => e.toString()).toList(),
      id: themoviedb.id,
      originalLanguage: themoviedb.originalLanguage,
      originalTitle: themoviedb.originalTitle,
      overview: themoviedb.overview,
      popularity: themoviedb.popularity,
      posterPath: (themoviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w300${themoviedb.posterPath}'
          : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      releaseDate: themoviedb.releaseDate ?? DateTime.now(),
      title: themoviedb.title,
      video: themoviedb.video,
      voteAverage: themoviedb.voteAverage,
      voteCount: themoviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails themoviedb) => Movie(
      adult: themoviedb.adult,
      backdropPath: (themoviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w300${themoviedb.backdropPath}'
          : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      genreIds: themoviedb.genres.map((e) => e.name).toList(),
      id: themoviedb.id,
      originalLanguage: themoviedb.originalLanguage,
      originalTitle: themoviedb.originalTitle,
      overview: themoviedb.overview,
      popularity: themoviedb.popularity,
      posterPath: (themoviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w300${themoviedb.posterPath}'
          : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      releaseDate: themoviedb.releaseDate,
      title: themoviedb.title,
      video: themoviedb.video,
      voteAverage: themoviedb.voteAverage,
      voteCount: themoviedb.voteCount);
}
