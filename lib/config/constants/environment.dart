import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String test = 'test';

  static String getTheMovieDbKey() {
    final key = dotenv.env['THE_MOVIE_DB_KEY'];
    return key ?? 'THE_MOVIE_DB_KEY not found.';
  }
}
