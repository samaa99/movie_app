import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/movies_services.dart';

class MovieRepository {
  final MoviesServices moviesServices;
  MovieRepository(this.moviesServices);

  Future<List<Movie>> getMovies() async {
    final movies = await moviesServices.getMovies();
    return movies.map<Movie>((movieData) {
      return Movie.fromJson(movieData);
    }).toList();
  }
}
