part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class TextSearchInitial extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  MoviesLoaded(this.movies);
}
