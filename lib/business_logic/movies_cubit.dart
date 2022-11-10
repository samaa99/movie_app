import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/movie.dart';
import '../repository/movie_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MovieRepository movieRepository;
  MoviesCubit(this.movieRepository) : super(TextSearchInitial());
  List<Movie> movies = [];

  List<Movie> getMovies() {
    movieRepository.getMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
